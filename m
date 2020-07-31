Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF37C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 341CC208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="oM8FtIIa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733085AbgGaMLQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 08:11:16 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:17084 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732873AbgGaMLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 08:11:11 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06VC8jY3011686;
        Fri, 31 Jul 2020 14:11:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=OZnA7Vh3xkosB30guDpBIGnTonRyj7uk9V403xtYngQ=;
 b=oM8FtIIasffy9rSAsUIXHpVy6J08DS5qMNveO8tOlpdle2xahIwhc76JTE7Nv/pXp8vL
 2h8LHQczCfF7FEqJAfmo80TNI43X3HnwkPnLKV6VWud445nsgSTQcUnNXhNORy48rB8s
 6jCgU3DqANV60yBKCc4yCyiM6NQ8wPiBXX0PW4pYyppn46T2Ncik6dYU3wYVuBVkuFka
 sRLiZ/vHkPzeAtkkmL5BjXroNSibOQX+TjM9erxNWImyGH68JJUhzkGsEsRs8vPS7o22
 TrfjZA0qM1DfFir69QPvQcu7C8f7KsM6e05Bo0mWzYLD4IXmtFQhJ3S7heJajHkjH5KO 3Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 32ga72dcb0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Jul 2020 14:11:06 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E7EE310002A;
        Fri, 31 Jul 2020 14:11:05 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id DD2F32AE6DD;
        Fri, 31 Jul 2020 14:11:05 +0200 (CEST)
Received: from localhost (10.75.127.46) by SFHDAG3NODE1.st.com (10.75.127.7)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 31 Jul 2020 14:11:05
 +0200
From:   Arnaud Pouliquen <arnaud.pouliquen@st.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <arnaud.pouliquen@st.com>
Subject: [PATCH 05/13] rpmsg: uapi: add service param for create destroy ioctls
Date:   Fri, 31 Jul 2020 14:10:35 +0200
Message-ID: <20200731121043.24199-6-arnaud.pouliquen@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200731121043.24199-1-arnaud.pouliquen@st.com>
References: <20200731121043.24199-1-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG6NODE2.st.com (10.75.127.17) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-31_04:2020-07-31,2020-07-31 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To allow to associate an endpoint creation to a service, add
a new parameter in rpmsg_endpoint_info struct.
For each RPMsg service driver that want to support the ioctl interface
a new service will have to be added.
The  RPMSG_START_PRIVATE_SERVICES is used to allow developer to add is
own services with ID higher or equal to 1024.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 include/uapi/linux/rpmsg.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/uapi/linux/rpmsg.h b/include/uapi/linux/rpmsg.h
index e14c6dab4223..2ccc10ffacd4 100644
--- a/include/uapi/linux/rpmsg.h
+++ b/include/uapi/linux/rpmsg.h
@@ -9,16 +9,32 @@
 #include <linux/ioctl.h>
 #include <linux/types.h>
 
+/**
+ * enum rpmsg_services - list of supported RPMsg services
+ *
+ * @RPMSG_RAW_SERVICE: char device RPMSG service
+ * @RPMSG_START_PRIVATE_SERVICES: private services have to be declared after.
+ */
+enum rpmsg_services {
+	/* Reserved services */
+	RPMSG_RAW_SERVICE =  0,
+
+	/* Private services */
+	RPMSG_START_PRIVATE_SERVICES =  1024,
+};
+
 /**
  * struct rpmsg_endpoint_info - endpoint info representation
  * @name: name of service
  * @src: local address
  * @dst: destination address
+ * @service: associated RPMsg service
  */
 struct rpmsg_endpoint_info {
 	char name[32];
 	__u32 src;
 	__u32 dst;
+	__u32 service;
 };
 
 #define RPMSG_CREATE_EPT_IOCTL	_IOW(0xb5, 0x1, struct rpmsg_endpoint_info)
-- 
2.17.1

