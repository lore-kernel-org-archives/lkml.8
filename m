Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D49C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 09:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82D152076C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 09:20:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="JlokXir+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725814AbgIKJUu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 05:20:50 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:29716 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725613AbgIKJUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 05:20:49 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08B9GrU1022506;
        Fri, 11 Sep 2020 11:20:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=3OR8qxZpq3JUZtn+62eu3HHTqXzgdbLMzpf40hJBmi0=;
 b=JlokXir+4V+MLlcPGz7yfLqDge+HwQS//ZGrCDY6Q2ctmwVeySzbg2YiiYCtz9qgF5ND
 NBSI58IRoi7wwyHvDSEVP6/uQSVYKFX0d1eazQKJSruCQzSlCN7q1NaOeBlRtNU8KlpE
 JBM3SkQNR8IUwBf5hjiND2XUKUHXj78oOdjqRDDjOnN0gRNFepP9GsxVLLzqcdC9Efqx
 5xQm4SPUUxhwFdB6qXF7QD6dFJc7FyRkdskms9eG7dZUcXFERcc6y/YJN3zIlKyfVLG8
 QZaR2K20CXkGH4mBKSE9fPYEiFUE6idqcQLB2mQuyc2mrGivTeEZIm4uDB2RJqeV/W9l RQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 33c0ev88a1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Sep 2020 11:20:24 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 42FBA100034;
        Fri, 11 Sep 2020 11:20:24 +0200 (CEST)
Received: from Webmail-eu.st.com (gpxdag6node5.st.com [10.75.127.81])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2DD1721FEBE;
        Fri, 11 Sep 2020 11:20:24 +0200 (CEST)
Received: from localhost (10.75.127.44) by GPXDAG6NODE5.st.com (10.75.127.81)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 11 Sep 2020 11:20:23
 +0200
From:   Olivier Moysan <olivier.moysan@st.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <alexandre.torgue@st.com>, <robh@kernel.org>,
        <mark.rutland@arm.com>, <arnaud.pouliquen@st.com>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <olivier.moysan@st.com>
Subject: [PATCH 1/2] ASoC: dt-bindings: add mclk provider support to stm32 i2s
Date:   Fri, 11 Sep 2020 11:19:51 +0200
Message-ID: <20200911091952.14696-2-olivier.moysan@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200911091952.14696-1-olivier.moysan@st.com>
References: <20200911091952.14696-1-olivier.moysan@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG7NODE3.st.com (10.75.127.21) To GPXDAG6NODE5.st.com
 (10.75.127.81)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-11_03:2020-09-10,2020-09-11 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add master clock provider support to STM32 I2S.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 Documentation/devicetree/bindings/sound/st,stm32-i2s.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/st,stm32-i2s.yaml b/Documentation/devicetree/bindings/sound/st,stm32-i2s.yaml
index f32410890589..6feb5a09c184 100644
--- a/Documentation/devicetree/bindings/sound/st,stm32-i2s.yaml
+++ b/Documentation/devicetree/bindings/sound/st,stm32-i2s.yaml
@@ -54,6 +54,10 @@ properties:
   resets:
     maxItems: 1
 
+  "#clock-cells":
+    description: Configure the I2S device as MCLK clock provider.
+    const: 0
+
 required:
   - compatible
   - "#sound-dai-cells"
-- 
2.17.1

