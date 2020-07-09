Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B84B5C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 20:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D3E4206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 20:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="u/NVIzGy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgGIUcN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 16:32:13 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:44440 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726183AbgGIUcL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 16:32:11 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594326730; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=y9AFQoYip2XeCXFE+gS+geLi4ZnXO6Utr/vSQ5yoJVs=; b=u/NVIzGykgKKrnaamZwMXzOSSAQrZx8KgZlEyevfGGG4tYTyKrvjXGx++Dtbq/HqA9KgWaU4
 YvVZzfdJXgm43WOSZoqnIIvGRNNiIb0L5oZQ1PWkb6hvJu62YtbwE+LWOJRgsPu+fd3sOnkr
 Zx/0g52+KFOePLn8Y1QK6phijNc=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5f077ec871d7ca1d3a52763b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 09 Jul 2020 20:32:08
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 35785C433C8; Thu,  9 Jul 2020 20:32:08 +0000 (UTC)
Received: from rishabhb-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rishabhb)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4ECADC433C6;
        Thu,  9 Jul 2020 20:32:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4ECADC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rishabhb@codeaurora.org
From:   Rishabh Bhatnagar <rishabhb@codeaurora.org>
To:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        tsoni@codeaurora.org, psodagud@codeaurora.org,
        sidgup@codeaurora.org, Sibi Sankar <sibis@codeaurora.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>
Subject: [PATCH v1 2/4] remoteproc: qcom_q6v5_mss: Replace mask based tracking with size
Date:   Thu,  9 Jul 2020 13:31:54 -0700
Message-Id: <1594326716-15474-3-git-send-email-rishabhb@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594326716-15474-1-git-send-email-rishabhb@codeaurora.org>
References: <1594326716-15474-1-git-send-email-rishabhb@codeaurora.org>
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
 drivers/remoteproc/qcom_q6v5_mss.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
index feb70283b..c6ce032 100644
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
@@ -1338,7 +1337,7 @@ static int qcom_q6v5_register_dump_segments(struct rproc *rproc,
 		if (ret)
 			break;
 
-		qproc->dump_complete_mask |= BIT(i);
+		qproc->total_dump_size += phdr->p_memsz;
 	}
 
 	release_firmware(fw);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

