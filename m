Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F02CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 09:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0710120723
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 09:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="ftsrRfta"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbgGCJzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 05:55:53 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:14100 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725972AbgGCJzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 05:55:37 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0639dPXH030770;
        Fri, 3 Jul 2020 11:55:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=ydaCcNlIAAbZsmEQJWCB1IJ7M36EGiwXLo/DeKRtPRE=;
 b=ftsrRftaVp6e0DRjaVQxUmqUVMDmwEct+p1BjzQ32e0KT6TfnhQsHaKFZAfI3YQpJBa2
 gwauFD0PF4kE0notiNVWugTnqd3QM8Kn7uzv/wkTYClGvQvrm2KU2TulDTSRpYLrW9RF
 zposwZsf9W1Vbn44JRfi59ogOo4kx2XvWepX+NDbtu0EbvRvmKa0yqLNG/cxROsdvpRK
 bXmgcxxhDy0eaFb+1kBQ8oWA3yaWyKeXBUH//BId0TGSzoxiJyJTJrxhDJbwMWK5Vhbw
 XdKXXwiNVfLewViQyQGXmT0Ex6db91lAbgFVLjrbJ7ykWENeqgsJiMChYVrpTejYkolP rw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 31wu8a6ddn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Jul 2020 11:55:25 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id AB4A7100034;
        Fri,  3 Jul 2020 11:55:24 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9AD282BAC64;
        Fri,  3 Jul 2020 11:55:24 +0200 (CEST)
Received: from localhost (10.75.127.50) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 3 Jul 2020 11:55:24
 +0200
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <robh+dt@kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <lee.jones@linaro.org>,
        <benjamin.gaignard@st.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/5] dt-bingings: arm: stm32: Add compatibles for syscon nodes
Date:   Fri, 3 Jul 2020 11:55:16 +0200
Message-ID: <20200703095520.30264-2-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20200703095520.30264-1-benjamin.gaignard@st.com>
References: <20200703095520.30264-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-03_03:2020-07-02,2020-07-03 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit ad440432d1f9 ("dt-bindings: mfd: Ensure 'syscon' has a more specific compatible")
it is required to provide at least 2 compatibles string for syscon node.
This patch document the missing compatibles for stm32 SoCs.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 .../devicetree/bindings/arm/stm32/st,stm32-syscon.yaml     | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/stm32/st,stm32-syscon.yaml b/Documentation/devicetree/bindings/arm/stm32/st,stm32-syscon.yaml
index cf5db5e273f3..6f1cd0103c74 100644
--- a/Documentation/devicetree/bindings/arm/stm32/st,stm32-syscon.yaml
+++ b/Documentation/devicetree/bindings/arm/stm32/st,stm32-syscon.yaml
@@ -16,6 +16,9 @@ properties:
       - items:
           - enum:
               - st,stm32mp157-syscfg
+              - st,stm32mp151-pwr-mcu
+              - st,stm32-syscfg
+              - st,stm32-power-config
           - const: syscon
 
   reg:
@@ -27,7 +30,16 @@ properties:
 required:
   - compatible
   - reg
-  - clocks
+
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - st,stm32mp157-syscfg
+then:
+  required:
+    - clocks
 
 additionalProperties: false
 
-- 
2.15.0

