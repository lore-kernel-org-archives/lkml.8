Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C0BC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 16:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2EE3206F8
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 16:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404561AbgDCQ32 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 12:29:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36568 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404051AbgDCQ3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 12:29:14 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 033GEP7A035793;
        Fri, 3 Apr 2020 12:29:07 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com with ESMTP id 304gsundvn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Apr 2020 12:29:07 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 033GSlCS019265;
        Fri, 3 Apr 2020 16:29:05 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma02dal.us.ibm.com with ESMTP id 301x77xwxc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Apr 2020 16:29:05 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 033GT4s050921814
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Apr 2020 16:29:04 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 56EE8AE060;
        Fri,  3 Apr 2020 16:29:04 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 71896AE05C;
        Fri,  3 Apr 2020 16:29:03 +0000 (GMT)
Received: from ghost4.ibm.com (unknown [9.163.91.129])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  3 Apr 2020 16:29:03 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-aspeed@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, joel@jms.id.au, andrew@aj.id.au,
        eajames@linux.ibm.com
Subject: [PATCH v8 1/5] dt-bindings: soc: Add Aspeed XDMA Engine
Date:   Fri,  3 Apr 2020 11:28:57 -0500
Message-Id: <20200403162901.21106-2-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200403162901.21106-1-eajames@linux.ibm.com>
References: <20200403162901.21106-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-03_11:2020-04-03,2020-04-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 malwarescore=0 suspectscore=1 priorityscore=1501 lowpriorityscore=0
 phishscore=0 clxscore=1015 mlxlogscore=948 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004030134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the bindings for the Aspeed AST25XX and AST26XX XDMA engine.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
---
Changes since v6:
 - Add PCI-E root complex reset documentation
 - Add reset-names documentation
 - Switch to memory-region phandle instead of memory regs

 .../devicetree/bindings/soc/aspeed/xdma.txt   | 44 +++++++++++++++++++
 MAINTAINERS                                   |  6 +++
 2 files changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/aspeed/xdma.txt

diff --git a/Documentation/devicetree/bindings/soc/aspeed/xdma.txt b/Documentation/devicetree/bindings/soc/aspeed/xdma.txt
new file mode 100644
index 000000000000..c3d7cdeb1db6
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/aspeed/xdma.txt
@@ -0,0 +1,44 @@
+Aspeed AST25XX and AST26XX XDMA Engine
+
+The XDMA Engine embedded in the AST2500 and AST2600 SOCs can perform automatic
+DMA operations over PCI between the SOC (acting as a BMC) and a host processor.
+
+Required properties:
+ - compatible		: must be "aspeed,ast2500-xdma" or
+			  "aspeed,ast2600-xdma"
+ - reg			: contains the address and size of the memory region
+			  associated with the XDMA engine registers
+ - clocks		: clock specifier for the clock associated with the
+			  XDMA engine
+ - resets		: reset specifier for the syscon reset associated with
+			  the XDMA engine, and, for the AST2600, a second reset
+			  associated with the PCI-E root complex
+ - reset-names		: required only for the AST2600; must be "dev, "rc"
+ - interrupts-extended	: two interrupt cells; the first specifies the global
+			  interrupt for the XDMA engine and the second
+			  specifies the PCI-E reset or PERST interrupt.
+ - aspeed,scu		: a phandle to the syscon node for the system control
+			  unit of the SOC
+ - memory-region	: a phandle to the reserved memory region to be used by
+			  the XDMA engine for DMA operations
+
+Optional properties:
+ - pcie-device		: should be either "bmc" or "vga", corresponding to
+			  which device should be used by the XDMA engine for
+			  DMA operations. If this property is not set, the XDMA
+			  engine will use the BMC PCI-E device.
+
+Example:
+
+    xdma@1e6e7000 {
+        compatible = "aspeed,ast2600-xdma";
+        reg = <0x1e6e7000 0x100>;
+        clocks = <&syscon ASPEED_CLK_GATE_BCLK>;
+        resets = <&syscon ASPEED_RESET_DEV_XDMA>, <&syscon ASPEED_RESET_RC_XDMA>;
+        reset-names = "dev", "rc";
+        interrupts-extended = <&gic GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+                              <&scu_ic0 ASPEED_AST2600_SCU_IC0_PCIE_PERST_LO_TO_HI>;
+        aspeed,scu = <&syscon>;
+        pcie-device = "bmc";
+        memory-region = <&vga_memory>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 245a96316636..dcc0907b2aa5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2771,6 +2771,12 @@ S:	Maintained
 F:	drivers/media/platform/aspeed-video.c
 F:	Documentation/devicetree/bindings/media/aspeed-video.txt
 
+ASPEED XDMA ENGINE DRIVER
+M:	Eddie James <eajames@linux.ibm.com>
+L:	linux-aspeed@lists.ozlabs.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/devicetree/bindings/soc/aspeed/xdma.txt
+
 ASUS NOTEBOOKS AND EEEPC ACPI/WMI EXTRAS DRIVERS
 M:	Corentin Chary <corentin.chary@gmail.com>
 L:	acpi4asus-user@lists.sourceforge.net
-- 
2.24.0

