Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F2BC83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 06:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F231B2082E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 06:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgD2GNI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 02:13:08 -0400
Received: from relay.sw.ru ([185.231.240.75]:56440 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726181AbgD2GNH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 02:13:07 -0400
Received: from vvs-ws.sw.ru ([172.16.24.21])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <vvs@virtuozzo.com>)
        id 1jTfxf-0005DQ-K4; Wed, 29 Apr 2020 09:12:47 +0300
Subject: Re: [PATCH 1/1] drm/qxl: add mutex_lock/mutex_unlock to ensure the
 order in which resources are rele
To:     Gerd Hoffmann <kraxel@redhat.com>
References: <20200421084300.zggroiptwbrblzqy () sirius ! home ! kraxel ! org>
From:   Vasily Averin <vvs@virtuozzo.com>
Cc:     Caicai <caizhaopeng@uniontech.com>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org,
        dri-devel@lists.freedesktop.org,
        "linux-kernel@vger.kernel.org\"" <linux-kernel@vger.kernel.org>,
        Zhangyueqian <zhangyueqian@uniontech.com>,
        "Denis V. Lunev" <den@virtuozzo.com>
Message-ID: <bc954de7-bfe0-8e0c-79d4-90d726a0ffa6@virtuozzo.com>
Date:   Wed, 29 Apr 2020 09:12:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200421084300.zggroiptwbrblzqy () sirius ! home ! kraxel ! org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/21/20 11:43 AM, Gerd Hoffmann wrote:
> On Sat, Apr 18, 2020 at 02:39:17PM +0800, Caicai wrote:
>> When a qxl resource is released, the list that needs to be released is
>> fetched from the linked list ring and cleared. When you empty the list,
>> instead of trying to determine whether the ttm buffer object for each
>> qxl in the list is locked, you release the qxl object and remove the
>> element from the list until the list is empty. It was found that the
>> linked list was cleared first, and that the lock on the corresponding
>> ttm Bo for the QXL had not been released, so that the new qxl could not
>> be locked when it used the TTM.
> 
> So the dma_resv_reserve_shared() call in qxl_release_validate_bo() is
> unbalanced?  Because the dma_resv_unlock() call in
> qxl_release_fence_buffer_objects() never happens due to
> qxl_release_free_list() clearing the list beforehand?  Is that correct?

we observe similar issue: RHEL7 guests crashes in 
qxl_draw_opaque_fb()
 qxl_release_fence_buffer_objects() 

crashdump investigation shows that qlx_object was freed and reused,
so its original content was re-written.

At the same time qxl_device have empty release_idr,
ant there are no allocated qxl_bo_list entries.
i.e. qxl_release_free was really called.

> The only way I see for this to happen is that the guest is preempted
> between qxl_push_{cursor,command}_ring_release() and
> qxl_release_fence_buffer_objects() calls.  The host can complete the qxl
> command then, signal the guest, and the IRQ handler calls
> qxl_release_free_list() before qxl_release_fence_buffer_objects() runs.

We think the same: qxl_release was freed by garbage collector before
original thread had called qxl_release_fence_buffer_objects().

> Looking through the code I think it should be safe to simply swap the
> qxl_release_fence_buffer_objects() +
> qxl_push_{cursor,command}_ring_release() calls to close that race
> window.  Can you try that and see if it fixes the bug for you?

I'm going to prepare and test such patch but I have one question here:
qxl_push_*_ring_release can be called with  interruptible=true and fail
How to correctly handle this case? Is the hunk below correct from your POV?

--- a/drivers/gpu/drm/qxl/qxl_ioctl.c
+++ b/drivers/gpu/drm/qxl/qxl_ioctl.c
@@ -261,12 +261,8 @@ static int qxl_process_single_command(struct qxl_device *qdev,
                        apply_surf_reloc(qdev, &reloc_info[i]);
        }
 
+       qxl_release_fence_buffer_objects(release);
        ret = qxl_push_command_ring_release(qdev, release, cmd->type, true);
-       if (ret)
-               qxl_release_backoff_reserve_list(release);  <<<< ????
-       else
-               qxl_release_fence_buffer_objects(release);
-
 out_free_bos:
 out_free_release:


Thank you,
	Vasily Averin
