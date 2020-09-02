Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D9EC433E6
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 07:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 635D7207EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 07:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="hIukKkx0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgIBH6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 03:58:55 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:10540 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726140AbgIBH5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 03:57:42 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0827kdhp000525;
        Wed, 2 Sep 2020 09:57:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=E0OlX12Uh1E9X9WriKudw2kH7GGPXD0HUts6bxpjA8Y=;
 b=hIukKkx0kRVQLpJAmxF4LT7C9vm/Xq2wyfpFA5Q57/SsAwu7Ph61o9P3dOAlSFDZl3i8
 2wB++52ro/OIDSw2m3u95eF2uFJvW0OWFOhvPgZfAwQz0s9SiM0Q6Z3+PyuDYFp3WXGp
 0d5F94Ceylk/8Ou4Potye4l/pWaebfUUA5VfA07h6cVasahcPib9wloTacM1iVODhIyE
 822eYGohyQPrVMTI+nC7BdzKkvjCYecHxfs+n15D5Zte28xnFIB1WCRSN4YDptxo8J19
 ANC8HgoHBDBGWu9JNw9E2q2niTLW/D+yrXmaOtS9tHftgXbMOJP3uL5cQ3B35cv+NaIO +A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 337c58mbs9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Sep 2020 09:57:17 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 38E51100034;
        Wed,  2 Sep 2020 09:57:16 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2119E212FBA;
        Wed,  2 Sep 2020 09:57:16 +0200 (CEST)
Received: from localhost (10.75.127.46) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 2 Sep 2020 09:57:15
 +0200
From:   Amelie Delaunay <amelie.delaunay@st.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Russell King <linux@armlinux.org.uk>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: [RESEND PATCH v2 1/6] dt-bindings: connector: add power-opmode optional property to usb-connector
Date:   Wed, 2 Sep 2020 09:57:02 +0200
Message-ID: <20200902075707.9052-2-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200902075707.9052-1-amelie.delaunay@st.com>
References: <20200902075707.9052-1-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG5NODE1.st.com (10.75.127.13) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-02_03:2020-09-02,2020-09-02 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Power operation mode may depends on hardware design, so, add the optional
property power-opmode for usb-c connector to select the power operation
mode capability.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
Changes in v2:
- Add description for possible operation current values
---
 .../bindings/connector/usb-connector.yaml     | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
index 9bd52e63c935..2fd85b9a7e1a 100644
--- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
+++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
@@ -88,6 +88,26 @@ properties:
       - device
       - dual
 
+  power-opmode:
+    description: Determines the power operation mode that the Type C connector
+      will support and will advertise through CC pins.
+      - "default" corresponds to default USB voltage and current defined by the
+        USB 2.0 and USB 3.2 specifications, 5V 500mA for USB 2.0 ports and
+        5V 900mA or 1500mA for USB 3.2 ports in single-lane or dual-lane
+        operation respectively.
+      - "1.5A" and "3.0A", 5V 1.5A and 5V 3.0A respectively, as defined in USB
+        Type-C Cable and Connector specification, when Power Delivery is not
+        supported.
+      - "usb_power_delivery" when Power Delivery is supported, as defined in
+        USB Power Delivery specification.
+    allOf:
+      - $ref: /schemas/types.yaml#definitions/string
+    enum:
+      - default
+      - 1.5A
+      - 3.0A
+      - usb_power_delivery
+
   # The following are optional properties for "usb-c-connector" with power
   # delivery support.
   source-pdos:
-- 
2.17.1

