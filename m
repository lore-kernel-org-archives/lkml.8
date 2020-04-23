Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26CEC2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 07:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8A0921569
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 07:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbgDWHPz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 03:15:55 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41420 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727028AbgDWHPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 03:15:54 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 50CC9EBCA0F13E12BD17;
        Thu, 23 Apr 2020 15:15:49 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Thu, 23 Apr 2020 15:15:39 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <rjw@rjwysocki.net>, <lenb@kernel.org>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] ACPI / CPPC: Make some symbols static
Date:   Thu, 23 Apr 2020 15:21:58 +0800
Message-ID: <1587626518-97669-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following sparse warnings:

drivers/acpi/cppc_acpi.c:353:20: warning: symbol 'cppc_mbox_cl' was not declared. Should it be static?
drivers/acpi/cppc_acpi.c:600:5: warning: symbol 'pcc_data_alloc' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/acpi/cppc_acpi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 8b2e89c..f818400 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -350,7 +350,7 @@ static void cppc_chan_tx_done(struct mbox_client *cl, void *msg, int ret)
 				*(u16 *)msg, ret);
 }
 
-struct mbox_client cppc_mbox_cl = {
+static struct mbox_client cppc_mbox_cl = {
 	.tx_done = cppc_chan_tx_done,
 	.knows_txdone = true,
 };
@@ -597,7 +597,7 @@ bool __weak cpc_ffh_supported(void)
  *
  * Return: 0 for success, errno for failure
  */
-int pcc_data_alloc(int pcc_ss_id)
+static int pcc_data_alloc(int pcc_ss_id)
 {
 	if (pcc_ss_id < 0 || pcc_ss_id >= MAX_PCC_SUBSPACES)
 		return -EINVAL;
-- 
2.6.2

