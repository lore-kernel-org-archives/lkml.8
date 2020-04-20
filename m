Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 376FCC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06A422072B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587386642;
	bh=7+5pEKWARNc84ZkGGLnLU/rBEp2gTmMmQzl/RUdX5DU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=T1jbGhfz0QRlslivRCDKsT/WV6HOH8wMsQwyJRH3cx3IDSneqerQXjrogNAe0OeFg
	 Yk39cL6iMo87ljRM6IYyznVZC+8eAXpRSSwxNxI+S3y6tE7Y80tBR+wRc0NRzPczay
	 vmgbTdbyfTxD//dVHxuLsqvfMTDsmcwTOXdiMvdI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbgDTMoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:44:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:37740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728484AbgDTMn6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:43:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 414542070B;
        Mon, 20 Apr 2020 12:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587386637;
        bh=7+5pEKWARNc84ZkGGLnLU/rBEp2gTmMmQzl/RUdX5DU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dXHoxOORb1EH6E72EudVi2tS+rx7Yj8iVDiQkyAF/jPFXvlW1bakD+ZVphFZhzH+l
         mjvxfluqXS5ZNuaKgkxBsNYs5do0Eel+0M8c4X4qzkV06BrS+4Daw3E8i7trSD1apP
         /OeIUoPEX7k9Gz3OkfayKPk8FiIJ9geJIK7YDoAs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 5.6 37/71] ARM: dts: imx7-colibri: fix muxing of usbc_det pin
Date:   Mon, 20 Apr 2020 14:38:51 +0200
Message-Id: <20200420121516.650346866@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200420121508.491252919@linuxfoundation.org>
References: <20200420121508.491252919@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>

commit 7007f2eca0f258710899ca486da00546d03db0ed upstream.

USB_C_DET pin shouldn't be in ethernet group.

Creating a separate group allows one to use this pin
as an USB ID pin.

Fixes: b326629f25b7 ("ARM: dts: imx7: add Toradex Colibri iMX7S/iMX7D suppor")
Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/imx7-colibri.dtsi |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/arch/arm/boot/dts/imx7-colibri.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri.dtsi
@@ -345,7 +345,7 @@
 &iomuxc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_gpio1 &pinctrl_gpio2 &pinctrl_gpio3 &pinctrl_gpio4
-		     &pinctrl_gpio7>;
+		     &pinctrl_gpio7 &pinctrl_usbc_det>;
 
 	pinctrl_gpio1: gpio1-grp {
 		fsl,pins = <
@@ -450,7 +450,6 @@
 
 	pinctrl_enet1: enet1grp {
 		fsl,pins = <
-			MX7D_PAD_ENET1_CRS__GPIO7_IO14			0x14
 			MX7D_PAD_ENET1_RGMII_RX_CTL__ENET1_RGMII_RX_CTL	0x73
 			MX7D_PAD_ENET1_RGMII_RD0__ENET1_RGMII_RD0	0x73
 			MX7D_PAD_ENET1_RGMII_RD1__ENET1_RGMII_RD1	0x73
@@ -648,6 +647,12 @@
 		>;
 	};
 
+	pinctrl_usbc_det: gpio-usbc-det {
+		fsl,pins = <
+			MX7D_PAD_ENET1_CRS__GPIO7_IO14	0x14
+		>;
+	};
+
 	pinctrl_usbh_reg: gpio-usbh-vbus {
 		fsl,pins = <
 			MX7D_PAD_UART3_CTS_B__GPIO4_IO7	0x14 /* SODIMM 129 USBH PEN */


