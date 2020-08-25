Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC4FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 16:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1573020782
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 16:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="aAfO25ZI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgHYQwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 12:52:50 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:41072 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726471AbgHYQwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 12:52:25 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07PGkt5Q010046;
        Tue, 25 Aug 2020 18:52:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=qO78AbgiBHwh2Bo0X12NYYis5HJeGCLxxhU0UT9xviY=;
 b=aAfO25ZI4SAeBGoRwLnME9q5VhkRDqo7owLRBKYbYa3K7k5qhWoVp6CKzFYz4XjV4kMS
 5AomSvchdshLSsN3pI/u32uudGtYr3n93vH72R7fOVJsKJmcmyRfKDVDYfYaK5IHyAjp
 RPrm/e4Yjh3e4XfqGdioSEtsVT7RFh7zLWZJKgWojevExStQRzsS2L7EAKJsNnw7KUYl
 mI3tZTDno9MEegvVuU1Ip8KsWZQMXPvRYajl9Oh2b1ktN8DfAPwnpXuEH1sDBXdwkxVV
 rACeHqTRnhidUSKwGZUATENrZ4mlBsZRDXFzJlansyGAFDUq11xd7rZsSHH4QiKwGQFp XA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 332t8fpmpd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Aug 2020 18:52:21 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E8B2610002A;
        Tue, 25 Aug 2020 18:52:20 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id DE55D2AE6AA;
        Tue, 25 Aug 2020 18:52:20 +0200 (CEST)
Received: from localhost (10.75.127.46) by SFHDAG3NODE1.st.com (10.75.127.7)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 25 Aug 2020 18:52:20
 +0200
From:   Arnaud Pouliquen <arnaud.pouliquen@st.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <arnaud.pouliquen@st.com>
Subject: [PATCH v2 7/8] rpmsg: ns: add name service announcement service
Date:   Tue, 25 Aug 2020 18:49:06 +0200
Message-ID: <20200825164907.3642-8-arnaud.pouliquen@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200825164907.3642-1-arnaud.pouliquen@st.com>
References: <20200825164907.3642-1-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG7NODE1.st.com (10.75.127.19) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-25_06:2020-08-25,2020-08-25 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the RPMsg driver is in charge of the name service announcement,
create an API to send channel creation and destruction to the remote
processor.
Notice that the source address of the message sent is now RPMSG_NS_ADDR.
Legacy implementation was to send the message with source address
corresponding to the ept created.
RPMSG_NS_ADDR as source address make sense as we want to send a message
belonging to the NS announcement service and the created ept address is
already in the message payload.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 drivers/rpmsg/rpmsg_internal.h |  3 +++
 drivers/rpmsg/rpmsg_ns.c       | 39 ++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/drivers/rpmsg/rpmsg_internal.h b/drivers/rpmsg/rpmsg_internal.h
index 641b48f6bf2a..d1549e5cb607 100644
--- a/drivers/rpmsg/rpmsg_internal.h
+++ b/drivers/rpmsg/rpmsg_internal.h
@@ -119,4 +119,7 @@ static inline int rpmsg_ns_register_device(struct rpmsg_device *rpdev)
 	return rpmsg_register_device(rpdev);
 }
 
+int rpmsg_ns_announce_create(struct rpmsg_device *rpdev);
+int rpmsg_ns_announce_destroy(struct rpmsg_device *rpdev);
+
 #endif
diff --git a/drivers/rpmsg/rpmsg_ns.c b/drivers/rpmsg/rpmsg_ns.c
index 3c929b6976a6..2a34e36a592d 100644
--- a/drivers/rpmsg/rpmsg_ns.c
+++ b/drivers/rpmsg/rpmsg_ns.c
@@ -37,6 +37,45 @@ struct rpmsg_ns_msg {
 	__le32 flags;
 } __packed;
 
+/**
+ * rpmsg_ns_announce_create() - announce to the remote processor
+ * the service creation or destruction
+ * @rpdev: the rpmsg channel
+ * @ns_flag: related to the @rpmsg_ns_flags enum
+ *
+ * This function can be called on a channel creation or destruction to inform
+ * the remote processor, using the reserved name service anouncement channel.
+ */
+static int rpmsg_ns_channel_announce(struct rpmsg_device *rpdev, int ns_flag)
+{
+	struct rpmsg_ns_msg nsm;
+
+	if (!rpdev->announce || !rpdev->ept)
+		return 0;
+
+	if (ns_flag != RPMSG_NS_CREATE && ns_flag != RPMSG_NS_DESTROY)
+		return -EINVAL;
+
+	strncpy(nsm.name, rpdev->id.name, RPMSG_NAME_SIZE);
+	nsm.addr = cpu_to_le32(rpdev->ept->addr);
+	nsm.flags = cpu_to_le32(ns_flag);
+
+	return rpmsg_send_offchannel(rpdev->ept, RPMSG_NS_ADDR, RPMSG_NS_ADDR,
+				     &nsm, sizeof(nsm));
+}
+
+int rpmsg_ns_announce_create(struct rpmsg_device *rpdev)
+{
+	return rpmsg_ns_channel_announce(rpdev, RPMSG_NS_CREATE);
+}
+EXPORT_SYMBOL(rpmsg_ns_announce_create);
+
+int rpmsg_ns_announce_destroy(struct rpmsg_device *rpdev)
+{
+	return rpmsg_ns_channel_announce(rpdev, RPMSG_NS_DESTROY);
+}
+EXPORT_SYMBOL(rpmsg_ns_announce_destroy);
+
 /* Invoked when a name service announcement arrives */
 static int rpmsg_ns_cb(struct rpmsg_device *rpdev, void *data, int len,
 		       void *priv, u32 src)
-- 
2.17.1

