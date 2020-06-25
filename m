Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1598C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 00:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 999AA20781
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 00:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jHXXxjot"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388810AbgFYAtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 20:49:49 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:55155 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388679AbgFYAts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 20:49:48 -0400
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200625004944epoutp01c42b64eb929c496b379293b986cb25a0~boxCIwlxh0463904639epoutp01_
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 00:49:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200625004944epoutp01c42b64eb929c496b379293b986cb25a0~boxCIwlxh0463904639epoutp01_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593046184;
        bh=Eds3BGSYDjL1I5LrtCqGZDPZaGJ30g3XqixJ3NbRXxE=;
        h=From:To:Cc:Subject:Date:References:From;
        b=jHXXxjotIl7OmsdMxwBfu6aPbByy8W+WdY8DNgPwKMqaM7BS7sElvMnANGGF91QcF
         7QaReLrarpqzNZbc1h8Qkk/VEi7PNEq9yuUrLbB6aobthKmfmkdW+qjMXq55RHftL7
         DcFBpUJ1jnji0zH5og6QvD5YDhhWc/4yB9LZYbZM=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20200625004943epcas5p348d85321de5b65ae60e24b50c6f82e11~boxA33NSh0109901099epcas5p3u;
        Thu, 25 Jun 2020 00:49:43 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D6.8E.09467.7A4F3FE5; Thu, 25 Jun 2020 09:49:43 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20200625004942epcas5p13b2b4303e42bdd00f203419cbf883177~boxAWD5Jy0190701907epcas5p1O;
        Thu, 25 Jun 2020 00:49:42 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200625004942epsmtrp16c64aedb0adb8820ca6758fee3e679f7~boxAVV4X52883928839epsmtrp1E;
        Thu, 25 Jun 2020 00:49:42 +0000 (GMT)
X-AuditID: b6c32a49-a29ff700000024fb-a1-5ef3f4a72cf6
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BE.7B.08382.6A4F3FE5; Thu, 25 Jun 2020 09:49:42 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200625004941epsmtip2803d568a082e823207b9f42a2f2b1aad~bow-OcBS_3239932399epsmtip2c;
        Thu, 25 Jun 2020 00:49:41 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     robh+dt@kernel.org
Cc:     krzk@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>
Subject: [RESEND PATCH v10] dt-bindings: ufs: Add bindings for Samsung ufs
 host
Date:   Thu, 25 Jun 2020 06:00:25 +0530
Message-Id: <20200625003025.11656-1-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRmVeSWpSXmKPExsWy7bCmhu7yL5/jDN72c1k8mLeNzWL+kXOs
        FufPb2C32PT4GqvF5V1z2CxmnN/HZNG69wi7A7vHplWdbB6bl9R79G1ZxejxeZNcAEsUl01K
        ak5mWWqRvl0CV8bdbR3MBV2yFb8XLWZuYFwq3sXIySEhYCJxePcv9i5GLg4hgd2MEp++X2WC
        cD4xSsw4+5URwvnGKPF1yk62LkYOsJY5zeUQ8b2MEtf3bGSGcFqYJA79fcgEMpdNQFvi7vQt
        TCANIgJiEnvXioLUMAscZJS4sf4/M0iNsECgxIPtJ8HqWQRUJc6dXMIIYvMK2Eg8/tTJAnGf
        vMTqDQfAFkgIrGKXmHz6FhNEwkWiq/cvVJGwxKvjW9ghbCmJl/1t7BCXZkv07DKGCNdILJ13
        DKrcXuLAlTksICXMApoS63fpg4SZBfgken8/YYLo5JXoaBOCqFaVaH53FapTWmJidzcrhO0h
        sWXdazBbSCBW4tb25ywTGGVmIQxdwMi4ilEytaA4Nz212LTAMC+1XK84Mbe4NC9dLzk/dxMj
        OKK1PHcw3n3wQe8QIxMH4yFGCQ5mJRHeELdPcUK8KYmVValF+fFFpTmpxYcYpTlYlMR5lX6c
        iRMSSE8sSc1OTS1ILYLJMnFwSjUwsWkf3n5Kj1cz6YlsTvhvsavsLWyJi+Ie7o099SNuq1bV
        PX5jBU7nz3a2p85+Epp4zY3rv2585coYlodRfFtOPQtS5z37wHbGrMaDe7yWt8W33Dljse7T
        yxOdnDNk7Y8nLgx7MvOQXcFlwdfvP8ccntT3aRmTyyWWvS/T9bWj7u+6scrupNKfA3vuv5o2
        4eDPHbUl9em9u3wCHPas2y/MsMrniM+FdS9Kt3Szn+eKjleJuKM46caSrcfNa0S+P+n4ybv0
        jgavxFvRQq3dIcKxq7VsWtZcYcrY5J5v9ERoP191OWts+0qRg+ann8Te2m0prOBl4+XGsSxg
        zdYqRnfhuwq57Zs41zkeEdu5xUmnUomlOCPRUIu5qDgRAOauKkZXAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBJMWRmVeSWpSXmKPExsWy7bCSvO6yL5/jDGb1K1s8mLeNzWL+kXOs
        FufPb2C32PT4GqvF5V1z2CxmnN/HZNG69wi7A7vHplWdbB6bl9R79G1ZxejxeZNcAEsUl01K
        ak5mWWqRvl0CV8bdbR3MBV2yFb8XLWZuYFwq3sXIwSEhYCIxp7m8i5GLQ0hgN6PEwV9TGLsY
        OYHi0hLXN05gh7CFJVb+e84OUdTEJHHow3qwIjYBbYm707cwgQwSERCT2LtWFKSGWeA4o8Tt
        7nZWkBphAX+JTb/ugg1iEVCVOHdyCVgvr4CNxONPnSwQC+QlVm84wDyBkWcBI8MqRsnUguLc
        9NxiwwLDvNRyveLE3OLSvHS95PzcTYzgwNHS3MG4fdUHvUOMTByMhxglOJiVRHhD3D7FCfGm
        JFZWpRblxxeV5qQWH2KU5mBREue9UbgwTkggPbEkNTs1tSC1CCbLxMEp1cAkaJARx2rQ3/tp
        UcWvp6xaVz7+bQ1YmSU8ZWHe7YbcM2fbdDZYpAVeOVP0K/n60f+91jI1HUc+OFQxJ+j9/xXw
        RmN3eEvRPNatU+UDj/htsDs2meWb/NeXK17oGvkvbeD6/fq3mWVM648pM8KW/fp9feulO8HW
        1QxHLi48EOb/zle4qHmOMNc9oU/3BKQUkvQ0ZZjOqm76s7Bv4qe33YscNM3fcz96sucxu8+i
        hrlyep+2zRS6q1TJGX9qRpHcPLXvHwSZAxXuz2W33bL30Iq1scmvf5pnuIj8s/v1Ujgv/3e1
        /3vV067KpYevl4itk97k77hq38SUw2tfRjqWl3x3ji6c7HOPc1WNnMOHOeycSizFGYmGWsxF
        xYkAOendCosCAAA=
