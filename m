Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE48C83001
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 13:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76D60208FE
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 13:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgD1Nrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 09:47:53 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3327 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726798AbgD1Nrw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 09:47:52 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5AB36E1E74B4ADC021EB;
        Tue, 28 Apr 2020 21:47:49 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Tue, 28 Apr 2020 21:47:39 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] stm class: stm_heartbeat: fix error return code
Date:   Tue, 28 Apr 2020 13:48:55 +0000
Message-ID: <20200428134855.78014-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix to return error code -ENOMEM from the error handling case instead
of 0(ret can be overwritted to 0 in for loop).

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/hwtracing/stm/heartbeat.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/stm/heartbeat.c b/drivers/hwtracing/stm/heartbeat.c
index 3e7df1c0477f..81d7b21d31ec 100644
--- a/drivers/hwtracing/stm/heartbeat.c
+++ b/drivers/hwtracing/stm/heartbeat.c
@@ -64,7 +64,7 @@ static void stm_heartbeat_unlink(struct stm_source_data *data)
 
 static int stm_heartbeat_init(void)
 {
-	int i, ret = -ENOMEM;
+	int i, ret;
 
 	if (nr_devs < 0 || nr_devs > STM_HEARTBEAT_MAX)
 		return -EINVAL;
@@ -72,8 +72,10 @@ static int stm_heartbeat_init(void)
 	for (i = 0; i < nr_devs; i++) {
 		stm_heartbeat[i].data.name =
 			kasprintf(GFP_KERNEL, "heartbeat.%d", i);
-		if (!stm_heartbeat[i].data.name)
+		if (!stm_heartbeat[i].data.name) {
+			ret = -ENOMEM;
 			goto fail_unregister;
+		}
 
 		stm_heartbeat[i].data.nr_chans	= 1;
 		stm_heartbeat[i].data.link	= stm_heartbeat_link;





