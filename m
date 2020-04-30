Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A02DC8300C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 09:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 685EE214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 09:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Analogixsemi.onmicrosoft.com header.i=@Analogixsemi.onmicrosoft.com header.b="WzPlYb+P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgD3JeW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 05:34:22 -0400
Received: from mail-eopbgr680091.outbound.protection.outlook.com ([40.107.68.91]:31823
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726378AbgD3JeW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 05:34:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yv48D2RPMos9+PSCVr6CF7wyVR0qHzHwYfB4VAcBIEnvItIeTjjCoKDkQIaTN4/0SG8w0DJaRi6iSfseQ2hVEODRqNvwO9H/f4/b8n0WRdVIaOk/vnBs0hfWf2CkLyYGpqrfk9fX8INPpGhF0l8lK5K7mogqq5GtXqK3PcR/olTw4KXllZaR5eGZlprc4jJZF7UQah4f8E8htatJWfqjwKzfEfAzTgztpSA4J321GvMtVFcjpLIFUTqRtB5yrFdy6mhxdPJe5Zty7NkSvDhfWFuP5ijljMYQHIlD8d9qG2HQFj6JxNQoFiuwfaLeh0fsuJZNMkBbuUd4AK2fGqzztA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IKfIEdu/ETiUcQSFoBgQ0ZBuWnP+aHJiER9Wtx7nuKw=;
 b=j/rFCnivhIm6qQeiJEqkq8BIdXi4baEAr8Mr/kDxMPzgJljcr8hTRWiXSapeya83JzGEe49x8YqXlI2d5L8TZWjQ2HszGOoXsq2ZX5WYN4IUKzYAqKHtlOOYzQ0XKpeJENiZadDWPZwms6I3LOG15wkwcsnvl8HSs5ruoCQ/SXVK3X5yzm18jPKfomAWh/8So/jk8KcSl4AJ2wbH90VXkQ3xucGMf9i/hwKg+SCVCToYR2MP48YuDZMzJh4ggA915ZC9QLNXnGVp5myUa3FIjRZfUMlNOAZqKiNpEag5Mq3d9NHVy+JRjM0unm5eqaPBC76+AXP0UrZoaNTuGcc6vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IKfIEdu/ETiUcQSFoBgQ0ZBuWnP+aHJiER9Wtx7nuKw=;
 b=WzPlYb+PHg4SSa1qNIKe9AFvipSGmLFq2IqbtQggnxFHaAbCn60FXWypvtBIkvTVfqoQtmpC/7LUx12j3X+Z1Pg63OfdmcYVG39qo6pjMAjtqygRBMUpuhjCFhRWwd48cavomyZXDjinsvz6YkJoMR953fY2x3KeXKqMofZE0Cc=
Authentication-Results: analogixsemi.com; dkim=none (message not signed)
 header.d=none;analogixsemi.com; dmarc=none action=none
 header.from=analogixsemi.com;
Received: from BY5PR04MB6739.namprd04.prod.outlook.com (2603:10b6:a03:229::8)
 by BY5PR04MB6625.namprd04.prod.outlook.com (2603:10b6:a03:219::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19; Thu, 30 Apr
 2020 09:34:19 +0000
Received: from BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::4517:bcc8:a3bd:407f]) by BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::4517:bcc8:a3bd:407f%6]) with mapi id 15.20.2958.020; Thu, 30 Apr 2020
 09:34:19 +0000
Date:   Thu, 30 Apr 2020 17:34:11 +0800
From:   Xin Ji <xji@analogixsemi.com>
To:     devel@driverdev.osuosl.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Nicolas Boichat <drinkcat@google.com>,
        Sam Ravnborg <sam@ravnborg.org>, devicetree@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Sheng Pan <span@analogixsemi.com>
Subject: [PATCH v9 1/2] dt-bindings: drm/bridge: anx7625: MIPI to DP
 transmitter binding
Message-ID: <a5d43ffb0250468050be5b9271567fadd0fe4e1c.1588236052.git.xji@analogixsemi.com>
References: <cover.1588236052.git.xji@analogixsemi.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1588236052.git.xji@analogixsemi.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-ClientProxiedBy: HK0PR01CA0072.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::36) To BY5PR04MB6739.namprd04.prod.outlook.com
 (2603:10b6:a03:229::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xin-VirtualBox (114.247.245.254) by HK0PR01CA0072.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::36) with Microsoft SMTP Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.20.2958.19 via Frontend Transport; Thu, 30 Apr 2020 09:34:18 +0000
