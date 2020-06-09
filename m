Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E825C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 23:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B1752072F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 23:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591744000;
	bh=Wzi8oef6iZ3b/Z33PF0patJWIY9kvxxNOXMI1MjZCIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZHM6519M98R/czH1gswRBQYVdQMeLdIR31hnzkZwgcdlFZ00oNpMWCtd8mtnWrAU9
	 XS5bpyMtHTI1VB+FKUniV2qI+zt45U51yyORNgfrl7hmNiNUtwPr+8PZKk6NcsP/3W
	 y7j7kTyjZCh5yR/mPhWG8/VnrbZUBlnDsB8HtZgo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728954AbgFIXGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 19:06:39 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:41999 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728522AbgFIXGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 19:06:38 -0400
Received: by mail-il1-f194.google.com with SMTP id 18so100917iln.9;
        Tue, 09 Jun 2020 16:06:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lowGDgqik15FywyulT8g8hjG3BqBie9BHX3NbVdEAb8=;
        b=NaLAM6GZjNQpV5ukpBJ+mvNTXIDOSxjAVf79+0PLPNhh7pWvPZ7X6Pe6WESubAPJMJ
         ckbCbP3+ZzaZuLE7+y8yR+t8GTs9MypKKKz981kyh3LDLh/mYfQM9wW9NCs0LjVRObHW
         D/V4wu7HtzRK/UFcs2W0Q3TTbLKJq+H8G1ilA7J8N7C2TDgrq3VGiYyNkmEcqQLySvC8
         aDoW9O9kbGuGX3p1cAiTjCKqc8aX7kPGYkC84AoqKUt7n9iUxIQ7TO2L9+vrWrq/mCap
         /DrfKrs8WYy2Elq+Z55EKBDNAQVUaOAz0hYOUa6xy37W4mgF0/W2V8cBsDziJZHIdKqK
         WzZw==
X-Gm-Message-State: AOAM5302IIE0pvG8Bl4t8YEaHqPc1N03EoJBdd/ixKuMXfyFsIt3zRBv
        OL33Y6QHkyAOXJLzYzlARw==
X-Google-Smtp-Source: ABdhPJzA471O+zLyrUVgcaJtMiMWHipLZjGeKrxG0e9HUEXXPzjEfeCsCCzLurZKeeKMdsHSRLkaRw==
X-Received: by 2002:a92:5e59:: with SMTP id s86mr369637ilb.104.1591743996208;
        Tue, 09 Jun 2020 16:06:36 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id b29sm7856241ioc.32.2020.06.09.16.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 16:06:35 -0700 (PDT)
Received: (nullmailer pid 1677087 invoked by uid 1000);
        Tue, 09 Jun 2020 23:06:34 -0000
Date:   Tue, 9 Jun 2020 17:06:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Roger Quadros <rogerq@ti.com>
Cc:     kishon@ti.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCHv2 2/3] dt-binding: phy: ti,omap-usb2: Add quirk to
 disable charger detection
Message-ID: <20200609230634.GA1674560@bogus>
References: <20200602114606.32045-1-rogerq@ti.com>
 <20200602114606.32045-3-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602114606.32045-3-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 02:46:05PM +0300, Roger Quadros wrote:
> Add "ti,dis-chg-det-quirk" property to disable the USB2_PHY Charger Detect
> logic.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  Documentation/devicetree/bindings/phy/ti,omap-usb2.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/ti,omap-usb2.yaml b/Documentation/devicetree/bindings/phy/ti,omap-usb2.yaml
> index 2bbea8d2bcb1..5e8c7a98de1e 100644
> --- a/Documentation/devicetree/bindings/phy/ti,omap-usb2.yaml
> +++ b/Documentation/devicetree/bindings/phy/ti,omap-usb2.yaml
> @@ -50,6 +50,11 @@ properties:
>        (deprecated) phandle of the control module used by PHY driver
>        to power on the PHY. Use syscon-phy-power instead.
>  
> +  ti,dis-chg-det-quirk:

Bikeshed:

ti,disable-charge-det

Reviewed-by: Rob Herring <robh@kernel.org>

> +    description:
> +      if present, driver will disable charger detection logic.
> +    type: boolean
> +
>  required:
>    - compatible
>    - reg
> -- 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 
