Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C45A8C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 08:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A2AD2098B
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 08:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KmPWD4qH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgDUInI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 04:43:08 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36847 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726052AbgDUInH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 04:43:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587458586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9iDz7iWPK0i9U6uK8B+Kq/VOxGdFwzyl3Psdz4sCMdw=;
        b=KmPWD4qH/aPr/2RrJUUerU6dXmB3un7+/Z4QcEO9rMLsAWcEJ3GcHwKkzP+743oQOxbso1
        qY8DnGpz8jxROE/hwTegHv1fBjdR9XZLu6kVFwC6+JmxLde11DwAlKissi/GzdOmAbECWa
        bLwWuvG5yYym8OzaUe5nl0z/5qD4rHg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-2FtRnLJzNz2bXqouSQxh6Q-1; Tue, 21 Apr 2020 04:43:04 -0400
X-MC-Unique: 2FtRnLJzNz2bXqouSQxh6Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9DD0F190B2A0;
        Tue, 21 Apr 2020 08:43:02 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-193.ams2.redhat.com [10.36.113.193])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D5A351001B30;
        Tue, 21 Apr 2020 08:43:01 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id AB34016E16; Tue, 21 Apr 2020 10:43:00 +0200 (CEST)
Date:   Tue, 21 Apr 2020 10:43:00 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Caicai <caizhaopeng@uniontech.com>
Cc:     Dave Airlie <airlied@redhat.com>, David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Zhangyueqian <zhangyueqian@uniontech.com>,
        Zhangshuang <zhangshuang@uniontech.com>,
        Zhangshiwen <zhangshiwen@uniontech.com>
Subject: Re: [PATCH 1/1] drm/qxl: add mutex_lock/mutex_unlock to ensure the
 order in which resources are released.
Message-ID: <20200421084300.zggroiptwbrblzqy@sirius.home.kraxel.org>
References: <20200418063917.26278-1-caizhaopeng@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200418063917.26278-1-caizhaopeng@uniontech.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 18, 2020 at 02:39:17PM +0800, Caicai wrote:
> When a qxl resource is released, the list that needs to be released is
> fetched from the linked list ring and cleared. When you empty the list,
> instead of trying to determine whether the ttm buffer object for each
> qxl in the list is locked, you release the qxl object and remove the
> element from the list until the list is empty. It was found that the
> linked list was cleared first, and that the lock on the corresponding
> ttm Bo for the QXL had not been released, so that the new qxl could not
> be locked when it used the TTM.

So the dma_resv_reserve_shared() call in qxl_release_validate_bo() is
unbalanced?  Because the dma_resv_unlock() call in
qxl_release_fence_buffer_objects() never happens due to
qxl_release_free_list() clearing the list beforehand?  Is that correct?

The only way I see for this to happen is that the guest is preempted
between qxl_push_{cursor,command}_ring_release() and
qxl_release_fence_buffer_objects() calls.  The host can complete the qxl
command then, signal the guest, and the IRQ handler calls
qxl_release_free_list() before qxl_release_fence_buffer_objects() runs.

Looking through the code I think it should be safe to simply swap the
qxl_release_fence_buffer_objects() +
qxl_push_{cursor,command}_ring_release() calls to close that race
window.  Can you try that and see if it fixes the bug for you?

>  		if (flush)
> -			flush_work(&qdev->gc_work);
> +			//can't flush work, it may lead to deadlock
> +			usleep_range(500, 1000);
> +

The commit message doesn't explain this chunk.

take care,
  Gerd

