Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1178C3F2C6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 23:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF7F920828
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 23:47:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbgB2XrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 18:47:12 -0500
Received: from gloria.sntech.de ([185.11.138.130]:55130 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727170AbgB2XrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 18:47:12 -0500
Received: from p508fcd9d.dip0.t-ipconnect.de ([80.143.205.157] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1j8Bp6-0004qM-8P; Sun, 01 Mar 2020 00:47:08 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ARM: dts: remove g-use-dma from rockchip usb nodes
Date:   Sun, 01 Mar 2020 00:47:07 +0100
Message-ID: <8908074.NjHMO83URx@phil>
In-Reply-To: <20200228113922.20266-1-jbx6244@gmail.com>
References: <20200228113922.20266-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 28. Februar 2020, 12:39:21 CET schrieb Johan Jonker:
> A test with the command below gives these errors:
> 
> arch/arm/boot/dts/rv1108-elgin-r1.dt.yaml: usb@30180000:
> 'g-use-dma' does not match any of the regexes: 'pinctrl-[0-9]+'
> arch/arm/boot/dts/rv1108-evb.dt.yaml: usb@30180000:
> 'g-use-dma' does not match any of the regexes: 'pinctrl-[0-9]+'
> arch/arm/boot/dts/rk3228-evb.dt.yaml: usb@30040000:
> 'g-use-dma' does not match any of the regexes: 'pinctrl-[0-9]+'
> arch/arm/boot/dts/rk3229-evb.dt.yaml: usb@30040000:
> 'g-use-dma' does not match any of the regexes: 'pinctrl-[0-9]+'
> arch/arm/boot/dts/rk3229-xms6.dt.yaml: usb@30040000:
> 'g-use-dma' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> 'g-use-dma' is not a valid option in dwc2.yaml, so remove it
> from all Rockchip dtsi files.
> 
> make ARCH=arm dtbs_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/usb/dwc2.yaml
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>

applied both patches for 5.7

Thanks
Heiko


