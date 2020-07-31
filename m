Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF71C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 11:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48E6B2087C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 11:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="LbYYfJku"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732819AbgGaLrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 07:47:53 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:59832 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732784AbgGaLrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 07:47:48 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06VBc333015223;
        Fri, 31 Jul 2020 13:47:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=0GCBgslDZw0GYxmu1/0QyIojItqk9H/Ui6PIwaiTKBw=;
 b=LbYYfJkuthsTZUqclPZmdITvrbh//greT4ll2Blj6+EPjWOXDf+s8vCbN9nqgyV0373z
 A0KeFwP8ErMwbUbFU463x+rBF/IhdFPu2xuRwg4RXf8RMzkGDdXYoXytWgRXwTz5Fi6m
 TBjIKQEDJEXxdct/DBh4zNt6wCJl8yj9hdU6CEuafB0GNImk1fdo4VsuxvKZ4limLlkb
 EilyMZmhJiToiZmaJi8WaHw6rXBmEJqs9NUT+lj2y1xkiMCXqd/BHjkgD0mIv2dD1p92
 covJKWlOfCLow468Y7vSNKlu5OKIc2jUuvVUTjMTQyqdmJVL+k5JIXcd13KzG2hKrJvp qA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 32gagvna7k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Jul 2020 13:47:45 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E704710002A;
        Fri, 31 Jul 2020 13:47:44 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D9842221061;
        Fri, 31 Jul 2020 13:47:44 +0200 (CEST)
Received: from localhost (10.75.127.45) by SFHDAG3NODE1.st.com (10.75.127.7)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 31 Jul 2020 13:47:44
 +0200
From:   Arnaud Pouliquen <arnaud.pouliquen@st.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <arnaud.pouliquen@st.com>
Subject: [PATCH 4/9] rpmsg: define the name service announcement as reserved address
Date:   Fri, 31 Jul 2020 13:47:27 +0200
Message-ID: <20200731114732.12815-5-arnaud.pouliquen@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200731114732.12815-1-arnaud.pouliquen@st.com>
References: <20200731114732.12815-1-arnaud.pouliquen@st.com>
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

The address 53 is reserved for the dynamic RPMsg device management
on name service announcement.
Define this address in a reserved enum list.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 drivers/rpmsg/virtio_rpmsg_bus.c | 3 ---
 include/linux/rpmsg.h            | 9 +++++++++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index 910d30818901..b2927661868c 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -162,9 +162,6 @@ struct virtio_rpmsg_channel {
  */
 #define RPMSG_RESERVED_ADDRESSES	(1024)
 
-/* Address 53 is reserved for advertising remote services */
-#define RPMSG_NS_ADDR			(53)
-
 static void virtio_rpmsg_destroy_ept(struct rpmsg_endpoint *ept);
 static int virtio_rpmsg_send(struct rpmsg_endpoint *ept, void *data, int len);
 static int virtio_rpmsg_sendto(struct rpmsg_endpoint *ept, void *data, int len,
diff --git a/include/linux/rpmsg.h b/include/linux/rpmsg.h
index 9fe156d1c018..5496d27c6f8c 100644
--- a/include/linux/rpmsg.h
+++ b/include/linux/rpmsg.h
@@ -20,6 +20,15 @@
 
 #define RPMSG_ADDR_ANY		0xFFFFFFFF
 
+/**
+ * enum rpmsg_ns_flags - List of reserved RPMsg addresses
+ *
+ * @RPMSG_NS_ADDR: remote services advertising for dynamic allocation
+ */
+enum rpmsg_reserved_addr {
+	RPMSG_NS_ADDR		= 53,
+};
+
 struct rpmsg_device;
 struct rpmsg_endpoint;
 struct rpmsg_device_ops;
-- 
2.17.1

