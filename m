Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C29C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 11:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A2662067D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 11:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbgGFLPQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 07:15:16 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.51]:21221 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728578AbgGFLPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 07:15:15 -0400
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7wpz8NMGH/PvwDCqz4U="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 46.10.5 DYNA|AUTH)
        with ESMTPSA id V07054w66BF5pdY
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Mon, 6 Jul 2020 13:15:05 +0200 (CEST)
Subject: Re: [PATCH] MIPS: CI20: DTS: Correcting IW8103 Wifi binding
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20200705103215.96672-1-agriveaux@deutnet.info>
Date:   Mon, 6 Jul 2020 13:15:04 +0200
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        linux-mips <linux-mips@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <457C75ED-A033-4B46-A9D9-53B510C16F37@goldelico.com>
References: <20200705103215.96672-1-agriveaux@deutnet.info>
To:     agriveaux@deutnet.info
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

> Am 05.07.2020 um 12:32 schrieb agriveaux@deutnet.info:
> 
> From: Alexandre GRIVEAUX <agriveaux@deutnet.info>
> 
> Use brcm,bcm4329-fmac instead of brcm,bcm4330-fmac.
> 
> Signed-off-by: Alexandre GRIVEAUX <agriveaux@deutnet.info>
> ---
> arch/mips/boot/dts/ingenic/ci20.dts | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/boot/dts/ingenic/ci20.dts b/arch/mips/boot/dts/ingenic/ci20.dts
> index 75f5bfbf2c37..82a1f126b778 100644
> --- a/arch/mips/boot/dts/ingenic/ci20.dts
> +++ b/arch/mips/boot/dts/ingenic/ci20.dts
> @@ -116,8 +116,8 @@
> 	pinctrl-0 = <&pins_mmc1>;
> 
> 	brcmf: wifi@1 {
> -/*		reg = <4>;*/
> -		compatible = "brcm,bcm4330-fmac";
> +		reg = <1>;
> +		compatible = "brcm,bcm4329-fmac";
> 		vcc-supply = <&wlan0_power>;
> 		device-wakeup-gpios = <&gpd 9 GPIO_ACTIVE_HIGH>;
> 		shutdown-gpios = <&gpf 7 GPIO_ACTIVE_LOW>;

Do you have it working with a v5.8 kernel?

I don't see any activity to detect the module or load firmware.

Does it rely on some other patch?

BR and thanks,
Nikolaus

