Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E124C352A3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 04:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F3C322522
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 04:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fa8cbhBE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbgBGEnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 23:43:55 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:52736 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbgBGEnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 23:43:55 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0174honT006635;
        Thu, 6 Feb 2020 22:43:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1581050630;
        bh=N772M1HVWYuRbbvV8p+XPFSDQ/pQiXG8RazWTeN44xw=;
        h=From:To:CC:Subject:Date;
        b=fa8cbhBELrdPym8rin2aolElUB9oRfE9Xxb82LToFqHDP89z3zkUJ/UuidfPomAiv
         XnEXc2Ih1sRPxOZilFD5cYoN3eloc7ERQUyk4cZNf9d+siAuat6XfcXVptpN3ZXInD
         +gq9kPSIK38itHwkVuVciB82XhWt5t7zW+JDgg2Q=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0174horb077402
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 6 Feb 2020 22:43:50 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 6 Feb
 2020 22:43:50 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 6 Feb 2020 22:43:50 -0600
Received: from a0132425.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0174hkKC120043;
        Thu, 6 Feb 2020 22:43:47 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Santosh Shilimkar <ssantosh@kernel.org>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <t-kristo@ti.com>
Subject: [PATCH v2 0/2] clk: keystone: Add new driver to handle ehrpwm tbclk
Date:   Fri, 7 Feb 2020 10:14:23 +0530
Message-ID: <20200207044425.32398-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On TI's AM654 and J721e SoCs, certain clocks can be gated/ungated by setting a
single bit in SoC's System Control registers. Sometime more than
one clock control can be in the same register. But these registers might
also have bits to control other SoC functionalities.
For example, Time Base clock(TBclk) enable bits for various EPWM IPs are
all in EPWM_CTRL Syscon registers on K2G SoC.

This series adds a new clk driver to support controlling tbclk. Registers
which control clocks will be grouped into a syscon DT node, thus
enabling sharing of register across clk drivers and other drivers.

v2:
Simplify driver to have only one clock node per group of syscon
controller registers instead of one per clock instance.

v1: https://patchwork.kernel.org/cover/10848783/

Vignesh Raghavendra (2):
  dt-bindings: clock: Add binding documentation for TI syscon gate clock
  clk: keystone: Add new driver to handle syscon based clocks

 .../bindings/clock/ti,am654-ehrpwm-tbclk.yaml |  47 +++++
 drivers/clk/keystone/Kconfig                  |   8 +
 drivers/clk/keystone/Makefile                 |   1 +
 drivers/clk/keystone/syscon-clk.c             | 177 ++++++++++++++++++
 4 files changed, 233 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/ti,am654-ehrpwm-tbclk.yaml
 create mode 100644 drivers/clk/keystone/syscon-clk.c

-- 
2.25.0

