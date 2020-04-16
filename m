Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAFA0C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F1F520771
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="kNxtSLkd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896498AbgDPQPe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 12:15:34 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:3988 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2636453AbgDPQOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 12:14:25 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03GGDTiP026461;
        Thu, 16 Apr 2020 18:14:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=agyR1ppdr+Eyr30Bf9LkTx+EimYHLQAtT1Py/m/yieE=;
 b=kNxtSLkdGTEkqabTVTr5xwwiOvFr+CK5GzI6NE+TzQjco7oxDNSYUm5VXulS8bF/LNYJ
 g71gQNxe998zXeac1aIvkW9oqiwoYMXVPtEmlIyCMMTBg73xSfQIXcCaD4esXa0ECkaV
 x3ejaRAQfE6LLlfl7kW6JNXUG5mVk53S1YLDG+/Io8hQqigBqIQcoTRqyaixOpY4IDta
 DoWumD8KCW82WtkgSBkF4fSrTdHEKT2XDRCXHB7mFHTiq9R9G0THZ5C7f5LZIxmhOEKc
 unIbGqS3cuPKhuZoJ4bHG+pxSexDEALtYE4EoEbchvoxZTi7/ZeufaSo1+RMr8gEC6M0 KA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30dn8s3kn4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Apr 2020 18:14:21 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3C2F410002A;
        Thu, 16 Apr 2020 18:14:21 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2C9A12B2D2A;
        Thu, 16 Apr 2020 18:14:21 +0200 (CEST)
Received: from localhost (10.75.127.46) by SFHDAG3NODE1.st.com (10.75.127.7)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 16 Apr 2020 18:14:20
 +0200
From:   Arnaud Pouliquen <arnaud.pouliquen@st.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <arnaud.pouliquen@st.com>
Subject: [RFC 10/18] remoteproc: Add capability to populate rproc subnode devices
Date:   Thu, 16 Apr 2020 18:13:23 +0200
Message-ID: <20200416161331.7606-11-arnaud.pouliquen@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200416161331.7606-1-arnaud.pouliquen@st.com>
References: <20200416161331.7606-1-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG6NODE2.st.com (10.75.127.17) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-16_06:2020-04-14,2020-04-16 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the capability to add rproc sub nodes in device tree.
Devices declared as rproc sub node will be probed
before the remote firmware boot sequence.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 drivers/remoteproc/remoteproc_core.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index c9e07c53ed0c..75f84fd3bd60 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1605,6 +1605,26 @@ static void rproc_crash_handler_work(struct work_struct *work)
 		rproc_trigger_recovery(rproc);
 }
 
+static int rproc_platform_populate(struct rproc *rproc)
+{
+	struct device *dev = rproc->dev.parent;
+	int ret;
+
+	ret = of_platform_populate(dev->of_node, NULL, NULL, dev);
+	if (ret < 0) {
+		dev_err(dev, "failed to populate child devices (%d)\n", ret);
+
+		goto depopulate;
+	}
+
+	return 0;
+
+depopulate:
+	of_platform_depopulate(dev);
+
+	return ret;
+}
+
 /**
  * rproc_boot() - boot a remote processor
  * @rproc: handle of a remote processor
@@ -1629,6 +1649,10 @@ int rproc_boot(struct rproc *rproc)
 
 	dev = &rproc->dev;
 
+	ret = rproc_platform_populate(rproc);
+	if (ret)
+		return ret;
+
 	ret = mutex_lock_interruptible(&rproc->lock);
 	if (ret) {
 		dev_err(dev, "can't lock rproc %s: %d\n", rproc->name, ret);
@@ -1735,6 +1759,7 @@ void rproc_shutdown(struct rproc *rproc)
 	rproc->table_ptr = NULL;
 out:
 	mutex_unlock(&rproc->lock);
+	of_platform_depopulate(rproc->dev.parent);
 }
 EXPORT_SYMBOL(rproc_shutdown);
 
-- 
2.17.1

