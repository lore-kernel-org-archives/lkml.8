Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19042C3F2C0
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 21:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E30F724690
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 21:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582839745;
	bh=eP2PgAj9f7/R2T4FIWvJwwF1aYOF2wVQsYe5OD3EvlM=;
	h=Date:From:To:List-Id:Cc:Subject:References:In-Reply-To:List-ID:
	 From;
	b=0EpH7Ld0bdNTvlpvXCXnWxKIjAV+yUlUAOFoDcietPf3gdJU4govkvYpRYvscFu+Z
	 kInZHRYeR67fkhdX0pgqibSFEUyQpKQ0T4Jp43XVb5gp+mJhpO5sgdB9l/P/lJ8Pj4
	 ySWrwfAn41uwoK3UKHkTfp0l50R89HHQ5RZ/XEuI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730000AbgB0VmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 16:42:23 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45230 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729162AbgB0VmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 16:42:22 -0500
Received: by mail-oi1-f196.google.com with SMTP id v19so739491oic.12;
        Thu, 27 Feb 2020 13:42:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hxSUt8ecSkxryci9k7+9ny1llgrPw7O7ypz9WTmNE9A=;
        b=rZJDMg5sy4qQqvl/qAR4orGfEgOkxn7z/X+CkxSWWbmYHIuO4NO1Ugpd34baMnWhXn
         VjPYvjRIM88K154wmFahWWsBRzmUANaZligcX78Wy7Ql1Jq168X97Lv5xlGqH0TfzvFV
         2cJOfCxDTdeaRK+MyqQaH/nhAQBnxpFvVNJmuhQ/Gbifd8LqVYSoUT/zYdrCnkqkk4wO
         o1lDmVg/xhyzA55ib4spbaDyq4WPjhbxmQUxsYHnuaImWPid1JxL5dxK4xlcaFbUO8k2
         EnPz283ah0mnUzBTOiedeBwM26p0Dcv7ejxaYQuntw6zA6jFo0eZNxRFQ88d7TNzuHLP
         LP7w==
X-Gm-Message-State: APjAAAXv+0yguuG0pWcgfy6vqGqEKYAmzYT/APMs+1DQnm4CEg5h2WHM
        31BN5Wuu/UST7OMtT3eWNg==
X-Google-Smtp-Source: APXvYqyJuw4LqldUP8MH0Ja45kzZ5rHTt45NPh9538Dg11MACmv0nYndqV17CAWIl0VA6KmbgC3AIA==
X-Received: by 2002:a05:6808:618:: with SMTP id y24mr832198oih.86.1582839740003;
        Thu, 27 Feb 2020 13:42:20 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t20sm2365430oij.19.2020.02.27.13.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 13:42:19 -0800 (PST)
Received: (nullmailer pid 2192 invoked by uid 1000);
        Thu, 27 Feb 2020 21:42:18 -0000
Date:   Thu, 27 Feb 2020 15:42:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andre Przywara <andre.przywara@arm.com>
List-Id: <soc.lore.kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        Robert Richter <rric@kernel.org>, soc@kernel.org,
        Jon Loeliger <jdl@jdl.com>,
        Mark Langsdorf <mlangsdo@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v2 01/13] arm: dts: calxeda: Basic DT file fixes
Message-ID: <20200227214218.GA26010@bogus>
References: <20200227182210.89512-1-andre.przywara@arm.com>
 <20200227182210.89512-2-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227182210.89512-2-andre.przywara@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 06:21:58PM +0000, Andre Przywara wrote:
> The .dts files for the Calxeda machines are quite old, so carry some
> sloppy mistakes that the DT schema checker will complain about.
> 
> Fix those issues, they should not have any effect on functionality.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  arch/arm/boot/dts/ecx-2000.dts | 3 ---
>  arch/arm/boot/dts/highbank.dts | 7 ++-----
>  2 files changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/ecx-2000.dts b/arch/arm/boot/dts/ecx-2000.dts
> index 5651ae6dc969..81eb382b4c23 100644
> --- a/arch/arm/boot/dts/ecx-2000.dts
> +++ b/arch/arm/boot/dts/ecx-2000.dts
> @@ -13,7 +13,6 @@
>  	compatible = "calxeda,ecx-2000";
>  	#address-cells = <2>;
>  	#size-cells = <2>;
> -	clock-ranges;
>  
>  	cpus {
>  		#address-cells = <1>;
> @@ -83,8 +82,6 @@
>  		intc: interrupt-controller@fff11000 {
>  			compatible = "arm,cortex-a15-gic";
>  			#interrupt-cells = <3>;
> -			#size-cells = <0>;
> -			#address-cells = <1>;

This is needed if there's an interrupt-map pointing to the gic node. 
However, it should be 0 in that case. 

I thought we had to fix this at some point, but I can't find any record 
of it. So I guess fine to remove. 

Reviewed-by: Rob Herring <robh@kernel.org>

>  			interrupt-controller;
>  			interrupts = <1 9 0xf04>;
>  			reg = <0xfff11000 0x1000>,
> diff --git a/arch/arm/boot/dts/highbank.dts b/arch/arm/boot/dts/highbank.dts
> index f4e4dca6f7e7..9e34d1bd7994 100644
> --- a/arch/arm/boot/dts/highbank.dts
> +++ b/arch/arm/boot/dts/highbank.dts
> @@ -13,7 +13,6 @@
>  	compatible = "calxeda,highbank";
>  	#address-cells = <1>;
>  	#size-cells = <1>;
> -	clock-ranges;
>  
>  	cpus {
>  		#address-cells = <1>;
> @@ -96,7 +95,7 @@
>  		};
>  	};
>  
> -	memory {
> +	memory@0 {
>  		name = "memory";
>  		device_type = "memory";
>  		reg = <0x00000000 0xff900000>;
> @@ -128,14 +127,12 @@
>  		intc: interrupt-controller@fff11000 {
>  			compatible = "arm,cortex-a9-gic";
>  			#interrupt-cells = <3>;
> -			#size-cells = <0>;
> -			#address-cells = <1>;
>  			interrupt-controller;
>  			reg = <0xfff11000 0x1000>,
>  			      <0xfff10100 0x100>;
>  		};
>  
> -		L2: l2-cache {
> +		L2: cache-controller {
>  			compatible = "arm,pl310-cache";
>  			reg = <0xfff12000 0x1000>;
>  			interrupts = <0 70 4>;
> -- 
> 2.17.1
> 
