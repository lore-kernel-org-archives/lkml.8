Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97249C2BB85
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 23:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E4792074F
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 23:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="Pgwmf13c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbgDIXeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 19:34:03 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:17068 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726924AbgDIXeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 19:34:02 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586475242; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=LoEYHxHjJumMLwAkE0oLJJVPZMxtLaW944wQD+0R1kg=; b=Pgwmf13c5eEySOTYUnO0SmqMiY6MWW+oJzqGELM8oMP2ldkEU9ecH6oN62bE+x4NdB6MMfR8
 v0iLNsk6LVvFPqAL5v/sM6HYfdR9ihMfkPNQjlQOjXbCnqm1lvWdAv/RasQRiyL1lmVQcMGr
 9kAqZm0Al/V5z5YZ83h1xJK/3ng=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e8fb0ea.7f8ac2394dc0-smtp-out-n03;
 Thu, 09 Apr 2020 23:34:02 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6D06EC072B7; Thu,  9 Apr 2020 23:33:58 +0000 (UTC)
Received: from localhost.localdomain (c-71-237-101-98.hsd1.co.comcast.net [71.237.101.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 60A7FC433CB;
        Thu,  9 Apr 2020 23:33:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 60A7FC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     iommu@lists.linux-foundation.org
Cc:     linux-arm-msm@vger.kernel.org, robin.murphy@arm.com,
        will@kernel.org, linux-arm-kernel@lists.infradead.org,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/5] iommu: Add DOMAIN_ATTR_SPLIT_TABLES
Date:   Thu,  9 Apr 2020 17:33:46 -0600
Message-Id: <20200409233350.6343-2-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200409233350.6343-1-jcrouse@codeaurora.org>
References: <20200409233350.6343-1-jcrouse@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new attribute to enable and query the state of split pagetables
for the domain.

Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---

 include/linux/iommu.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 7ef8b0bda695..d0f96f748a00 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -126,6 +126,8 @@ enum iommu_attr {
 	DOMAIN_ATTR_FSL_PAMUV1,
 	DOMAIN_ATTR_NESTING,	/* two stages of translation */
 	DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE,
+	/* Enable split pagetables (for example, TTBR1 on arm-smmu) */
+	DOMAIN_ATTR_SPLIT_TABLES,
 	DOMAIN_ATTR_MAX,
 };
 
-- 
2.17.1
