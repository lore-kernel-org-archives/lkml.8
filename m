Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089F9C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 23:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D73D92076D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 23:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="JXClyfV5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbgGPXLK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 19:11:10 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:47433 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726205AbgGPXLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 19:11:10 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594941069; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=pCo9IyWGzz5InIzoYekTI4bxA69hoCf7jB3CN8mY28M=; b=JXClyfV5oqoDAw1m6YbbE7Yk7NA9aLiZACPIxH36Db4YPEyv792ekXW5dUR9T2phoaA1GcEs
 UcQKFsxVrvNgs6eiN1SzBVrpJD+UsNiTwxqmkl98vOPyTogQYTct4Z9AlT2aLSJtqLtP+bsE
 NGRMiuQZBa8bZBlGvWKcDF57e4A=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n13.prod.us-east-1.postgun.com with SMTP id
 5f10d31ee3bee12510dab031 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 16 Jul 2020 22:22:22
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8653DC433A0; Thu, 16 Jul 2020 22:22:21 +0000 (UTC)
Received: from rishabhb-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rishabhb)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 93D3CC4339C;
        Thu, 16 Jul 2020 22:22:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 93D3CC4339C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rishabhb@codeaurora.org
From:   Rishabh Bhatnagar <rishabhb@codeaurora.org>
To:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        sibis@codearora.org, tsoni@codeaurora.org, psodagud@codeaurora.org,
        sidgup@codeaurora.org, Sibi Sankar <sibis@codeaurora.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>
Subject: [PATCH v8 2/5] remoteproc: qcom_q6v5_mss: Replace mask based tracking with size
Date:   Thu, 16 Jul 2020 15:20:32 -0700
Message-Id: <1594938035-7327-3-git-send-email-rishabhb@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594938035-7327-1-git-send-email-rishabhb@codeaurora.org>
References: <1594938035-7327-1-git-send-email-rishabhb@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sibi Sankar <sibis@codeaurora.org>

In order to land inline coredump support for mss, the dump_segment
function would need to support granularities less than the segment
size. This is achieved by replacing mask based tracking with size.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
---
 drivers/remoteproc/qcom_q6v5_mss.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
index feb70283b..037cd45 100644
--- a/drivers/remoteproc/qcom_q6v5_mss.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -181,8 +181,8 @@ struct q6v5 {
 	bool running;
 
 	bool dump_mba_loaded;
-	unsigned long dump_segment_mask;
-	unsigned long dump_complete_mask;
+	size_t current_dump_size;
+	size_t total_dump_size;
 
 	phys_addr_t mba_phys;
 	void *mba_region;
@@ -1203,7 +1203,6 @@ static void qcom_q6v5_dump_segment(struct rproc *rproc,
 {
 	int ret = 0;
 	struct q6v5 *qproc = rproc->priv;
-	unsigned long mask = BIT((unsigned long)segment->priv);
 	int offset = segment->da - qproc->mpss_reloc;
 	void *ptr = NULL;
 
@@ -1229,10 +1228,10 @@ static void qcom_q6v5_dump_segment(struct rproc *rproc,
 		memset(dest, 0xff, segment->size);
 	}
 
-	qproc->dump_segment_mask |= mask;
+	qproc->current_dump_size += segment->size;
 
 	/* Reclaim mba after copying segments */
-	if (qproc->dump_segment_mask == qproc->dump_complete_mask) {
+	if (qproc->current_dump_size == qproc->total_dump_size) {
 		if (qproc->dump_mba_loaded) {
 			/* Try to reset ownership back to Q6 */
 			q6v5_xfer_mem_ownership(qproc, &qproc->mpss_perm,
@@ -1274,7 +1273,7 @@ static int q6v5_start(struct rproc *rproc)
 			"Failed to reclaim mba buffer system may become unstable\n");
 
 	/* Reset Dump Segment Mask */
-	qproc->dump_segment_mask = 0;
+	qproc->current_dump_size = 0;
 	qproc->running = true;
 
 	return 0;
@@ -1323,7 +1322,7 @@ static int qcom_q6v5_register_dump_segments(struct rproc *rproc,
 
 	ehdr = (struct elf32_hdr *)fw->data;
 	phdrs = (struct elf32_phdr *)(ehdr + 1);
-	qproc->dump_complete_mask = 0;
+	qproc->total_dump_size = 0;
 
 	for (i = 0; i < ehdr->e_phnum; i++) {
 		phdr = &phdrs[i];
@@ -1334,11 +1333,11 @@ static int qcom_q6v5_register_dump_segments(struct rproc *rproc,
 		ret = rproc_coredump_add_custom_segment(rproc, phdr->p_paddr,
 							phdr->p_memsz,
 							qcom_q6v5_dump_segment,
-							(void *)i);
+							NULL);
 		if (ret)
 			break;
 
-		qproc->dump_complete_mask |= BIT(i);
+		qproc->total_dump_size += phdr->p_memsz;
 	}
 
 	release_firmware(fw);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

