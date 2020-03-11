Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F7CEC10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 10:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36C2E2192A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 10:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="VZldWqjd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729192AbgCKKyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 06:54:50 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:38714 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726713AbgCKKyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 06:54:47 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02BAmlmO007361;
        Wed, 11 Mar 2020 11:54:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=68gVoIOTswhoH9BzUdkH5JXWP+gK2iB9fVzO3ctGbkg=;
 b=VZldWqjd/M5NEwmJVC5vMLbr9ueqSyHbRsfKQdSB9cqbE3swERLeKjcDNUXhgVwCYvAm
 5YMvTPtKGPbiVZvn4qec7e4o77nLY4drf+PHtlmLxqAJaZu3IhidJiB1OUNB0VIHQkuC
 rBlGE+qEmKIyZbHDXF6MbVryrprBodxRLhrs4oqwWiZRh/KXkE3mdvc9ytA3uWlXfBws
 RQvK0dRzLHwS2HwljkZmALmflzzCxTcVe9xvACaHUGNRNmGfaDm3tnEOy1pId7CuO/H6
 WN1XkQ17AsJyPA1ZnRY003XQ+eXfWspKJouyQmdH89NyM+9jZQuLOGt30LsJ/HTW54yF Ug== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2ynecdgshm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Mar 2020 11:54:43 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6B27E10002A;
        Wed, 11 Mar 2020 11:54:38 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag7node2.st.com [10.75.127.20])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5C96E2A543D;
        Wed, 11 Mar 2020 11:54:38 +0100 (CET)
Received: from localhost (10.75.127.46) by SFHDAG7NODE2.st.com (10.75.127.20)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 11 Mar 2020 11:54:37
 +0100
From:   Loic Pallardy <loic.pallardy@st.com>
To:     <bjorn.andersson@linaro.org>, <ohad@wizery.com>,
        <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <arnaud.pouliquen@st.com>, <benjamin.gaignard@linaro.org>,
        <fabien.dessenne@st.com>, <s-anna@ti.com>,
        Loic Pallardy <loic.pallardy@st.com>
Subject: [RFC 1/2] remoteproc: sysfs: authorize rproc shutdown when rproc is crashed
Date:   Wed, 11 Mar 2020 11:54:31 +0100
Message-ID: <1583924072-20648-2-git-send-email-loic.pallardy@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583924072-20648-1-git-send-email-loic.pallardy@st.com>
References: <1583924072-20648-1-git-send-email-loic.pallardy@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG7NODE3.st.com (10.75.127.21) To SFHDAG7NODE2.st.com
 (10.75.127.20)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-11_04:2020-03-11,2020-03-11 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When remoteproc recovery is disabled and rproc crashed, user space
client has no way to reboot co-processor except by a complete platform
reboot.
Indeed rproc_shutdown() is called by sysfs state_store() only is rproc
state is RPROC_RUNNING.

This patch offers the possibility to shutdown the co-processor if
it is in RPROC_CRASHED state and so to restart properly co-processor
from sysfs interface.

Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
---
 drivers/remoteproc/remoteproc_core.c  | 2 +-
 drivers/remoteproc/remoteproc_sysfs.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 097f33e4f1f3..7ac87a75cd1b 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1812,7 +1812,7 @@ void rproc_shutdown(struct rproc *rproc)
 	if (!atomic_dec_and_test(&rproc->power))
 		goto out;
 
-	ret = rproc_stop(rproc, false);
+	ret = rproc_stop(rproc, rproc->state == RPROC_CRASHED);
 	if (ret) {
 		atomic_inc(&rproc->power);
 		goto out;
diff --git a/drivers/remoteproc/remoteproc_sysfs.c b/drivers/remoteproc/remoteproc_sysfs.c
index 7f8536b73295..1029458a4678 100644
--- a/drivers/remoteproc/remoteproc_sysfs.c
+++ b/drivers/remoteproc/remoteproc_sysfs.c
@@ -101,7 +101,7 @@ static ssize_t state_store(struct device *dev,
 		if (ret)
 			dev_err(&rproc->dev, "Boot failed: %d\n", ret);
 	} else if (sysfs_streq(buf, "stop")) {
-		if (rproc->state != RPROC_RUNNING)
+		if (rproc->state != RPROC_RUNNING && rproc->state != RPROC_CRASHED)
 			return -EINVAL;
 
 		rproc_shutdown(rproc);
-- 
2.7.4

