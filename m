Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECDE4C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7A712245C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="BRg4UNR1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733103AbgGaMLS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 08:11:18 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:22308 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733004AbgGaMLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 08:11:11 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06VC85s9026417;
        Fri, 31 Jul 2020 14:11:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=Zev07XZF6gQYZQsYDyxnZ6yZusIc9M6Jp3/EdDM79V8=;
 b=BRg4UNR1l0Yewsw5dRHDTp0KvjZ4Bm/5mS7vrZF4EUCSbvT3ph5c7ZYCJqK5Af9mowkw
 G9lwTg50lFZfdagNhep5EwDnKupev64/1NB4etceFB1+ZIU5z4VJkLDeGoKl4tnyYhg5
 g2gvvaABeS5MwtcgOARp9NtoJAsL1LYYdmuH1dC6lPGmOpa6trOFVbcGKOQNCMwD3TXs
 FtSpkSIFFzNqr/xeDIhGa9S8LpvieijrUYebEzp94sezzoISGcWcLiTve0vCcXFPTn4p
 zdfCbCNZK6cOsxkEopETEyowXU8l5aZxVe/nLIRpHgQvw/9bppFPFQq/0ejlSvUpm48K 5A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 32gagvnd0k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Jul 2020 14:11:07 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E2A4B10002A;
        Fri, 31 Jul 2020 14:11:06 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D809C2AE6DD;
        Fri, 31 Jul 2020 14:11:06 +0200 (CEST)
Received: from localhost (10.75.127.45) by SFHDAG3NODE1.st.com (10.75.127.7)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 31 Jul 2020 14:11:06
 +0200
From:   Arnaud Pouliquen <arnaud.pouliquen@st.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <arnaud.pouliquen@st.com>
Subject: [PATCH 06/13] rpmsg: add RPMsg control info structure
Date:   Fri, 31 Jul 2020 14:10:36 +0200
Message-ID: <20200731121043.24199-7-arnaud.pouliquen@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200731121043.24199-1-arnaud.pouliquen@st.com>
References: <20200731121043.24199-1-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG6NODE2.st.com (10.75.127.17) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-31_04:2020-07-31,2020-07-31 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new structure for RPMsg driver registration.
This structure will be used to link a service to its driver.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 include/linux/rpmsg.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/rpmsg.h b/include/linux/rpmsg.h
index 5496d27c6f8c..ef8d1b987d38 100644
--- a/include/linux/rpmsg.h
+++ b/include/linux/rpmsg.h
@@ -34,6 +34,19 @@ struct rpmsg_endpoint;
 struct rpmsg_device_ops;
 struct rpmsg_endpoint_ops;
 
+/**
+ * struct rpmsg_drv_ctrl_info - rpmsg ctrl structure
+ * @drv_name:	name of the associated driver
+ * @service:	the associated rpmsg service listed in @rpmsg_services
+ *
+ * This structure is used by rpmsg_ctl to link the endpoint creation to the
+ * service rpmsg driver.
+ */
+struct rpmsg_drv_ctrl_info {
+	const char *drv_name;
+	u32  service;
+};
+
 /**
  * struct rpmsg_channel_info - channel info representation
  * @name: name of service
-- 
2.17.1

