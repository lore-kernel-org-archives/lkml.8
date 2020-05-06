Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6775BC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 07:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45F7C207DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 07:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Blpzrd2W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728509AbgEFHxl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 03:53:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53446 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728412AbgEFHxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 03:53:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588751619;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8W0xSmvUlYVndDM8MoTsGUiUlHlecuHz50ZkJqJ3zCY=;
        b=Blpzrd2Wm0O93KkVoSr1gHv6p+sBFkuXSXZOtue0JcgVJj5D4vrnSn0Md2XvG5gsoDvf4z
        rRBUyUEu+fgKB0LTd61nNmnA8rD+0HldQIVjWnFdL4x0xfYrYtuh7TIwd1zsHFf25jy41R
        h+CLBr6obYatALYAFJaZb2dOZV4F93g=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-XFdgnQjZP5aZb8ahg5twRw-1; Wed, 06 May 2020 03:53:36 -0400
X-MC-Unique: XFdgnQjZP5aZb8ahg5twRw-1
Received: by mail-wr1-f72.google.com with SMTP id f15so899179wrj.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 00:53:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8W0xSmvUlYVndDM8MoTsGUiUlHlecuHz50ZkJqJ3zCY=;
        b=PDCCG/n6w7aTbjIDYM13Mv4hO3hDUgkk2cPauIBeTMkDq/a3Lij7F8az0M5P3oBfkd
         slvptknd47q478mkyaU36QGG5hOZvlbLhPx07Pb53RwKejIwhNWhA86aGohkkyVHpUJw
         Ad2MKbRFLqizNCt79NQ1HumzKoEqWK3iJYeN5UMlX/0pBv1TnM8fIbtC1Ri+A3pB4W3j
         hr3rkFfRhWM/dOlu2DdtFAH1FGmtZloEJEa2XNyYUTwFIEBbUx9Q+4rj6rgz5GblT9Bw
         kv3zaPnHCCPLBXlj85IpLjyf65pdT+eRs05gjyltyylfkeLojWLghVFCm1XYiahl5oAA
         1eMw==
X-Gm-Message-State: AGi0PubjHK1dAaiAm3wtabB4KW+xyhYKsRgJ8mvQy/0ZTCCZdSBRIteN
        xrylKqE6gZXYlIFjpuX/LQyRi0YxY34yt7y1XH6OUDyUGk95OkQfcFBGV3nytnscRNosjp7I5GG
        oy2BotBj6TZM9EWXMPqxW1WNi
X-Received: by 2002:a5d:6692:: with SMTP id l18mr8511147wru.423.1588751614940;
        Wed, 06 May 2020 00:53:34 -0700 (PDT)
X-Google-Smtp-Source: APiQypI/1wp+em/vQpb50Bo7ALnQIlQcctHrYO0O4kec4Eg43lHoV1FZjHRLjxj87amFb1+gASDZpQ==
X-Received: by 2002:a5d:6692:: with SMTP id l18mr8511130wru.423.1588751614751;
        Wed, 06 May 2020 00:53:34 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
        by smtp.gmail.com with ESMTPSA id p190sm1710263wmp.38.2020.05.06.00.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 00:53:34 -0700 (PDT)
Date:   Wed, 6 May 2020 03:53:31 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH net-next 1/2] virtio-net: don't reserve space for vnet
 header for XDP
Message-ID: <20200506033834-mutt-send-email-mst@kernel.org>
References: <20200506061633.16327-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506061633.16327-1-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 02:16:32PM +0800, Jason Wang wrote:
> We tried to reserve space for vnet header before
> xdp.data_hard_start. But this is useless since the packet could be
> modified by XDP which may invalidate the information stored in the
> header and there's no way for XDP to know the existence of the vnet
> header currently.

What do you mean? Doesn't XDP_PASS use the header in the buffer?

> So let's just not reserve space for vnet header in this case.

In any case, we can find out XDP does head adjustments
if we need to.


> Cc: Jesper Dangaard Brouer <brouer@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/net/virtio_net.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 11f722460513..98dd75b665a5 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -684,8 +684,8 @@ static struct sk_buff *receive_small(struct net_device *dev,
>  			page = xdp_page;
>  		}
>  
> -		xdp.data_hard_start = buf + VIRTNET_RX_PAD + vi->hdr_len;
> -		xdp.data = xdp.data_hard_start + xdp_headroom;
> +		xdp.data_hard_start = buf + VIRTNET_RX_PAD;
> +		xdp.data = xdp.data_hard_start + xdp_headroom + vi->hdr_len;
>  		xdp.data_end = xdp.data + len;
>  		xdp.data_meta = xdp.data;
>  		xdp.rxq = &rq->xdp_rxq;
> @@ -845,7 +845,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
>  		 * the descriptor on if we get an XDP_TX return code.
>  		 */
>  		data = page_address(xdp_page) + offset;
> -		xdp.data_hard_start = data - VIRTIO_XDP_HEADROOM + vi->hdr_len;
> +		xdp.data_hard_start = data - VIRTIO_XDP_HEADROOM;
>  		xdp.data = data + vi->hdr_len;
>  		xdp.data_end = xdp.data + (len - vi->hdr_len);
>  		xdp.data_meta = xdp.data;
> -- 
> 2.20.1

