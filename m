Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E0E0C4CECE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 14:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F30B6206FA
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 14:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgCMOq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 10:46:57 -0400
Received: from smtp2.ustc.edu.cn ([202.38.64.46]:57740 "EHLO ustc.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726481AbgCMOq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 10:46:56 -0400
Received: from xhacker (unknown [101.86.20.80])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygAnL5M7m2teLr88AA--.11016S2;
        Fri, 13 Mar 2020 22:39:56 +0800 (CST)
Date:   Fri, 13 Mar 2020 22:38:14 +0800
From:   Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 1/4] regulator: bindings: add MPS mp8869 voltage regulator
Message-ID: <20200313223814.07e40543@xhacker>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LkAmygAnL5M7m2teLr88AA--.11016S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw4fCrWkGr4fWr4xCr47twb_yoW8XrWxpF
        4DCFsxCr40yF1xWa1fGa4Iya1rXr48Ca4rCF12yw4Fgas8A3Zrt390kryrAF18Ar4kJFW5
        ArZ8Cry8Kw1Iv3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyFb7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWUJVW8Jw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E
        4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
        WUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
        Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rV
        W3JVWrJr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8
        JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8TCJPUUUUU==
X-CM-SenderInfo: xmv2xttqjtqzxdloh3xvwfhvlgxou0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

The MP8869 from Monolithic Power Systems is a single output dc/dc
converter with voltage control over i2c.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 .../devicetree/bindings/regulator/mp886x.txt       | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/mp886x.txt

diff --git a/Documentation/devicetree/bindings/regulator/mp886x.txt b/Documentation/devicetree/bindings/regulator/mp886x.txt
new file mode 100644
index 00000000..6858e38
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/mp886x.txt
@@ -0,0 +1,25 @@
+Monolithic Power Systems MP8869 voltage regulator
+
+Required properties:
+- compatible: "mps,mp8869";
+- reg: I2C slave address.
+- enable-gpios: enable gpios.
+- mps,fb-voltage-divider: An array of two integers containing the resistor
+  values R1 and R2 of the feedback voltage divider in kilo ohms.
+
+Any property defined as part of the core regulator binding, defined in
+./regulator.txt, can also be used.
+
+Example:
+
+	vcpu: regulator@62 {
+		compatible = "mps,mp8869";
+		regulator-name = "vcpu";
+		regulator-min-microvolt = <700000>;
+		regulator-max-microvolt = <850000>;
+		regulator-always-on;
+		regulator-boot-on;
+		enable-gpios = <&porta 1 GPIO_ACTIVE_LOW>;
+		mps,fb-voltage-divider = <80 240>;
+		reg = <0x62>;
+	};
-- 
2.7.4


