Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C512C83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 08:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E10E920731
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 08:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ApM0VH+7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgD2I2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 04:28:46 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49234 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726355AbgD2I2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 04:28:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588148924;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=307isNnvbFBLVIHqWZVI02AT/E09cU5NkzO3QxAC0lI=;
        b=ApM0VH+7FcEfCho3QdDp0fQwK825YhYpkXnXpT24Wwb/iV4QSEQmMd2fMkhDMTvBhFp0EV
        msDadlnz1mqKJ4R9xoT/Gmb8/SjVWAaj2a7kcNjSs/rYbhXXJWDHfxTGNxBQ9pG2zGnYqO
        lpN/IjSI4PvKAU1Jr9gERibk4EdKpO0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-ETodXgd1OBKAK3jUQcuNEw-1; Wed, 29 Apr 2020 04:28:41 -0400
X-MC-Unique: ETodXgd1OBKAK3jUQcuNEw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 81BFD45F;
        Wed, 29 Apr 2020 08:28:39 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-193.ams2.redhat.com [10.36.113.193])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 06B6F5D9E5;
        Wed, 29 Apr 2020 08:28:38 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id BFF5E1753B; Wed, 29 Apr 2020 10:28:37 +0200 (CEST)
Date:   Wed, 29 Apr 2020 10:28:37 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Caicai <caizhaopeng@uniontech.com>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org,
        dri-devel@lists.freedesktop.org,
        "linux-kernel@vger.kernel.org\"" <linux-kernel@vger.kernel.org>,
        Zhangyueqian <zhangyueqian@uniontech.com>,
        "Denis V. Lunev" <den@virtuozzo.com>
Subject: Re: [PATCH 1/1] drm/qxl: add mutex_lock/mutex_unlock to ensure the
 order in which resources are rele
Message-ID: <20200429082837.uedcapxmennuc5a2@sirius.home.kraxel.org>
References: <bc954de7-bfe0-8e0c-79d4-90d726a0ffa6@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc954de7-bfe0-8e0c-79d4-90d726a0ffa6@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> > The only way I see for this to happen is that the guest is preempted
> > between qxl_push_{cursor,command}_ring_release() and
> > qxl_release_fence_buffer_objects() calls.  The host can complete the qxl
> > command then, signal the guest, and the IRQ handler calls
> > qxl_release_free_list() before qxl_release_fence_buffer_objects() runs.
> 
> We think the same: qxl_release was freed by garbage collector before
> original thread had called qxl_release_fence_buffer_objects().

Ok, nice, I think we can consider the issue being analyzed then ;)

> > Looking through the code I think it should be safe to simply swap the
> > qxl_release_fence_buffer_objects() +
> > qxl_push_{cursor,command}_ring_release() calls to close that race
> > window.  Can you try that and see if it fixes the bug for you?
> 
> I'm going to prepare and test such patch but I have one question here:
> qxl_push_*_ring_release can be called with  interruptible=true and fail
> How to correctly handle this case? Is the hunk below correct from your POV?

Oh, right, the error code path will be quite different, checking ...

> --- a/drivers/gpu/drm/qxl/qxl_ioctl.c
> +++ b/drivers/gpu/drm/qxl/qxl_ioctl.c
> @@ -261,12 +261,8 @@ static int qxl_process_single_command(struct qxl_device *qdev,
>                         apply_surf_reloc(qdev, &reloc_info[i]);
>         }
>  
> +       qxl_release_fence_buffer_objects(release);
>         ret = qxl_push_command_ring_release(qdev, release, cmd->type, true);
> -       if (ret)
> -               qxl_release_backoff_reserve_list(release);  <<<< ????
> -       else
> -               qxl_release_fence_buffer_objects(release);
> -
>  out_free_bos:
>  out_free_release:
	if (ret)
		qxl_release_free(qdev, release);

[ code context added ]

qxl_release_free() checks whenever a release is fenced and signals the
fence in case it is so it doesn't wait for the signal forever.  So, yes,
I think qxl_release_free() should cleanup the release properly in any
case and the patch chunk should be correct.

take care,
  Gerd

