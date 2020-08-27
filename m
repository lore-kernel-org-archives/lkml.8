Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB076C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4C9722BEA
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="F29YgNNl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgH0HVg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 03:21:36 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:22030 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727839AbgH0HVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:21:32 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07R7HlT7013427;
        Thu, 27 Aug 2020 09:21:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=KQ+9yJUzemMWVFCVMFRX7+xLDsvlII1rDD1EoRBdZsw=;
 b=F29YgNNl3PbFfdfhnPmZPy3O97AqOiU6gnw1thd3npR26u+hmxW7+fuaYkyGH21oCPMM
 T1dYz+o4fF9zxKtSM155dGj1OuoUmf2Eme5YLTiuYOMV27HH85/nDGsoxfuo2nEQJFKP
 aSiNPwsoirxdpAupCBUa/ygF8cqmmXThgJUj/FFGJO6wvO/vz9/KlLewNoQvB2gdc2SP
 1/CcXA/Ft4s0vWbI/bMNFi6xJgwohLExE3+XMFX6jNEhG+zWEWQht6aljwTOdETPkoFp
 wN4BEtNg+KmXoE1xpCB5FO0v6kFiBDkDgYp4yUhMRULHnF7X3BGsdZkU3AymzykWhOzF 3Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 333b2mvfux-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Aug 2020 09:21:19 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4DC20100034;
        Thu, 27 Aug 2020 09:21:19 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3D050212648;
        Thu, 27 Aug 2020 09:21:19 +0200 (CEST)
Received: from localhost (10.75.127.46) by SFHDAG3NODE1.st.com (10.75.127.7)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 27 Aug 2020 09:21:18
 +0200
From:   Arnaud Pouliquen <arnaud.pouliquen@st.com>
To:     Rob Herring <robh@kernel.org>,
        Alexandre Torgue <alexandre.torgue@st.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Fabien Dessenne <fabien.dessenne@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH 1/3] dt-bindings: arm: stm32: Add compatible for syscon tamp node
Date:   Thu, 27 Aug 2020 09:20:59 +0200
Message-ID: <20200827072101.26588-2-arnaud.pouliquen@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200827072101.26588-1-arnaud.pouliquen@st.com>
References: <20200827072101.26588-1-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-27_02:2020-08-27,2020-08-27 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit ad440432d1f9 ("dt-bindings: mfd: Ensure 'syscon' has a
more specific compatible")
It is required to provide at least 2 compatibles string for syscon node.
This patch documents the new compatible for stm32 SoC to support
TAMP registers access.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 Documentation/devicetree/bindings/arm/stm32/st,stm32-syscon.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/stm32/st,stm32-syscon.yaml b/Documentation/devicetree/bindings/arm/stm32/st,stm32-syscon.yaml
index 6f1cd0103c74..6634b3e0853e 100644
--- a/Documentation/devicetree/bindings/arm/stm32/st,stm32-syscon.yaml
+++ b/Documentation/devicetree/bindings/arm/stm32/st,stm32-syscon.yaml
@@ -19,6 +19,7 @@ properties:
               - st,stm32mp151-pwr-mcu
               - st,stm32-syscfg
               - st,stm32-power-config
+              - st,stm32-tamp
           - const: syscon
 
   reg:
-- 
2.17.1

