Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF3EC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 12:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BE242086A
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 12:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="imz9wDsg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbgHGMo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 08:44:29 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36778 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728478AbgHGMo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 08:44:27 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 077CiGfW062478;
        Fri, 7 Aug 2020 07:44:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1596804256;
        bh=PGZa7kjLYyxaGRhEZYx5F3rjv14rpCPDFQflGcxKrRE=;
        h=From:To:CC:Subject:Date;
        b=imz9wDsgSjVWOgl/EJPUW1uReHyVLSrJCyFj9K0+UKnyMV88FDoKzqB/YqtBNQWFO
         BQS15RDohb+cS5ckVySmHcUccb/wYT8Bjtf2lwvhbGWHrVlNPD+m2yqmyp9AEU6JtY
         /YnixdqQsGtd7xlc2ERwo8O9VxyBqHLiFFrPRTYE=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 077CiGmQ131053
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 7 Aug 2020 07:44:16 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 7 Aug
 2020 07:44:16 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 7 Aug 2020 07:44:16 -0500
Received: from ula0132425.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 077CiCeF072818;
        Fri, 7 Aug 2020 07:44:13 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH 0/2] arm64: dts: ti: k3-j7200: Add HyperFlash related nodes
Date:   Fri, 7 Aug 2020 18:14:05 +0530
Message-ID: <20200807124407.12604-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds HyperBus and HyperFlash nodes for TI's J7200 SoC

Based on top of https://lore.kernel.org/linux-arm-kernel/20200723084628.19241-1-lokeshvutla@ti.com/
And earlier I2C DT patches:
https://lore.kernel.org/linux-arm-kernel/20200730192600.1872-1-vigneshr@ti.com/

Vignesh Raghavendra (2):
  arm64: dts: ti: k3-j7200: Add HyperBus node
  arm64: dts: ti: k3-j7200-som-p0: Add HyperFlash node

 .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      | 27 ++++++++++++++
 arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi   | 36 +++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j7200.dtsi          |  8 +++--
 3 files changed, 69 insertions(+), 2 deletions(-)

-- 
2.28.0

