Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90378C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 17:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 626F420658
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 17:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tutanota.com header.i=@tutanota.com header.b="lKxB7YFk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729341AbgHPRSV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 13:18:21 -0400
Received: from w1.tutanota.de ([81.3.6.162]:39564 "EHLO w1.tutanota.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726699AbgHPRSQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 13:18:16 -0400
Received: from w3.tutanota.de (unknown [192.168.1.164])
        by w1.tutanota.de (Postfix) with ESMTP id F3C85FA03D5;
        Sun, 16 Aug 2020 17:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1597598293;
        s=s1; d=tutanota.com;
        h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Cc:Date:Date:In-Reply-To:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:References:Sender;
        bh=Ts7Ttd5K3DBpu12TNijg7qgS/999Myo7TYEvq9J4U2E=;
        b=lKxB7YFk88HcohnIG8pB+IC2u5Jbf1goGY0Q1k72Ux5fNXDB5pC10A3VDiN6ZsUS
        ajTFIlGBpo4Tm0O8EZHj6Js4e7mtkuzoVPgNW0k35olHyCBAD9hXqVKRAHQqe5BasdV
        vIg72LeKQfWAwhy+BlQY/S4Wzn9iEek2UWDPyKMmPyWVmmCS8ZxzGesmY523eyCcPaD
        c+i41ZHKiHeg6imBu9dPl87Y+/wgjvQoREvuaSs2yXmkrjALvyE77HnKZ2soMTIh6Hv
        5Y05A8Z06G1sYb0y7zM5dZtjsAwbk5WXdmUmsXDFP/fMdypcKJLPkXHtEddm2gjyV8A
        GQBHrjrl9Q==
Date:   Sun, 16 Aug 2020 19:18:13 +0200 (CEST)
From:   Cameron Nemo <cnemo@tutanota.com>
To:     Devicetree <devicetree@vger.kernel.org>,
        Linux Arm Kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Rockchip <linux-rockchip@lists.infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Usb <linux-usb@vger.kernel.org>
Cc:     Robh+dt <robh+dt@kernel.org>, Heiko <heiko@sntech.de>,
        Balbi <balbi@kernel.org>, Gregkh <gregkh@linuxfoundation.org>
Message-ID: <MEsGppx--3-2@tutanota.com>
In-Reply-To: <MEsGWB_--3-2@tutanota.com>
References: <MEsGWB_--3-2@tutanota.com>
Subject: [PATCH 2/3] arm64: dts: rockchip: rk3328 usb3 controller node
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RK3328 SoCs have one USB 3.0 OTG controller which uses DWC_USB3
core's general architecture. It can act as static xHCI host
controller, static device controller, USB 3.0/2.0 OTG basing
on ID of USB3.0 PHY.

Signed-off-by: William Wu <william.wu@rock-chips.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Cameron Nemo <cnemo@tutanota.com>
---
arch/arm64/boot/dts/rockchip/rk3328.dtsi | 27 ++++++++++++++++++++++++
1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts=
/rockchip/rk3328.dtsi
index bbdb19a3e85d..27e86bf06d3e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -983,6 +983,33 @@ usb_host0_ohci: usb@ff5d0000 {
status =3D "disabled";
};

+=09usbdrd3: usb@ff600000 {
+=09=09compatible =3D "rockchip,rk3328-dwc3";
+=09=09clocks =3D <&cru SCLK_USB3OTG_REF>, <&cru SCLK_USB3OTG_SUSPEND>,
+=09=09=09 <&cru ACLK_USB3OTG>;
+=09=09clock-names =3D "ref_clk", "suspend_clk",
+=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "bus_clk";
+=09=09#address-cells =3D <2>;
+=09=09#size-cells =3D <2>;
+=09=09ranges;
+=09=09status =3D "disabled";
+
+=09=09usbdrd_dwc3: dwc3@ff600000 {
+=09=09=09compatible =3D "snps,dwc3";
+=09=09=09reg =3D <0x0 0xff600000 0x0 0x100000>;
+=09=09=09interrupts =3D <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
+=09=09=09dr_mode =3D "otg";
+=09=09=09phy_type =3D "utmi_wide";
+=09=09=09snps,dis_enblslpm_quirk;
+=09=09=09snps,dis-u2-freeclk-exists-quirk;
+=09=09=09snps,dis_u2_susphy_quirk;
+=09=09=09snps,dis_u3_susphy_quirk;
+=09=09=09snps,dis-del-phy-power-chg-quirk;
+=09=09=09snps,dis-tx-ipgap-linecheck-quirk;
+=09=09=09status =3D "disabled";
+=09=09};
+=09};
+
gic: interrupt-controller@ff811000 {
compatible =3D "arm,gic-400";
#interrupt-cells =3D <3>;
--
2.28.0


