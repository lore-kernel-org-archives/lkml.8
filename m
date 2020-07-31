Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129A6C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEFF3208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="yDugJ9ha"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733183AbgGaMLu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 08:11:50 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:35923 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733054AbgGaMLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 08:11:14 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06VC8fuX011305;
        Fri, 31 Jul 2020 14:11:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=VkOlCxczALyBGyhK0x3jjVQY6384tdF2+bl3dLOk1VU=;
 b=yDugJ9hasKAJgsud6QlBjPHtuqquAH3tqYNNZZcW39WVwNPOxC4/V7Ow7G0MlS0qxQNA
 QbxINUKyjoCeVwpxz5+iVJs3KbqZEwr8XD2Cg/HmsxM18PG0DPZEBjBSYLskz7tnEIxM
 MmRl5eRIqKCbC91rXGxRrEQLe/zJvx93wlphJKQAAt0EteJlMRHOBF1lBF8KpHu5k2Jr
 wrw+6oWsF9cJaA/gNVY1HktpkhOR8z9S/xUAmrwBR1Sff3Kn60MPg0Q3VaNT+T6SurJA
 L9U3aC0PR3gPbvKc+FyjLtYmVjHiVCkkooY1fwqgomcrbpWHhaWdMzFTnxgaGwurZD11 3g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 32ga72dcba-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Jul 2020 14:11:09 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2919F10002A;
        Fri, 31 Jul 2020 14:11:09 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1E01C2AE6DD;
        Fri, 31 Jul 2020 14:11:09 +0200 (CEST)
Received: from localhost (10.75.127.45) by SFHDAG3NODE1.st.com (10.75.127.7)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 31 Jul 2020 14:11:08
 +0200
From:   Arnaud Pouliquen <arnaud.pouliquen@st.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <arnaud.pouliquen@st.com>
Subject: [PATCH 08/13] rpmsg: raw: register service to the rpmsg control
Date:   Fri, 31 Jul 2020 14:10:38 +0200
Message-ID: <20200731121043.24199-9-arnaud.pouliquen@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200731121043.24199-1-arnaud.pouliquen@st.com>
References: <20200731121043.24199-1-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-31_04:2020-07-31,2020-07-31 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register the RPMSG_RAW_SERVICE service to the RPMsg control

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 drivers/rpmsg/rpmsg_raw.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/rpmsg/rpmsg_raw.c b/drivers/rpmsg/rpmsg_raw.c
index 8684a78ab4d1..117da0c566ed 100644
--- a/drivers/rpmsg/rpmsg_raw.c
+++ b/drivers/rpmsg/rpmsg_raw.c
@@ -315,6 +315,11 @@ static struct rpmsg_driver rpmsg_raw_client = {
 	.remove		= rpmsg_raw_remove,
 };
 
+const struct rpmsg_drv_ctrl_info  rpmsg_raw_ctl_info = {
+	.drv_name = KBUILD_MODNAME,
+	.service = RPMSG_RAW_SERVICE,
+};
+
 static int rpmsg_raw_init(void)
 {
 	int ret;
@@ -328,7 +333,18 @@ static int rpmsg_raw_init(void)
 
 	ret = register_rpmsg_driver(&rpmsg_raw_client);
 	if (ret < 0)
-		unregister_chrdev_region(rpmsg_raw_major, RPMSG_DEV_MAX);
+		goto free_region;
+
+	ret = rpmsg_ctrl_register_ctl(&rpmsg_raw_ctl_info);
+	if (ret < 0)
+		goto free_rpmsg;
+
+	return 0;
+
+free_rpmsg:
+	unregister_rpmsg_driver(&rpmsg_raw_client);
+free_region:
+	unregister_chrdev_region(rpmsg_raw_major, RPMSG_DEV_MAX);
 
 	return ret;
 }
@@ -336,6 +352,7 @@ module_init(rpmsg_raw_init);
 
 static void rpmsg_raw_exit(void)
 {
+	rpmsg_ctrl_unregister_ctl(&rpmsg_raw_ctl_info);
 	unregister_rpmsg_driver(&rpmsg_raw_client);
 	unregister_chrdev_region(rpmsg_raw_major, RPMSG_DEV_MAX);
 }
-- 
2.17.1

