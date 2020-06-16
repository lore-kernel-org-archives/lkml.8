Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07257C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAA2220882
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731532AbgFPP4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 11:56:31 -0400
Received: from mga07.intel.com ([134.134.136.100]:36618 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733159AbgFPP42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 11:56:28 -0400
IronPort-SDR: bfpRj0EjOsGkkSjl6V1XjKu+1wuzklwM7TDCZdYkI6meeBQH9COAtj4RNFcNKMGUzAVk7Su3t3
 dmueh2Icwo/A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2020 08:56:27 -0700
IronPort-SDR: in4r+TxdBN4FC3FWATQR7/ZxAsXR/nLhuKTUZGFkw0TDMg6ovkftth9h3pL9rvP5mbyQgFtP7o
 G4H98731L5jg==
X-IronPort-AV: E=Sophos;i="5.73,518,1583222400"; 
   d="scan'208";a="449888089"
Received: from pperycz-mobl.ger.corp.intel.com (HELO dalessan-mobl1.ir.intel.com) ([10.213.235.69])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2020 08:56:24 -0700
From:   Daniele Alessandrelli <daniele.alessandrelli@linux.intel.com>
To:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Paul Murphy <paul.j.murphy@intel.com>,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 1/7] dt-bindings: mailbox: Add Keem Bay SCMI mailbox bindings
Date:   Tue, 16 Jun 2020 16:56:07 +0100
Message-Id: <20200616155613.121242-2-daniele.alessandrelli@linux.intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200616155613.121242-1-daniele.alessandrelli@linux.intel.com>
References: <20200616155613.121242-1-daniele.alessandrelli@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Murphy <paul.j.murphy@intel.com>

These are the bindings required for the Intel Keem Bay SCMI mailbox
driver.

Reviewed-by: Dinh Nguyen <dinguyen@kernel.org>
Signed-off-by: Paul Murphy <paul.j.murphy@intel.com>
---
 .../mailbox/intel,keembay-scmi-mailbox.yaml   | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/intel,keembay-scmi-mailbox.yaml

diff --git a/Documentation/devicetree/bindings/mailbox/intel,keembay-scmi-mailbox.yaml b/Documentation/devicetree/bindings/mailbox/intel,keembay-scmi-mailbox.yaml
new file mode 100644
index 000000000000..149294dd8141
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/intel,keembay-scmi-mailbox.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (c) 2020 Intel Corporation
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/mailbox/intel,keembay-scmi-mailbox.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Intel Keem Bay SCMI mailbox
+
+maintainers:
+  - Paul Murphy <paul.j.murphy@intel.com>
+
+description: |
+  The Intel Keem Bay SCMI mailbox is used to communicate SCMI messages to the
+  runtime service in BL31 behaving as the SCMI 'SCP'.
+  Refer to ./mailbox.txt for generic information about mailbox device-tree
+  bindings.
+  For more information about SCMI, refer to the bindings described in
+  Documentation/devicetree/bindings/arm/arm,scmi.txt
+
+properties:
+  compatible:
+    enum:
+      - intel,keembay-scmi-mailbox
+
+  "#mbox-cells":
+    const: 1
+
+  memory-region:
+    description:
+      Memory region describing the SCMI shared memory
+
+required:
+  - compatible
+  - "#mbox-cells"
+  - memory-region
+
+examples:
+  - |
+    scmi_mailbox: scmi_mailbox {
+        compatible = "intel,keembay-scmi-mailbox";
+        #mbox-cells = <1>;
+        memory-region = <&scmi_sec_shmem>;
+    };
-- 
2.26.2

