Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CAC1C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 04:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F0942072D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 04:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="SWck33LS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbgHYEW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 00:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728614AbgHYEWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 00:22:48 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A91C061795
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 21:22:47 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id 15so7636659pfy.15
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 21:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=xSJS/XKA/aUbgtCi/q0K7inzUjymBY7nSgjzrufvP5I=;
        b=SWck33LSi0EUA97KEivGtM62HLq7cI9NPByz2VNQN5Yj76sbRwA6eIbsgtw8t23Bo1
         4dpzmutg2ZM1LAJHCqo01eRTrUM9a/MKq6F7uNwM1uO7gJn/bocbf5OvUlnWy0M1yraV
         Heefpw9QTivgPe9clxyaQp7XfjjLvU8jD8sjFD0WyP3mliSoP4ypB5g3bjOc+uzw8zUs
         orCxBMEIdseOw4S9L+tyozs83Lp0XsJT0NoekcAenBCZytN4OLq9EQ9I+2MMKYZI9fwt
         1DdK4dQP6isJnXpvq278juj4El9L1p4/f5qH5gTMSnu/Ndpk/krM/OppVWZLdRoGxIRE
         nT7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xSJS/XKA/aUbgtCi/q0K7inzUjymBY7nSgjzrufvP5I=;
        b=F6Cme5OIcW3cwcTyCo8n3YOkFsQz6dBUMwDZuJ1I4IrLLwLWpDaH2jeMSzvhwM2IWW
         IOM8I6dMBM6dgQHaP/zj9XWODDIpsLhvDDGE7Nk29xgGQA9j5Vm4vzdvilSZiCc6jdX3
         thnhm5ptUOtGNc47EYrtw7Iji3qxSx+U+h/4YFR/Oc2BFLzAo/iqoeRjVCCev7KA/HLg
         14Shjjfn7XqGALLT+5n2+8GWbUIkYEQBsIzQVlRVZ5p1k/LkLhZNt0WeWglIJOQyTQ6s
         FevZ/KJH86CEa11fHflEUq5k9UVRYw6ST0CiacZc6OyMnJCO8Qm0NmMG6Aht4jg2uD+w
         gqYg==
X-Gm-Message-State: AOAM531CNrwIeBMe8UsLpYs09AufYHZek36Zfhyz2RdYJLTRmsQQ2d6F
        vcTHAM0VPQaZ4ygWSjDfHV6zROKjwZI=
X-Google-Smtp-Source: ABdhPJwHNxFi0Ec+H6bmOoX2PQxOar5hmeGLFWZaRs3cPffAINCKLYgzjt/DsBEo87S7HZEhfXLkegbK/LQ=
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:1:f292:1cff:fee0:66cf])
 (user=badhri job=sendgmr) by 2002:a63:3e0c:: with SMTP id l12mr2515256pga.190.1598329366531;
 Mon, 24 Aug 2020 21:22:46 -0700 (PDT)
Date:   Mon, 24 Aug 2020 21:22:04 -0700
In-Reply-To: <20200825042210.300632-1-badhri@google.com>
Message-Id: <20200825042210.300632-9-badhri@google.com>
Mime-Version: 1.0
References: <20200825042210.300632-1-badhri@google.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH 08/14 v1] dt-bindings: connector: Add property to set initial
 current cap for FRS
From:   Badhri Jagan Sridharan <badhri@google.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Badhri Jagan Sridharan <badhri@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change adds frs-typec-current which allows setting the initial current
capability of the new source when vSafe5V is applied during PD3.0
sink Fast Role Swap.

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
 .../bindings/connector/usb-connector.txt      | 128 ++++++++++++++++++
 include/dt-bindings/usb/pd.h                  |  10 ++
 2 files changed, 138 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/connector/usb-connector.txt

