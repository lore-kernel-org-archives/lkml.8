Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DCCC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 20:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5288520739
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 20:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbgFNUYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 16:24:41 -0400
Received: from mail-oln040092010077.outbound.protection.outlook.com ([40.92.10.77]:5929
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726648AbgFNUYj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 16:24:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hAkIJ6BWdqaNuP9NooLcKd7pM7lay3nsRbAPUQD24nwZLMHjWPFk9y25ecVHguuwOYc9UUoOzmowqXkc8nd+fSrJSgd6fCCLo+DrSQ2h33oGz12kkUR3I1jcMlVnAxd3hYV7CbXZ4vim897PMTwZUeEwIiCQMWGZCHQ/wQUOr6tUhoguXVWRmRnqMvWofjCoOPbNNqF3exUw/zjwUaJAKTprCeAqd87c+4APMLXCKctf8s7JSKGAGztNuPUdpJnCErtllzb3JAWW8Dwd37Rwk43HHdO9oAxbJuC9HMessD3crNVw3T1uLIJPSBvWzSBT/04pBeOPvEyBjvH5H3h+pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XaJSE+s5yX2GVKSHfVHq1cf4cPg2lcWi05XyGQgu3BQ=;
 b=icrutlKuWGe5udmKFsp9gzmDf1C7EJ98nPwe4QWL3NvD86jUlWc9CHzHb1wgSvsFxFgtr0EzpfKxSvQG4+Ni3Ow2cWV5An4UCgEGBLRRkKfX43c7xTiiYfLSaYKcjoFOPFzE3+TpNMEoueK8bWZgx/ddMT2MPpFuT3G6odvFtHPGPAK19L21KSlkaGf6c7+wCm27Fktk+G/LipQsEekcvIJZTvYTt7O/aPmW1Eqmb40dRRB4DNg7YaEq2T2mSfhCC+tGarV/1zNYn+tLr5opzqGezGDprDVuOwFDofF/eWoMMYQvyz69rd3BuxmxSfKKEDF6Nbfb+GanGJovhqGX+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BN3NAM04FT037.eop-NAM04.prod.protection.outlook.com
 (10.152.92.60) by BN3NAM04HT220.eop-NAM04.prod.protection.outlook.com
 (10.152.93.157) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Sun, 14 Jun
 2020 20:24:36 +0000
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 (2a01:111:e400:7e4e::4c) by BN3NAM04FT037.mail.protection.outlook.com
 (2a01:111:e400:7e4e::196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18 via Frontend
 Transport; Sun, 14 Jun 2020 20:24:36 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:D141BCAA82DBBC1438D37EA86A075DDCA14519EAFA93C785F4C9FD51FB3D2F76;UpperCasedChecksum:AA57FA52895F6C8BF3BC5C5C9042F375BF8AF000BC30C90A0DD9D8734FA4C54B;SizeAsReceived:7866;Count:49
Received: from BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::b9c3:9bff:541d:f383]) by BN6PR04MB0660.namprd04.prod.outlook.com
 ([fe80::b9c3:9bff:541d:f383%9]) with mapi id 15.20.3088.028; Sun, 14 Jun 2020
 20:24:36 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     krzk@kernel.org, sbkim73@samsung.com, s.nawrocki@samsung.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org
Cc:     Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH 2/3] dt-bindings: sound: Add bindings for Samsung Aries audio complex
Date:   Sun, 14 Jun 2020 13:24:10 -0700
Message-ID: <BN6PR04MB0660866A9B5FD4B9E74D7C31A39F0@BN6PR04MB0660.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200614202411.27843-1-xc-racer2@live.ca>
References: <20200614202411.27843-1-xc-racer2@live.ca>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MWHPR2001CA0018.namprd20.prod.outlook.com
 (2603:10b6:301:15::28) To BN6PR04MB0660.namprd04.prod.outlook.com
 (2603:10b6:404:d9::21)
