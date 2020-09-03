Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98ABC433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 13:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A96322072A
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 13:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="clqUkEe8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbgICNnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 09:43:37 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:37658 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728936AbgICNB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 09:01:57 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 083D0M4v043852;
        Thu, 3 Sep 2020 08:00:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599138022;
        bh=3ErMb7axqI3TRtkdw9SxX8yrDCtno5nBT9qvPSppG10=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=clqUkEe8SXi5s6LjKV4o0ChllNf9eJp401BE5S7ZGUveFe7UylPpFTOjV/n5b/0DC
         dwVZydUpxh78M54s3BaHOwsyu2tL90QFHlZ6glRLCnK/AqdwnkjGffa0h92mmEgxYD
         PRe8BsZE+KBOlSrZJbU41Dqw92ZtiHACy0htC69k=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 083D0MNw097462
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Sep 2020 08:00:22 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 3 Sep
 2020 08:00:21 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 3 Sep 2020 08:00:21 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 083D0LgZ084897;
        Thu, 3 Sep 2020 08:00:21 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Rob Herring <robh+dt@kernel.org>, Tero Kristo <t-kristo@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Suman Anna <s-anna@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, <lokeshvutla@ti.com>,
        <grygorii.strashko@ti.com>, <nsekhar@ti.com>,
        Nishanth Menon <nm@ti.com>
Subject: [PATCH V2 0/8] arm64: dts: ti: k3-*: Squash up node_name_chars_strict warnings + hex usage
Date:   Thu, 3 Sep 2020 08:00:07 -0500
Message-ID: <20200903130015.21361-1-nm@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200901223059.14801-1-nm@ti.com>
References: <20200901223059.14801-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a respin of v2 of the series posted as [1].

As part of this cleanup, I ran a cross check of nodes that are
part of K3 as of right now, Vs what is "generic" definition as per 0.3
dt specification [2].

Changes in v2:
- Based off 20200903
- Picked up Acks and reviewed-by from previous versions (please comment
  if you disagree).
- Dropped tsadc rename [3] based on review
- Added 2 patches to fixup hexadecimal usage caught as part of review
- few additional fixups.


Nishanth Menon (8):
  arm64: dts: ti: k3-j721e: Use lower case hexadecimal
  arm64: dts: ti: k3-am65-main: Use lower case hexadecimal
  arm64: dts: ti: k3-am65*: Use generic gpio for node names
  arm64: dts: ti: k3-am65*: Use generic clock for syscon clock names
  arm64: dts: ti: k3-*: Use generic pinctrl for node names
  arm64: dts: ti: k3-am65-base-board Use generic camera for node name
    instead of ov5640
  arm64: dts: ti: k3-am65-wakeup: Use generic temperature-sensor for
    node name
  arm64: dts: ti: k3-*: Fix up node_name_chars_strict warnings

 arch/arm64/boot/dts/ti/k3-am65-main.dtsi      | 22 +++++++++----------
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi       |  4 ++--
 arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi    |  6 ++---
 .../arm64/boot/dts/ti/k3-am654-base-board.dts | 18 +++++++--------
 .../dts/ti/k3-am654-industrial-thermal.dtsi   | 12 +++++-----
 .../dts/ti/k3-j721e-common-proc-board.dts     | 18 +++++++--------
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     |  8 +++----
 .../boot/dts/ti/k3-j721e-mcu-wakeup.dtsi      |  4 ++--
 arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi   |  2 +-
 arch/arm64/boot/dts/ti/k3-j721e.dtsi          |  2 +-
 10 files changed, 48 insertions(+), 48 deletions(-)

[1] v1: https://lore.kernel.org/linux-arm-kernel/20200901223059.14801-1-nm@ti.com/
[2] https://pastebin.ubuntu.com/p/Z5zGQydH3G/
[3] https://lore.kernel.org/linux-arm-kernel/9fb2f8f4-5eeb-6190-9cbf-b28084c58a8f@ti.com/

-- 
2.17.1

