Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 800FBC433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 01:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5534D2070E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 01:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="J9H1WSMq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbgGQBrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 21:47:43 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:27133 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbgGQBrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 21:47:42 -0400
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200717014738epoutp0412614e90e4ca5be15c56eeda0fcc5273~iZv3VcK-70139901399epoutp04g
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 01:47:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200717014738epoutp0412614e90e4ca5be15c56eeda0fcc5273~iZv3VcK-70139901399epoutp04g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1594950458;
        bh=HoYLigUkXpgPPX/S1zvIzuISGl/Lk1UqTK8Vt6lzUac=;
        h=From:To:Cc:Subject:Date:References:From;
        b=J9H1WSMqZp+ONlZhhyvxb9X4Y5eDkO7nHs1Cc2v8PNGBbMgU0b6HopU6sSE284bq0
         Q4tdQj86x3w1N965oXBP97NOwzorietBuRAb7xTZDPg/d0m7OxtXTxsOTZGuJgBjiJ
         71c/P43ZPteJjaV04vW2Udi58HYrDEhOkkpx/Pgg=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20200717014737epcas5p239cfde51eed65112095d564f2ae67392~iZv2dqHMU1345213452epcas5p2X;
        Fri, 17 Jul 2020 01:47:37 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7A.23.09475.933011F5; Fri, 17 Jul 2020 10:47:37 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20200716194405epcas5p2da2808b30d8f958290bc5d424aa6a0c7~iUyco0cpl0350903509epcas5p2e;
        Thu, 16 Jul 2020 19:44:05 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200716194405epsmtrp26da9ad8315e22d1625ba78198590ad0e~iUycoErbs1392113921epsmtrp2F;
        Thu, 16 Jul 2020 19:44:05 +0000 (GMT)
X-AuditID: b6c32a4b-39fff70000002503-77-5f1103397652
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        F5.56.08303.50EA01F5; Fri, 17 Jul 2020 04:44:05 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200716194404epsmtip18d525f308c7b0757ca2f3f374c782f92~iUybTPfi61985919859epsmtip1U;
        Thu, 16 Jul 2020 19:44:04 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     vkoul@kernel.org
Cc:     robh+dt@kernel.org, krzk@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>
Subject: [PATCH v13 1/2] dt-bindings: phy: Document Samsung UFS PHY bindings
Date:   Fri, 17 Jul 2020 00:52:16 +0530
Message-Id: <20200716192217.35740-1-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgleLIzCtJLcpLzFFi42LZdlhTQ9eSWTDe4MEVaYsH87axWcw/co7V
        4vz5DewWmx5fY7W4vGsOm8WM8/uYLFr3HmG32HnnBLMDh8emVZ1sHpuX1Hv0bVnF6PF5k1wA
        SxSXTUpqTmZZapG+XQJXxvx971kLOsUq3s9Zx9jA2CXYxcjJISFgIvHyfCN7FyMXh5DAbkaJ
        rztXs0I4nxglnt19wwjhfGaU+HSwix2mpefKcxaIxC5GicV/PkO1tDBJbD+wD6yKTUBb4u70
        LUwgtoiAiMTqlfPARjELXGWU+LlnByNIQljAR+LBmanMIDaLgKrEzhO/wJp5BWwkFk3ZzAix
        Tl5i9YYDzBBxQYmTM5+wgNjMQPHmrbOZQYZKCNxjl3h8fQkTRIOLRMv+jSwQtrDEq+NboO6W
        kvj8bi9bFyMHkJ0t0bPLGCJcI7F03jGocnuJA1fmsICUMAtoSqzfpQ8RlpWYemodE8RaPone
        30+gNvFK7JgHY6tKNL+7CjVGWmJidzcrhO0h8W77PjBbSCBW4vmu40wTGOVnIflmFpJvZiFs
        XsDIvIpRMrWgODc9tdi0wDgvtVyvODG3uDQvXS85P3cTIzixaHnvYHz04IPeIUYmDsZDjBIc
        zEoivPNfCsQL8aYkVlalFuXHF5XmpBYfYpTmYFES51X6cSZOSCA9sSQ1OzW1ILUIJsvEwSnV
        wBR81v7Ewfrrt7/Jed3Q36l70Gpl8J/bZXHvWG/OEt7carpcwpXZKHydJp+Y6N69kdK/dwnr
        7ZNSWp8xb+fl52ktPTmiu/4vz/IqifNf6fTDb3G+x6FG3aXCq0Py98he4N3/4u5Nq4i0+ZsX
        8rJ+DMoUvbj9bmSxcQ6DMKPfGjaVWBmxxOkCC8V35h16ZqzirlQ55fpknavyl510zhd77q/5
        d2KT84pdPg0Ou6avTnYvDnB/P7n6/Yzqln+HNm53bZp5s85V88DpGwrvV8/M6GOcO2vlvONX
        P1hfCPGrz3n8U/PdXXHW5/zrMxdePvLdRzvpD3/hLanDGay1vmU/1rBPPm1gmq9WxDtpZuEU
        gSVKLMUZiYZazEXFiQAOe7ShmwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMLMWRmVeSWpSXmKPExsWy7bCSnC7rOoF4g6OdShYP5m1js5h/5Byr
        xfnzG9gtNj2+xmpxedccNosZ5/cxWbTuPcJusfPOCWYHDo9NqzrZPDYvqffo27KK0ePzJrkA
        ligum5TUnMyy1CJ9uwSujPn73rMWdIpVvJ+zjrGBsUuwi5GTQ0LARKLnynMWEFtIYAejxPHu
        eIi4tMT1jRPYIWxhiZX/nrND1DQxSUw+xwpiswloS9ydvoUJxBYREJFYvXIeYxcjFwezwF1G
        iel7b7KBJIQFfCQenJnKDGKzCKhK7DzxC2wQr4CNxKIpmxkhFshLrN5wgBkiLihxcuYToIM4
        gAapS6yfJwQSZgYqad46m3kCI/8sJFWzEKpmIalawMi8ilEytaA4Nz232LDAKC+1XK84Mbe4
        NC9dLzk/dxMjOJy1tHYw7ln1Qe8QIxMH4yFGCQ5mJRFeHi7eeCHelMTKqtSi/Pii0pzU4kOM
        0hwsSuK8X2ctjBMSSE8sSc1OTS1ILYLJMnFwSjUwKd08O888K/pmtpPstVlpNn+5XoS8+zLZ
        Yqbqv6288U6+Rw2VhRkZhCWfnT833STsXk2jxS7BF0eaZ07+cWwOm4JdC5fJka0c2+/WN/RI
        VPAfPy/zYmbDVc7P7C2uXFVGnNEGX1n+1ZgkzuWcuYxdsso2J3uj/IrnhtxzxLc9sN61MmTS
        F6lbGt/iNXpzTr9faX+1c21O+J15k3MjH5rWb3j57f78b6yRIeUHN/FNeLnwx6rkj4tKcvab
        1Yuw/ru9yq13U5v7pAeBstEum2/805NNt+HbUHZfd9PO2h+rvc4tFK3493T1b2XHjAlyT3ZX
        xcTxfy+4+EbtydFfFp5ZzEePb/WvmHjTcoF5Qtvuv0osxRmJhlrMRcWJAA9JopjWAgAA
