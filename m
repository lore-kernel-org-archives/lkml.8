Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26611C54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 06:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F119C206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 06:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Analogixsemi.onmicrosoft.com header.i=@Analogixsemi.onmicrosoft.com header.b="mwRZWTVg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgD0GRz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 02:17:55 -0400
Received: from mail-eopbgr750114.outbound.protection.outlook.com ([40.107.75.114]:16801
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726242AbgD0GRy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 02:17:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GWduBtI0zquMtmAOubanQOmGySMeHZ1SmapWa9w8tow2ivkaUvwKZ5T2lZcfvDOrX/YT1efhEHZV34esvPxVZDmTQeElgUEpQA7G5iu3lpJAar9XBhRdr8kRCdncbyk/C148VYxrvRC2nBDTdAuyU0McOnd9YyWOvuhN9Ic1bU0tRQ1s0E8rAbeGHPaJ5g30P9TRbK6K1OfYQgKDpJoQGxOJF89xOnsKf62VGyPFuAZbNSKPFbjSgjyDD6/KGitMhHymslZKyf07t+/A/zVSido0JzRdOau3JnvLtqVwzYxP4TRJcmDzKpuZD6ixyU+Tye5eVGcMFH856Qd36hRCcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3dfc4ziFptkt/bkpbGubhkAqjkBfgj2Sy9MOVNPYkU=;
 b=PKEZvk0mOJJBFYWLP2kfm0tVCdINFk9ZGwMBjiSEPjV+JUhKABoZd9zzob9UV9i+pHEL95uxoTb4JVZhil4FNw+Ad7NV7xAilG894uj8eBET4K98taNJHSROEvKk54KP24Ci6J/gF88xnSMUOPrNebqQBy+MsQzPpQLANx2Y5kOm29+Ylv4OLjL1LbHkjvRQZZ2vCipcy3hvkaLxcrosuiwFZIr8mhb28Ns0vucmY3TwpfiJOiqPotJEwAQx4jRpNnoMGLdW+8AxrkFQNTFIQXpKkPi4sE/Tv82WtKo9/wWt+w3TxKigEhCvZMxJzbJ3tmqwmz8CUkB1KvwLZwD+IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3dfc4ziFptkt/bkpbGubhkAqjkBfgj2Sy9MOVNPYkU=;
 b=mwRZWTVgZq+qzF8Ne9FjM+8CsAB/aibYw7h0oAHhQncSd54o8PEFyilkN7GM5TV9cnsxOzCeri8E2U4L+SwPRF/K+y/SXmWQoRLBtvlse/XSFayb62ES/Iq/tALnwdzTzlCI0I3hawux2NpXw4aK6i02dDgrzxlAbWQ6zxB/Dl8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=xji@analogixsemi.com; 
Received: from BY5PR04MB6739.namprd04.prod.outlook.com (2603:10b6:a03:229::8)
 by BY5PR04MB6518.namprd04.prod.outlook.com (2603:10b6:a03:1d4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Mon, 27 Apr
 2020 06:17:51 +0000
Received: from BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::4517:bcc8:a3bd:407f]) by BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::4517:bcc8:a3bd:407f%6]) with mapi id 15.20.2937.023; Mon, 27 Apr 2020
 06:17:51 +0000
Date:   Mon, 27 Apr 2020 14:17:46 +0800
From:   Xin Ji <xji@analogixsemi.com>
To:     devel@driverdev.osuosl.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Nicolas Boichat <drinkcat@google.com>
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
Subject: [PATCH v8 1/2] dt-bindings: drm/bridge: anx7625: MIPI to DP
 transmitter binding
