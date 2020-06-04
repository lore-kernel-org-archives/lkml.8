Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA5CFC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 07:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABEE8206DC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 07:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Analogixsemi.onmicrosoft.com header.i=@Analogixsemi.onmicrosoft.com header.b="KbuTc9vU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgFDH4v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 03:56:51 -0400
Received: from mail-bn7nam10on2131.outbound.protection.outlook.com ([40.107.92.131]:27955
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725950AbgFDH4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 03:56:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BSUOaG6ZACaDUiFJVjGjPlPw9oljdvNlvhTE/ezc6mm7ugwevVR2E5Sb8UH9eM7K9wjnb0nEYFVJCFoaJ7/S3ndDNQWYg1Sqd5xjUoLPEkUpfn5rNHE3t097EYeSxk6dp04uYZenqj8bCJwr6SBrvef1lNx1hUYF7PrEuLbcXeATiDLSFZwB6X0i0rXlBZEhp3gHNsMICIAcu8MCoViNqMWTu36tNfCqlLHLS+upi6X820H+4pTi6aK7ZuconwQAZ2oiDl6j76Oi18vCP1uKnWj5tBT7U/uS8Conpf0AibQAIvXCLUXlQg2fFtgcJJW3f5g97hLwTMqDuFE5kcnw6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cwqbvv8QcEVow6I7FbphHs1hFgKwk2phXjRDkPn6Wjg=;
 b=ndrNE5yrPAc5rI+3wRa+/4CZQwleVGCTYP0Ta/Yf08a+/SD5ft3f1btzLGchnw+p5pnbIl9C6dbNQdwFkjjiJHw1CxjSZlJGKbFfUffNSEmwtxTD4zWppucHNiyE40txhcYQAiyo0VEMEUjtrNgb/eXgA0hZ0UdM9WdoZZj3eq8iZLOFgNyAOXQqlICZIMIq32i5Cw+qGvQjLHSAYSW3qCP+rYfk42sPlqZCtcBywFxF+ketg1HdfAwQ5a33kQGfGXVk711eykNVN+OKUPvO1FRRBNm8PVdapZRhqk3Jq07fcZbHJsAZjLyEkd5AzY5xRFKopNsymGAlr/Z2n3obTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cwqbvv8QcEVow6I7FbphHs1hFgKwk2phXjRDkPn6Wjg=;
 b=KbuTc9vUAkLiojCnTZn7SNlqKlFDmfbi+ZmCmaL5aprslj/q1bxfvxQZjQUZbQGxrHQ37ToiiRlCtbMIerXngT1r+sytap6doLaU3tT4jfM/HvvbL1NEVamm0+ztgee1w/mKzF9qgJbtfSxSSYyN32KbYTi8GYfZPMC3SnzOMpc=
Authentication-Results: analogixsemi.com; dkim=none (message not signed)
 header.d=none;analogixsemi.com; dmarc=none action=none
 header.from=analogixsemi.com;
Received: from BY5PR04MB6739.namprd04.prod.outlook.com (2603:10b6:a03:229::8)
 by BY5PR04MB6690.namprd04.prod.outlook.com (2603:10b6:a03:22c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.20; Thu, 4 Jun
 2020 07:56:48 +0000
Received: from BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::844e:398b:2165:631b]) by BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::844e:398b:2165:631b%7]) with mapi id 15.20.3066.018; Thu, 4 Jun 2020
 07:56:48 +0000
Date:   Thu, 4 Jun 2020 15:56:36 +0800
From:   Xin Ji <xji@analogixsemi.com>
To:     devicetree@vger.kernel.org, devel@driverdev.osuosl.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Nicolas Boichat <drinkcat@google.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Sheng Pan <span@analogixsemi.com>
Subject: [PATCH v12 1/2] dt-bindings: drm/bridge: anx7625: MIPI to DP
 transmitter DT schema
