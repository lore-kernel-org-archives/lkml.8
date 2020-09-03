Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A13ABC433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 12:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65AF02072A
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 12:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbgICMMl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 08:12:41 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:37492 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728810AbgICMFw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 08:05:52 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6FDF925D277F9FD9C604;
        Thu,  3 Sep 2020 20:05:27 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.253) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Thu, 3 Sep 2020 20:05:19 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 1/2] dt-bindings: interrupt-controller: add Hisilicon SD5203 vector interrupt controller
Date:   Thu, 3 Sep 2020 20:05:03 +0800
Message-ID: <20200903120504.2308-2-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20200903120504.2308-1-thunder.leizhen@huawei.com>
References: <20200903120504.2308-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT bindings for the Hisilicon SD5203 vector interrupt controller.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 .../hisilicon,sd5203-vic.txt                  | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/hisilicon,sd5203-vic.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/hisilicon,sd5203-vic.txt b/Documentation/devicetree/bindings/interrupt-controller/hisilicon,sd5203-vic.txt
new file mode 100644
index 000000000000..a08292e868b0
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/hisilicon,sd5203-vic.txt
@@ -0,0 +1,27 @@
+Hisilicon SD5203 vector interrupt controller (VIC)
+
+Hisilicon SD5203 VIC based on Synopsys DesignWare APB interrupt controller, but
+there's something special:
+1. The maximum number of irqs supported is 32. The registers ENABLE, MASK and
+   FINALSTATUS are 32 bits.
+2. There is only one VIC, it's used as primary interrupt controller.
+
+Required properties:
+- compatible: shall be "hisilicon,sd5203-vic"
+- reg: physical base address of the controller and length of memory mapped
+  region starting with ENABLE_LOW register
+- interrupt-controller: identifies the node as an interrupt controller
+- #interrupt-cells: number of cells to encode an interrupt-specifier, shall be 1
+
+The interrupt sources map to the corresponding bits in the interrupt
+registers, i.e.
+- 0 maps to bit 0 of low interrupts,
+- 1 maps to bit 1 of low interrupts,
+
+Example:
+	vic: interrupt-controller@10130000 {
+		compatible = "hisilicon,sd5203-vic";
+		reg = <0x10130000 0x1000>;
+		interrupt-controller;
+		#interrupt-cells = <1>;
+	};
-- 
2.26.0.106.g9fadedd


