Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B330C2BA16
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 10:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37B5E206F5
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 10:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=flygoat.com header.i=jiaxun.yang@flygoat.com header.b="AjAsHQYn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388017AbgDBKvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 06:51:25 -0400
Received: from sender3-op-o12.zoho.com.cn ([124.251.121.243]:17882 "EHLO
        sender3-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387592AbgDBKvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 06:51:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1585824667;
        s=mail; d=flygoat.com; i=jiaxun.yang@flygoat.com;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=wo0+AUxnoZlrbKC5hxp6GLkb/pZHeEjSheMrmhdzJdg=;
        b=AjAsHQYnAt6ISbnGXlGVm/3UXUCLeWEcz7FoSKYEr/2x/g1EIs1WGklwJVu56xuZ
        ezUDrTUdoEY9kNT7TNABeHJyzebNP+jlM+HDF+B7XcEQ4W/9vyFYIr7dsWWEU2l7UDs
        CYDAFMl+wl6bXoe9h4+nbtVFBlMoVDPxH6gtZl/I=
Received: from localhost.localdomain (39.155.141.144 [39.155.141.144]) by mx.zoho.com.cn
        with SMTPS id 1585824666964419.4005134939064; Thu, 2 Apr 2020 18:51:06 +0800 (CST)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Rob Herring <robh+dt@kernel.org>,
        Huacai Chen <chenhc@lemote.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-ID: <20200402104851.368465-3-jiaxun.yang@flygoat.com>
Subject: [PATCH 3/5] dt-bindings: Document Loongson RS780E PCH ACPI Controller
Date:   Thu,  2 Apr 2020 18:48:41 +0800
X-Mailer: git-send-email 2.26.0.rc2
In-Reply-To: <20200402104851.368465-1-jiaxun.yang@flygoat.com>
References: <20200402104851.368465-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This controller is attached under ISA Bus and can be found
in Loongson-3 systems with RS780E PCH.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 .../bindings/mips/loongson/rs780e-acpi.yaml   | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mips/loongson/rs780e-=
acpi.yaml

diff --git a/Documentation/devicetree/bindings/mips/loongson/rs780e-acpi.ya=
ml b/Documentation/devicetree/bindings/mips/loongson/rs780e-acpi.yaml
new file mode 100644
index 000000000000..d317897e1115
--- /dev/null
+++ b/Documentation/devicetree/bindings/mips/loongson/rs780e-acpi.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/mips/loongson/rs780e-acpi.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Loongson RS780E PCH ACPI Controller
+
+maintainers:
+  - Jiaxun Yang <jiaxun.yang@flygoat.com>
+
+description: |
+  This controller can be found in Loongson-3 systems with RS780E PCH.
+
+properties:
+  compatible:
+    const: loongson,rs780e-acpi
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    isa@0 {
+      compatible =3D "isa";
+      #address-cells =3D <2>;
+      #size-cells =3D <1>;
+      ranges =3D <1 0 0 0x1000>;
+
+      acpi@800 {
+        compatible =3D "loongson,rs780e-acpi";
+        reg =3D <1 0x800 0x100>;
+      };
+    };
+
+...
--=20
2.26.0.rc2


