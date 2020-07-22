Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38DE8C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 09:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EDF720714
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 09:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731669AbgGVJrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 05:47:35 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8351 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730142AbgGVJre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 05:47:34 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E06B03B132C9DC4F16B9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 17:47:30 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Wed, 22 Jul 2020 17:47:23 +0800
From:   Hanjun Guo <guohanjun@huawei.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH] mailbox: pcc: Put the PCCT table for error path
Date:   Wed, 22 Jul 2020 17:40:40 +0800
Message-ID: <1595410840-15231-1-git-send-email-guohanjun@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The acpi_get_table() should be coupled with acpi_put_table() if
the mapped table is not used at runtime to release the table
mapping.

In acpi_pcc_probe(), the PCCT table entries will be used as private
data for communication chan at runtime, but the table should be put
for error path.

Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
---
 drivers/mailbox/pcc.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 8c7fac3..ef9ecd1 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -457,14 +457,17 @@ static int __init acpi_pcc_probe(void)
 			pr_warn("Error parsing PCC subspaces from PCCT\n");
 		else
 			pr_warn("Invalid PCCT: %d PCC subspaces\n", count);
-		return -EINVAL;
+
+		rc = -EINVAL;
+		goto err_put_pcct;
 	}
 
 	pcc_mbox_channels = kcalloc(count, sizeof(struct mbox_chan),
 				    GFP_KERNEL);
 	if (!pcc_mbox_channels) {
 		pr_err("Could not allocate space for PCC mbox channels\n");
-		return -ENOMEM;
+		rc = -ENOMEM;
+		goto err_put_pcct;
 	}
 
 	pcc_doorbell_vaddr = kcalloc(count, sizeof(void *), GFP_KERNEL);
@@ -535,6 +538,8 @@ static int __init acpi_pcc_probe(void)
 	kfree(pcc_doorbell_vaddr);
 err_free_mbox:
 	kfree(pcc_mbox_channels);
+err_put_pcct:
+	acpi_put_table(pcct_tbl);
 	return rc;
 }
 
-- 
1.7.12.4

