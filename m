Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BC7C33CAA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 22:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D53024655
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 22:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579644894;
	bh=6Eq6lP+J8xkmDTjFf66pv+50rgm+IHkdDoavDqU/qAg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=q9FLFIBxn5OmbNYKw24gICuL8pfrJM7lihQF+2APkSnvUOB5T2sPqOaydZGY0jSBy
	 LrHsagUeiEJI8kwuYBF1AYEvHCGNn7a5Yt4ez/UbEKawZuFcRgNADt6oflwjE994Lo
	 ngwHENxl+wbjxI3q+z1cT339IRq7y4SHJppEXyd8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729061AbgAUWOw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 17:14:52 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46897 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728609AbgAUWOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 17:14:52 -0500
Received: by mail-oi1-f193.google.com with SMTP id 13so4157232oij.13;
        Tue, 21 Jan 2020 14:14:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XeT9kzkIHCvSt/qNrsfQn5oLTaIKQtpNqKnbt7XpRAU=;
        b=tqwvsjnurKGu9rQOG0U26erhb0Q5i3S1Ov2rrsl6/Y8RlQEqrxKgn6K10mApKy2a0x
         IpDF4gh2ZHAZRpgLe8RjHwMkOxk3q2dBSBEAhoqHa4Zsfv2fLQhoi2Jr6nDb+YRhIdfe
         twlkQDs4w/yRsAJLYrw4yzEm5Twt2/j+e4RLi/4AtF1OLfwx44dLH3v/wfGoUEHcpps7
         Yay8CILP+/wYZJfslmVjaIcFIXfegN9ms9ph3X5yGdEX4Y2fG8JXwPiBcO8r75a9Hmu3
         hDGcwo3q0xYcN5GQjbPFuvVViB8Cj2rWJEhdwFxqdFG5LIluZ/3pEh5pnVfRNTvpiUvY
         EomA==
X-Gm-Message-State: APjAAAWuY4gdGO02zRa2tEBUQGQXnUtHuKzGC+7WU2GV5DWOc5R3p0lF
        Y/2z/1i4J7HIXLtGTQkYYA==
X-Google-Smtp-Source: APXvYqyLemxUnMpNDM+pJQJvFcfqR3NxQi7BGrwaFu5XgWlF4uD8+O0BJuRJD1JSkakbLg1/vTxvxA==
X-Received: by 2002:a05:6808:683:: with SMTP id k3mr4558084oig.50.1579644890978;
        Tue, 21 Jan 2020 14:14:50 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i13sm12372864oik.7.2020.01.21.14.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 14:14:50 -0800 (PST)
Received: (nullmailer pid 1380 invoked by uid 1000);
        Tue, 21 Jan 2020 22:14:49 -0000
Date:   Tue, 21 Jan 2020 16:14:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, kishon@ti.com,
        devicetree@vger.kernel.org, cheol.yong.kim@intel.com,
        andriy.shevchenko@intel.com, qi-ming.wu@intel.com
Subject: Re: [PATCH v1] dt-bindings: phy: Fix for intel,lgm-emmc-phy.yaml
 build error
Message-ID: <20200121221449.GA25322@bogus>
References: <20200114104710.23135-1-vadivel.muruganx.ramuthevar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200114104710.23135-1-vadivel.muruganx.ramuthevar@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 06:47:10PM +0800, Ramuthevar,Vadivel MuruganX wrote:
> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> 
> This patch fixes the devicetree binding yaml build errors
> in linux-next kernel Error: Documentation/devicetree/bindings/
> phy/intel,lgm-emmc-phy.example.dts:21.19-20
> syntax error FATAL ERROR: Unable to parse input tree
> 
> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> Reported-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/phy/intel,lgm-emmc-phy.yaml       | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml b/Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml
> index ff7959c21af0..d9bd2e47dfe7 100644
> --- a/Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml
> @@ -16,10 +16,7 @@ description: |+
>    The eMMC PHY node should be the child of a syscon node with the
>    required property:
>  
> -  - compatible:         Should be one of the following:
> -                        "intel,lgm-syscon", "syscon"
> -  - reg:
> -      maxItems: 1
> +  should be compatible strings are - "intel,lgm-syscon", "syscon"

What's this change for?

>  
>  properties:
>    compatible:
> @@ -34,6 +31,12 @@ properties:
>    clocks:
>      maxItems: 1
>  
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 1
> +

This schema is properties in the emmc-phy node, so these don't belong 
here. But the example change is correct.

>  required:
>    - "#phy-cells"
>    - compatible
> @@ -45,8 +48,10 @@ examples:
>      sysconf: chiptop@e0200000 {
>        compatible = "intel,lgm-syscon", "syscon";
>        reg = <0xe0200000 0x100>;
> +      #address-cells = <1>;
> +      #size-cells = <1>;
>  
> -      emmc-phy: emmc-phy@a8 {
> +      emmc_phy: emmc_phy@a8 {

Don't use '_' in node names. The error was in the label.

emmc_phy: emmc-phy@a8 {

>          compatible = "intel,lgm-emmc-phy";
>          reg = <0x00a8 0x10>;
>          clocks = <&emmc>;
> -- 
> 2.11.0
> 
