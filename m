Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692EDC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47B942223E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:15:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="S5BoDHi7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1414600AbgDPQPu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 12:15:50 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:4048 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2410725AbgDPQOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 12:14:16 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03GGDXZ9026476;
        Thu, 16 Apr 2020 18:14:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=KXRIrH9Ae0pX/k70Vo3qC2ZlR604P+0OK1B0a7N8Gos=;
 b=S5BoDHi7XiofvM6AZHQ0HGIgOEuixNf2v4oh9upneAfUoeFvzUulh1c15J+1ON3QS7/e
 K77ud9wrpRUtOauhZZqYIXVCwTIHEg46jKUsBrdazCY0B+wvutPL3nsyfRZuigiLlHIp
 YNzp2q/iY5jC0rc4dn8Se9Pq/OqHTUcghhjWjjUGFTgYCHlH/W4mtNRWhZ1jVH/1jBpT
 OYdMIa6qrp7NLRdEZaOExZz8NGgvk8LpC/4H/ZccDUvIn+r5Pvf8qr8DsYBps7RM/Nfn
 LjFj7qK6X8v+0oCGFv9ECFVIPxtbmBF3d+DQ5Sav8TFu+wTw35amzhbrxQdHzH/oQDaJ yA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30dn8s3kma-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Apr 2020 18:14:12 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id ECA4A10002A;
        Thu, 16 Apr 2020 18:14:11 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id DDD2F2B2D2A;
        Thu, 16 Apr 2020 18:14:11 +0200 (CEST)
Received: from localhost (10.75.127.44) by SFHDAG3NODE1.st.com (10.75.127.7)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 16 Apr 2020 18:14:11
 +0200
From:   Arnaud Pouliquen <arnaud.pouliquen@st.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <arnaud.pouliquen@st.com>
Subject: [RFC 04/18] remoteproc: Add rproc_get_by_node helper
Date:   Thu, 16 Apr 2020 18:13:17 +0200
Message-ID: <20200416161331.7606-5-arnaud.pouliquen@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200416161331.7606-1-arnaud.pouliquen@st.com>
References: <20200416161331.7606-1-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG7NODE1.st.com (10.75.127.19) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-16_06:2020-04-14,2020-04-16 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow to retrieve the rproc structure from a rproc platform
child declared in the device tree.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 drivers/remoteproc/remoteproc_core.c | 14 ++++++--------
 include/linux/remoteproc.h           |  7 ++++++-
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 4fcd685cbfd8..32056449bb72 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1739,10 +1739,10 @@ void rproc_shutdown(struct rproc *rproc)
 EXPORT_SYMBOL(rproc_shutdown);
 
 /**
- * rproc_get_by_phandle() - find a remote processor by phandle
- * @phandle: phandle to the rproc
+ * rproc_get_by_node() - find a remote processor by device node
+ * @np: device tree node
  *
- * Finds an rproc handle using the remote processor's phandle, and then
+ * Finds an rproc handle using the remote processor's node, and then
  * return a handle to the rproc.
  *
  * This function increments the remote processor's refcount, so always
@@ -1751,12 +1751,10 @@ EXPORT_SYMBOL(rproc_shutdown);
  * Returns the rproc handle on success, and NULL on failure.
  */
 #ifdef CONFIG_OF
-struct rproc *rproc_get_by_phandle(phandle phandle)
+struct rproc *rproc_get_by_node(struct device_node *np)
 {
 	struct rproc *rproc = NULL, *r;
-	struct device_node *np;
 
-	np = of_find_node_by_phandle(phandle);
 	if (!np)
 		return NULL;
 
@@ -1781,12 +1779,12 @@ struct rproc *rproc_get_by_phandle(phandle phandle)
 	return rproc;
 }
 #else
-struct rproc *rproc_get_by_phandle(phandle phandle)
+struct rproc *rproc_get_by_node(struct device_node *np)
 {
 	return NULL;
 }
 #endif
-EXPORT_SYMBOL(rproc_get_by_phandle);
+EXPORT_SYMBOL(rproc_get_by_node);
 
 /**
  * rproc_add() - register a remote processor
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index a78e28bda962..ab9762563ae0 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -586,9 +586,14 @@ struct rproc_vdev {
 	u32 index;
 };
 
-struct rproc *rproc_get_by_phandle(phandle phandle);
+struct rproc *rproc_get_by_node(struct device_node *np);
 struct rproc *rproc_get_by_child(struct device *dev);
 
+static inline struct rproc *rproc_get_by_phandle(phandle phandle)
+{
+	return rproc_get_by_node(of_find_node_by_phandle(phandle));
+}
+
 struct rproc *rproc_alloc(struct device *dev, const char *name,
 			  const struct rproc_ops *ops,
 			  const char *firmware, int len);
-- 
2.17.1

