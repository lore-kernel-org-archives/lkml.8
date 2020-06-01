Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F00C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A6392076B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgFAJp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 05:45:26 -0400
Received: from foss.arm.com ([217.140.110.172]:35650 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbgFAJpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 05:45:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 99CE9101E;
        Mon,  1 Jun 2020 02:45:20 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9CF803F305;
        Mon,  1 Jun 2020 02:45:19 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>
Subject: [RFC PATCH 1/3] dt-bindings: Add ARM PSA FF binding for non-secure VM partitions
Date:   Mon,  1 Jun 2020 10:45:10 +0100
Message-Id: <20200601094512.50509-2-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200601094512.50509-1-sudeep.holla@arm.com>
References: <20200601094512.50509-1-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree bindings for a Arm PSA FF-A compliant non-secure partition
at virtual interface(VMs).

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 .../devicetree/bindings/arm/arm,psa-ffa.txt   | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/arm,psa-ffa.txt

diff --git a/Documentation/devicetree/bindings/arm/arm,psa-ffa.txt b/Documentation/devicetree/bindings/arm/arm,psa-ffa.txt
new file mode 100644
index 000000000000..ee543fb5b397
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/arm,psa-ffa.txt
@@ -0,0 +1,47 @@
+Arm Platform Security Architecture(PSA) Firmware Framework(FF) for Armv8-A
+--------------------------------------------------------------------------
+
+This binding is intended to define the interface the firmware framework
+implementing the Non-secure partitions/endpoints(mostly VMs) as described
+in ARM document ARM DEN 0077A ("Arm Platform Security Architecture
+Firmware Framework for Arm v8-A") [0]
+
+In the case of a Non-secure virtual FF-A instance, the hypervisor
+(e.g. Linux KVM) can use this binding to create and launch VM partitions.
+
+The SMCCC conduit available in the VM partition itself is used and hence
+there is no explicit binding to specify the conduit used for PSA FFA
+interface.
+
+Required properties:
+
+- compatible : Should be one of:
+	       "arm,psa-ffa"
+
+- One or more child nodes, each describing an PSA FFA partition using the
+  following required properties:
+
+  - compatible: Should be one of:
+		"arm,psa-ffa-partition"
+
+  - uuid : The 128-bit UUID [2] of the service implemented by this partition,
+	   represented as a string.
+
+[0] https://developer.arm.com/docs/den0077/latest
+[1] https://tools.ietf.org/html/rfc4122
+
+Example:
+
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	firmware {
+		psa-ffa {
+			compatible = "arm,psa-ffa";
+
+			partition0: psa_ffa_partition {
+				compatible = "arm,psa-ffa-partition";
+				uuid = "12345678-9abc-def0-1234-56789abcdef0";
+			};
+		};
+	};
-- 
2.17.1

