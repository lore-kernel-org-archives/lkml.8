Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D79C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 22:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48A592073E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 22:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="cmka9cu9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbgFKW3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 18:29:42 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:60826 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726417AbgFKW3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 18:29:40 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591914580; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=PQnTZkYVOn9g39XJGJ/Fc5lnyvhq0qe68meDTmbVWdk=; b=cmka9cu9mh3Cv/VQ5jxf5V8kqFg3Fokqhsx8Vt9/yxNh1q7omx0EGfrAhX0ithziIZdxDY5i
 JAsb/Dijyojp35X3A9WYmgD6cPcku73bvGRIsWqxbGjewft9DRiGhbhq8WQaI4iNqmI6Itiw
 w1vBMwjFHpKNwCJ2+/4COG1vXPs=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5ee2b04a8fe116ddd99a5724 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 11 Jun 2020 22:29:30
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E3DA3C433C8; Thu, 11 Jun 2020 22:29:29 +0000 (UTC)
Received: from jordan-laptop.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B7CA5C433CB;
        Thu, 11 Jun 2020 22:29:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B7CA5C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     freedreno@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        Joerg Roedel <jroedel@suse.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>, Yong Wu <yong.wu@mediatek.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] iommu/io-pgtable: Allow a pgtable implementation to skip TLB operations
Date:   Thu, 11 Jun 2020 16:29:17 -0600
Message-Id: <20200611222921.464-3-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200611222921.464-1-jcrouse@codeaurora.org>
References: <20200611222921.464-1-jcrouse@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow a io-pgtable implementation to skip TLB operations by checking for
NULL pointers in the helper functions. It will be up to to the owner
of the io-pgtable instance to make sure that they independently handle
the TLB correctly.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---

 include/linux/io-pgtable.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index 53d53c6c2be9..bbed1d3925ba 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -210,21 +210,24 @@ struct io_pgtable {
 
 static inline void io_pgtable_tlb_flush_all(struct io_pgtable *iop)
 {
-	iop->cfg.tlb->tlb_flush_all(iop->cookie);
+	if (iop->cfg.tlb)
+		iop->cfg.tlb->tlb_flush_all(iop->cookie);
 }
 
 static inline void
 io_pgtable_tlb_flush_walk(struct io_pgtable *iop, unsigned long iova,
 			  size_t size, size_t granule)
 {
-	iop->cfg.tlb->tlb_flush_walk(iova, size, granule, iop->cookie);
+	if (iop->cfg.tlb)
+		iop->cfg.tlb->tlb_flush_walk(iova, size, granule, iop->cookie);
 }
 
 static inline void
 io_pgtable_tlb_flush_leaf(struct io_pgtable *iop, unsigned long iova,
 			  size_t size, size_t granule)
 {
-	iop->cfg.tlb->tlb_flush_leaf(iova, size, granule, iop->cookie);
+	if (iop->cfg.tlb)
+		iop->cfg.tlb->tlb_flush_leaf(iova, size, granule, iop->cookie);
 }
 
 static inline void
@@ -232,7 +235,7 @@ io_pgtable_tlb_add_page(struct io_pgtable *iop,
 			struct iommu_iotlb_gather * gather, unsigned long iova,
 			size_t granule)
 {
-	if (iop->cfg.tlb->tlb_add_page)
+	if (iop->cfg.tlb && iop->cfg.tlb->tlb_add_page)
 		iop->cfg.tlb->tlb_add_page(gather, iova, granule, iop->cookie);
 }
 
-- 
2.17.1