Message-ID: <67ccead807b7d0a50df479cab2c9d325041224bc.1587880280.git.xji@analogixsemi.com>
References: <cover.1587880280.git.xji@analogixsemi.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1587880280.git.xji@analogixsemi.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-ClientProxiedBy: HK2PR02CA0175.apcprd02.prod.outlook.com
 (2603:1096:201:21::11) To BY5PR04MB6739.namprd04.prod.outlook.com
 (2603:10b6:a03:229::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xin-VirtualBox (114.247.245.254) by HK2PR02CA0175.apcprd02.prod.outlook.com (2603:1096:201:21::11) with Microsoft SMTP Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.20.2937.13 via Frontend Transport; Mon, 27 Apr 2020 06:17:50 +0000
X-Originating-IP: [114.247.245.254]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72ed83a8-ba5c-40e3-2f3c-08d7ea72b6db
X-MS-TrafficTypeDiagnostic: BY5PR04MB6518:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR04MB651878CFC47842AC6A716B49C7AF0@BY5PR04MB6518.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 0386B406AA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6739.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(376002)(136003)(346002)(39840400004)(396003)(6486002)(81156014)(8936002)(5660300002)(36756003)(8676002)(26005)(2906002)(6496006)(52116002)(110136005)(54906003)(66476007)(66556008)(66946007)(956004)(2616005)(7416002)(6666004)(4326008)(186003)(16526019)(478600001)(316002)(86362001)(107886003);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: analogixsemi.com does not
 designate permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sz9TiZNg3TWlejVBTxHJ6ARUwZ7mWB/7w/2SUi0jegod7+whUYyLzzJpL91y8ejuOXFHJtziVD5ZKmG/2oxup09HtXk/KkPKtZzpYlh38Ue0zzDRXvAv3vlemi/sRUC8qFPwV5dLY4fDTrDC72YeGLE6/nXi+DeAOCBrrvM+mngi+epE4xvneli6gv0th2UffUd8NsDx30Cww37w6S1h7yxkIqUqWFEQJg3uRmsv6eFCECrQOiCuDt1RV+LCH16xMNmLwfJ4IIALTPYTlmUevOxEBov5H4LRfNLjhudkj5S5sJ2en5kuZ7f+4BHzZkM8pQH18t4XDoXuewADZel2dNyfyv44DtY5Jl8nzq+tURoCGVL5Bq1S5D0I8TqKc0XMRKY4nolgvBxrIdAZhCdbc60UbPhmn0GUSNt7TtowV6pEeaX5/jlYy6R10BIm4JUE8jQmZNr9CyE+Jvs03Xp6gHsz1WjH1b2fAuJagsnAhGThb1cyLcm+PzPY+jaVon/Yh4uDsG1H8D8m26XBpSL8OQ==
X-MS-Exchange-AntiSpam-MessageData: TJsKl1aw5+MsjKhy9l+D8Qw6gyu1BckCuwn6Q0kvgtlStJzOyxh3632PKoBIAIPbhx2xYUohFMDlojyPnLGJtAQv6M54K5VA6KfTkxvki/SwvET5lL/eOeGFVm7FFIJrGwmFMOvqP08AN6pweoTr4WnzuqJ/mFVf3YQobFNCMkJLB3D2JzXP/23sRJFNxeCSLofWCqQVSRzSEkVvsaFYNuAAA7hmmEuLSIu8omQJKOGHAu45Z0eWuR1RQTj3laVEJ5n77XezvsUlziXF3fxGT8Atoty5IJyXXumV13NzYc4n90pseujsqp4GMNt11qtXlAof4EI2JfgHNZfpSpT+spGccxn1w+HPANbnn4VR/GdcM+XWQb76ghnH/2aEZD0JivKOJ49h9Bf1e3xBXWXyPkSMNKgYcpO1w2bkvapiZw+FiXW0asTQzKfnkzGWiN22nrrw/eAWR0xP+JHXEsjpzxuLeVcrP0gVUiEzp23xlhJkxBZVptRI5bCTqO5sBhU+2hRnSWDdWd0+YhMj+wCWmen7LLeHgujnd/kHZalpyGdffXg6M4seKOcuTQgoYwCKIPDUe4b6MIZiHShKTf4G0ZM+zde1XsPq499NGShRojScAyrY8WczRMTQvPZjoSV7+tcLoTY9IWNYnZ73JgmaLo7th0WC4r73Z4D9JH0/TjwclzvuMlTU/Sad5dNfNVeFg/Mp9nLhHve8qE8ASu68OVOvDxumnb92tkwpCg7Z0tN+uU7xqXXjkPj/JMfMLzEjwcV21SIMWIOq95atSZHgb4joe+EEEZCb96ae3H5dYUiHe5LzU13ARS/f4hopykuC
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72ed83a8-ba5c-40e3-2f3c-08d7ea72b6db
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2020 06:17:51.4548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lhiEb3tBfLqCSADDcYDplw0PETnOpNOefWtkGSpZfyVAXDK4DQnV1MZnEqYMaV4HwLb6jX+aCGaNbxVpxX0Q0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6518
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
		panel-flags = <1>;
		enable-gpios = <&pio 45 GPIO_ACTIVE_HIGH>;
		reset-gpios = <&pio 73 GPIO_ACTIVE_HIGH>;
		#address-cells = <1>;
		#size-cells = <0>;

		port@0 {
		  reg = <0>;
		  anx_1_in: endpoint {
		    remote-endpoint = <&mipi_dsi>;
		  };
		};

		port@2 {
		  reg = <2>;
		  anx_1_out: endpoint {
		    remote-endpoint = <&panel_in>;
		  };
		};
	};

Signed-off-by: Xin Ji <xji@analogixsemi.com>
---
 .../bindings/display/bridge/anx7625.yaml           | 91 ++++++++++++++++++++++
 1 file changed, 91 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/anx7625.yaml

diff --git a/Documentation/devicetree/bindings/display/bridge/anx7625.yaml b/Documentation/devicetree/bindings/display/bridge/anx7625.yaml
new file mode 100644
index 0000000..1149ebb
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/anx7625.yaml
@@ -0,0 +1,91 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2019 Analogix Semiconductor, Inc.
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/display/bridge/anx7625.yaml#"
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
+  panel-flags:
+    description: indicate the panel is internal or external.
+    maxItems: 1
+
+  interrupts:
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
+  port@0:
+    type: object
+    description:
+      A port node pointing to MIPI DSI host port node.
+
+  port@1:
+    type: object
+    description:
+      A port node pointing to MIPI DPI host port node.
+
+  port@2:
+    type: object
+    description:
+      A port node pointing to panel port node.
+
+required:
+  - "#address-cells"
+  - "#size-cells"
+  - compatible
+  - reg
+  - port@0
+  - port@2
+
+example:
+  - |
+    anx7625_bridge: encoder@58 {
+        compatible = "analogix,anx7625";
+        reg = <0x58>;
+        status = "okay";
+        panel-flags = <1>;
+        enable-gpios = <&pio 45 GPIO_ACTIVE_HIGH>;
+        reset-gpios = <&pio 73 GPIO_ACTIVE_HIGH>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        port@0 {
+          reg = <0>;
+          anx_1_in: endpoint {
+            remote-endpoint = <&mipi_dsi>;
+          };
+        };
+
+        port@2 {
+          reg = <2>;
+          anx_1_out: endpoint {
+            remote-endpoint = <&panel_in>;
+          };
+        };
+    };
-- 
2.7.4

