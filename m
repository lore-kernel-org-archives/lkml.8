Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C73C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 19:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8D5220748
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 19:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="m0AuyraL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbgGJTCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 15:02:43 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50010 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727819AbgGJTC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 15:02:27 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06AJ2Kua024765;
        Fri, 10 Jul 2020 14:02:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1594407740;
        bh=D4QxQuOkakaxXUIUnv8OhviwRU9ZU44y/TIOg18mJ6w=;
        h=From:To:CC:Subject:Date;
        b=m0AuyraLeI5Nmn3vbzBD3BofIcvSzFSc6zT6TE0Om9if7SYyZYDMKi50CdtV0Z7/l
         TnoMSGUg31aJdOl/cJQO7zvuCvQJxuGlXtAYcdOo/f9L8O4Q0AM1L1f9EkJTWGutbD
         v9rgNGYXSPNUHOdvp5rKbunAY2o3xShgkCrB+yYY=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06AJ2KWZ002750
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 10 Jul 2020 14:02:20 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 10
 Jul 2020 14:02:19 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 10 Jul 2020 14:02:19 -0500
Received: from a0230074-Latitude-E7470.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06AJ2Gm3043446;
        Fri, 10 Jul 2020 14:02:16 -0500
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <robh+dt@kernel.org>, <nm@ti.com>, <t-kristo@ti.com>,
        <faiz_abbas@ti.com>
Subject: [PATCH 0/2] Add support for SD card on on AM65x-evm
Date:   Sat, 11 Jul 2020 00:32:13 +0530
Message-ID: <20200710190215.30938-1-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following patches add support for SD card node in am654x-evm

Because of fundamental interface issues (see patch 2 for details),
SD card was never enabled for silicon revision 1.0

These issues have been fixed with SR2.0 but boards with SR1.0 are
recommended to disable this node

These patches depend on kernel patches for supporting silicon revision
2.0 posted here:
https://patchwork.kernel.org/project/linux-mmc/list/?series=305565

The dependencies have been picked up and are in linux-next

Faiz Abbas (2):
  arm64: dts: ti: k3-am65-main: Add support for sdhci1
  arm64: dts: ti: k3-am654-base-board: Add support for SD card

 arch/arm64/boot/dts/ti/k3-am65-main.dtsi      | 24 +++++++++++++++++++
 .../arm64/boot/dts/ti/k3-am654-base-board.dts | 24 +++++++++++++++++++
 2 files changed, 48 insertions(+)

-- 
2.17.1

