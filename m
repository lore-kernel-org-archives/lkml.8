Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7FDEC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 22:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85FF0206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 22:31:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="iA1rH8ja"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbgIAWbT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 18:31:19 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:49674 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728070AbgIAWbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 18:31:13 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 081MV6Xs120502;
        Tue, 1 Sep 2020 17:31:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1598999466;
        bh=RICOIzWjSODfmeMzx1fNWMWjnS7MPPZWyc9csFlAc3w=;
        h=From:To:CC:Subject:Date;
        b=iA1rH8jaPgaohru11g7auHOOP88msLvkPk11Vsz23JQYSKv5A3GsX45qtjg2OBe5P
         NjSCjXxrZ5VpQ1oyYA9PBAM7QmKbQHBpFeDEaCaD8CSfnyfc7yudZq5zD/GWhWXPvK
         Y3hWRzOWbBje4eo8w5N7NGdda18pojFTMh4GRgmY=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 081MV6Iv029129
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 1 Sep 2020 17:31:06 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 1 Sep
 2020 17:31:05 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 1 Sep 2020 17:31:05 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 081MV5Gu060400;
        Tue, 1 Sep 2020 17:31:05 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Rob Herring <robh+dt@kernel.org>, Tero Kristo <t-kristo@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Suman Anna <s-anna@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, <lokeshvutla@ti.com>,
        <grygorii.strashko@ti.com>, <nsekhar@ti.com>,
        Nishanth Menon <nm@ti.com>
Subject: [PATCH 0/7] arm64: dts: ti: k3-*: Squash up node_name_chars_strict warnings
Date:   Tue, 1 Sep 2020 17:30:52 -0500
Message-ID: <20200901223059.14801-1-nm@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is one part of cleanups meant for make W=2 dtbs for 5.10 on TI
dtbs. Hopefully we dont see node_name_chars_strict warnings anymore.

As part of this cleanup, I ran a cross check of nodes that are
part of K3 as of right now, Vs what is "generic" definition as per 0.3
dt specification:
https://pastebin.ubuntu.com/p/kp3g4ktBYp/

I dont think the remaining have a good reference, at least in my
subjective view.

In possibly some cases, bootloaders may need to sync before doing DT
fixup etc.

Nishanth Menon (7):
  arm64: dts: ti: k3-am65*: Use generic gpio for node names
  arm64: dts: ti: k3-am65*: Use generic clock for serdes clock name
  arm64: dts: ti: k3-*: Use generic pinctrl for node names
  arm64: dts: ti: k3-am65-base-board Use generic camera for node name
    instead of ov5640
  arm64: dts: ti: k3-am65-wakeup: Use generic temperature-sensor for
    node name
  arm64: dts: ti: k3-*: Use generic adc for node names
  arm64: dts: ti: k3-*: Fix up node_name_chars_strict errors

 arch/arm64/boot/dts/ti/k3-am65-main.dtsi       | 18 +++++++++---------
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi        |  8 ++++----
 arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi     |  6 +++---
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts | 18 +++++++++---------
 .../dts/ti/k3-am654-industrial-thermal.dtsi    | 12 ++++++------
 .../boot/dts/ti/k3-j721e-common-proc-board.dts | 18 +++++++++---------
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi      |  8 ++++----
 .../arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi |  8 ++++----
 arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi    |  2 +-
 9 files changed, 49 insertions(+), 49 deletions(-)

-- 
2.17.1

