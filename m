Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA3EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4799222BF3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="PikdmGCX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbgH0HVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 03:21:48 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:28850 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727991AbgH0HVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:21:33 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07R7Ivpf016719;
        Thu, 27 Aug 2020 09:21:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=XwGmwMIIYdrDy6Y3ICeaN4bEoGRK+NWOLS2IGOw0OWc=;
 b=PikdmGCXuf7CNVzwK0fV6c7F5+1Q9N2ZnOstbnPwNTR8T8R8TzGvjIC+VM7lrwKzc0ub
 e4SsQKuuQU2xdl1/n5mJqWZbCeFIrKFi/C3Uz1di1/M8CMcaRivbR2yfHiCAmvcp4bn7
 MiiJuFe6QCYflwT91ST5BcvaMANTbeUuHtKZTUfwkeISd5bqnYTnkBqPWxO7g+O8lTXe
 OmxEP9zsIigBHrziMjTl8vpBCX0R6yxGfJG6vhJKTp6N2BlSwpUqJKdftweX2BgGaJzJ
 uaGEcDmcizvDXkQgAgSpW4OK8/zos2XL/9Qrv6QZ0WGfjYS8dF14wAQbgtPptK54yPg6 1g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 333b6xcfeg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Aug 2020 09:21:20 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 681B010002A;
        Thu, 27 Aug 2020 09:21:20 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 57838212648;
        Thu, 27 Aug 2020 09:21:20 +0200 (CEST)
Received: from localhost (10.75.127.45) by SFHDAG3NODE1.st.com (10.75.127.7)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 27 Aug 2020 09:21:19
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
Subject: [PATCH 2/3] dt-bindings: remoteproc: stm32_rproc: update for firmware synchronization
Date:   Thu, 27 Aug 2020 09:21:00 +0200
Message-ID: <20200827072101.26588-3-arnaud.pouliquen@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200827072101.26588-1-arnaud.pouliquen@st.com>
References: <20200827072101.26588-1-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG6NODE2.st.com (10.75.127.17) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-27_02:2020-08-27,2020-08-27 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new properties description used to attach to a pre-loaded
firmware according to the commit 9276536f455b3
("remoteproc: stm32: Parse syscon that will manage M4 synchronisation")
which updates the driver part.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 .../bindings/remoteproc/st,stm32-rproc.yaml   | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml
index 4ffa25268fcc..e50957d86b1c 100644
--- a/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml
@@ -96,6 +96,25 @@ properties:
         3rd cell: register bitmask for the deep sleep bit
     maxItems: 1
 
+  st,syscfg-m4-state:
+    $ref: "/schemas/types.yaml#/definitions/phandle-array"
+    description: |
+      Reference to the tamp register which exposes the Cortex-M4 state.
+        1st cell: phandle to syscon block
+        2nd cell: register offset containing the Cortex-M4 state
+        3rd cell: register bitmask for the Cortex-M4 state
+    maxItems: 1
+
+  st,syscfg-rsc-tbl:
+    $ref: "/schemas/types.yaml#/definitions/phandle-array"
+    description: |
+      Reference to the tamp register which references the Cortex-M4
+      resource table address.
+        1st cell: phandle to syscon block
+        2nd cell: register offset containing the resource table address
+        3rd cell: register bitmask for the resource table address
+    maxItems: 1
+
   st,auto-boot:
     $ref: /schemas/types.yaml#/definitions/flag
     description:
-- 
2.17.1

