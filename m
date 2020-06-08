Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F473C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 10:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BA7B207BC
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 10:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cBv8BeBn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729380AbgFHKSA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 06:18:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35284 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729172AbgFHKR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 06:17:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591611475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8qWrXG5uSNE9Dzp6V1sYS5ofw86anDpXXrPKXmMCdEo=;
        b=cBv8BeBn9eK9q7YCOOGLrghlshosq6eJq4gT5YGVCQRS1h34C6K/D5lmGxfDCLkdaAYJM9
        902+A7njENZM5uvFdwwWp51eiIX4Tm0EkPJ6hEjicHOqzokUtMVk9LE8fJuLe4vCVCveEV
        dkyx1WQpquTVEUyGEIDlVVwizMK+ZIE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-1oGKYR1HOUGApazEuTfmKg-1; Mon, 08 Jun 2020 06:17:50 -0400
X-MC-Unique: 1oGKYR1HOUGApazEuTfmKg-1
Received: by mail-wm1-f71.google.com with SMTP id g84so5078239wmf.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 03:17:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8qWrXG5uSNE9Dzp6V1sYS5ofw86anDpXXrPKXmMCdEo=;
        b=If6iXgEmEjWtd8yi6ZfvHFwxyj8LK53k6UyMxEUqkyhUN5hWFnglP2W0qPhTGBx9r/
         9BZLOBnN0Ywt2pfWYfVc+hmo30hrFie2jIXvgdyJTJrmsYRKBUiNt/hBrqc8bctUXPvL
         h1PYl0aFtbx7eU1YFBI/jgILow5XJb08NCQZ/bClETapUjZW2jOLvV/qQD45PfurZHDD
         XVW2/KRif+CLcvHWm7ZyUp6b7wQI7Ls/J3n1JsYnukh2m6BQF1cnL5vwPyon53zZCKGx
         QZibOuwazIe2RBwaMDOOyU/jsJc0Ia4HaL8+RM927PJTBY5YYopFSAnrKcG8ULjEQo+9
         5bTw==
X-Gm-Message-State: AOAM532VOCQkAO6p0RH1+6m59jKFfkwyngFUsRKyLROfG/kSn53xgKOI
        vr9C8F1KwXeaDCoDP+9TyMXOzs2gN9PD+9Eb5YCYXzP6ABflxt97InTfyjqYouQjCzyd6mZO7fw
        r0PKQUYrKccGJJSInizyx3g5W
X-Received: by 2002:a1c:4105:: with SMTP id o5mr15395855wma.168.1591611469370;
        Mon, 08 Jun 2020 03:17:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw01MpQfAn3zflPb7GVdN7FLLZh1HetB9oB+KWr4r5voKTa+SLtxH/AzT7wvjwZnQiGg0J+Pw==
X-Received: by 2002:a1c:4105:: with SMTP id o5mr15395824wma.168.1591611469097;
        Mon, 08 Jun 2020 03:17:49 -0700 (PDT)
Received: from steredhat ([79.49.207.108])
        by smtp.gmail.com with ESMTPSA id a3sm22199003wrp.91.2020.06.08.03.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 03:17:48 -0700 (PDT)
Date:   Mon, 8 Jun 2020 12:17:46 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>, eperezma@redhat.com,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH RFC v5 12/13] vhost/vsock: switch to the buf API
Message-ID: <20200608101746.xnxtwwygolsk7yol@steredhat>
References: <20200607141057.704085-1-mst@redhat.com>
 <20200607141057.704085-13-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200607141057.704085-13-mst@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 07, 2020 at 10:11:49AM -0400, Michael S. Tsirkin wrote:
> A straight-forward conversion.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/vhost/vsock.c | 30 ++++++++++++++++++------------
>  1 file changed, 18 insertions(+), 12 deletions(-)

The changes for vsock part LGTM:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


I also did some tests with vhost-vsock (tools/testing/vsock/vsock_test
and iperf-vsock), so for vsock:

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