X-CMS-MailID: 20200716194405epcas5p2da2808b30d8f958290bc5d424aa6a0c7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20200716194405epcas5p2da2808b30d8f958290bc5d424aa6a0c7
References: <CGME20200716194405epcas5p2da2808b30d8f958290bc5d424aa6a0c7@epcas5p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch documents Samsung UFS PHY device tree bindings

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
Tested-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 .../bindings/phy/samsung,ufs-phy.yaml         | 75 +++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/samsung,ufs-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/samsung,ufs-phy.yaml b/Documentation/devicetree/bindings/phy/samsung,ufs-phy.yaml
new file mode 100644
index 000000000000..636cc501b54f
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/samsung,ufs-phy.yaml
@@ -0,0 +1,75 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/samsung,ufs-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung SoC series UFS PHY Device Tree Bindings
+
+maintainers:
+  - Alim Akhtar <alim.akhtar@samsung.com>
+
+properties:
+  "#phy-cells":
+    const: 0
+
+  compatible:
+    enum:
+      - samsung,exynos7-ufs-phy
+
+  reg:
+    maxItems: 1
+
+  reg-names:
+    items:
+      - const: phy-pma
+
+  clocks:
+    items:
+      - description: PLL reference clock
+      - description: symbol clock for input symbol ( rx0-ch0 symbol clock)
+      - description: symbol clock for input symbol ( rx1-ch1 symbol clock)
+      - description: symbol clock for output symbol ( tx0 symbol clock)
+
+  clock-names:
+    items:
+      - const: ref_clk
+      - const: rx1_symbol_clk
+      - const: rx0_symbol_clk
+      - const: tx0_symbol_clk
+
+  samsung,pmu-syscon:
+    $ref: '/schemas/types.yaml#/definitions/phandle'
+    description: phandle for PMU system controller interface, used to
+                 control pmu registers bits for ufs m-phy
+
+required:
+  - "#phy-cells"
+  - compatible
+  - reg
+  - reg-names
+  - clocks
+  - clock-names
+  - samsung,pmu-syscon
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/exynos7-clk.h>
+
+    ufs_phy: ufs-phy@15571800 {
+        compatible = "samsung,exynos7-ufs-phy";
+        reg = <0x15571800 0x240>;
+        reg-names = "phy-pma";
+        samsung,pmu-syscon = <&pmu_system_controller>;
+        #phy-cells = <0>;
+        clocks = <&clock_fsys1 SCLK_COMBO_PHY_EMBEDDED_26M>,
+                 <&clock_fsys1 PHYCLK_UFS20_RX1_SYMBOL_USER>,
+                 <&clock_fsys1 PHYCLK_UFS20_RX0_SYMBOL_USER>,
+                 <&clock_fsys1 PHYCLK_UFS20_TX0_SYMBOL_USER>;
+        clock-names = "ref_clk", "rx1_symbol_clk",
+                      "rx0_symbol_clk", "tx0_symbol_clk";
+
+    };
+...

base-commit: 0ff35966d171ec99b118df666c1687cc86ba8d7e
-- 
2.17.1

