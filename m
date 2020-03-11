Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B86C3F2D0
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 07:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ABC02192A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 07:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583910983;
	bh=OQIeb4oj8r6aT9zrf+ckOYy531/qz6nDOVCUb0TQuxU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nLLsN3xClqsJwVKXoTRaMDcDLYhEHC9gdAzrzdYqB4r8bg1uK8Tlnw0BIt76W4bTb
	 dx3HhNWIHA28pZS7UfuZI1IS2/Ayw3BU9FoBJUOaq+c8OGyiw1LlnJFH65ZguGUge7
	 U1IK2fDrgMzLYAleKK0w50/4DAjrHRaUazhq/KWo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbgCKHQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 03:16:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:39490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbgCKHQV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 03:16:21 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAF5A208C3;
        Wed, 11 Mar 2020 07:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583910981;
        bh=OQIeb4oj8r6aT9zrf+ckOYy531/qz6nDOVCUb0TQuxU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PEWHmPatR+Metyz2pN2PIn+lc0oPlTzr34YQam5O/lpbq0OXTuRat4ADPVIE6H+p7
         WEy6/dZbEiUkSX2sud5UK18LvNfmefUqhP97G9i/8xWe79LAHG+uahsKto1NyWUx/c
         8jVaoqxKmfsFh3F+CZptkLDyC6ncQrvsuEdm2c5w=
Date:   Wed, 11 Mar 2020 15:16:14 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Li Yang <leoyang.li@nxp.com>
Subject: Re: [PATCH 1/3] arm64: dts: ls1028a: sl28: fix on-board EEPROMS
Message-ID: <20200311071613.GL29269@dragon>
References: <20200225175756.29508-1-michael@walle.cc>
 <20200225175756.29508-2-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225175756.29508-2-michael@walle.cc>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 06:57:54PM +0100, Michael Walle wrote:
> The module itself has another EEPROM at 50h on I2C4. The EEPROM on the
> carriers is located at 57h on I2C3. Fix that in the device trees.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>

Doesn't apply to my branch.

Shawn

> ---
>  .../fsl-ls1028a-kontron-kbox-a-230-ls.dts          |  6 +++---
>  .../fsl-ls1028a-kontron-sl28-var3-ads2.dts         | 14 ++++++++------
>  .../dts/freescale/fsl-ls1028a-kontron-sl28.dts     |  6 ++++++
>  3 files changed, 17 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dts
> index aaf3c04771c3..32f6c80414bc 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dts
> @@ -18,10 +18,10 @@
>  		     "kontron,sl28", "fsl,ls1028a";
>  };
>  
> -&i2c4 {
> -	eeprom@50 {
> +&i2c3 {
> +	eeprom@57 {
>  		compatible = "atmel,24c32";
> -		reg = <0x50>;
> +		reg = <0x57>;
>  		pagesize = <32>;
>  	};
>  };
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dts
> index 20fd86746f94..ff4a43986290 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dts
> @@ -80,6 +80,14 @@
>  	};
>  };
>  
> +&i2c3 {
> +	eeprom@57 {
> +		compatible = "atmel,24c64";
> +		reg = <0x57>;
> +		pagesize = <32>;
> +	};
> +};
> +
>  &i2c4 {
>  	status = "okay";
>  
> @@ -92,12 +100,6 @@
>  		assigned-clocks = <&mclk>;
>  		assigned-clock-rates = <1250000>;
>  	};
> -
> -	eeprom@50 {
> -		compatible = "atmel,24c32";
> -		reg = <0x50>;
> -		pagesize = <32>;
> -	};
>  };
>  
>  &sai5 {
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
> index c60a444ad09d..4ba6aae45ef1 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
> @@ -181,6 +181,12 @@
>  
>  &i2c4 {
>  	status = "okay";
> +
> +	eeprom@50 {
> +		compatible = "atmel,24c32";
> +		reg = <0x50>;
> +		pagesize = <32>;
> +	};
>  };
>  
>  &lpuart1 {
> -- 
> 2.20.1
> 
