Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62235C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 19:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2775E2187F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 19:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xf2T8kUv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388546AbgBNT1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 14:27:16 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33249 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387576AbgBNT1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 14:27:16 -0500
Received: by mail-qt1-f193.google.com with SMTP id d5so7751032qto.0;
        Fri, 14 Feb 2020 11:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rLdqNzAySRjmMgZB/PpbO12duUi9dVI2RpZBkw4lPuY=;
        b=Xf2T8kUvWsfjQ/Up+Poojpe8L31XmtsOqhwlO2wut9m/gKzA9/QE50fQF3Tt0oo+aE
         UBBLRLEMhUe5LsimhidkJi0bRIOfuOXP3cIkcLwMzPFNI3MFPArhJLo0DSLHGwZwiUF7
         D7rmFgVzNAzt683d7R9vhs8Cv47yZfUL9qvOT34xE/d6+2I5Kf42td2lX+AlTR6snNkA
         YV64hqetBncpWkEe2mSimUbdixXtVLcmAuC1T3ydm3Y0fYrSs4FfcdZVxijy74Lii5aR
         gGJoPsMhpzjn//hXqEqT+4rJxInmDcsU9gYYgnJgaQghj58ZYHeI+EvZqt5GPMILD7HE
         1ztg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rLdqNzAySRjmMgZB/PpbO12duUi9dVI2RpZBkw4lPuY=;
        b=sqyepniYwlXN3O9IpxPPVDy0S5nIrtoNHlwzOL+nstxHfgHqRDw5J+/D6cLFW26q3F
         CSQghXKtxxhCsRXG2k4T64b6hWnLtjLgPF+9X5KKgwEJyD9oJ55Mp7JIWbiO+G+aIZtL
         Gdd59ON0U/0Oc17beEIF0kJXPFQgKEUIdXd5LfZmeFlEiiu7AnCRB5Sn9u2mRoOkHYGD
         cbTEIJOM50QYWIskRXnPgHjz1K/p2esuU1yyulNFi+h1EECXZ7nSuoUNao74Ui1CQvh3
         SwLLydwwJOzZ29SWAso58ND3JICPcv/bwu59obeXODKgR5pk3S0+7IDYe42/eUV5BdVK
         JXKA==
X-Gm-Message-State: APjAAAV6mghPMgJCNy/mwrz4FUEkEG2vRWbD9jbokaxX1X48Pi8ucQq6
        y5EdiO2beQUOQaBjMv3RJ7A=
X-Google-Smtp-Source: APXvYqynfs5kAav/PDO8R4gLse736bHsst/9DYgxRCWQaKraQ6rdoxAnUwHgh62yxQr95Xrv7YHoQQ==
X-Received: by 2002:aed:2284:: with SMTP id p4mr3749213qtc.329.1581708434667;
        Fri, 14 Feb 2020 11:27:14 -0800 (PST)
Received: from L-E5450.nxp.com ([177.221.114.206])
        by smtp.gmail.com with ESMTPSA id o55sm4009953qtf.46.2020.02.14.11.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 11:27:13 -0800 (PST)
From:   Alifer Moraes <alifer.wsdm@gmail.com>
To:     robh+dt@kernel.org
Cc:     mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        peng.fan@nxp.com, leonard.crestez@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alifer Moraes <alifer.wsdm@gmail.com>
Subject: [PATCH 1/2] arm64: dts: imx8mm-evk: add phy-reset-gpios for fec1
Date:   Fri, 14 Feb 2020 16:27:49 -0300
Message-Id: <20200214192750.20845-1-alifer.wsdm@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

imx8mm-evk has a GPIO connected to AR8031 Ethernet PHY's reset pin.

Describe it in the device tree, following phy's datasheet reset duration of 10ms.

Tested booting via NFS.

Signed-off-by: Alifer Moraes <alifer.wsdm@gmail.com>
---

Originally sent by Peng Fan <peng.fan@nxp.com>

Back then CONFIG_AT803X_PHY was set as "m" in defconfig so the boot process hung
at nfs boot, now that CONFIG_AT803X_PHY is set as "y" by default, the patch works
correctly.

Peng's original patch missed to pass the phy-reset-duration, according to the AR8031
datasheet the reset GPIO needs to stay low for 10ms.

Original thread: https://lkml.org/lkml/2019/10/21/347

 arch/arm64/boot/dts/freescale/imx8mm-evk.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dts b/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
index 28ab17a277bb..11903ca86f0e 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
@@ -82,6 +82,8 @@
 	pinctrl-0 = <&pinctrl_fec1>;
 	phy-mode = "rgmii-id";
 	phy-handle = <&ethphy0>;
+	phy-reset-gpios = <&gpio4 22 GPIO_ACTIVE_LOW>;
+	phy-reset-duration = <10>;
 	fsl,magic-packet;
 	status = "okay";
 
-- 
2.17.1

