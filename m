Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A05BDC47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 14:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E21620708
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 14:41:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XPu4qCyE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729468AbgEAOlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 10:41:02 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36807 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728918AbgEAOlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 10:41:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588344059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FMCVUX3SZIQcfGxvWeP6Mw5R9IcHL0EXZloLxMg4CEI=;
        b=XPu4qCyELR0pt0+mjhA+gfy8tvJCVCfZVHh74qB7Yc9Kt1mVo8Oi8PYQwdW7O/XjxpEo+f
        n6pJpCwwFDPQkfgV2dk974zJakLRPabdX3q2mjYHsZ/zVveU1z4xRrgQ0sUhTmm83gVZWZ
        BcusGtGoovEQGbr+n0Kj/omU5wIwF30=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-t_d-xH-SNBm7h800OJtL5w-1; Fri, 01 May 2020 10:40:56 -0400
X-MC-Unique: t_d-xH-SNBm7h800OJtL5w-1
Received: by mail-wr1-f71.google.com with SMTP id r11so5754296wrx.21
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 07:40:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FMCVUX3SZIQcfGxvWeP6Mw5R9IcHL0EXZloLxMg4CEI=;
        b=ByE0+uJVILjKUck5eZjRnJVLJ87NMRDQpGgHqSr5kHXs8b0bcP+WeugIL2t6d7CYYJ
         hWPg4OqN3CU2CCb06V0ULGIWSJPr7Fhqe9JNtZd47rwYJ7wLUvouCnv9Sw34vu5gjlSf
         OtAcPD8awhuvRawyIDsvBiWG6Wd8AqpDaIeC7O3M6HkDU/RlOYGBqS2m1AdEzEykth6z
         nzm78SxwUG2lqy5zoKdVliPkeGOvyxSeH4bCpco71ILiSznU4b/s35Dg6BqBqDoHffg1
         a3hmVuJPNw5KhRQyKcogJpZRTdz7KoL92R84wITmvZVh29jezQFtCTtKzentV0WDoS54
         4wxw==
X-Gm-Message-State: AGi0PuZ65D/XBMhIT12dgIQOe0MNS+TnSreRCrghAV0BWJI0VV7vbefJ
        xO5flbjSQH0ysQLc7JIjEjjqSEsKSr7QkYeA7NUBKltDMX6auej5Xj/XyswZ9rtSDeF9TwpMECd
        EEQ3UKEdGKdvOeXtOJFHG+g5L
X-Received: by 2002:adf:df82:: with SMTP id z2mr4930986wrl.58.1588344054920;
        Fri, 01 May 2020 07:40:54 -0700 (PDT)
X-Google-Smtp-Source: APiQypIlKvu49W7Dejd9vm/UPweyZkYbpJJGe7ZlU91a4UNN1ZrYUoJL1vdxXdT4Bd7iUQNCZUPcMg==
X-Received: by 2002:adf:df82:: with SMTP id z2mr4930967wrl.58.1588344054718;
        Fri, 01 May 2020 07:40:54 -0700 (PDT)
Received: from steredhat (host108-207-dynamic.49-79-r.retail.telecomitalia.it. [79.49.207.108])
        by smtp.gmail.com with ESMTPSA id j13sm4611452wrq.24.2020.05.01.07.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 07:40:53 -0700 (PDT)
Date:   Fri, 1 May 2020 16:40:51 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jia He <justin.he@arm.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kaly Xin <Kaly.Xin@arm.com>
Subject: Re: [PATCH v2] vhost: vsock: kick send_pkt worker once device is
 started
Message-ID: <20200501144051.aotbofpyuy5tqcfp@steredhat>
References: <20200501043840.186557-1-justin.he@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501043840.186557-1-justin.he@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 01, 2020 at 12:38:40PM +0800, Jia He wrote:
> Ning Bo reported an abnormal 2-second gap when booting Kata container [1].
> The unconditional timeout was caused by VSOCK_DEFAULT_CONNECT_TIMEOUT of
> connecting from the client side. The vhost vsock client tries to connect
> an initializing virtio vsock server.
> 
> The abnormal flow looks like:
> host-userspace           vhost vsock                       guest vsock
> ==============           ===========                       ============
> connect()     -------->  vhost_transport_send_pkt_work()   initializing
>    |                     vq->private_data==NULL
>    |                     will not be queued
>    V
> schedule_timeout(2s)
>                          vhost_vsock_start()  <---------   device ready
>                          set vq->private_data
> 
> wait for 2s and failed
> connect() again          vq->private_data!=NULL         recv connecting pkt
> 
> Details:
> 1. Host userspace sends a connect pkt, at that time, guest vsock is under
>    initializing, hence the vhost_vsock_start has not been called. So
>    vq->private_data==NULL, and the pkt is not been queued to send to guest
> 2. Then it sleeps for 2s
> 3. After guest vsock finishes initializing, vq->private_data is set
> 4. When host userspace wakes up after 2s, send connecting pkt again,
>    everything is fine.
> 
> As suggested by Stefano Garzarella, this fixes it by additional kicking the
> send_pkt worker in vhost_vsock_start once the virtio device is started. This
> makes the pending pkt sent again.
> 
> After this patch, kata-runtime (with vsock enabled) boot time is reduced
> from 3s to 1s on a ThunderX2 arm64 server.
> 
> [1] https://github.com/kata-containers/runtime/issues/1917
> 
> Reported-by: Ning Bo <n.b@live.com>
> Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Jia He <justin.he@arm.com>
> ---
> v2: new solution suggested by Stefano Garzarella
> 
>  drivers/vhost/vsock.c | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

> 
> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index e36aaf9ba7bd..0716a9cdffee 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -543,6 +543,11 @@ static int vhost_vsock_start(struct vhost_vsock *vsock)
>  		mutex_unlock(&vq->mutex);
>  	}
>  
> +	/* Some packets may have been queued before the device was started,
> +	 * let's kick the send worker to send them.
> +	 */
> +	vhost_work_queue(&vsock->dev, &vsock->send_pkt_work);
> +
>  	mutex_unlock(&vsock->dev.mutex);
>  	return 0;
>  
> -- 
> 2.17.1
> 

