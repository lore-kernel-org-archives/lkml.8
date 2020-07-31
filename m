Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BECAC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46CDD2245C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="0TGt8XX/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733146AbgGaML0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 08:11:26 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:11274 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733090AbgGaMLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 08:11:18 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06VC7bie011768;
        Fri, 31 Jul 2020 14:11:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=z/FPnRPNTGOl2B/1fOLQu51Ns64FIJlkJ28q5n8hoPw=;
 b=0TGt8XX/8AWTuQyZX0botExlIyNJJeu/ZfyEktWXM7yxXaYPjcL67Oyin2NnlGaAyC1P
 qjCnPf9s7BvL/CUD2c6Lq/xPQitvefx8YZ6Xp/H4jw+g4PdWSigP2KcYxLirYbzSdS1h
 ADR5wgswWCU32/wTmS5RHZ7n22PLxqvDHNozNVL0hDrPeQaUfToyDqgyxei+TBHJEBTu
 UWvehEb7LAEQ7/m2VOLoUUvvWlGnadpQN/oSIrVDzvFzikn6jN8JaZVyCVQZElBHAdXS
 DFuJUJB+rtZttGGRUTGOjzh5M3mGRuXwHwJi8a6KN4hv15hd3ZDDVbk4Q0A0o5Mb/qZw Jw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 32g9v9xkvd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Jul 2020 14:11:15 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 89DC810002A;
        Fri, 31 Jul 2020 14:11:14 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7F96D2AE6DD;
        Fri, 31 Jul 2020 14:11:14 +0200 (CEST)
Received: from localhost (10.75.127.46) by SFHDAG3NODE1.st.com (10.75.127.7)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 31 Jul 2020 14:11:13
 +0200
From:   Arnaud Pouliquen <arnaud.pouliquen@st.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <arnaud.pouliquen@st.com>
Subject: [PATCH 13/13] rpmsg: ctrl: add support of the endpoints release
Date:   Fri, 31 Jul 2020 14:10:43 +0200
Message-ID: <20200731121043.24199-14-arnaud.pouliquen@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200731121043.24199-1-arnaud.pouliquen@st.com>
References: <20200731121043.24199-1-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-31_04:2020-07-31,2020-07-31 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the support of the release of an endpoint using the ioctl
interface.
The endpoint is identified using its name, its source address
and is destination address.
To support legacy a new ioctl ioctl is created instead of updating
RPMSG_DESTROY_EPT_IOCTL.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 drivers/rpmsg/rpmsg_ctrl.c | 35 ++++++++++++++++++++++++-----------
 include/uapi/linux/rpmsg.h |  1 +
 2 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/rpmsg/rpmsg_ctrl.c b/drivers/rpmsg/rpmsg_ctrl.c
index d2a6dbb8798f..d696247970c2 100644
--- a/drivers/rpmsg/rpmsg_ctrl.c
+++ b/drivers/rpmsg/rpmsg_ctrl.c
@@ -75,26 +75,39 @@ static long rpmsg_ctrl_dev_ioctl(struct file *fp, unsigned int cmd,
 	struct rpmsg_channel_info chinfo;
 	struct rpmsg_endpoint_info eptinfo;
 	struct rpmsg_device *newch;
-
-	if (cmd != RPMSG_CREATE_EPT_IOCTL)
-		return -EINVAL;
+	int ret;
 
 	if (copy_from_user(&eptinfo, argp, sizeof(eptinfo)))
 		return -EFAULT;
 
-	chinfo.driver_override = rpmsg_ctrl_get_drv_name(eptinfo.service);
-	if (!chinfo.driver_override)
-		return -ENODEV;
-
 	memcpy(chinfo.name, eptinfo.name, RPMSG_NAME_SIZE);
 	chinfo.name[RPMSG_NAME_SIZE - 1] = '\0';
 	chinfo.src = eptinfo.src;
 	chinfo.dst = eptinfo.dst;
 
-	newch = rpmsg_create_channel(ctrldev->rpdev, &chinfo);
-	if (!newch) {
-		dev_err(&ctrldev->dev, "rpmsg_create_channel failed\n");
-		return -ENXIO;
+	switch (cmd) {
+	case RPMSG_CREATE_EPT_IOCTL:
+		chinfo.driver_override =
+				rpmsg_ctrl_get_drv_name(eptinfo.service);
+		if (!chinfo.driver_override)
+			return -ENODEV;
+
+		newch = rpmsg_create_channel(ctrldev->rpdev, &chinfo);
+		if (!newch) {
+			dev_err(&ctrldev->dev, "rpmsg_create_channel failed\n");
+			return -ENXIO;
+		}
+		break;
+	case RPMSG_RELEASE_EPT_IOCTL:
+		ret = rpmsg_release_channel(ctrldev->rpdev, &chinfo);
+		if (ret) {
+			dev_err(&ctrldev->dev,
+				"rpmsg_release_channel failed: %d\n", ret);
+			return ret;
+		}
+		break;
+	default:
+		return -EINVAL;
 	}
 
 	return 0;
diff --git a/include/uapi/linux/rpmsg.h b/include/uapi/linux/rpmsg.h
index 2ccc10ffacd4..74d821ee5f8c 100644
--- a/include/uapi/linux/rpmsg.h
+++ b/include/uapi/linux/rpmsg.h
@@ -39,5 +39,6 @@ struct rpmsg_endpoint_info {
 
 #define RPMSG_CREATE_EPT_IOCTL	_IOW(0xb5, 0x1, struct rpmsg_endpoint_info)
 #define RPMSG_DESTROY_EPT_IOCTL	_IO(0xb5, 0x2)
+#define RPMSG_RELEASE_EPT_IOCTL	_IOW(0xb5, 0x3, struct rpmsg_endpoint_info)
 
 #endif
-- 
2.17.1

