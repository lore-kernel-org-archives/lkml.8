Return-Path: <SRS0=OX35=4D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9476BC4741C
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 14:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EF7C2082F
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 14:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uuH9l2oM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgBOOQ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Feb 2020 09:16:58 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:60066 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbgBOOQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Feb 2020 09:16:58 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01FEGnuV044784;
        Sat, 15 Feb 2020 08:16:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1581776209;
        bh=RYOaiBA9FV6IhJjYA+UzrWdsfigt3j0cagskXzoxCUM=;
        h=From:To:CC:Subject:Date;
        b=uuH9l2oMr/RC/4DCp2ipVfBOUE7k0Jj08LaS2d+yy2gTxQ35XIjHgH8ryLTuXMpUY
         ZQZKqWOy+frtLArR5GoH1ZK0v8oE8aaDOCoakvXdECpFz8egWq7nGgOJ4TWKoGIUNv
         WoLztlblcJT5/RESgcMTs8oHjYA6NI+1VQoyJkCM=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01FEGn7c077491
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 15 Feb 2020 08:16:49 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Sat, 15
 Feb 2020 08:16:48 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Sat, 15 Feb 2020 08:16:48 -0600
Received: from a0132425.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01FEGjP5004147;
        Sat, 15 Feb 2020 08:16:46 -0600
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
Subject: [PATCH v3 0/2] clk: keystone: Add new driver to handle ehrpwm tbclk
Date:   Sat, 15 Feb 2020 19:47:22 +0530
Message-ID: <20200215141724.32291-1-vigneshr@ti.com>
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

v3:
Register syscon node as clk provider

v2:
Simplify driver to have only one clock node per group of syscon
controller registers instead of one per clock instance.

v1: https://patchwork.kernel.org/cover/10848783/

Vignesh Raghavendra (2):
  dt-bindings: clock: Add binding documentation for TI syscon gate clock
  clk: keystone: Add new driver to handle syscon based clocks

 .../bindings/clock/ti,am654-ehrpwm-tbclk.yaml |  35 ++++
 drivers/clk/keystone/Kconfig                  |   8 +
 drivers/clk/keystone/Makefile                 |   1 +
 drivers/clk/keystone/syscon-clk.c             | 172 ++++++++++++++++++
 4 files changed, 216 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/ti,am654-ehrpwm-tbclk.yaml
 create mode 100644 drivers/clk/keystone/syscon-clk.c

-- 
2.25.0

