Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75EBFC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 12:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50AC820780
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 12:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="k4nQ1ilE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730721AbgGAM7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 08:59:37 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:16814 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730520AbgGAM7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 08:59:36 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 061CqsEd019513;
        Wed, 1 Jul 2020 14:59:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=zWShjHdtkDP9KEzM3tiXokZkb+o6dSeLDNYRf6d3oDE=;
 b=k4nQ1ilEehuqobsy5lLNot5vy+vbnM4ayBHCdzRTy1DXQ+hPDGnC9MpaasLbOSuyqr1+
 +4sUg6s3xclWzzK+19q7dfx6m8ZdlSARE5ktVzu7OMTYjuE30O/K/CWzVuVPA4QTPdU5
 5mWtSrHX38Iv1mpgOUR16LpWQHAyrycE/eUg9NHYVO1DDB/f6wQRNlDegYDj9hYDZfW6
 sT61lgmOghoYvo2pTxuwH+mUGsyxNvhYrVWept0ATKzXbnXKlXyLn8kIfqD6HD4jW5ah
 zmMm/8ffNJtcevQCKCFfwBjcNbg8oqdD49zbd+wIFjh14M2DubvG0DpDAH1IsAcSZEwg hQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 31wuvwa2bc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Jul 2020 14:59:23 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A4B6C100034;
        Wed,  1 Jul 2020 14:59:22 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 956092B66DE;
        Wed,  1 Jul 2020 14:59:22 +0200 (CEST)
Received: from localhost (10.75.127.51) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 1 Jul 2020 14:59:21
 +0200
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <hugues.fruchet@st.com>, <mchehab@kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <robh+dt@kernel.org>
CC:     <linux-media@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <vincent.guittot@linaro.org>,
        <valentin.schneider@arm.com>, <rjw@rjwysocki.net>,
        <devicetree@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v6 1/3] dt-bindings: media: stm32-dcmi: Add DCMI min frequency property
Date:   Wed, 1 Jul 2020 14:59:16 +0200
Message-ID: <20200701125918.30793-2-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20200701125918.30793-1-benjamin.gaignard@st.com>
References: <20200701125918.30793-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG6NODE3.st.com (10.75.127.18) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-01_08:2020-07-01,2020-07-01 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document st,stm32-dcmi-min-frequency property which is used to
request CPUs minimum frequency when streaming frames.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 Documentation/devicetree/bindings/media/st,stm32-dcmi.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/st,stm32-dcmi.yaml b/Documentation/devicetree/bindings/media/st,stm32-dcmi.yaml
index 3fe778cb5cc3..05ca85a2411a 100644
--- a/Documentation/devicetree/bindings/media/st,stm32-dcmi.yaml
+++ b/Documentation/devicetree/bindings/media/st,stm32-dcmi.yaml
@@ -44,6 +44,13 @@ properties:
       bindings defined in
       Documentation/devicetree/bindings/media/video-interfaces.txt.
 
+  st,stm32-dcmi-min-frequency:
+    description: DCMI minimum CPUs frequency requirement (in KHz).
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - minimum: 0
+      - default: 0
+
 required:
   - compatible
   - reg
@@ -71,6 +78,7 @@ examples:
         clock-names = "mclk";
         dmas = <&dmamux1 75 0x400 0x0d>;
         dma-names = "tx";
+        st,stm32-dcmi-min-frequency = <650000>;
 
         port {
              dcmi_0: endpoint {
-- 
2.15.0

