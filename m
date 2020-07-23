Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDADEC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 19:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8082B22B47
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 19:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ECkIRQ+U";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ObSUhpNM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbgGWTJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 15:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgGWTJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 15:09:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E636C0619DC;
        Thu, 23 Jul 2020 12:09:40 -0700 (PDT)
Date:   Thu, 23 Jul 2020 19:09:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595531378;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wZfFSsxHAB5cwoZHqlCIGgBvLiRHmrE/NCnCF5aUK5w=;
        b=ECkIRQ+UW6lqGVVagCpAEV90zL0T9vnILT8CSgmzuv+J5nZpfUdvbvjwNE9sqYv+W159r9
        B7n3zyCW2nkg3EBfbYRZFgBq1AInD4JlDb7dQbbx8TpOo+55pPy4zXK0K2soTz5cJtKID5
        CY1rtU1Z6Ykhf6WjfcGllYvUbgTixGIS/33yxxvXRiblF2OuOHMK/3CdkTsaFolHb3QRKb
        MDr6Nfa5HwnZOzmu/dK4NVDWMJkcgeqjbB1oxpcxsyMJRmKq9xAbjxukuJeA8wdF4tn4EV
        /WJqk6fvN7V3d0pU6ywIJZRxmOgkJe+6zsGX5j0XMtjMUglBUyf0Nl6syxwhkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595531378;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wZfFSsxHAB5cwoZHqlCIGgBvLiRHmrE/NCnCF5aUK5w=;
        b=ObSUhpNM3f4qnrEX2XP/90jaKbiPh8uLuJP5wUh9VoXyoCc4FDYo9Wr9G5DmKXO1jEAKdX
        MUEE/A4zzxDLDFCg==
From:   tip-bot2 for =?utf-8?b?5ZGo55Cw5p2w?= (Zhou Yanjie) 
        <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] dt-bindings: timer: Add Ingenic X1000 OST bindings.
Cc:     sernia.zhou@foxmail.com, zhouyanjie@wanyeetech.com,
        Paul Cercueil <paul@crapouillou.net>,
        Rob Herring <robh@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200722171804.97559-2-zhouyanjie@wanyeetech.com>
References: <20200722171804.97559-2-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Message-ID: <159553137772.4006.12727287721506810751.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     ac756d05c468e535380c7b4b102105793c5d095e
Gitweb:        https://git.kernel.org/tip/ac756d05c468e535380c7b4b102105793c5=
d095e
Author:        =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie) <zhouyanjie@wanyeete=
ch.com>
AuthorDate:    Thu, 23 Jul 2020 01:18:03 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 23 Jul 2020 16:58:09 +02:00

dt-bindings: timer: Add Ingenic X1000 OST bindings.

Add the OST bindings for the X1000 SoC from Ingenic.

Tested-by: =E5=91=A8=E6=AD=A3 (Zhou Zheng) <sernia.zhou@foxmail.com>
Signed-off-by: =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie) <zhouyanjie@wanyeete=
ch.com>
Reviewed-by: Paul Cercueil <paul@crapouillou.net>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200722171804.97559-2-zhouyanjie@wanyeetech.=
com
---
 Documentation/devicetree/bindings/timer/ingenic,sysost.yaml | 63 +++++++-
 include/dt-bindings/clock/ingenic,sysost.h                  | 12 +-
 2 files changed, 75 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/ingenic,sysost.ya=
ml
 create mode 100644 include/dt-bindings/clock/ingenic,sysost.h

diff --git a/Documentation/devicetree/bindings/timer/ingenic,sysost.yaml b/Do=
cumentation/devicetree/bindings/timer/ingenic,sysost.yaml
new file mode 100644
index 0000000..df3eb76
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/ingenic,sysost.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/ingenic,sysost.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Bindings for SYSOST in Ingenic XBurst family SoCs
+
+maintainers:
+  - =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
+
+description:
+  The SYSOST in an Ingenic SoC provides one 64bit timer for clocksource
+  and one or more 32bit timers for clockevent.
+
+properties:
+  "#clock-cells":
+    const: 1
+
+  compatible:
+    enum:
+      - ingenic,x1000-ost
+      - ingenic,x2000-ost
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: ost
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - "#clock-cells"
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/x1000-cgu.h>
+
+    ost: timer@12000000 {
+        compatible =3D "ingenic,x1000-ost";
+        reg =3D <0x12000000 0x3c>;
+
+        #clock-cells =3D <1>;
+
+        clocks =3D <&cgu X1000_CLK_OST>;
+        clock-names =3D "ost";
+
+        interrupt-parent =3D <&cpuintc>;
+        interrupts =3D <3>;
+    };
+...
diff --git a/include/dt-bindings/clock/ingenic,sysost.h b/include/dt-bindings=
/clock/ingenic,sysost.h
new file mode 100644
index 0000000..9ac88e9
--- /dev/null
+++ b/include/dt-bindings/clock/ingenic,sysost.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * This header provides clock numbers for the ingenic,tcu DT binding.
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_INGENIC_OST_H__
+#define __DT_BINDINGS_CLOCK_INGENIC_OST_H__
+
+#define OST_CLK_PERCPU_TIMER	0
+#define OST_CLK_GLOBAL_TIMER	1
+
+#endif /* __DT_BINDINGS_CLOCK_INGENIC_OST_H__ */
