Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC9FAC433F7
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 10:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A77C020748
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 10:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="X2ifo8xu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbgGXKrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 06:47:53 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:51618 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727058AbgGXKrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 06:47:39 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06OAhunt008149;
        Fri, 24 Jul 2020 12:47:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=i7ijBgfYqNtevxO1Vk+gug8GMNkBspZO4mB3AYmj0Vc=;
 b=X2ifo8xuH8k5gEjgHA/y/GDf4IswT3Z4Uj/vlLyurmxaqSeXqF7PDdJTUlN5qF/WALDX
 v1lNwS5A+MZ61Emtwz5ZHL+C7AccMk3UGIFAo+A/Yqud+uzLEbakZ+bjB1tUyqpVxQ/F
 zjFksVMsJTZjLcaGv1wvZXn7NVc4BF78tYYxTobpaSUmrAMnpfapblSs272ylfzcG+RQ
 rqnVrMH4HKHNxTJ5O4BlkDObTMO6Ds6EuHo8z+HfmivlRqS8ZT3r5crrUO6sHUfjSBKW
 ii7wVrEPab/39bsOQmVNCDXXJDfA+sGdm47BhNXtz+kevhmEbJSG85nslO/g21boAagZ Tg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 32bsfpys0n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jul 2020 12:47:19 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 99576100034;
        Fri, 24 Jul 2020 12:47:18 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8B6802A4D71;
        Fri, 24 Jul 2020 12:47:18 +0200 (CEST)
Received: from localhost (10.75.127.45) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 24 Jul 2020 12:47:18
 +0200
From:   Amelie Delaunay <amelie.delaunay@st.com>
To:     Minas Harutyunyan <hminas@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
CC:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v3 2/3] dt-bindings: usb: dwc2: add optional usb-role-switch property
Date:   Fri, 24 Jul 2020 12:47:10 +0200
Message-ID: <20200724104711.5474-3-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200724104711.5474-1-amelie.delaunay@st.com>
References: <20200724104711.5474-1-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG5NODE3.st.com (10.75.127.15) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-24_03:2020-07-24,2020-07-24 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch documents the usb-role-switch property in dwc2 bindings, now
that usb-role-switch support is available in dwc2 driver.

Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
New since v2 patchset.
---
 Documentation/devicetree/bindings/usb/dwc2.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/dwc2.yaml b/Documentation/devicetree/bindings/usb/dwc2.yaml
index 9352a8ef60a6..7b226eeffe82 100644
--- a/Documentation/devicetree/bindings/usb/dwc2.yaml
+++ b/Documentation/devicetree/bindings/usb/dwc2.yaml
@@ -100,6 +100,10 @@ properties:
   dr_mode:
     enum: [host, peripheral, otg]
 
+  usb-role-switch:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: Support role switch.
+
   g-rx-fifo-size:
     $ref: /schemas/types.yaml#/definitions/uint32
     description: size of rx fifo size in gadget mode.
-- 
2.17.1

