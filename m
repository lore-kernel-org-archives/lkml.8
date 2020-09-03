Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF8BC2D0A6
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 20:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02A1F206C0
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 20:20:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tcd-ie.20150623.gappssmtp.com header.i=@tcd-ie.20150623.gappssmtp.com header.b="f5+yqTBU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729323AbgICUUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 16:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728491AbgICUT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 16:19:58 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED05C061244
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 13:19:57 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id o64so4312264qkb.10
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 13:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tcd-ie.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I6sqmpjYQS1i8I2u5OlgYcgH9H7Q/fBtF5RLdQCIbUY=;
        b=f5+yqTBUf+Zh3CRFoO7j+ETaR7BoPwPjFFldKKUkS1MaF6C6Fhwpo/kFj9rjCy1WKz
         UvVrCewv98Q0u5xdiLRiQc2o21P1MUhEJpVVKYv4Oib5ziK5CvQHARu0Q+x5d183b+a6
         pF1Y9Ta/u7jrWC4e/BOGveysxuPjYG6SL8clEy2/9NFsjB7pcUzK5w/ajmD0QUJEmEJ7
         grlTnuwzZj90QQPTQfrRqu+3zrbInu79cugqbqdNdno5i9bSMHWFc6OH7UE+QbWnabjI
         j4ujlx1OtFcGDtL7MGk8lvaMK9Ru9VrxxbhDJZygAX8HxPJDXZGH/dbbp+8T2c57rjnq
         uR2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I6sqmpjYQS1i8I2u5OlgYcgH9H7Q/fBtF5RLdQCIbUY=;
        b=FpXPg62R80bmBUUU3kF2N8yEUYR7mr5Ax31mIHZfG+w23PsiMBOilKKa+NEZthDMJM
         88D5QwWvET8/FQeT8y9t7LzsPz8t1Ur4eNK3gCLX4HkGAUKdRxFclhSM2IaZK2ginRLj
         GsUJKB1BoLxSE6C7HpXYass9ifCMzswwxKqtUM3MS5g34cmUKZIf5lACOetHIm4DSblX
         HhCu7fbT4Ls92YWVQRq+pEhKgBui36TlQumc807ESe520DWXDFCBr65ppnvVHCU0w0T0
         /GDO/huwDlhbSky29CoNINEUUaUvjswDR1Q5liGB+RYUa4IWy8W6qEzO8qLUT2acf09Z
         d9xQ==
X-Gm-Message-State: AOAM531SY8NpsFuHC1JAeeq4+2VlQVImbOXTquwAMfTYO+0vaACA07JT
        n6ZAvvwuyzi1He9tI5X4iWmu2g==
X-Google-Smtp-Source: ABdhPJy41UyVnEf4Yul9EU5IS6jK0ALJvv/N9qDQ6Ke4Op2ACBvgPzzrHN3lrSAG5StjeziwV2NjPg==
X-Received: by 2002:a37:a00d:: with SMTP id j13mr4956214qke.349.1599164396368;
        Thu, 03 Sep 2020 13:19:56 -0700 (PDT)
Received: from tom-ThinkPad-X1-Carbon-5th.hitronhub.home (CPEa84e3fce9b83-CMa84e3fce9b80.cpe.net.cable.rogers.com. [99.230.61.29])
        by smtp.googlemail.com with ESMTPSA id g37sm2863257qtk.76.2020.09.03.13.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 13:19:56 -0700 (PDT)
From:   Tom Murphy <murphyt7@tcd.ie>
To:     iommu@lists.linux-foundation.org
Cc:     Tom Murphy <murphyt7@tcd.ie>, Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 5/5] DO NOT MERGE: iommu: disable list appending in dma-iommu
Date:   Thu,  3 Sep 2020 21:18:37 +0100
Message-Id: <20200903201839.7327-6-murphyt7@tcd.ie>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200903201839.7327-1-murphyt7@tcd.ie>
References: <20200903201839.7327-1-murphyt7@tcd.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disable combining sg segments in the dma-iommu api.
Combining the sg segments exposes a bug in the intel i915 driver which
causes visual artifacts and the screen to freeze. This is most likely
because of how the i915 handles the returned list. It probably doesn't
respect the returned value specifying the number of elements in the list
and instead depends on the previous behaviour of the intel iommu driver
which would return the same number of elements in the output list as in
the input list.

Signed-off-by: Tom Murphy <murphyt7@tcd.ie>
---
 drivers/iommu/dma-iommu.c | 38 ++++++--------------------------------
 1 file changed, 6 insertions(+), 32 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 185cd504ca5a..6697b4ad0df6 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -843,49 +843,23 @@ static int __finalise_sg(struct device *dev, struct scatterlist *sg, int nents,
 		dma_addr_t dma_addr)
 {
 	struct scatterlist *s, *cur = sg;
-	unsigned long seg_mask = dma_get_seg_boundary(dev);
-	unsigned int cur_len = 0, max_len = dma_get_max_seg_size(dev);
-	int i, count = 0;
+	int i;
 
 	for_each_sg(sg, s, nents, i) {
 		/* Restore this segment's original unaligned fields first */
 		unsigned int s_iova_off = sg_dma_address(s);
 		unsigned int s_length = sg_dma_len(s);
 		unsigned int s_iova_len = s->length;
+		if (i > 0)
+			cur = sg_next(cur);
 
 		s->offset += s_iova_off;
 		s->length = s_length;
-		sg_dma_address(s) = DMA_MAPPING_ERROR;
-		sg_dma_len(s) = 0;
-
-		/*
-		 * Now fill in the real DMA data. If...
-		 * - there is a valid output segment to append to
-		 * - and this segment starts on an IOVA page boundary
-		 * - but doesn't fall at a segment boundary
-		 * - and wouldn't make the resulting output segment too long
-		 */
-		if (cur_len && !s_iova_off && (dma_addr & seg_mask) &&
-		    (max_len - cur_len >= s_length)) {
-			/* ...then concatenate it with the previous one */
-			cur_len += s_length;
-		} else {
-			/* Otherwise start the next output segment */
-			if (i > 0)
-				cur = sg_next(cur);
-			cur_len = s_length;
-			count++;
-
-			sg_dma_address(cur) = dma_addr + s_iova_off;
-		}
-
-		sg_dma_len(cur) = cur_len;
+		sg_dma_address(cur) = dma_addr + s_iova_off;
+		sg_dma_len(cur) = s_length;
 		dma_addr += s_iova_len;
-
-		if (s_length + s_iova_off < s_iova_len)
-			cur_len = 0;
 	}
-	return count;
+	return nents;
 }
 
 /*
-- 
2.20.1

