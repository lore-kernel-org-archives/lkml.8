Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C04A2C3F2C6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 10:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98B8121655
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 10:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="oeNThnRe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729183AbgCKKyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 06:54:47 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:10342 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729056AbgCKKyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 06:54:47 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02BAmM0s020922;
        Wed, 11 Mar 2020 11:54:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=3cvGCt8bpqbB/LxrpYqHti3FK8Z4pnOI3/BaTMIW+tU=;
 b=oeNThnReaSNTfbbFhxUuGXeiiVjbv1FeEB/UdRUcWBiu7l6L2zGuLvG4icO8IiJUlGP/
 G4oBk4lznjcYQQtIWjkWHKr4da51Iiu70YfUkKstYgNElnKfXV/hoqGWY2pDWgV4XmVD
 J7e7eIjVA7suRAnsm/7dDt4vdIagTm4mOaXCaTaIpbaEoh4qC5wj1slnWZlp5hVW5KVe
 orzBQBILuOujZp2jt9Jvf1awJYNOEyGHBBvBRPTF11TUAcnqwOBORsEMDoTE2v3XEyOs
 /+wizsNZ5CJ3A3/4bMWeIC74kkrDIW8pRk+uOWi/M+zA33DgjnQRsKIWiLGNtfGdRqXU vA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2ym1mh29p6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Mar 2020 11:54:43 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 302C110003D;
        Wed, 11 Mar 2020 11:54:39 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag7node2.st.com [10.75.127.20])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 25EDB2A543D;
        Wed, 11 Mar 2020 11:54:39 +0100 (CET)
Received: from localhost (10.75.127.48) by SFHDAG7NODE2.st.com (10.75.127.20)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 11 Mar 2020 11:54:38
 +0100
From:   Loic Pallardy <loic.pallardy@st.com>
To:     <bjorn.andersson@linaro.org>, <ohad@wizery.com>,
        <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <arnaud.pouliquen@st.com>, <benjamin.gaignard@linaro.org>,
        <fabien.dessenne@st.com>, <s-anna@ti.com>,
        Loic Pallardy <loic.pallardy@st.com>
Subject: [RFC 2/2] remoteproc: core: keep rproc in crash state in case of recovery failure
Date:   Wed, 11 Mar 2020 11:54:32 +0100
Message-ID: <1583924072-20648-3-git-send-email-loic.pallardy@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583924072-20648-1-git-send-email-loic.pallardy@st.com>
References: <1583924072-20648-1-git-send-email-loic.pallardy@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG6NODE1.st.com (10.75.127.16) To SFHDAG7NODE2.st.com
 (10.75.127.20)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-11_04:2020-03-11,2020-03-11 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When an error occurs during recovery procedure, internal rproc
variables may be unaligned:
- state is set to RPROC_OFFLINE
- power atomic not equal to 0
which is normal as only rproc_stop() has been executed and not
rproc_shutdown()

In such case, rproc_boot() can be re-executed by client to
reboot co-processor.

This patch proposes to keep rproc in RPROC_CRASHED state in case
of recovery failure to be coherent with recovery disabled mode.

Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
---
 drivers/remoteproc/remoteproc_core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 7ac87a75cd1b..def4f9fc881d 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1679,6 +1679,12 @@ int rproc_trigger_recovery(struct rproc *rproc)
 	release_firmware(firmware_p);
 
 unlock_mutex:
+	/*
+	 * In case of error during recovery sequence restore rproc
+	 * state in CRASHED
+	 */
+	if (ret)
+		rproc->state = RPROC_CRASHED;
 	mutex_unlock(&rproc->lock);
 	return ret;
 }
-- 
2.7.4

