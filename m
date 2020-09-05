Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B06C433E2
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 15:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB1EA20760
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 15:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbgIEPVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 11:21:40 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:44752 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbgIEPV1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 11:21:27 -0400
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1kEa0I-00DMcD-E2; Sat, 05 Sep 2020 17:21:22 +0200
Date:   Sat, 5 Sep 2020 17:21:22 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Luka Kovacic <luka.kovacic@sartura.hr>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-leds@vger.kernel.org,
        lee.jones@linaro.org, pavel@ucw.cz, dmurphy@ti.com,
        robh+dt@kernel.org, jdelvare@suse.com, linux@roeck-us.net,
        jason@lakedaemon.net, gregory.clement@bootlin.com,
        luka.perkov@sartura.hr
Subject: Re: [PATCH 7/7] arm64: dts: marvell: Add a device tree for the iEi
 Puzzle-M801 board
Message-ID: <20200905152122.GB3164319@lunn.ch>
References: <20200905130336.967622-1-luka.kovacic@sartura.hr>
 <20200905130336.967622-8-luka.kovacic@sartura.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200905130336.967622-8-luka.kovacic@sartura.hr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 05, 2020 at 03:03:36PM +0200, Luka Kovacic wrote:

> +&cp0_mdio {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	status = "okay";
> +
> +	ge_phy2: ethernet-phy@2 {
> +		reg = <0>;

Hi Luka

The value after the @ should be the same as the reg value.
So this should be ge_phy2: ethernet-phy@0

> +	};
> +
> +	ge_phy3: ethernet-phy@3 {
> +		reg = <1>;

And this is:

ge_phy2: ethernet-phy@1

This is a general DT rule, so please check the whole file.

> +&cp0_eth0 {
> +	status = "okay";
> +	phy-mode = "10gbase-r";
> +	phys = <&cp0_comphy4 0>;
> +	local-mac-address = [00 50 43 de ff 00];

Does the bootloader overwrite these with per device MAC addresses?

Looking up this OUI i find:

00:50:43 Marvell Semiconductor, Inc.

I'm not sure you should be using that!

    Andrew
