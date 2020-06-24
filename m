Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3782EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 00:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D01D2078D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 00:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="R0ajLe+M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388863AbgFYAPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 20:15:51 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:25366 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388058AbgFYAPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 20:15:50 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200625001546epoutp0214c9676029202df0e68d91a10392c130~boTYdTF2i0237102371epoutp02H
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 00:15:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200625001546epoutp0214c9676029202df0e68d91a10392c130~boTYdTF2i0237102371epoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593044147;
        bh=K++Hc08bAChySryV6xpOMUZDcRAOfde/r1jVXz7IMhM=;
        h=From:To:Cc:Subject:Date:References:From;
        b=R0ajLe+Mp/4jHL01kttLwprq3dpuaRABc08yzW6zH/Xuni+IeiQv40kj8c54yGbPL
         KDkLCl2yVDKTM4yMDfXkZ4OKvWbMpbPDTYsa3XnfgalIyMubG/h5B2yCpjrN3B1SzJ
         852uSjCWTpskkiRwaT/o50jQjPJOgKWKn8K/P9bM=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20200625001545epcas5p428d7a679260ac346e34b1164dd488804~boTWr2J-J1595815958epcas5p4d;
        Thu, 25 Jun 2020 00:15:45 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D3.98.09475.0BCE3FE5; Thu, 25 Jun 2020 09:15:44 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20200625001543epcas5p2d1f9f7f7de574cac6db4157ca2ec1eec~boTVSj4E50338303383epcas5p2B;
        Thu, 25 Jun 2020 00:15:43 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200625001543epsmtrp29bc724a369ef686a37ad4ada5537ccce~boTVRpxmv1949219492epsmtrp2d;
        Thu, 25 Jun 2020 00:15:43 +0000 (GMT)
X-AuditID: b6c32a4b-39fff70000002503-24-5ef3ecb0d2c8
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9B.98.08382.FACE3FE5; Thu, 25 Jun 2020 09:15:43 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200625001541epsmtip147a08a9f7f078048181c7fc901b5ff2c~boTTzIqHU1042310423epsmtip1t;
        Thu, 25 Jun 2020 00:15:41 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     vkoul@kernel.org
Cc:     robh+dt@kernel.org, krzk@kernel.org, kwmad.kim@samsung.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        kishon@ti.com, Alim Akhtar <alim.akhtar@samsung.com>
Subject: [RESEND PATCH v10 1/2] dt-bindings: phy: Document Samsung UFS PHY
 bindings
