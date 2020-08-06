Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8589C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1896C22DCC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wzydsvz+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729717AbgHFR2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:28:36 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38867 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730422AbgHFR2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:28:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596734892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MwHd6CcJYEmEuf+YoO55dE8m5E0R87S7YH74U/aXf1A=;
        b=Wzydsvz+CgFV08PnSwCga3m51Yl0+Yh98F/ELo+/7zTJMQIwrdni7S5cuddE4bVPl3k70D
        n7zVtcl+KMA1fkDj25156nCeq6nH3cMzzsmOXalPwxzAMLxPGgsTZEPwKSpXJi7vQYUdBg
        cUUxwACifn8/+2iPNocajYDVCPiq6Zc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-yw4yRZZJNTKvU8TjJjHtNg-1; Thu, 06 Aug 2020 13:28:10 -0400
X-MC-Unique: yw4yRZZJNTKvU8TjJjHtNg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 34FF6106F8C4;
        Thu,  6 Aug 2020 17:28:09 +0000 (UTC)
Received: from horse.redhat.com (ovpn-112-23.rdu2.redhat.com [10.10.112.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D74767C0E5;
        Thu,  6 Aug 2020 17:28:02 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 47886220441; Thu,  6 Aug 2020 13:28:02 -0400 (EDT)
Date:   Thu, 6 Aug 2020 13:28:02 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 31/38] virtio_fs: convert to LE accessors
Message-ID: <20200806172802.GD367847@redhat.com>
References: <20200805134226.1106164-1-mst@redhat.com>
 <20200805134226.1106164-32-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805134226.1106164-32-mst@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 05, 2020 at 09:44:39AM -0400, Michael S. Tsirkin wrote:
> Virtio fs is modern-only. Use LE accessors for config space.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Acked-by: Vivek Goyal <vgoyal@redhat.com>

Vivek

> ---
>  fs/fuse/virtio_fs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index 4c4ef5d69298..104f35de5270 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -606,8 +606,8 @@ static int virtio_fs_setup_vqs(struct virtio_device *vdev,
>  	unsigned int i;
>  	int ret = 0;
>  
> -	virtio_cread(vdev, struct virtio_fs_config, num_request_queues,
> -		     &fs->num_request_queues);
> +	virtio_cread_le(vdev, struct virtio_fs_config, num_request_queues,
> +			&fs->num_request_queues);
>  	if (fs->num_request_queues == 0)
>  		return -EINVAL;
>  
> -- 
> MST
> 

