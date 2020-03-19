Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B754DC4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 11:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86BAE20724
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 11:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z35VKlFh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgCSLCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 07:02:39 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:27832 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726663AbgCSLCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 07:02:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584615757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wv0CIJUyl8keYTWgcuAGZ94Xhx3biDTfmG+KzaIIjzY=;
        b=Z35VKlFhVBqxLyCfBzP7jz54Ryns9E4tDd2xm+Tu4koDAKWDTsSuSz8rlTEgJA2E2e9K7m
        Zc/dcw+/McxxrNe1RcuA3APHFGVQ5vds8xvFWo82nsVh3pK7UgKrwYoxLagThzVZ9Al/Hg
        I6wN20bTo0rsxtjOVP2IHS8/RqDTFlo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-1-_FJnZKOjStqy_fyQIQYQ-1; Thu, 19 Mar 2020 07:02:33 -0400
X-MC-Unique: 1-_FJnZKOjStqy_fyQIQYQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A93E18C8C02;
        Thu, 19 Mar 2020 11:02:32 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-49.ams2.redhat.com [10.36.112.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 239CB5C1D8;
        Thu, 19 Mar 2020 11:02:31 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 4973E3BD; Thu, 19 Mar 2020 12:02:30 +0100 (CET)
Date:   Thu, 19 Mar 2020 12:02:30 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Gurchetan Singh <gurchetansingh@chromium.org>
Subject: Re: [PATCH] drm/virtio: fix OOB in virtio_gpu_object_create
Message-ID: <20200319110230.rxezuk3ex5fbov3f@sirius.home.kraxel.org>
References: <20200319100421.16267-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200319100421.16267-1-jslaby@suse.cz>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 11:04:21AM +0100, Jiri Slaby wrote:
> After commit f651c8b05542, virtio_gpu_create_object allocates too small
> space to fit everything in. It is because it allocates struct
> virtio_gpu_object, but should allocate a newly added struct
> virtio_gpu_object_shmem which has 2 more members.
> 
> So fix that by using correct type in virtio_gpu_create_object.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Fixes: f651c8b05542 ("drm/virtio: factor out the sg_table from virtio_gpu_object")
> Cc: Gurchetan Singh <gurchetansingh@chromium.org>
> Cc: Gerd Hoffmann <kraxel@redhat.com>

That was fast.  Yes, exactly this.  Pushed to drm-misc-next.

thanks,
  Gerd

