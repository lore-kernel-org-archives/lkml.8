Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C23BFC4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 05:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9839424679
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 05:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rmtsiL1H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgB0FfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 00:35:14 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:47142 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgB0FfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 00:35:14 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01R5Z9nq009722;
        Wed, 26 Feb 2020 23:35:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582781709;
        bh=W6a8xjdmdk6xg15QL1s3y6dekJ7l96jr9e8pSwH3q0E=;
        h=From:To:CC:Subject:Date;
        b=rmtsiL1HmQ71s9YKQNYsl5WFRhepg6ktXQ5L5+MjW8BP3wwbrg1D7iOCGVPQAsobw
         myUIvlxF3PY+hUazeUZegFWF53o8cjkhuzMA01/h5wLzBGa4T4F3/rSuwlBFVTVPjy
         6maSyuJcKyTwNpHMgHglBNRPJ8+6migD4MOrKqow=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01R5Z9mT020205
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Feb 2020 23:35:09 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 26
 Feb 2020 23:35:09 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 26 Feb 2020 23:35:09 -0600
Received: from a0132425.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01R5Z6ee022834;
        Wed, 26 Feb 2020 23:35:06 -0600
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
Subject: [PATCH v4 0/2]  clk: keystone: Add new driver to handle ehrpwm tbclk
Date:   Thu, 27 Feb 2020 11:05:27 +0530
Message-ID: <20200227053529.16479-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.25.1
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

v4:
Fix up the title of YAML bindings file to drop reference to driver

v3:
Register syscon node as clk provider

v2:
Simplify driver to have only one clock node per group of syscon
controller registers instead of one per clock instance.

v1: https://patchwork.kernel.org/cover/10848783/

Vignesh Raghavendra (2):
  dt-bindings: clock: Add binding documentation for TI EHRPWM TBCLK
  clk: keystone: Add new driver to handle syscon based clocks

 .../bindings/clock/ti,am654-ehrpwm-tbclk.yaml |  35 ++++
 drivers/clk/keystone/Kconfig                  |   8 +
 drivers/clk/keystone/Makefile                 |   1 +
 drivers/clk/keystone/syscon-clk.c             | 172 ++++++++++++++++++
 4 files changed, 216 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/ti,am654-ehrpwm-tbclk.yaml
 create mode 100644 drivers/clk/keystone/syscon-clk.c

-- 
2.25.1

