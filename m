Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7085FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 20:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3715C2078A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 20:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="bsjc/5BL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgHZUnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 16:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbgHZUnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 16:43:14 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C699AC061574;
        Wed, 26 Aug 2020 13:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/v3xD7Yj6E46youW4kSUkt7tAjcS/uM9PSo7nM0jFJg=; b=bsjc/5BLixCdysHvhmxVpzDPZf
        ucALOSbLSQR/5vgAz+N3vRjJvX9DYXS4++iZ4Ltq2PjyU6hO15ZyPXSEnFfBQpe7FPrB1RNuvBoUo
        thO1sTZta4XjBFfWt6EdQRI26w0uoiAnQDqq9Uqd1p7RkYkTUkEzkj1N74q0U3E0Nf5k=;
Received: from p200300ccff0d72001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff0d:7200:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1kB2G3-00011s-61; Wed, 26 Aug 2020 22:42:59 +0200
Received: from andi by aktux with local (Exim 4.92)
        (envelope-from <andreas@kemnade.info>)
        id 1kB2G2-0001Kh-MP; Wed, 26 Aug 2020 22:42:58 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        andreas@kemnade.info, Anson.Huang@nxp.com,
        marcel.ziswiler@toradex.com, sebastien.szymanski@armadeus.com,
        michael@walle.cc, rjones@gateworks.com, leoyang.li@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, j.neuschaefer@gmx.net,
        letux-kernel@openphoenux.org
Subject: [PATCH v2 0/2] ARM: dts: add Tolino Shine 2 HD
Date:   Wed, 26 Aug 2020 22:42:49 +0200
Message-Id: <20200826204251.5082-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a device tree for the Tolino Shine 2 HD Ebook reader.

It is equipped with an i.MX6SL SoC. Except for backlight (via an EC) and
the EPD, drivers are available and therefore things are defined in the
dts.

Andreas Kemnade (2):
  dt-bindings: arm: fsl: add compatible string for Tolino Shine 2 HD
  ARM: dts: imx: add devicetree for Tolino Shine 2 HD

 .../devicetree/bindings/arm/fsl.yaml          |   1 +
 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/imx6sl-tolino-shine2hd.dts  | 588 ++++++++++++++++++
 3 files changed, 590 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6sl-tolino-shine2hd.dts

-- 
2.20.1

