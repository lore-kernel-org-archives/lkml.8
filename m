Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3086C433E7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 16:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AE512253A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 16:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbgGNQNu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 12:13:50 -0400
Received: from mga17.intel.com ([192.55.52.151]:13555 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728281AbgGNQNt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 12:13:49 -0400
IronPort-SDR: eOEYARkJ6RH14vh5s7DyxmB8TbBKday4SXAhpn15WvoGQVWLqFpENtrzbMt9JiC+mB4I9RQS2r
 j2snln2wP6wg==
X-IronPort-AV: E=McAfee;i="6000,8403,9681"; a="129030372"
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="scan'208";a="129030372"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2020 09:13:49 -0700
IronPort-SDR: w02oRpL+zy/c4+nw16rV03VnHTGrSz40xWcmPlrviQAykU91o0+Mtr+DbOtNcYjXFn8CwLJexJ
 Ii7zVmI/uHug==
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="scan'208";a="485930577"
Received: from yagellee-mobl.ger.corp.intel.com (HELO dalessan-mobl1.ir.intel.com) ([10.252.20.60])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2020 09:13:45 -0700
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
Subject: [PATCH v3 4/7] dt-bindings: power: Add Keem Bay power domains
Date:   Tue, 14 Jul 2020 17:13:02 +0100
Message-Id: <20200714161305.836348-5-daniele.alessandrelli@linux.intel.com>
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

Add power domain dt-bindings for Keem Bay SoC.

Signed-off-by: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
---
 include/dt-bindings/power/keembay-power.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 include/dt-bindings/power/keembay-power.h

diff --git a/include/dt-bindings/power/keembay-power.h b/include/dt-bindings/power/keembay-power.h
new file mode 100644
index 000000000000..1385c42f897d
--- /dev/null
+++ b/include/dt-bindings/power/keembay-power.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause) */
+/*
+ * Copyright (c) 2020 Intel Corporation.
+ *
+ * Device tree defines for power domains in Keem Bay.
+ */
+
+#ifndef __DT_BINDINGS_KEEMBAY_POWER_H
+#define __DT_BINDINGS_KEEMBAY_POWER_H
+
+#define KEEM_BAY_PSS_POWER_DOMAIN 0
+#define KEEM_BAY_MSS_CPU_POWER_DOMAIN 1
+#define KEEM_BAY_VDEC_POWER_DOMAIN 2
+#define KEEM_BAY_VENC_POWER_DOMAIN 3
+#define KEEM_BAY_PCIE_POWER_DOMAIN 4
+#define KEEM_BAY_USS_POWER_DOMAIN 5
+#define KEEM_BAY_MSS_CAM_POWER_DOMAIN 6
+
+#endif /* __DT_BINDINGS_KEEMBAY_POWER_H */
-- 
2.26.2

