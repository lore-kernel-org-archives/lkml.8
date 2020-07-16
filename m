Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEEBAC433E8
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 23:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97434212CC
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 23:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="lFIrTj1w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbgGPXIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 19:08:53 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:43189 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbgGPXIu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 19:08:50 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594940930; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=48pheG6DAtrlIvf3tL1tLzrFDusskcmsxUCA7Ou9opQ=; b=lFIrTj1wkVSqHe86gKCgkxMTUH/aRz5VKzvnxJWNbMHXnZ+YHW9uDcIkunD/oCxGlT3SqhDe
 kbF6PgbiLC5DY5dF1sLp9/hsqYmOtpsLv6zrgHhPrUaAxlHPrKP4TlXB7n8SN1DgStohC0vh
 1lBh6pYE+hQFtTILHGXclvOYslY=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 5f10d31f7c8ca473a84dbc78 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 16 Jul 2020 22:22:23
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 893EEC433C9; Thu, 16 Jul 2020 22:22:22 +0000 (UTC)
Received: from rishabhb-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rishabhb)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 31897C433AD;
        Thu, 16 Jul 2020 22:22:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 31897C433AD
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rishabhb@codeaurora.org
From:   Rishabh Bhatnagar <rishabhb@codeaurora.org>
To:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        sibis@codearora.org, tsoni@codeaurora.org, psodagud@codeaurora.org,
        sidgup@codeaurora.org, Rishabh Bhatnagar <rishabhb@codeaurora.org>
Subject: [PATCH v8 3/5] remoteproc: Pass size and offset as arguments to segment dump function
Date:   Thu, 16 Jul 2020 15:20:33 -0700
Message-Id: <1594938035-7327-4-git-send-email-rishabhb@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594938035-7327-1-git-send-email-rishabhb@codeaurora.org>
References: <1594938035-7327-1-git-send-email-rishabhb@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the segment dump API signature to include size and offset
arguments. Refactor the qcom_q6v5_mss driver to use these
arguments while copying the segment. Doing this lays the ground
work for "inline" coredump functionality being added in the next
patch.

Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
---
 drivers/remoteproc/qcom_q6v5_mss.c       | 10 +++++-----
 drivers/remoteproc/remoteproc_coredump.c |  5 +++--
 include/linux/remoteproc.h               |  5 +++--
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
index 037cd45..6baa3ae 100644
--- a/drivers/remoteproc/qcom_q6v5_mss.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -1199,7 +1199,7 @@ static int q6v5_mpss_load(struct q6v5 *qproc)
 
 static void qcom_q6v5_dump_segment(struct rproc *rproc,
 				   struct rproc_dump_segment *segment,
-				   void *dest)
+				   void *dest, size_t cp_offset, size_t size)
 {
 	int ret = 0;
 	struct q6v5 *qproc = rproc->priv;
@@ -1219,16 +1219,16 @@ static void qcom_q6v5_dump_segment(struct rproc *rproc,
 	}
 
 	if (!ret)
-		ptr = ioremap_wc(qproc->mpss_phys + offset, segment->size);
+		ptr = ioremap_wc(qproc->mpss_phys + offset + cp_offset, size);
 
 	if (ptr) {
-		memcpy(dest, ptr, segment->size);
+		memcpy(dest, ptr, size);
 		iounmap(ptr);
 	} else {
-		memset(dest, 0xff, segment->size);
+		memset(dest, 0xff, size);
 	}
 
-	qproc->current_dump_size += segment->size;
+	qproc->current_dump_size += size;
 
 	/* Reclaim mba after copying segments */
 	if (qproc->current_dump_size == qproc->total_dump_size) {
diff --git a/drivers/remoteproc/remoteproc_coredump.c b/drivers/remoteproc/remoteproc_coredump.c
index ded0244..390f563 100644
--- a/drivers/remoteproc/remoteproc_coredump.c
+++ b/drivers/remoteproc/remoteproc_coredump.c
@@ -72,7 +72,8 @@ int rproc_coredump_add_custom_segment(struct rproc *rproc,
 				      dma_addr_t da, size_t size,
 				      void (*dumpfn)(struct rproc *rproc,
 						     struct rproc_dump_segment *segment,
-						     void *dest),
+						     void *dest, size_t offset,
+						     size_t size),
 				      void *priv)
 {
 	struct rproc_dump_segment *segment;
@@ -183,7 +184,7 @@ void rproc_coredump(struct rproc *rproc)
 		elf_phdr_set_p_align(class, phdr, 0);
 
 		if (segment->dump) {
-			segment->dump(rproc, segment, data + offset);
+			segment->dump(rproc, segment, data + offset, 0, segment->size);
 		} else {
 			ptr = rproc_da_to_va(rproc, segment->da, segment->size);
 			if (!ptr) {
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index e7b7bab..eb08139 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -451,7 +451,7 @@ struct rproc_dump_segment {
 
 	void *priv;
 	void (*dump)(struct rproc *rproc, struct rproc_dump_segment *segment,
-		     void *dest);
+		     void *dest, size_t offset, size_t size);
 	loff_t offset;
 };
 
@@ -630,7 +630,8 @@ int rproc_coredump_add_custom_segment(struct rproc *rproc,
 				      dma_addr_t da, size_t size,
 				      void (*dumpfn)(struct rproc *rproc,
 						     struct rproc_dump_segment *segment,
-						     void *dest),
+						     void *dest, size_t offset,
+						     size_t size),
 				      void *priv);
 int rproc_coredump_set_elf_info(struct rproc *rproc, u8 class, u16 machine);
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

