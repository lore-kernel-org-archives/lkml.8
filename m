Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38449C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 08:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EDB520772
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 08:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=maximintegrated.onmicrosoft.com header.i=@maximintegrated.onmicrosoft.com header.b="ZftUt73G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgFBIoV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 04:44:21 -0400
Received: from mail-eopbgr690096.outbound.protection.outlook.com ([40.107.69.96]:11589
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725835AbgFBIoV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 04:44:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sq6MOXsdxk9ETP5Sdl7ZjC9U2RdOiJ/P1ongxHqLIDBzrIxlClYp2b9CjeZwWlvhF3jDwCasCBJrRvTfuMTBxzn99ReFYiPqKf90x9+sohNcr/uXkGwMcaIlFjSdaEVMyPMuvdwId+zIBKOfggIHBl3JbQ+hboQOnLZ3WdKRX8nRqk1oH+bpXBsRmMDUWKh2jv3UgO+Z1YZ7lFzQIhwtpAWuFVzHl+K+1ZMN43PjWBPjqj2tc63Nn2kfy0vqZUEP96QV2ZvGH34OmyHCdaMi7Ft5iJjsrTwz+1A5AVI1Idor9PWx3gFRgb88bmm/vGF/Ti1w1GEHe4rIPffeKUw2BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ymLiV1mrG5Oz7Ulv3QIq03ZuC8dnksniBhorGy+hhIo=;
 b=nnB3M6B8BAtdpIGgtrSmp5cCkJarZzWGjMd2b8yuG07hBPpfa4BEr/ydQdTvQBLUJWV1Jvy9O6WXHLvpSkbB1cPKN3KNS03ilpuPTB1TiSSDnxbeMfiqIhb2sY2FwFF4pQNyqIIKWDcOUFDfH0DHs9sbgMen5kd1w0h/wEsdOLNfbXAdyBgKcbxFrHMX97OtICp31lPRxUgtkVsgPSknbRqHyGGhCQeZ60HsmcUhil7IPiyxFIckh0FN3TTsKtVCkM5MJ9t1WJvaqPkjSJaipMnx9YckI1O4F2wQKX1egvsftVHzZTfmsf1xXvmcR6sxs20Zd2J+z5PEsnwKwheQ9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=maximintegrated.com; dmarc=pass action=none
 header.from=maximintegrated.com; dkim=pass header.d=maximintegrated.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=maximintegrated.onmicrosoft.com;
 s=selector2-maximintegrated-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ymLiV1mrG5Oz7Ulv3QIq03ZuC8dnksniBhorGy+hhIo=;
 b=ZftUt73GL3IhEIs+u35CLsrd6xYUGe0yIZjTNn0DcF0v/QcaBWr8DVEluou6J09AsVVt1+OXQEtplsASl/65zf9FbLJQYRcIR/uh5ijmijCebq7hD6RI6gsCrCS6o/3BOLxBI7i2KAcfJM69QgBJWaAMuSRynwP+nyULEQpjx2g=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none
 header.from=maximintegrated.com;
Received: from MWHPR11MB2047.namprd11.prod.outlook.com (2603:10b6:300:2a::12)
 by MWHPR11MB1901.namprd11.prod.outlook.com (2603:10b6:300:110::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.22; Tue, 2 Jun
 2020 08:44:18 +0000
Received: from MWHPR11MB2047.namprd11.prod.outlook.com
 ([fe80::994e:6a48:f660:f363]) by MWHPR11MB2047.namprd11.prod.outlook.com
 ([fe80::994e:6a48:f660:f363%5]) with mapi id 15.20.3045.024; Tue, 2 Jun 2020
 08:44:18 +0000
From:   Steve Lee <steves.lee@maximintegrated.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ryan.lee.maxim@gmail.com, ryans.lee@maximintegrated.com,
        steves.lee.maxim@gmail.com,
        Steve Lee <steves.lee@maximintegrated.com>
Subject: [V7 PATCH] dt-bindings: Added device tree binding for max98390
Date:   Tue,  2 Jun 2020 17:43:37 +0900
Message-Id: <20200602084337.22116-1-steves.lee@maximintegrated.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SL2PR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:100:2d::23) To MWHPR11MB2047.namprd11.prod.outlook.com
 (2603:10b6:300:2a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2001:2d8:959:1878:d447:7247:839:5c8e) by SL2PR04CA0011.apcprd04.prod.outlook.com (2603:1096:100:2d::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17 via Frontend Transport; Tue, 2 Jun 2020 08:44:14 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [2001:2d8:959:1878:d447:7247:839:5c8e]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6f522d1d-9d2e-4fbe-3f42-08d806d122e3
X-MS-TrafficTypeDiagnostic: MWHPR11MB1901:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR11MB1901C186D34E721354E26AC5928B0@MWHPR11MB1901.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 0422860ED4
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JHy5y2AL/A5U2QeIavo71uB0iQi0otvvlTIIcpqc+kAiLyJ7D3Kxz0ib9wl+qg+yPXbiMSKA3EWpj3YPx2eh+CVHlT0srjXW6WL23lq8QSOdf3L+57LxMSBbZ+btddsNBf0QlRgkgWI1UVpnY29Ytjb3Ac0tm67CEGABzOpc/jrHWBJNHqtpmjolbn+awEhAgF1djofqxNMjBkwio24Szpl8+WEBxnDTNwbKtgPJtWJRvirIT7YAImt7uHB/e0BCo2BzYkx0iJIxBxrh7aGOLTC7juBibo/fmO1D2KQrS460h9XVVuphDGL/tHsOMxTODRa282JdwaNR+XaAHPYC/N3moaMt5BInumSUUBvVoIGQ2c9v0zJEyJZ8zdBTqHXkkbAuZweCgNz6tfC7FpgfJDVU8/5RG4o+FYteXzeuxpBxPSkL03nWDsvbtBjr963ZpLRC82i/huXX/ZBTuKsCaA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB2047.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(346002)(366004)(136003)(376002)(86362001)(6512007)(1076003)(83380400001)(478600001)(2906002)(6486002)(186003)(66556008)(4326008)(316002)(5660300002)(966005)(52116002)(6506007)(107886003)(66476007)(16526019)(69590400007)(66946007)(2616005)(36756003)(8676002)(6666004)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: j0xOhFrB3CyQwRO3ZsAab1Y6xmPJ674ieSlEuyy6ZiXUAOpyOvU0t+IC0eO+lB/Iw3zKMX2C8kn7Vct/4rTANK5lZiy30HOXjMQ3YVt6+cA9ncOBvEmPmwec1+3ig+p8sv8C2uO4HIh8kPFugSu7dEKv9NrrRfcbRbJ2d617fQy4prU17vx135Fq76F5Gm0v4S7wht9+WAd282JS0aL3k//a/AndJrtf346PIcs1FpkfvJ6GSRNBYElr5xnTjjIQrH+dMkixYuGwJTZsyTmEpCnkJYy7tWiTVaACSEl3wvhA8VExYcdaTcBvcXoJuN5HvSIIDh6cl8piNvBOXf7to81cyoUaczzcG6mhH2g3YQ6ar9gORL/6owYi16woMHmHtXSzwhRDmz4+/m7fVU/wG5KDsZDFqk/hXjITr8Ll2TvCwqqo/RiIdZ6OVBL8+BGuK43OUbAeXwZ4bT+0TseR2rwxqs9rFK40iTmDQ1n6Z78zrs8jgEvU6FrkJgS6ftaLefu91jzAszMNgGe+qeG4zqAlzVRlXsLjZfBuvC3s510=
X-OriginatorOrg: maximintegrated.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f522d1d-9d2e-4fbe-3f42-08d806d122e3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2020 08:44:17.8683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd909df-ea69-4788-a554-f24b7854ad03
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p8R93IdWgxgTeQpd2lL4+K9UXddTFYZjJzOZt236Zvd3Q22DkeKk6qix07g+qDdA0MIALrr7Wg6pH8H/HfPEmWO8x+2fgv3GobMSn8u6osA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1901
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT binding of max98390 amplifier driver.

Signed-off-by: Steve Lee <steves.lee@maximintegrated.com>
---

Changed since V6:
	* Re-confirm yaml dt binding check
	* Add minimum and maximum value for each temperature_calib and r0_calib
	* Add maxim prefix for naming.
Changed since V5:
	* Change txt to yaml and fix up the examples.
Changed since V4:
	* No changes.
Changed since V3:
	* No changes.
Changed since V2:
	* No changes.
Changed since V1:
	* Modified sample text in example

 .../bindings/sound/maxim,max98390.yaml        | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/maxim,max98390.yaml

diff --git a/Documentation/devicetree/bindings/sound/maxim,max98390.yaml b/Documentation/devicetree/bindings/sound/maxim,max98390.yaml
new file mode 100644
index 000000000000..e5ac35280da3
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/maxim,max98390.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/maxim,max98390.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim Integrated MAX98390 Speaker Amplifier with Integrated Dynamic Speaker Management
+
+maintainers:
+  - Steve Lee <steves.lee@maximintegrated.com>
+
+properties:
+  compatible:
+      const: maxim,max98390
+
+  reg:
+    maxItems: 1
+    description: I2C address of the device.
+
+  maxim,temperature_calib:
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+    description: The calculated temperature data was measured while doing the calibration.
+    minimum: 0
+    maximum: 65535
+
+  maxim,r0_calib:
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+    description: This is r0 calibration data which was measured in factory mode.
+    minimum: 1
+    maximum: 8388607
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      max98390: amplifier@38 {
+        compatible = "maxim,max98390";
+        reg = <0x38>;
+        maxim,temperature_calib = <1024>;
+        maxim,r0_calib = <100232>;
+      };
+    };
-- 
2.17.1