X-Microsoft-Original-Message-ID: <20200614202411.27843-3-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jon-hp-6570b.telus (2001:569:fb68:9c00:8067:f823:1e15:7520) by MWHPR2001CA0018.namprd20.prod.outlook.com (2603:10b6:301:15::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.21 via Frontend Transport; Sun, 14 Jun 2020 20:24:34 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200614202411.27843-3-xc-racer2@live.ca>
X-TMN:  [fHoz5g2xrwMrlQnMZnSfcZ90/2thkAgTf5gNlwBnyHv3P9vt1m/kBEnpworuBIvg]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 49
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 27eaae79-14c4-4e9f-d091-08d810a0f4dc
X-MS-TrafficTypeDiagnostic: BN3NAM04HT220:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8x+Jpo3B2PiZPl6M5XVT26qpeT5ts1FiRSj5xE2tlbI5hs26K+0twiGdxW/uRS2z/7DGhUGKIMPSL5jrkMXG8oafyiI+YzAUgLPwGZAa59w1L1JP5sDl/AWiSLAI03N5AC4p6cmAxTuetkkiKAsWpko7AwmzhypEuFTahKKUqG+EgC2opqtnEKbh8oUjIfuzHdVStqOm4B23ligIjnfNcNBOMyu0KAq/dB46kUrpx645VwUj2mBD/OaZGc2lkT+/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0660.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: Dj3dPNxn4Yj7V9+JD9A6ItGkYb26btSuPWbeaugdkpE5B7DnbrN3DFG4JFU7Sv9NF4OrhDPDWV+vn+/iHSyVnAjmG5ZEfK5pFq3wZe6mcfk+LOj2GCepcUQleGP77bAiZbtrGccI1c2s12pH/wzrUI5DzoSVsGKm4V4aMeBR+oC/93eLKI2cX5GwOuzig7ocutRwC8lkjcbrd6x3KGbXeA==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27eaae79-14c4-4e9f-d091-08d810a0f4dc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2020 20:24:36.5447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3NAM04HT220
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The audio system on S5PV210 Aries boards have a wm8994 codec connected
to the Samsung I2S0 DAI.  Jack detection is done via GPIOs, an ADC, and
an extcon device (fsa9480).

There are two main variants, one with an FM radio and where the wm8994 is
the master for the modem audio and the other without FM and the modem is
the master.

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
---
 .../bindings/sound/samsung,aries-wm8994.yaml  | 147 ++++++++++++++++++
 1 file changed, 147 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/samsung,aries-wm8994.yaml

diff --git a/Documentation/devicetree/bindings/sound/samsung,aries-wm8994.yaml b/Documentation/devicetree/bindings/sound/samsung,aries-wm8994.yaml
new file mode 100644
index 000000000000..902a0b66628e
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/samsung,aries-wm8994.yaml
@@ -0,0 +1,147 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/samsung,aries-wm8994.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung Aries audio complex with WM8994 codec
+
+maintainers:
+  - Jonathan Bakker <xc-racer2@live.ca>
+
+properties:
+  compatible:
+    oneOf:
+      - const: samsung,aries-wm8994
+        description: With FM radio and modem master
+
+      - const: samsung,fascinate4g-wm8994
+        description: Without FM radio and modem slave
+
+  model:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: The user-visible name of this sound complex.
+
+  cpu:
+    type: object
+    properties:
+      sound-dai:
+        minItems: 2
+        maxItems: 2
+        $ref: /schemas/types.yaml#/definitions/phandle-array
+        description: |
+          phandles to the I2S controller and bluetooth codec,
+          in that order
+
+  codec:
+    type: object
+    properties:
+      sound-dai:
+        $ref: /schemas/types.yaml#/definitions/phandle-array
+        description: phandle to the WM8994 CODEC
+
+  samsung,audio-routing:
+    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
+    description: |
+      List of the connections between audio
+      components;  each entry is a pair of strings, the first being the
+      connection's sink, the second being the connection's source;
+      valid names for sources and sinks are the WM8994's pins (as
+      documented in its binding), and the jacks on the board -
+      For samsung,aries-wm8994: HP, SPK, RCV, LINE, Main Mic, Headset Mic,
+      or FM In
+      For samsung,fascinate4g-wm8994: HP, SPK, RCV, LINE, Main Mic,
+      or HeadsetMic
+
+  extcon:
+    description: Extcon phandle for dock detection
+
+  main-micbias-supply:
+    description: Supply for the micbias on the main mic
+
+  headset-micbias-supply:
+    description: Supply for the micbias on the headset mic
+
+  earpath-sel-gpios:
+    description: GPIO for switching between tv-out and mic paths
+
+  headset-detect-gpios:
+    description: GPIO for detection of headset insertion
+
+  headset-key-gpios:
+    description: GPIO for detection of headset key press
+
+  io-channels:
+    maxItems: 1
+    description: IO channel to read micbias voltage for headset detection
+
+  io-channel-names:
+    const: headset-detect
+
+required:
+  - compatible
+  - model
+  - cpu
+  - codec
+  - samsung,audio-routing
+  - extcon
+  - main-micbias-supply
+  - headset-micbias-supply
+  - earpath-sel-gpios
+  - headset-detect-gpios
+  - headset-key-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    sound {
+        compatible = "samsung,fascinate4g-wm8994";
+
+        model = "Fascinate4G";
+
+        extcon = <&fsa9480>;
+
+        main-micbias-supply = <&main_micbias_reg>;
+        headset-micbias-supply = <&headset_micbias_reg>;
+
+        earpath-sel-gpios = <&gpj2 6 GPIO_ACTIVE_HIGH>;
+
+        io-channels = <&adc 3>;
+        io-channel-names = "headset-detect";
+        headset-detect-gpios = <&gph0 6 GPIO_ACTIVE_HIGH>;
+        headset-key-gpios = <&gph3 6 GPIO_ACTIVE_HIGH>;
+
+        samsung,audio-routing =
+            "HP", "HPOUT1L",
+            "HP", "HPOUT1R",
+
+            "SPK", "SPKOUTLN",
+            "SPK", "SPKOUTLP",
+
+            "RCV", "HPOUT2N",
+            "RCV", "HPOUT2P",
+
+            "LINE", "LINEOUT2N",
+            "LINE", "LINEOUT2P",
+
+            "IN1LP", "Main Mic",
+            "IN1LN", "Main Mic",
+
+            "IN1RP", "Headset Mic",
+            "IN1RN", "Headset Mic";
+
+        pinctrl-names = "default";
+        pinctrl-0 = <&headset_det &earpath_sel>;
+
+        cpu {
+            sound-dai = <&i2s0>, <&bt_codec>;
+        };
+
+        codec {
+            sound-dai = <&wm8994>;
+        };
+    };
+
-- 
2.20.1

