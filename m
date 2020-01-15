Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B500C33CB3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 15:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB0D82053B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 15:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="jToC03rQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbgAOP1A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 10:27:00 -0500
Received: from uho.ysoft.cz ([81.19.3.130]:49264 "EHLO uho.ysoft.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbgAOP1A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 10:27:00 -0500
X-Greylist: delayed 562 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Jan 2020 10:26:59 EST
Received: from iota-build.ysoft.local (unknown [10.1.5.151])
        by uho.ysoft.cz (Postfix) with ESMTP id 6BEEBA04F7;
        Wed, 15 Jan 2020 16:17:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
        s=20160406-ysoft-com; t=1579101455;
        bh=0ULpnmAUHvffsEugGgwMjETvdEv0t9gZHoFvdALaxho=;
        h=From:To:Cc:Subject:Date:From;
        b=jToC03rQSGKXgTBIs++wTaE//kVMn+aU223x64vW/iQkyWk5hCUcVTiyBsIUnuEDM
         ndUw30/zFMTthl6z+Hd0u0iWEVr/gu2CZ4QozCAC9mU2bymD8HaG2M1e/jbqVzhJxx
         +kMYuzYOadxgttPvpfhplPFJbWsgDX6RqbYBlocU=
From:   =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
Subject: [PATCH] ARM: dts: imx6dl-yapp4: Specify USB overcurrent protection polarity
Date:   Wed, 15 Jan 2020 16:17:28 +0100
Message-Id: <1579101448-7247-1-git-send-email-michal.vokac@ysoft.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Patchwork-Bot: notify
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After reset the oc protection polarity is set to active high on imx6.
If the polarity is not specified in device tree it is not changed.

The imx6dl-yapp4 platform uses an active-low oc signal so explicitly
configure that in the device tree.

Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
---
 arch/arm/boot/dts/imx6dl-yapp4-common.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi b/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
index b494042e2d8f..fb6ce6d662bc 100644
--- a/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
+++ b/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
@@ -563,6 +563,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usbh1>;
 	vbus-supply = <&reg_usb_h1_vbus>;
+	over-current-active-low;
 	status = "disabled";
 };
 
@@ -570,6 +571,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usbotg>;
 	vbus-supply = <&reg_usb_otg_vbus>;
+	over-current-active-low;
 	srp-disable;
 	hnp-disable;
 	adp-disable;
-- 
2.1.4

