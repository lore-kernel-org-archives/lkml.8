Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875FEC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6471A20736
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587386476;
	bh=7+5pEKWARNc84ZkGGLnLU/rBEp2gTmMmQzl/RUdX5DU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oYFZDl4OC5A1KPWvZ1ncMB78OoTkFEF0RNpMiKRzFB2GR+KMnAkjiHsS+ys7t61Mw
	 TsfU4nnsmEP3nTRXOUcf7c8S4LU5lspfKF6K9RTyrOXSK05pU3aWa5ce/2z6aACy2z
	 O7yvgz+B4MK6rp0YLbV/qECDZk4K6L0m2ExXO6Lw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgDTMlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:41:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:33790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727962AbgDTMlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:41:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86B412070B;
        Mon, 20 Apr 2020 12:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587386472;
        bh=7+5pEKWARNc84ZkGGLnLU/rBEp2gTmMmQzl/RUdX5DU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kElVvrx0LaR5a3wrP2MqsFpsfSUazkHRA+DIDWqBKXGE6Q4EiBabe987h+5BkyBfW
         kL9MjUGtMXZvvKA0n/bA5nMI3TU8ShDHCTk8zO5+Wb8xHtuHcFP3X2GCE0kDu0Dnce
         Cd1ITPb52Bt4Ui5SRgW6aw7PPLyKaYGqC+Nju5zk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 5.5 35/65] ARM: dts: imx7-colibri: fix muxing of usbc_det pin
Date:   Mon, 20 Apr 2020 14:38:39 +0200
Message-Id: <20200420121513.884223890@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200420121505.909671922@linuxfoundation.org>
References: <20200420121505.909671922@linuxfoundation.org>
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


