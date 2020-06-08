Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 574C4C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 17:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24D8B20760
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 17:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UlwFlZRU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387477AbgFHRJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 13:09:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42929 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730701AbgFHRJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 13:09:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591636137;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sI72Ms6GymnWW5IgfsQfm5B7QZQFkpb/EFt5z5NFsqI=;
        b=UlwFlZRUpFc7w+YwBK3XcWXSBoqFzo5uIGHoS/3uA+OuQVxaSIr8bHut/MDYLmbvu4TXYj
        0pBqoqctNKKg5Qjjnf1XTxhkThkibgEiQ6KBwCg1gWB7RjdslCDxCS0cvvdAGi7TkNRnuJ
        k3PEkMqiOHh7MqbfWgx01Z72jfP4vzY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235--bi5KKb3O9K-aWug7gC55g-1; Mon, 08 Jun 2020 13:08:54 -0400
X-MC-Unique: -bi5KKb3O9K-aWug7gC55g-1
Received: by mail-wr1-f71.google.com with SMTP id f4so7422586wrp.21
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 10:08:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sI72Ms6GymnWW5IgfsQfm5B7QZQFkpb/EFt5z5NFsqI=;
        b=mn5QXIUfyveWDwA7VPOxqSrU8N4WVJtEZnSg9VTDv+7/z8NONS7HWy2yCe6HFOC2GM
         ugZPvgPp7+VPI4hgenbcRt4FrsOhJ4R/XF1Jqr6+02rgYXxwsWK7AhoKvybZ5/GmU7GU
         m+OiTWiiBFqdTVKPV5I2QxJJ/Lm+6yxEJKw1jY895QASXalFwk2n897GvNxiTIykBQDW
         FyxdI/ogcuaz3pTIATF7cfPHHKlpTnSWB6keTymUT3dD18GJlDbvdJBGdxqAahK6Gr6F
         +r8hX5zTDsTif3Yl8W9aVcuoWXjluDtgzZfcroOssx/teSMc3IGfKL4oiL6J+ETXK0fn
         rd3w==
X-Gm-Message-State: AOAM533TrzwAR3xZthHxpAVcZ8zxyHBTi72kxuh99x6DvrmkzSqEDaCg
        WXu5wLlRGI69TGpxgtrW4cSgJQJ2K/70Tqp0NfeoEmCybEw17FALznMgpnsBwW8ZyqMWLWc5FLV
        di+HBgdcGYt383MgtcyQTaWKq
X-Received: by 2002:a1c:3b43:: with SMTP id i64mr339444wma.112.1591636132900;
        Mon, 08 Jun 2020 10:08:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw4dUf9x3rgVZHJRvrEuMPKhxm/lCre/+sG86XOaArTyYsFZli8wP4z+s74imLE54MU9CeoNw==
X-Received: by 2002:a1c:3b43:: with SMTP id i64mr339413wma.112.1591636132598;
        Mon, 08 Jun 2020 10:08:52 -0700 (PDT)
Received: from steredhat ([79.49.207.108])
        by smtp.gmail.com with ESMTPSA id l2sm342741wru.58.2020.06.08.10.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 10:08:51 -0700 (PDT)
Date:   Mon, 8 Jun 2020 19:08:49 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>, eperezma@redhat.com,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH RFC v6 10/11] vhost/vsock: switch to the buf API
Message-ID: <20200608170849.udaxzmfzmhbonoi7@steredhat>
References: <20200608125238.728563-1-mst@redhat.com>
 <20200608125238.728563-11-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200608125238.728563-11-mst@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 08, 2020 at 08:53:13AM -0400, Michael S. Tsirkin wrote:
> A straight-forward conversion.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/vhost/vsock.c | 30 ++++++++++++++++++------------
>  1 file changed, 18 insertions(+), 12 deletions(-)

I ran the vsock tests again with this new series and everything seems
to go well:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Tested-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

> 
> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index a483cec31d5c..61c6d3dd2ae3 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -103,7 +103,8 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
>  		unsigned out, in;
>  		size_t nbytes;
>  		size_t iov_len, payload_len;
> -		int head;
> +		struct vhost_buf buf;
> +		int ret;
>  
>  		spin_lock_bh(&vsock->send_pkt_list_lock);
>  		if (list_empty(&vsock->send_pkt_list)) {
> @@ -117,16 +118,17 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
>  		list_del_init(&pkt->list);
>  		spin_unlock_bh(&vsock->send_pkt_list_lock);
>  
> -		head = vhost_get_vq_desc(vq, vq->iov, ARRAY_SIZE(vq->iov),
> -					 &out, &in, NULL, NULL);
> -		if (head < 0) {
> +		ret = vhost_get_avail_buf(vq, &buf,
> +					  vq->iov, ARRAY_SIZE(vq->iov),
> +					  &out, &in, NULL, NULL);
> +		if (ret < 0) {
>  			spin_lock_bh(&vsock->send_pkt_list_lock);
>  			list_add(&pkt->list, &vsock->send_pkt_list);
>  			spin_unlock_bh(&vsock->send_pkt_list_lock);
>  			break;
>  		}
>  
> -		if (head == vq->num) {
> +		if (!ret) {
>  			spin_lock_bh(&vsock->send_pkt_list_lock);
>  			list_add(&pkt->list, &vsock->send_pkt_list);
>  			spin_unlock_bh(&vsock->send_pkt_list_lock);
> @@ -186,7 +188,8 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
>  		 */
>  		virtio_transport_deliver_tap_pkt(pkt);
>  
> -		vhost_add_used(vq, head, sizeof(pkt->hdr) + payload_len);
> +		buf.in_len = sizeof(pkt->hdr) + payload_len;
> +		vhost_put_used_buf(vq, &buf);
>  		added = true;
>  
>  		pkt->off += payload_len;
> @@ -440,7 +443,8 @@ static void vhost_vsock_handle_tx_kick(struct vhost_work *work)
>  	struct vhost_vsock *vsock = container_of(vq->dev, struct vhost_vsock,
>  						 dev);
>  	struct virtio_vsock_pkt *pkt;
> -	int head, pkts = 0, total_len = 0;
> +	int ret, pkts = 0, total_len = 0;
> +	struct vhost_buf buf;
>  	unsigned int out, in;
>  	bool added = false;
>  
> @@ -461,12 +465,13 @@ static void vhost_vsock_handle_tx_kick(struct vhost_work *work)
>  			goto no_more_replies;
>  		}
>  
> -		head = vhost_get_vq_desc(vq, vq->iov, ARRAY_SIZE(vq->iov),
> -					 &out, &in, NULL, NULL);
> -		if (head < 0)
> +		ret = vhost_get_avail_buf(vq, &buf,
> +					  vq->iov, ARRAY_SIZE(vq->iov),
> +					  &out, &in, NULL, NULL);
> +		if (ret < 0)
>  			break;
>  
> -		if (head == vq->num) {
> +		if (!ret) {
>  			if (unlikely(vhost_enable_notify(&vsock->dev, vq))) {
>  				vhost_disable_notify(&vsock->dev, vq);
>  				continue;
> @@ -494,7 +499,8 @@ static void vhost_vsock_handle_tx_kick(struct vhost_work *work)
>  			virtio_transport_free_pkt(pkt);
>  
>  		len += sizeof(pkt->hdr);
> -		vhost_add_used(vq, head, len);
> +		buf.in_len = len;
> +		vhost_put_used_buf(vq, &buf);
>  		total_len += len;
>  		added = true;
>  	} while(likely(!vhost_exceeds_weight(vq, ++pkts, total_len)));
> -- 
> MST
> 