X-CMS-MailID: 20200625004942epcas5p13b2b4303e42bdd00f203419cbf883177
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20200625004942epcas5p13b2b4303e42bdd00f203419cbf883177
References: <CGME20200625004942epcas5p13b2b4303e42bdd00f203419cbf883177@epcas5p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds DT bindings for Samsung ufs hci

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---

Hi Rob
This is just a rebase on your's dt/next

This patch was part of [1]
[1] https://lkml.org/lkml/2020/5/27/1697

 .../bindings/ufs/samsung,exynos-ufs.yaml      | 89 +++++++++++++++++++
 1 file changed, 89 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ufs/samsung,exynos-ufs.yaml

diff --git a/Documentation/devicetree/bindings/ufs/samsung,exynos-ufs.yaml b/Documentation/devicetree/bindings/ufs/samsung,exynos-ufs.yaml
new file mode 100644
index 000000000000..38193975c9f1
--- /dev/null
+++ b/Documentation/devicetree/bindings/ufs/samsung,exynos-ufs.yaml
@@ -0,0 +1,89 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ufs/samsung,exynos-ufs.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung SoC series UFS host controller Device Tree Bindings
+
+maintainers:
+  - Alim Akhtar <alim.akhtar@samsung.com>
+
+description: |
+  Each Samsung UFS host controller instance should have its own node.
+  This binding define Samsung specific binding other then what is used
+  in the common ufshcd bindings
+  [1] Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
+
+properties:
+
+  compatible:
+    enum:
+      - samsung,exynos7-ufs
+
+  reg:
+    items:
+     - description: HCI register
+     - description: vendor specific register
+     - description: unipro register
+     - description: UFS protector register
+
+  reg-names:
+    items:
+      - const: hci
+      - const: vs_hci
+      - const: unipro
+      - const: ufsp
+
+  clocks:
+    items:
+      - description: ufs link core clock
+      - description: unipro main clock
+
+  clock-names:
+    items:
+      - const: core_clk
+      - const: sclk_unipro_main
+
+  interrupts:
+    maxItems: 1
+
+  phys:
+    maxItems: 1
+
+  phy-names:
+    const: ufs-phy
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - phys
+  - phy-names
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/exynos7-clk.h>
+
+    ufs: ufs@15570000 {
+       compatible = "samsung,exynos7-ufs";
+       reg = <0x15570000 0x100>,
+             <0x15570100 0x100>,
+             <0x15571000 0x200>,
+             <0x15572000 0x300>;
+       reg-names = "hci", "vs_hci", "unipro", "ufsp";
+       interrupts = <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>;
+       clocks = <&clock_fsys1 ACLK_UFS20_LINK>,
+                <&clock_fsys1 SCLK_UFSUNIPRO20_USER>;
+       clock-names = "core_clk", "sclk_unipro_main";
+       pinctrl-names = "default";
+       pinctrl-0 = <&ufs_rst_n &ufs_refclk_out>;
+       phys = <&ufs_phy>;
+       phy-names = "ufs-phy";
+    };
+...

base-commit: b3a9e3b9622ae10064826dccb4f7a52bd88c7407
prerequisite-patch-id: e0425bbe8f2aff3882b728a0caf0218b6b3e9b6e
prerequisite-patch-id: c8c8502c512f9d6fdaf7d30e54dde3e68c3d855b
prerequisite-patch-id: 8505df2fd70632150b50543cadc6fd7dd42d191c
prerequisite-patch-id: 1a9701ab83425940c8aacb76737edb57ab815e47
prerequisite-patch-id: 7881e0b87f1f04f657d9e6d450fb5231ad6ffa1a
prerequisite-patch-id: 01dbc0e550e3fcad6e525e7e3183f9f0312e8496
prerequisite-patch-id: ad801812fff960abab3f27d2c7383be9fd9aa439
prerequisite-patch-id: 65474c9540e6dc749d30223897de1f486d6b3843
prerequisite-patch-id: 64b58cd4c5ecfacf28fc20c31a6617092a1e1931
prerequisite-patch-id: 9bcdd2995fd3f6361f8d5e89c56645058ac9ff96
-- 
2.17.1

