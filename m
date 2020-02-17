Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B81D9C34022
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 14:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D2C6207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 14:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="g3l5Nhq2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728952AbgBQO1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 09:27:22 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:38248 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728798AbgBQO1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 09:27:21 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01HEQtNf112638;
        Mon, 17 Feb 2020 08:26:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1581949615;
        bh=po/B6mtGdawuqToBGVPn55uQrgRGXqH10+7GXhQfSLE=;
        h=From:To:CC:Subject:Date;
        b=g3l5Nhq25UNXDvFYR35wDVh1fJ82s2lJ/fYKKis+BlbjT/Ji/V3sOlfHeFsIESwgb
         ATU4N9ESsVcGqoy5y/EqlV8tl7UMFFoBw7hTp2XhFdntmB2s77CjhAuHyBJZnwkXiQ
         FNJhcHyFBghe3hPZgaeYyLN5b3bYbXiCvF4HAaYQ=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01HEQtMQ064540;
        Mon, 17 Feb 2020 08:26:55 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 17
 Feb 2020 08:26:55 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 17 Feb 2020 08:26:55 -0600
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01HEQoJL033875;
        Mon, 17 Feb 2020 08:26:51 -0600
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-can@vger.kernel.org>
CC:     <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <catalin.marinas@arm.com>, <mark.rutland@arm.com>,
        <robh+dt@kernel.org>, <mkl@pengutronix.de>, <wg@grandegger.com>,
        <sriram.dash@samsung.com>, <dmurphy@ti.com>, <faiz_abbas@ti.com>
Subject: [PATCH v2 0/3] Add Support for MCAN in AM654x-idk
Date:   Mon, 17 Feb 2020 19:58:33 +0530
Message-ID: <20200217142836.23702-1-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds driver patches to support MCAN in TI's AM654x-idk.

v2: Model the sandby line to the transceiver as a regulator.

Faiz Abbas (3):
  dt-bindings: m_can: Add Documentation for transceiver regulator
  can: m_can: m_can_platform: Add support for enabling transceiver
  arm64: defconfig: Add Support for Bosch M_CAN controllers

 Documentation/devicetree/bindings/net/can/m_can.txt | 3 +++
 arch/arm64/configs/defconfig                        | 3 +++
 drivers/net/can/m_can/m_can_platform.c              | 6 ++++++
 3 files changed, 12 insertions(+)

-- 
2.19.2

