Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C283DC43461
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 09:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3E1A206F4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 09:05:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgGQJFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 05:05:14 -0400
Received: from mga14.intel.com ([192.55.52.115]:64984 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726530AbgGQJE6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 05:04:58 -0400
IronPort-SDR: YDKGW3RE9atmu8ZOf8OPhita2hqmmkgzq5+zyTYsQ5NzhUrUkV8G4m7ZVZWEb5RAcdj/wZGdQd
 0wIjILgNeQnA==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="148719445"
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="148719445"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 02:04:44 -0700
IronPort-SDR: kJMfeIN5E2kVzc7EFlALbeDhG9wsl9q+G0DtFpHKrmToBZSsQmks1lAy0YEV4+N7hIdAO3d6+Q
 1FKa+YVBPTVQ==
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="460786052"
Received: from enaessen-mobl1.ger.corp.intel.com (HELO dalessan-mobl1.ir.intel.com) ([10.251.86.9])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 02:04:40 -0700
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
        "Paul J. Murphy" <paul.j.murphy@linux.intel.com>,
        Dinh Nguyen <dinguyen@kernel.org>
Subject: [PATCH v4 2/5] dt-bindings: arm: Add Keem Bay bindings
Date:   Fri, 17 Jul 2020 10:04:11 +0100
Message-Id: <20200717090414.313530-3-daniele.alessandrelli@linux.intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200717090414.313530-1-daniele.alessandrelli@linux.intel.com>
References: <20200717090414.313530-1-daniele.alessandrelli@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniele Alessandrelli <daniele.alessandrelli@intel.com>

Document Intel Movidius SoC code-named Keem Bay, along with the Keem Bay
EVM board.

Reviewed-by: Dinh Nguyen <dinguyen@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
---
 .../bindings/arm/intel,keembay.yaml           | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/intel,keembay.yaml

diff --git a/Documentation/devicetree/bindings/arm/intel,keembay.yaml b/Documentation/devicetree/bindings/arm/intel,keembay.yaml
new file mode 100644
index 000000000000..4d925785f504
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/intel,keembay.yaml
@@ -0,0 +1,19 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/intel,keembay.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Keem Bay platform device tree bindings
+
+maintainers:
+  - Paul J. Murphy <paul.j.murphy@intel.com>
+  - Daniele Alessandrelli <daniele.alessandrelli@intel.com>
+
+properties:
+  compatible:
+    items:
+      - enum:
+        - intel,keembay-evm
+      - const: intel,keembay
+...
-- 
2.26.2

