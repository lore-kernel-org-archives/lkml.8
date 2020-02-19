Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7884C34047
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 12:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE1DB24654
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 12:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wvTEMRu6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbgBSMgg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 07:36:36 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35208 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbgBSMgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 07:36:36 -0500
Received: by mail-wm1-f68.google.com with SMTP id b17so505041wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 04:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=e1KT/bGjXdS9JX36oYOobEWFP9+9W68S7UedIsUPL3g=;
        b=wvTEMRu62ptTSLne83UAS/8TEW7UxSrhbG1LVY3oBfEBItR+m5QjfxK5dQr9NifGft
         UNKysyLr9HQd77BiQeECDkigzsckGT3nNYCiBxFXpcXhLyugZlqOBC8ApoAh3cEOfVTB
         kidpv/aznZ5R/iCDpFXdI906intbC0yWh0HF81iIMuukY1dKfW/PEhcq7k36M34bmaiq
         p/ap+2SEYw64zC9WeJRef1upliHpDswNNL36BIqKATRqQH0MhM984prn0F7ipUcl6w+S
         mmv1cmtTmcYnnnBcUQA+atbKHlmikIwLFPABmhbA/jUcfB8/hGLDezrE7QFiFD0iCAl2
         M5oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e1KT/bGjXdS9JX36oYOobEWFP9+9W68S7UedIsUPL3g=;
        b=H4JqPM9ixUcd5rkJvKQYuz5D14ee9BBmPUrgyg6eHAUzUjFWfi4m3D0LMVJuQzJ+Ya
         9swS2Zh9zDz9CfvL9/DTp7S6JsjgSPk3/ZMYHV+X4BF8kw3K6vsX4Oh1QPf6Hdlp8RRf
         jabZq01eopBvc3IsFtrlBIvK8h41v7Mue2KWQuZDmt0/hpg4iX36/KEsM9BP/Eln3rcv
         MWFaYuwgWSvBaUNicC1pHyysrcNfFIccI7uULM/F5MntZ3m4CEK5ZoZuG3XvvzC7k0DR
         ZpLsueYZF9WEL6MgveSyw0MSWxci0lMPveplyKn4e3xEI1kAUn9Hxp7c/my4M0eienzB
         lanQ==
X-Gm-Message-State: APjAAAW2MEyUSlUsIVsiqd5/i50rfv8XGVOVX43p53d2/U163d4dfo/E
        CSGzb4qQRUwGX88wSMxUrxi6Xg==
X-Google-Smtp-Source: APXvYqxBfJy9323J1kVWL0P8JS4bRHRmT/7haNAKhAZi8RRkU1GfQ+qPOMG+QE0ZIvZfwhzwoEP4Og==
X-Received: by 2002:a7b:c05a:: with SMTP id u26mr5189887wmc.74.1582115794896;
        Wed, 19 Feb 2020 04:36:34 -0800 (PST)
Received: from apalos.home (ppp-2-87-54-32.home.otenet.gr. [2.87.54.32])
        by smtp.gmail.com with ESMTPSA id c141sm2821179wme.41.2020.02.19.04.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 04:36:34 -0800 (PST)
Date:   Wed, 19 Feb 2020 14:36:31 +0200
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2 10/13] net: socionext: use new helper
 tcp_v6_gso_csum_prep
Message-ID: <20200219123631.GA651277@apalos.home>
References: <fffc8b6d-68ed-7501-18f1-94cf548821fb@gmail.com>
 <6f02ce1c-aef7-6127-1724-72f7eee56810@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f02ce1c-aef7-6127-1724-72f7eee56810@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 09:09:17PM +0100, Heiner Kallweit wrote:
> Use new helper tcp_v6_gso_csum_prep in additional network drivers.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/net/ethernet/socionext/netsec.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/socionext/netsec.c b/drivers/net/ethernet/socionext/netsec.c
> index e8224b543..6266926fe 100644
> --- a/drivers/net/ethernet/socionext/netsec.c
> +++ b/drivers/net/ethernet/socionext/netsec.c
> @@ -1148,11 +1148,7 @@ static netdev_tx_t netsec_netdev_start_xmit(struct sk_buff *skb,
>  				~tcp_v4_check(0, ip_hdr(skb)->saddr,
>  					      ip_hdr(skb)->daddr, 0);
>  		} else {
> -			ipv6_hdr(skb)->payload_len = 0;
> -			tcp_hdr(skb)->check =
> -				~csum_ipv6_magic(&ipv6_hdr(skb)->saddr,
> -						 &ipv6_hdr(skb)->daddr,
> -						 0, IPPROTO_TCP, 0);
> +			tcp_v6_gso_csum_prep(skb);
>  		}
>  
>  		tx_ctrl.tcp_seg_offload_flag = true;
> -- 
> 2.25.1
> 
> 

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
