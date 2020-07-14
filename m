Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE13DC433EA
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 16:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB6292075B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 16:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbgGNQNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 12:13:55 -0400
Received: from mga17.intel.com ([192.55.52.151]:13555 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728281AbgGNQNy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 12:13:54 -0400
IronPort-SDR: cOZ3dXkC3vVzbzdVUQJon1ew9izxnkHbKAh2TLPxMiGZnZY7q27SvLdJHYpOHyqiqjfFzHpKp3
 Hb1yGA44RYjw==
X-IronPort-AV: E=McAfee;i="6000,8403,9681"; a="129030385"
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="scan'208";a="129030385"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2020 09:13:53 -0700
IronPort-SDR: v6TE1gIQVEZ9VPhhOjH/H2OxprPTbe0IVhPdt7ialG5gyYQbE4G7GMYeOj9NnkrfcNi4uw1/HN
 3WLZyjFaflFw==
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="scan'208";a="485930605"
Received: from yagellee-mobl.ger.corp.intel.com (HELO dalessan-mobl1.ir.intel.com) ([10.252.20.60])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2020 09:13:49 -0700
From:   Daniele Alessandrelli <daniele.alessandrelli@linux.intel.com>
List-Id: <soc.lore.kernel.org>
To:     linux-arm-kernel@lists.infradead.org, SoC Team <soc@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Paul J. Murphy" <paul.j.murphy@intel.com>,
        Dinh Nguyen <dinguyen@kernel.org>
Subject: [PATCH v3 5/7] MAINTAINERS: Add maintainers for Keem Bay SoC
Date:   Tue, 14 Jul 2020 17:13:03 +0100
Message-Id: <20200714161305.836348-6-daniele.alessandrelli@linux.intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200714161305.836348-1-daniele.alessandrelli@linux.intel.com>
References: <20200714161305.836348-1-daniele.alessandrelli@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniele Alessandrelli <daniele.alessandrelli@intel.com>

Add maintainers for the new Intel Movidius SoC code-named Keem Bay.

Reviewed-by: Dinh Nguyen <dinguyen@kernel.org>
Signed-off-by: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b4a43a9e7fbc..b151d0fc0588 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1954,6 +1954,14 @@ F:	drivers/irqchip/irq-ixp4xx.c
 F:	include/linux/irqchip/irq-ixp4xx.h
 F:	include/linux/platform_data/timer-ixp4xx.h
 
+ARM/INTEL KEEMBAY ARCHITECTURE
+M:	Paul J. Murphy <paul.j.murphy@intel.com>
+M:	Daniele Alessandrelli <daniele.alessandrelli@intel.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/arm/keembay.yaml
+F:	include/dt-bindings/clock/keembay-clocks.h
+F:	include/dt-bindings/power/keembay-power.h
+
 ARM/INTEL RESEARCH IMOTE/STARGATE 2 MACHINE SUPPORT
 M:	Jonathan Cameron <jic23@cam.ac.uk>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-- 
2.26.2

