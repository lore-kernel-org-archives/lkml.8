Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80329C2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 08:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C28F2071A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 08:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="KXrYGwre"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730120AbgAXIl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 03:41:59 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:60453 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727432AbgAXIlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 03:41:53 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00O8cXt9008732;
        Fri, 24 Jan 2020 09:41:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=R7IzRXw6/OJS37SJZMT1W+UUjxaSITaX3RAyMYyTQK8=;
 b=KXrYGwreMj42qDupRbSkDj9XuDNBFKB9VXGdwv1ft5QTm/JuRMvCsZQsne3ctU3jvNXo
 yGc0nxrC8KsnNHC0RI1dH25oQmTJQOtQ8YQre/KB3iw3WtDg+dYdaxengtjK5Qi8Tgn7
 7JYB7mXOHyaBu2hAAIgM1oAUDWEDuGDxFAHSWG4b66GTsYJEjPBAm41cZLWg+l8eYFhZ
 tjmD3H7hw0LsXJNpGORq4X6f2+q2EwdrWdiPlsToWP9iegZxAlI6lBhh+e9BAJXgFmFE
 JyeeJbArBkgtQMTbP30jergs+lkaJLuehuesMVC5VGSwW7APK/Z4T7c8MbdIb/df5J/a TQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xkrp2ps45-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jan 2020 09:41:42 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5B48D100039;
        Fri, 24 Jan 2020 09:41:40 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 46EBD20EDC8;
        Fri, 24 Jan 2020 09:41:40 +0100 (CET)
Received: from localhost (10.75.127.44) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 24 Jan 2020 09:41:39
 +0100
From:   Amelie Delaunay <amelie.delaunay@st.com>
To:     Minas Harutyunyan <hminas@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH v3 1/2] dt-bindings: usb: dwc2: add support for STM32MP15 SoCs USB OTG HS and FS
Date:   Fri, 24 Jan 2020 09:41:30 +0100
Message-ID: <20200124084131.23749-2-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200124084131.23749-1-amelie.delaunay@st.com>
References: <20200124084131.23749-1-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG3NODE1.st.com (10.75.127.7) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-24_02:2020-01-24,2020-01-24 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the specific compatible string for the DWC2 IP found in the STM32MP15
SoCs.
STM32MP15 SoCs uses sensing comparators to detect Vbus valid levels and
ID pin state. usb33d-supply described the regulator supplying Vbus and ID
sensing comparators.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 Documentation/devicetree/bindings/usb/dwc2.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/dwc2.yaml b/Documentation/devicetree/bindings/usb/dwc2.yaml
index 71cf7ba32237..e95ba9373023 100644
--- a/Documentation/devicetree/bindings/usb/dwc2.yaml
+++ b/Documentation/devicetree/bindings/usb/dwc2.yaml
@@ -58,6 +58,8 @@ properties:
       - const: st,stm32f4x9-fsotg
       - const: st,stm32f4x9-hsotg
       - const: st,stm32f7-hsotg
+      - const: st,stm32mp15-fsotg
+      - const: st,stm32mp15-hsotg
       - const: samsung,s3c6400-hsotg
 
   reg:
@@ -103,6 +105,10 @@ properties:
   vusb_a-supply:
     description: phandle to voltage regulator of analog section.
 
+  vusb33d-supply:
+    description: reference to the VBUS and ID sensing comparators supply, in
+      order to perform OTG operation, used on STM32MP15 SoCs.
+
   dr_mode:
     enum: [host, peripheral, otg]
 
-- 
2.17.1

