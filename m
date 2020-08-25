Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8270AC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 19:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68C49207DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 19:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598382145;
	bh=UsX97ie3LWdOPxNzUYsEmiHiw19foauTYVSmUnWaSa8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FbHqZ4QdzvXdYEilovSh7D3Tg0ppLJimgqFMYzMDPfV1mZDqGjgY09zxiBVOYs1x6
	 bJd5nHKVZaT19Ov3H4j6DeiRrIH7gtmfdP7kf8sogp8uDWmqi+Lz5iF9XxLodBzAiK
	 PuXoopWhqA6SmJTPhMb60oMDXjGTl5qo8akpPkfY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgHYTCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 15:02:23 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:46549 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgHYTCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 15:02:23 -0400
Received: by mail-il1-f195.google.com with SMTP id c6so11327734ilo.13;
        Tue, 25 Aug 2020 12:02:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bCUdIkx3EH4ynR39zceLFnFiKqklMoIPLVpCbylMme0=;
        b=DAlqAbcKwIPeZCDLhBKf1K6yqnjkEw1fqTHcDw+wUhkdH1oh9LPaZa+o+TjU0yyBZA
         cszOwGoA4Vg4aHcdCPw+ShATWt50ZWUBfomqsfrM4Fmz2ISXLbr9FND9I6nyf9XMdYs5
         cztev0ipwc+2jKm4YbA0k2xkHR+4BWrUpnPb4oaE1F/vtV/LqcsccEGvOR1LnV2ktEKt
         p4lCDQ3jDoOq4w28SfznZ1pFtSWmIpW4xmXvzdpeI04vWocj5eiMIqlXH0hjSbxB8+7h
         oEZaD+R7Jcd4Bw/n6uLmtNNt9iVzXMzQd3zLxRAARmbnpE8VeY3pxkt50tm/S9uWbI1p
         KD3Q==
X-Gm-Message-State: AOAM530nz78U/emWFzfhJKystyPTQtUbG4qSG32DVqJABsTFPSfNaPXD
        ml7vmSivDrmooreWpkcgGzzfeLxH3kfw
X-Google-Smtp-Source: ABdhPJyp2RzYq4kUaObuB2FkwOWJE9pU5Wa539AYxfYQlLjDNUgMTHsNlNcZd+0aqG3qq9CfEGuYjw==
X-Received: by 2002:a92:8556:: with SMTP id f83mr10122295ilh.135.1598382141887;
        Tue, 25 Aug 2020 12:02:21 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id a11sm9505457ilh.74.2020.08.25.12.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 12:02:21 -0700 (PDT)
Received: (nullmailer pid 1133284 invoked by uid 1000);
        Tue, 25 Aug 2020 19:02:19 -0000
Date:   Tue, 25 Aug 2020 13:02:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Crystal Guo <crystal.guo@mediatek.com>
Cc:     p.zabel@pengutronix.de, matthias.bgg@gmail.com,
        srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, s-anna@ti.com, afd@ti.com,
        seiya.wang@mediatek.com, stanley.chu@mediatek.com,
        yingjoe.chen@mediatek.com, fan.chen@mediatek.com,
        yong.liang@mediatek.com
Subject: Re: [v4,2/4] dt-binding: reset-controller: ti: add
 'mediatek,infra-reset' to compatible
Message-ID: <20200825190219.GA1125997@bogus>
References: <20200817030324.5690-1-crystal.guo@mediatek.com>
 <20200817030324.5690-3-crystal.guo@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817030324.5690-3-crystal.guo@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 11:03:22AM +0800, Crystal Guo wrote:
> The TI syscon reset controller provides a common reset management,
> and is suitable for MTK SoCs. Add compatible 'mediatek,infra-reset',
> which denotes to use ti reset-controller driver directly.
> 
> Signed-off-by: Crystal Guo <crystal.guo@mediatek.com>
> ---
>  Documentation/devicetree/bindings/reset/ti-syscon-reset.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/reset/ti-syscon-reset.txt b/Documentation/devicetree/bindings/reset/ti-syscon-reset.txt
> index ab041032339b..5a0e9365b51b 100644
> --- a/Documentation/devicetree/bindings/reset/ti-syscon-reset.txt
> +++ b/Documentation/devicetree/bindings/reset/ti-syscon-reset.txt
> @@ -25,6 +25,7 @@ Required properties:
>  			    "ti,k2l-pscrst"
>  			    "ti,k2hk-pscrst"
>  			    "ti,syscon-reset"
> +			    "mediatek,infra-reset", "ti,syscon-reset"

You need your own binding doc. If you can use the same driver then fine, 
but that's a separate issue. There's also reset-simple driver if you 
have just array of 32-bit registers with a bit per reset.

Don't repeat 'ti,reset-bits' either.

>   - #reset-cells		: Should be 1. Please see the reset consumer node below
>  			  for usage details
>   - ti,reset-bits	: Contains the reset control register information
> -- 
> 2.18.0
