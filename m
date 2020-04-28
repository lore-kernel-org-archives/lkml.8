Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE8A3C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 13:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B222206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 13:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbgD1NtM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 09:49:12 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41056 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726798AbgD1NtM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 09:49:12 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1C32781411DE4945C840;
        Tue, 28 Apr 2020 21:49:09 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Tue, 28 Apr 2020 21:49:02 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] stm class: dummy_stm: fix error return code in dummy_stm_init()
Date:   Tue, 28 Apr 2020 13:50:19 +0000
Message-ID: <20200428135019.78920-1-weiyongjun1@huawei.com>
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
 drivers/hwtracing/stm/dummy_stm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/stm/dummy_stm.c b/drivers/hwtracing/stm/dummy_stm.c
index 38528ffdc0b3..36d32e7afb35 100644
--- a/drivers/hwtracing/stm/dummy_stm.c
+++ b/drivers/hwtracing/stm/dummy_stm.c
@@ -68,7 +68,7 @@ static int dummy_stm_link(struct stm_data *data, unsigned int master,
 
 static int dummy_stm_init(void)
 {
-	int i, ret = -ENOMEM;
+	int i, ret;
 
 	if (nr_dummies < 0 || nr_dummies > DUMMY_STM_MAX)
 		return -EINVAL;
@@ -80,8 +80,10 @@ static int dummy_stm_init(void)
 
 	for (i = 0; i < nr_dummies; i++) {
 		dummy_stm[i].name = kasprintf(GFP_KERNEL, "dummy_stm.%d", i);
-		if (!dummy_stm[i].name)
+		if (!dummy_stm[i].name) {
+			ret = -ENOMEM;
 			goto fail_unregister;
+		}
 
 		dummy_stm[i].sw_start		= master_min;
 		dummy_stm[i].sw_end		= master_max;