Message-ID: <eb82c52574bf41b5edad488e14c27cabad39b922.1591253353.git.xji@analogixsemi.com>
References: <cover.1591253353.git.xji@analogixsemi.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1591253353.git.xji@analogixsemi.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-ClientProxiedBy: HK2PR03CA0051.apcprd03.prod.outlook.com
 (2603:1096:202:17::21) To BY5PR04MB6739.namprd04.prod.outlook.com
 (2603:10b6:a03:229::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xin-VirtualBox (114.247.245.254) by HK2PR03CA0051.apcprd03.prod.outlook.com (2603:1096:202:17::21) with Microsoft SMTP Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.20.3088.7 via Frontend Transport; Thu, 4 Jun 2020 07:56:46 +0000
X-Originating-IP: [114.247.245.254]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 246728b4-abd8-4cfc-47d6-08d8085cd506
X-MS-TrafficTypeDiagnostic: BY5PR04MB6690:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR04MB66907B21FCA26D8F7BA63594C7890@BY5PR04MB6690.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-Forefront-PRVS: 04244E0DC5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NsQoQWHVn+crErdv7Vwi6WlQ7ElI0HURliN07lHf8+SbfdFnSQE6fhuUKO8AcmN3zLm6WEebIwrnaIiKXSEfcegi5AMxVPIWhHUJ2L8SZO7nwxwJoG0MkNGoXpd5NcsDIHq50xy1QZEpBFz3ihXwPDuNnrA5uUPjzA7LwM3D1FYZ62HoXtKGahdb/45YEFc9V15GceXYjPLEeX4qWgGnm+kTjRSU9vBEXJv2t/OEhPPP9qgXwIJctOGRY7jWyCffOzVY8UPPRt7BGnJK0kIE+7vJs+sj4cU4gbMkp+nOUHPauzt1u3JzWe0BMTOdKRGonw0Qi5zVyqu5LzCJJC0R+cOD1P4Je+2mQHBTrjIqJDhRJE0WOyUPkSMKLIt+rT5Qtf4f3bcx279tWu5w9DLwjw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6739.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(136003)(346002)(39850400004)(366004)(396003)(5660300002)(2906002)(54906003)(8936002)(110136005)(7416002)(6486002)(6666004)(316002)(2616005)(956004)(8676002)(36756003)(478600001)(66556008)(6496006)(66476007)(86362001)(52116002)(26005)(4326008)(107886003)(16526019)(66946007)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 8DPnhvqg3dMfoW9Ffj8UpFDNMjdE7NrYC6VOE1OfT/i/aFQ7wpmKH36MD4b7zh58BR2R/EYzPOveCJBQY/2bZsAh6+0qkO9N77VkKZFLMd0fMEW79GWjdj2+SPvZDQOVFLQKSLmKwd9y0lBp8eeFr+ro5lRCfAfYGTcx1iSGsgFFD74oxSCT9rWS3eaw5xB+dGIsx55mklIgJF2kcuXJogq5ghfvcluIyb/6K8/osTOVMYQhoVG9f5LiawvEpyF1jd1AoDVo2KnBdfkqKhv4v8mTV7UU0i5yvcTnVHvHLcRaq381mdaQqudUT0jmi6xwjUuukE7GweMZ8DnSON2Jmul85CTYoFgFDAtD1Vu7gvqPXqSMluI4N6VGhSItmqXD4Kx4QlDFcVhkkMxQNUTRQaYXSPXY0nPncRZ9A1yC1vh+xoh4+O69U1yhNMS4fA1j7+PRdBy3c3iwKFG1sNTe2UI9xoMzJypWTP7oNjExfCw=
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 246728b4-abd8-4cfc-47d6-08d8085cd506
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2020 07:56:47.9585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NjuNbdph/SAciZUyw+hcqw+2da/cnX+r4+A8r+AYOx5WU8lboU510fhS6ImtTlERYQiP4TdFzJ+BbAbyj0ZV7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6690
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

anx7625: MIPI to DP transmitter DT schema

Signed-off-by: Xin Ji <xji@analogixsemi.com>
---
 .../bindings/display/bridge/analogix,anx7625.yaml  | 95 ++++++++++++++++++++++
 1 file changed, 95 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml

diff --git a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
new file mode 100644
index 0000000..60585a4
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
@@ -0,0 +1,95 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2019 Analogix Semiconductor, Inc.
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/display/bridge/analogix,anx7625.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Analogix ANX7625 SlimPort (4K Mobile HD Transmitter)
+
+maintainers:
+  - Xin Ji <xji@analogixsemi.com>
+
+description: |
+  The ANX7625 is an ultra-low power 4K Mobile HD Transmitter
+  designed for portable devices.
+
+properties:
+  compatible:
+    items:
+      - const: analogix,anx7625
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description: used for interrupt pin B8.
+    maxItems: 1
+
+  enable-gpios:
+    description: used for power on chip control, POWER_EN pin D2.
+    maxItems: 1
+
+  reset-gpios:
+    description: used for reset chip control, RESET_N pin B7.
+    maxItems: 1
+
+  ports:
+    type: object
+
+    properties:
+      port@0:
+        type: object
+        description:
+          Video port for MIPI DSI input.
+
+      port@1:
+        type: object
+        description:
+          Video port for panel or connector.
+
+    required:
+        - port@0
+        - port@1
+
+required:
+  - compatible
+  - reg
+  - ports
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    i2c0 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        encoder@58 {
+            compatible = "analogix,anx7625";
+            reg = <0x58>;
+            enable-gpios = <&pio 45 GPIO_ACTIVE_HIGH>;
+            reset-gpios = <&pio 73 GPIO_ACTIVE_HIGH>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                mipi2dp_bridge_in: port@0 {
+                    reg = <0>;
+                    anx7625_in: endpoint {
+                        remote-endpoint = <&mipi_dsi>;
+                    };
+                };
+
+                mipi2dp_bridge_out: port@1 {
+                    reg = <1>;
+                    anx7625_out: endpoint {
+                        remote-endpoint = <&panel_in>;
+                    };
+                };
+            };
+        };
+    };
-- 
2.7.4