Date:   Thu, 25 Jun 2020 05:26:30 +0530
Message-Id: <20200624235631.11232-1-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjleLIzCtJLcpLzFFi42LZdlhTS3fDm89xBov+W1o8mLeNzWL+kXOs
        Fhee9rBZnD+/gd3i5pajLBabHl9jtbi8aw6bxYzz+5gsWvceYbfYeecEswOXx6ZVnWwem5fU
        e/RtWcXocfzGdiaPz5vkAlijuGxSUnMyy1KL9O0SuDJmHd7IWHBfrGJd22L2BsbTgl2MnBwS
        AiYSn3aeYuli5OIQEtjNKPHpWi8bhPOJUeLGofdMIFVCAt8YJVZOdexi5ADraNnoAlGzl1Fi
        w9cVUDUtTBKNXzlAbDYBbYm707eAxUUERCRWr5zHCNLALPCXUWLb9Y+sIAlhgVCJw1tvgxWx
        CKhKPNp5AizOK2Ajsf/3YVaI8+QlVm84wAwRF5Q4OfMJC4jNDBRv3jqbGWSohMBPdonza3ex
        QFznInHvGC9Er7DEq+Nb2CFsKYnP7/ayQZRkS/TsMoYI10gsnXeMBcK2lzhwZQ7YFGYBTYn1
        u/QhNvFJ9P5+wgTRySvR0SYEUa0q0fzuKlSntMTE7m6ogz0kzqx8xgIJkViJ3a82s05glJuF
        5P5ZSO6fhbBsASPzKkbJ1ILi3PTUYtMC47zUcr3ixNzi0rx0veT83E2M4KSi5b2D8dGDD3qH
        GJk4GA8xSnAwK4nwhrh9ihPiTUmsrEotyo8vKs1JLT7EKM3BoiTOq/TjTJyQQHpiSWp2ampB
        ahFMlomDU6qB6dg/twnL56+LWfllCVvSHwWZHIve3WmHoo8oveqvbPZbqLz/j0vH8TUbnGe1
        PFK+yHTN1mBylP0Zka5X92d6f39+aguT+orvQoslS8xmPbrhc+qxQ0DM3ValX/+31zQuOCVX
        270s0jA9jT1zZU5SlHaBdn6gctM90/q1PDfzgpe0ZMjH1aUcmpjmn/qSs6vTLzzYveCidcnL
        RXVTfn2992m/XmT9L8272jveSXM/F9uV05/zzsu3lknjLce5trnNHicZw1/9MStODlXUylCt
        t3ViuH1+lq19p3Kz1/NZrDeSu91yE2Y3LeReGHMy1bWA6xDjMU3HC0rhzeXLdRgNHlkWbslV
        7GosYnBULVdiKc5INNRiLipOBAD7ACqxmQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrELMWRmVeSWpSXmKPExsWy7bCSnO76N5/jDPb+k7Z4MG8bm8X8I+dY
        LS487WGzOH9+A7vFzS1HWSw2Pb7GanF51xw2ixnn9zFZtO49wm6x884JZgcuj02rOtk8Ni+p
        9+jbsorR4/iN7UwenzfJBbBGcdmkpOZklqUW6dslcGXMOryRseC+WMW6tsXsDYynBbsYOTgk
        BEwkWja6dDFycggJ7GaUWHOxCsSWEJCWuL5xAjuELSyx8t9zIJsLqKaJSWLz589MIAk2AW2J
        u9O3gNkiAiISq1fOYwQpYhZoZ5K4/v0AWEJYIFji89GtYDaLgKrEo50nWEFsXgEbif2/D7NC
        bJCXWL3hADNEXFDi5MwnLCDHMQuoS6yfJwQSZgYqad46m3kCI/8sJFWzEKpmIalawMi8ilEy
        taA4Nz232LDAMC+1XK84Mbe4NC9dLzk/dxMjONi1NHcwbl/1Qe8QIxMH4yFGCQ5mJRHeELdP
        cUK8KYmVValF+fFFpTmpxYcYpTlYlMR5bxQujBMSSE8sSc1OTS1ILYLJMnFwSjUwKVqYdXns
        3Ok0ZTanyhRjq1cP7nyonhjAr9++4eQX3YVlk9saCrLPxkfITLN5+1YgbJnc264HQZPMVHL4
        f7Ee3nfFSDqsbN/5Fed/vt2iUiAxb/e0kE0z+jwXcojd+ztRyqb+ofsNRt3ar4ynew/8ndW8
        78HPxu9BrvnvJ6VeSow8/d9i5y6lM5s3LOS1KKq6y258NcLy0bHdwW0nvXYrWk/1FdNfeNgy
        eGfvNplVP43mtcRrdbmI2OTEy6TnpYZcYtoaeUjIprN1VrpvsKbQo3XliVqNNn2MwaxCZtdX
        T8756CgavnnlY6ld5UqP33WH97oflRE+KrvHVrni/obL1bc6NWZIvNkuPU/hlZWqEktxRqKh
        FnNRcSIA6ZK74+UCAAA=
X-CMS-MailID: 20200625001543epcas5p2d1f9f7f7de574cac6db4157ca2ec1eec
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20200625001543epcas5p2d1f9f7f7de574cac6db4157ca2ec1eec
References: <CGME20200625001543epcas5p2d1f9f7f7de574cac6db4157ca2ec1eec@epcas5p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch documents Samsung UFS PHY device tree bindings

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
Tested-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
This is just a rebase on phy-next, was part of series [1]
which adds ufs host contoller driver.
[1]  https://lkml.org/lkml/2020/5/27/1697

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
-- 
2.17.1

