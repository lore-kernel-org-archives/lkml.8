Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 981F7C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 15:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72F79206F4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 15:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ls1xk/qf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730066AbgFJPN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 11:13:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50083 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730056AbgFJPN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 11:13:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591802034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UCaS5B0zDLBWnfrEXUqdrW0d6LJpY2CfoA/LuwizqL4=;
        b=Ls1xk/qfaKZVEoeux1dbDR6coWYqxOoriNXYK2Uxko9Kr8MQr3FRnvxQgjVUn795gIPqYQ
        u9aafpuDwW3ZU4u81xi86TRts6JckGEaLUNOPQSq0qdWWQ4FxGtj2kUQ6tXlvYfnGpdLXI
        GSt1JKC2J0o2YqzewFIzMZna7je5qM4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-SH615xblPOe7e8efm2W-3g-1; Wed, 10 Jun 2020 11:13:52 -0400
X-MC-Unique: SH615xblPOe7e8efm2W-3g-1
Received: by mail-wr1-f72.google.com with SMTP id r5so1219807wrt.9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 08:13:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UCaS5B0zDLBWnfrEXUqdrW0d6LJpY2CfoA/LuwizqL4=;
        b=HtzzDO/Lp5g8fsM6bNW+O0DFcdC6cVYFj1X7tqic+N2/qKnwHkr598dcMnc5hfbSnf
         fcsjZI3L1q3RhyOBZCNvDjq+FqRJNlhbfDj9YF1fWAj8un/CdtI8DzQlDRysFDlW2Ab8
         v+uYPrnJ23W/pinB0bNcMv99ezrGFbPZXjJQKzIjNrw9QID/0JAxowSDU6FhKwxiLBPo
         i5rQa5OPtwPKZy360mjqzFKyA7R5S685PEBrZcmo8U6zRkeL0BpOgK3HUuRTfArZjB/2
         WMPnOoyPv70ehIFpNA/m/uag3/tyCVnlx9VtOd5u6eXwLkD44k6cO4RVEMAMg8FxN2YH
         vMhw==
X-Gm-Message-State: AOAM532bUWZjEbbeDR0gXqiAObtQVnjMVFltjwYP9fOw4+K3o0hEvvbm
        rNuCCJ17akYLJA+OCc9sx/lTPKKiTQ7tbLz1FX742gLll5n4lYg02Zlq+/Qj5tWrk4dNw/Dgymf
        14HVdZBoAAktaqX7WLIpOZySq
X-Received: by 2002:adf:e285:: with SMTP id v5mr4183929wri.129.1591802031334;
        Wed, 10 Jun 2020 08:13:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy5S2qkrPk2gAmC4EmpHPkNmzHg3zetZnJqn/ot/vPFPTwl3usyYGmWEmhMX3VrjvnwAgO0OQ==
X-Received: by 2002:adf:e285:: with SMTP id v5mr4183909wri.129.1591802031104;
        Wed, 10 Jun 2020 08:13:51 -0700 (PDT)
Received: from eperezma.remote.csb (109.141.78.188.dynamic.jazztel.es. [188.78.141.109])
        by smtp.gmail.com with ESMTPSA id u12sm102944wrq.90.2020.06.10.08.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 08:13:50 -0700 (PDT)
Message-ID: <f2e20055215fcfb63eb4839644c1578b21aeded9.camel@redhat.com>
Subject: Re: [PATCH RFC v7 04/14] vhost/net: pass net specific struct pointer
From:   Eugenio =?ISO-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>
Date:   Wed, 10 Jun 2020 17:13:48 +0200
In-Reply-To: <20200610113515.1497099-5-mst@redhat.com>
References: <20200610113515.1497099-1-mst@redhat.com>
         <20200610113515.1497099-5-mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-6.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-06-10 at 07:36 -0400, Michael S. Tsirkin wrote:
