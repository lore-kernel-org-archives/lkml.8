Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C6F1C35DF9
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 11:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E45B321556
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 11:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QKjWlPRF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730444AbgBYLSN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 06:18:13 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41791 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727068AbgBYLSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 06:18:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582629492;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dcSrZJ633LnILl4hKZiWeKSTIw0SGihk9tSKZPfdWUo=;
        b=QKjWlPRFKgalFHUhwfpHEy7wBA90menDufzv8s0sGI6GTY5zciFxXwBlJHFx8AtOO+U8PU
        r4dhlDs4X3w+aNJ7cAy2nTBbXgAEsOfKDTyuQTzm32wQAx08I3nGEcDLw1hVDsjmzb/4ig
        BHSWYS+bbt/c2JoTIfphAbihBMdhSSg=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-nMevkjv_MHi9ROjTvinAkA-1; Tue, 25 Feb 2020 06:18:10 -0500
X-MC-Unique: nMevkjv_MHi9ROjTvinAkA-1
Received: by mail-qt1-f200.google.com with SMTP id t4so14465700qtd.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 03:18:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dcSrZJ633LnILl4hKZiWeKSTIw0SGihk9tSKZPfdWUo=;
        b=ryw2wYeINzW0uYel3QvupJrPH5/6wxRqiwiDrXwoBJL7CoIFSgKNmw5pM9ewxo+sCG
         aDvti2D0CZM7t7Bnj24kUKiu+6lI6OxEUIRUzJ3W/cSjWz09AzR7YQcBFEOBSR0DMzHC
         IFHiD5SoRgJkjdOzESlSCFSwgWmRGC7EVK6gHjd4Ci7rFc60IxEBydoQSRKPmNIaeWPh
         hoHoDOj9hrkOQYpA8sZZPQ2NxOy4kzJZlVKsoRJ+Qy+B6uKtItuwqJmP1Munb9ZOcHyE
         JxTx4JKIbPU5d4zRMH99OJhQL1JxCcKgRpD5pcbldcDnumxIvlLqvQr4ZlSqMnRPuvbH
         ApTg==
X-Gm-Message-State: APjAAAVRv+mMIkWWqgAv9MCyLYwDHlXVDJe3HHCTxs/7FaVwQGVYl2YS
        wjW/Ah0KiNFgjPc1H8M6mjyRirHI6qhtTmvHN56VQXL5DhvZ3j6p0O15tdvKFgxCRRzqmG9kLrr
        /2kkjzpoj3Hh1SuNrTM5iWSTj
X-Received: by 2002:a37:4a46:: with SMTP id x67mr48067760qka.160.1582629490231;
        Tue, 25 Feb 2020 03:18:10 -0800 (PST)
X-Google-Smtp-Source: APXvYqyhsafwxrmKzVs2GlO4jxoUvgmsXom8ElM3DBZS74WODQ6dFFsMn+QDBkv/j91R3JLvi5etkQ==
X-Received: by 2002:a37:4a46:: with SMTP id x67mr48067734qka.160.1582629489996;
        Tue, 25 Feb 2020 03:18:09 -0800 (PST)
Received: from redhat.com (bzq-79-178-2-214.red.bezeqint.net. [79.178.2.214])
        by smtp.gmail.com with ESMTPSA id s19sm5973078qkj.88.2020.02.25.03.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 03:18:08 -0800 (PST)
Date:   Tue, 25 Feb 2020 06:18:01 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Yuya Kusakabe <yuya.kusakabe@gmail.com>
Cc:     jasowang@redhat.com, andriin@fb.com, ast@kernel.org,
        bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        hawk@kernel.org, john.fastabend@gmail.com, kafai@fb.com,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, songliubraving@fb.com, yhs@fb.com
Subject: Re: [PATCH bpf-next v6 1/2] virtio_net: keep vnet header zeroed if
 XDP is loaded for small buffer
Message-ID: <20200225061501-mutt-send-email-mst@kernel.org>
References: <20200225033103.437305-1-yuya.kusakabe@gmail.com>
 <20200225033212.437563-1-yuya.kusakabe@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225033212.437563-1-yuya.kusakabe@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 12:32:11PM +0900, Yuya Kusakabe wrote:
> We do not want to care about the vnet header in receive_small() if XDP
> is loaded, since we can not know whether or not the packet is modified
> by XDP.
> 
> Fixes: f6b10209b90d ("virtio-net: switch to use build_skb() for small buffer")
> Signed-off-by: Yuya Kusakabe <yuya.kusakabe@gmail.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>


> ---
>  drivers/net/virtio_net.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 2fe7a3188282..f39d0218bdaa 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -735,10 +735,10 @@ static struct sk_buff *receive_small(struct net_device *dev,
>  	}
>  	skb_reserve(skb, headroom - delta);
>  	skb_put(skb, len);
> -	if (!delta) {
> +	if (!xdp_prog) {
>  		buf += header_offset;
>  		memcpy(skb_vnet_hdr(skb), buf, vi->hdr_len);
> -	} /* keep zeroed vnet hdr since packet was changed by bpf */
> +	} /* keep zeroed vnet hdr since XDP is loaded */
>  
>  err:
>  	return skb;
> -- 
> 2.24.1