diff --git a/Documentation/devicetree/bindings/connector/usb-connector.txt b/Documentation/devicetree/bindings/connector/usb-connector.txt
new file mode 100644
index 000000000000..e2f6e0f07d00
--- /dev/null
+++ b/Documentation/devicetree/bindings/connector/usb-connector.txt
@@ -0,0 +1,128 @@
+USB Connector
+=============
+
+USB connector node represents physical USB connector. It should be
+a child of USB interface controller.
+
+Required properties:
+- compatible: describes type of the connector, must be one of:
+    "usb-a-connector",
+    "usb-b-connector",
+    "usb-c-connector".
+
+Optional properties:
+- label: symbolic name for the connector,
+- type: size of the connector, should be specified in case of USB-A, USB-B
+  non-fullsize connectors: "mini", "micro".
+
+Optional properties for usb-c-connector:
+- power-role: should be one of "source", "sink" or "dual"(DRP) if typec
+  connector has power support.
+- try-power-role: preferred power role if "dual"(DRP) can support Try.SNK
+  or Try.SRC, should be "sink" for Try.SNK or "source" for Try.SRC.
+- data-role: should be one of "host", "device", "dual"(DRD) if typec
+  connector supports USB data.
+- frs-typec-current - Initial current capability of the new source when vSafe5V
+  is applied during PD3.0 Fast Role Swap. "Table 6-14 Fixed Supply PDO - Sink"
+  of "USB Power Delivery Specification Revision 3.0, Version 1.2" provides the
+  different power levels and "6.4.1.3.1.6 Fast Role Swap USB Type-C Current"
+  provides a detailed description of the field.
+  0: Fast role swap not supported
+  1: Default USB Power
+  2: 1.5A @ 5V
+  3: 3A @ 5V.
+
+Required properties for usb-c-connector with power delivery support:
+- source-pdos: An array of u32 with each entry providing supported power
+  source data object(PDO), the detailed bit definitions of PDO can be found
+  in "Universal Serial Bus Power Delivery Specification" chapter 6.4.1.2
+  Source_Capabilities Message, the order of each entry(PDO) should follow
+  the PD spec chapter 6.4.1. Required for power source and power dual role.
+  User can specify the source PDO array via PDO_FIXED/BATT/VAR/PPS_APDO()
+  defined in dt-bindings/usb/pd.h.
+- sink-pdos: An array of u32 with each entry providing supported power
+  sink data object(PDO), the detailed bit definitions of PDO can be found
+  in "Universal Serial Bus Power Delivery Specification" chapter 6.4.1.3
+  Sink Capabilities Message, the order of each entry(PDO) should follow
+  the PD spec chapter 6.4.1. Required for power sink and power dual role.
+  User can specify the sink PDO array via PDO_FIXED/BATT/VAR/PPS_APDO() defined
+  in dt-bindings/usb/pd.h.
+- op-sink-microwatt: Sink required operating power in microwatt, if source
+  can't offer the power, Capability Mismatch is set. Required for power
+  sink and power dual role.
+
+Required nodes:
+- any data bus to the connector should be modeled using the OF graph bindings
+  specified in bindings/graph.txt, unless the bus is between parent node and
+  the connector. Since single connector can have multpile data buses every bus
+  has assigned OF graph port number as follows:
+    0: High Speed (HS), present in all connectors,
+    1: Super Speed (SS), present in SS capable connectors,
+    2: Sideband use (SBU), present in USB-C.
+
+Examples
+--------
+
+1. Micro-USB connector with HS lines routed via controller (MUIC):
+
+muic-max77843@66 {
+	...
+	usb_con: connector {
+		compatible = "usb-b-connector";
+		label = "micro-USB";
+		type = "micro";
+	};
+};
+
+2. USB-C connector attached to CC controller (s2mm005), HS lines routed
+to companion PMIC (max77865), SS lines to USB3 PHY and SBU to DisplayPort.
+DisplayPort video lines are routed to the connector via SS mux in USB3 PHY.
+
+ccic: s2mm005@33 {
+	...
+	usb_con: connector {
+		compatible = "usb-c-connector";
+		label = "USB-C";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				usb_con_hs: endpoint {
+					remote-endpoint = <&max77865_usbc_hs>;
+				};
+			};
+			port@1 {
+				reg = <1>;
+				usb_con_ss: endpoint {
+					remote-endpoint = <&usbdrd_phy_ss>;
+				};
+			};
+			port@2 {
+				reg = <2>;
+				usb_con_sbu: endpoint {
+					remote-endpoint = <&dp_aux>;
+				};
+			};
+		};
+	};
+};
+
+3. USB-C connector attached to a typec port controller(ptn5110), which has
+power delivery support and enables drp.
+
+typec: ptn5110@50 {
+	...
+	usb_con: connector {
+		compatible = "usb-c-connector";
+		label = "USB-C";
+		power-role = "dual";
+		try-power-role = "sink";
+		source-pdos = <PDO_FIXED(5000, 2000, PDO_FIXED_USB_COMM)>;
+		sink-pdos = <PDO_FIXED(5000, 2000, PDO_FIXED_USB_COMM)
+			     PDO_VAR(5000, 12000, 2000)>;
+		op-sink-microwatt = <10000000>;
+	};
+};
diff --git a/include/dt-bindings/usb/pd.h b/include/dt-bindings/usb/pd.h
index 985f2bbd4d24..db1ad4532197 100644
--- a/include/dt-bindings/usb/pd.h
+++ b/include/dt-bindings/usb/pd.h
@@ -35,6 +35,16 @@
 
 #define VSAFE5V 5000 /* mv units */
 
+/*
+ * Based on "Table 6-14 Fixed Supply PDO - Sink" of "USB Power Delivery Specification Revision 3.0,
+ * Version 1.2"
+ * Initial current capability of the new source when vSafe5V is applied.
+ */
+#define FRS_NOT_SUPPORTED	0
+#define FRS_DEFAULT_POWER	1
+#define FRS_5V_1P5A		2
+#define FRS_5V_3A		3
+
 #define PDO_BATT_MAX_VOLT_SHIFT	20	/* 50mV units */
 #define PDO_BATT_MIN_VOLT_SHIFT	10	/* 50mV units */
 #define PDO_BATT_MAX_PWR_SHIFT	0	/* 250mW units */
-- 
2.28.0.297.g1956fa8f8d-goog