> In preparation for further cleanup, pass net specific pointer
> to ubuf callbacks so we can move net specific fields
> out to net structures.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/vhost/net.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index bf5e1d81ae25..ff594eec8ae3 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -94,7 +94,7 @@ struct vhost_net_ubuf_ref {
>  	 */
>  	atomic_t refcount;
>  	wait_queue_head_t wait;
> -	struct vhost_virtqueue *vq;
> +	struct vhost_net_virtqueue *nvq;
>  };
>  
>  #define VHOST_NET_BATCH 64
> @@ -231,7 +231,7 @@ static void vhost_net_enable_zcopy(int vq)
>  }
>  
>  static struct vhost_net_ubuf_ref *
> -vhost_net_ubuf_alloc(struct vhost_virtqueue *vq, bool zcopy)
> +vhost_net_ubuf_alloc(struct vhost_net_virtqueue *nvq, bool zcopy)
>  {
>  	struct vhost_net_ubuf_ref *ubufs;
>  	/* No zero copy backend? Nothing to count. */
> @@ -242,7 +242,7 @@ vhost_net_ubuf_alloc(struct vhost_virtqueue *vq, bool zcopy)
>  		return ERR_PTR(-ENOMEM);
>  	atomic_set(&ubufs->refcount, 1);
>  	init_waitqueue_head(&ubufs->wait);
> -	ubufs->vq = vq;
> +	ubufs->nvq = nvq;
>  	return ubufs;
>  }
>  
> @@ -384,13 +384,13 @@ static void vhost_zerocopy_signal_used(struct vhost_net *net,
>  static void vhost_zerocopy_callback(struct ubuf_info *ubuf, bool success)
>  {
>  	struct vhost_net_ubuf_ref *ubufs = ubuf->ctx;
> -	struct vhost_virtqueue *vq = ubufs->vq;
> +	struct vhost_net_virtqueue *nvq = ubufs->nvq;
>  	int cnt;
>  
>  	rcu_read_lock_bh();
>  
>  	/* set len to mark this desc buffers done DMA */
> -	vq->heads[ubuf->desc].len = success ?
> +	nvq->vq.heads[ubuf->desc].in_len = success ?

Not like this matter a lot, because it will be override in next patches of the series, but `.len` has been replaced by
`.in_len`, making compiler complain. This fixes it:

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index ff594eec8ae3..fdecf39c9ac9 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -390,7 +390,7 @@ static void vhost_zerocopy_callback(struct ubuf_info *ubuf, bool success)
        rcu_read_lock_bh();
 
        /* set len to mark this desc buffers done DMA */
-       nvq->vq.heads[ubuf->desc].in_len = success ?
+       nvq->vq.heads[ubuf->desc].len = success ?
                VHOST_DMA_DONE_LEN : VHOST_DMA_FAILED_LEN;
        cnt = vhost_net_ubuf_put(ubufs);

>  		VHOST_DMA_DONE_LEN : VHOST_DMA_FAILED_LEN;
>  	cnt = vhost_net_ubuf_put(ubufs);
>  
> @@ -402,7 +402,7 @@ static void vhost_zerocopy_callback(struct ubuf_info *ubuf, bool success)
>  	 * less than 10% of times).
>  	 */
>  	if (cnt <= 1 || !(cnt % 16))
> -		vhost_poll_queue(&vq->poll);
> +		vhost_poll_queue(&nvq->vq.poll);
>  
>  	rcu_read_unlock_bh();
>  }
> @@ -1525,7 +1525,7 @@ static long vhost_net_set_backend(struct vhost_net *n, unsigned index, int fd)
>  	/* start polling new socket */
>  	oldsock = vhost_vq_get_backend(vq);
>  	if (sock != oldsock) {
> -		ubufs = vhost_net_ubuf_alloc(vq,
> +		ubufs = vhost_net_ubuf_alloc(nvq,
>  					     sock && vhost_sock_zcopy(sock));
>  		if (IS_ERR(ubufs)) {
>  			r = PTR_ERR(ubufs);