X-Originating-IP: [114.247.245.254]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8a688bc-b1eb-4ee8-cf75-08d7ece9a80b
X-MS-TrafficTypeDiagnostic: BY5PR04MB6625:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR04MB662546FACF9FCC94CE235AD0C7AA0@BY5PR04MB6625.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:989;
X-Forefront-PRVS: 0389EDA07F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C4HLLqlQ1zq/Aj/W7L/7tGOgIBudhFup8oseJqrIROXLIhU2AEKvYCor5YGvTLqqcoK7kB5zYgkZwsRCB4bDHqWKKKIJDyK85GS+Es7CzIU5dfAMda5NRpzEi8Czr0naGinGSbtTW27bUcXItFY8J8MGX/Ehr063NEwubW9+mjldzvqEkAY3izcVm/n0Ev5iaCle+mtD30XAGbD4q3zVh82+4YANrIuSU5CFp0ZYWz/dpYn5hbXzAkRjBlTmWVEmo9CKw/9QGazmHuc0WzQzeQrGXkTc5PRuV7uctgb4k/qRy04/GVfNPmpReOZGoyXv1zXTrMS4IpmVNcx9bEJjr+PQQ2+JeMEhR1SS+rHzyY5guL4C48z2dM0MSgS9IKaN2kJEoYt0WOHBY9tT7FLd1StoTrlO3AqzdghryvjI8DvChg0SvbDGaf/QnkRLGi2BOF28ZGLayYXw48wIVQQTBchRWgCp8j6kc/V6bG1HLUR57ebmPhsnGvMuTISNteWHgR8v5Ft5H/RWuYeVUmBl/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6739.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(39840400004)(366004)(346002)(376002)(136003)(107886003)(4326008)(8936002)(36756003)(66556008)(8676002)(110136005)(6486002)(54906003)(66476007)(66946007)(2906002)(7416002)(26005)(86362001)(956004)(52116002)(6496006)(6666004)(478600001)(316002)(186003)(16526019)(2616005)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 9afGMUc2GxirtZb/itjlNnBRcOr5zGJ0X1+tTaU9yRkGobF5hG2BpIK8AfstHZeBVvzXCIqs3Jpe0J51ZeWO1lAuJl8Ld/zsa4bYbqc63WKfvXyNahm1ltrGW9URakyp5etJhyDoSpM8LgZqewqIBOR+Zq5w/JyoHM/iMkPVVvx+R8xpUW8lrrUK1brC3TFY+WF0PkV5SGMNp6uKmtZ7VBfHsSL5Kp5uczKDMrHVzgmsxReU9YMTnLbE1ijZLkUHfJ+Q5nw8GWHw19IqeQLukz+/mcVt0977/8AlfgJOZDjHrysFZZG5ppLkMfzhiqzmzZEQ6si5L6gFmlMe3DgzHRtkDs8sSdkQ2xGthw165TaGCKl2boucD2pVi9g4NKl1+59AG6/IOt57LYW+mmB6ApDM+LCsEiFuf8HyJ0DwF2UYAJX+PFIgPxySfBT/Dq0TFxdmxDNK5+lORxDQpqOvRg85ScbyVqFjl15Rza+n+l5DBP16SFqzolIwQDqb7SIyAl9bCcdKTtbj24Svgs3XeBS2mR6O7LHyAVpAADXR5Go+D1oSTJtOaTN0JE6WC70HyZplpHaiV0T6cFCt1Ma0pgrhB9l1EViDzjqgm+NvGVEkLGqnqPJqnnejlz2U9LsrXX4vl1Di1hj64Xh1F09M/2gIvM/gU/Fk5eE5uh9XtibOq8XDrvEV26ugHU53U3KGR9yC8IjkE3+efzcK4t2DhuowwXgUOdIO+QSXvDDdx0YWsYxmp/QHsoewb7cCZDZKxw+VxCtQ2TvGJ1hBMBytX2EcbZoefITevDD+zSuaum+jo3XOJHMWQGPcthY+uMTA
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8a688bc-b1eb-4ee8-cf75-08d7ece9a80b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2020 09:34:18.9435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rcZjYjM1sS/9A5A6EORmTEuwOUuqI9T8fsm1nFSjwf9naCQ71UXV5XFvnXqhSlqZ8mTO0Onfr+nnao2T1PeGeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6625
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ANX7625 is an ultra-low power 4K Mobile HD Transmitter designed
for portable device. It converts MIPI to DisplayPort 1.3 4K.

You can add support to your board with binding.

Example:
	anx7625_bridge: encoder@58 {
		compatible = "analogix,anx7625";
		reg = <0x58>;
		status = "okay";
		enable-gpios = <&pio 45 GPIO_ACTIVE_HIGH>;
		reset-gpios = <&pio 73 GPIO_ACTIVE_HIGH>;
		#address-cells = <1>;
		#size-cells = <0>;

		ports {
			#address-cells = <1>;
			#size-cells = <0>;

			mipi2dp_bridge_in: port@0 {
				reg = <0>;
				anx7625_in: endpoint {
					remote-endpoint = <&mipi_dsi>;
				};
			};

			mipi2dp_bridge_out: port@1 {
				reg = <1>;
				anx7625_out: endpoint {
					remote-endpoint = <&panel_in>;
				};
			};
		};
	};

Signed-off-by: Xin Ji <xji@analogixsemi.com>
---
 .../bindings/display/bridge/analogix,anx7625.yaml  | 97 ++++++++++++++++++++++
 1 file changed, 97 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml

diff --git a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
new file mode 100644
index 0000000..c2c50b0
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
@@ -0,0 +1,97 @@
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
+  "#address-cells": true
+  "#size-cells": true
+
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
+  - "#address-cells"
+  - "#size-cells"
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
+    anx7625_bridge: encoder@58 {
+        compatible = "analogix,anx7625";
+        reg = <0x58>;
+        enable-gpios = <&pio 45 GPIO_ACTIVE_HIGH>;
+        reset-gpios = <&pio 73 GPIO_ACTIVE_HIGH>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            mipi2dp_bridge_in: port@0 {
+                reg = <0>;
+                anx7625_in: endpoint {
+                    remote-endpoint = <&mipi_dsi>;
+                };
+            };
+
+            mipi2dp_bridge_out: port@1 {
+                reg = <1>;
+                anx7625_out: endpoint {
+                    remote-endpoint = <&panel_in>;
+                };
+            };
+        };
+    };
-- 
2.7.4

