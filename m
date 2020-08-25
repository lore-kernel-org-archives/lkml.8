Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB23C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 16:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15B9A20782
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 16:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="ts/rfNXw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgHYQxQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 12:53:16 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:38408 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726180AbgHYQwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 12:52:22 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07PGmbAS019652;
        Tue, 25 Aug 2020 18:52:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=FV+yGzCorer44bS2EQ3ZmV/Ce/Z43eVcESLLlSmmrtQ=;
 b=ts/rfNXw8XcHx9MORqLI/c1cY4/On+1quw5XXosxG3vgZgBvawzSXAf6p1O3wnQ3wD5h
 7R+N0ULAYOIJSRXD09cm414YHafVHbmApBBYkpXb4FvlvJkAfjXl2Cv0Hrbvo+dsG/n/
 oP/1Yef9HcRqtT/ujJ/Zx5qLMAconKyZO8iKGfVLoVTqP6ewhTI/CeOLpThwtFZaUjIb
 wb0dlLih+EfkHFoHJrIk0evqX7tHU8II5QrAkKhp7ve7AJtKIeHrWi6yl5dOjI2XI9MI
 /1+4itjOLlZYlNX8uNVIeWjR+EGssQDs1Pr7NXx1t0Dl7wtbOASKrAev/Twx1wqljN7X 0g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 333b6x405t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Aug 2020 18:52:15 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 330D610002A;
        Tue, 25 Aug 2020 18:52:15 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 287602AE6AA;
        Tue, 25 Aug 2020 18:52:15 +0200 (CEST)
Received: from localhost (10.75.127.45) by SFHDAG3NODE1.st.com (10.75.127.7)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 25 Aug 2020 18:52:14
 +0200
From:   Arnaud Pouliquen <arnaud.pouliquen@st.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <arnaud.pouliquen@st.com>
Subject: [PATCH v2 2/8] rpmsg: core: add channel creation internal API
Date:   Tue, 25 Aug 2020 18:49:01 +0200
Message-ID: <20200825164907.3642-3-arnaud.pouliquen@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200825164907.3642-1-arnaud.pouliquen@st.com>
References: <20200825164907.3642-1-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-25_06:2020-08-25,2020-08-25 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the channel creation API as a first step to be able to define the
name service announcement as a rpmsg driver independent from the RPMsg
virtio bus.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 drivers/rpmsg/rpmsg_core.c     | 45 ++++++++++++++++++++++++++++++++++
 drivers/rpmsg/rpmsg_internal.h | 12 +++++++++
 2 files changed, 57 insertions(+)

diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
index a6361cad608b..97c15c1a0cc8 100644
--- a/drivers/rpmsg/rpmsg_core.c
+++ b/drivers/rpmsg/rpmsg_core.c
@@ -20,6 +20,51 @@
 
 #include "rpmsg_internal.h"
 
+/**
+ * rpmsg_create_channel() - create a new rpmsg channel
+ * using its name and address info.
+ * @rpdev: rpmsg driver
+ * @chinfo: channel_info to bind
+ *
+ * Returns a pointer to the new rpmsg device on success, or NULL on error.
+ */
+struct rpmsg_device *
+	rpmsg_create_channel(struct rpmsg_device *rpdev,
+			     struct rpmsg_channel_info *chinfo)
+{
+	if (WARN_ON(!rpdev))
+		return NULL;
+	if (!rpdev->ops || !rpdev->ops->create_channel) {
+		dev_err(&rpdev->dev, "no create_channel ops found\n");
+		return NULL;
+	}
+
+	return rpdev->ops->create_channel(rpdev, chinfo);
+}
+EXPORT_SYMBOL(rpmsg_create_channel);
+
+/**
+ * rpmsg_release_channel() - release a rpmsg channel
+ * using its name and address info.
+ * @rpdev: rpmsg driver
+ * @chinfo: channel_info to bind
+ *
+ * Returns 0 on success or an appropriate error value.
+ */
+int rpmsg_release_channel(struct rpmsg_device *rpdev,
+			  struct rpmsg_channel_info *chinfo)
+{
+	if (WARN_ON(!rpdev))
+		return -EINVAL;
+	if (!rpdev->ops || !rpdev->ops->release_channel) {
+		dev_err(&rpdev->dev, "no release_channel ops found\n");
+		return -EPERM;
+	}
+
+	return rpdev->ops->release_channel(rpdev, chinfo);
+}
+EXPORT_SYMBOL(rpmsg_release_channel);
+
 /**
  * rpmsg_create_ept() - create a new rpmsg_endpoint
  * @rpdev: rpmsg channel device
diff --git a/drivers/rpmsg/rpmsg_internal.h b/drivers/rpmsg/rpmsg_internal.h
index 3fc83cd50e98..d5ab286d0e5e 100644
--- a/drivers/rpmsg/rpmsg_internal.h
+++ b/drivers/rpmsg/rpmsg_internal.h
@@ -20,6 +20,8 @@
 
 /**
  * struct rpmsg_device_ops - indirection table for the rpmsg_device operations
+ * @create_channel:	create backend-specific channel, optional
+ * @release_channel:	release backend-specific channel, optional
  * @create_ept:		create backend-specific endpoint, required
  * @announce_create:	announce presence of new channel, optional
  * @announce_destroy:	announce destruction of channel, optional
@@ -29,6 +31,11 @@
  * advertise new channels implicitly by creating the endpoints.
  */
 struct rpmsg_device_ops {
+	struct rpmsg_device *(*create_channel)(struct rpmsg_device *rpdev,
+					     struct rpmsg_channel_info *chinfo);
+	int (*release_channel)(struct rpmsg_device *rpdev,
+			       struct rpmsg_channel_info *chinfo);
+
 	struct rpmsg_endpoint *(*create_ept)(struct rpmsg_device *rpdev,
 					    rpmsg_rx_cb_t cb, void *priv,
 					    struct rpmsg_channel_info chinfo);
@@ -75,6 +82,11 @@ int rpmsg_unregister_device(struct device *parent,
 struct device *rpmsg_find_device(struct device *parent,
 				 struct rpmsg_channel_info *chinfo);
 
+struct rpmsg_device *
+	rpmsg_create_channel(struct rpmsg_device *rpdev,
+			     struct rpmsg_channel_info *chinfo);
+int rpmsg_release_channel(struct rpmsg_device *rpdev,
+			  struct rpmsg_channel_info *chinfo);
 /**
  * rpmsg_chrdev_register_device() - register chrdev device based on rpdev
  * @rpdev:	prepared rpdev to be used for creating endpoints
-- 
2.17.1

