Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2CBCC35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 20:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68E0C222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 20:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="gdBVkjkr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730109AbgBNUbE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 15:31:04 -0500
Received: from mail27.static.mailgun.info ([104.130.122.27]:11562 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729682AbgBNUbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 15:31:04 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1581712263; h=Content-Type: MIME-Version: Message-ID:
 Subject: cc: To: From: Date: Sender;
 bh=h/tkltk20e29nTfkQPxEvZyxDnAN8IM+C5401aPk9gc=; b=gdBVkjkr5W9bwa0E6l10yLQYfnluulKdjLZqCDW6r9YWM7Zvfiy4fbwgyz1Ki989Y8sPQuE+
 0YlEsgPg5pxJgDkJMOI7k9l2mPe7y4B9ZuSEU96lcXmkvu8fFm0GWBpTRg5d5a/v67yDkvBj
 J3/fMG1yU276ZMTEzymcLHj/SS0=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e470381.7fe9bb28a068-smtp-out-n02;
 Fri, 14 Feb 2020 20:30:57 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0435CC4479C; Fri, 14 Feb 2020 20:30:57 +0000 (UTC)
Received: from lmark-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lmark)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0C8EBC43383;
        Fri, 14 Feb 2020 20:30:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0C8EBC43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=lmark@codeaurora.org
Date:   Fri, 14 Feb 2020 12:30:55 -0800 (PST)
From:   Liam Mark <lmark@codeaurora.org>
X-X-Sender: lmark@lmark-linux.qualcomm.com
To:     Joerg Roedel <joro@8bytes.org>
cc:     kernel-team@android.com,
        "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [RFC PATCH] iommu/iova: Support limiting IOVA alignment
Message-ID: <alpine.DEB.2.10.2002141223510.27047@lmark-linux.qualcomm.com>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


When the IOVA framework applies IOVA alignment it aligns all
IOVAs to the smallest PAGE_SIZE order which is greater than or
equal to the requested IOVA size.

We support use cases that requires large buffers (> 64 MB in
size) to be allocated and mapped in their stage 1 page tables.
However, with this alignment scheme we find ourselves running
out of IOVA space for 32 bit devices, so we are proposing this
config, along the similar vein as CONFIG_CMA_ALIGNMENT for CMA
allocations.

Add CONFIG_IOMMU_LIMIT_IOVA_ALIGNMENT to limit the alignment of
IOVAs to some desired PAGE_SIZE order, specified by
CONFIG_IOMMU_IOVA_ALIGNMENT. This helps reduce the impact of
fragmentation caused by the current IOVA alignment scheme, and
gives better IOVA space utilization.

Signed-off-by: Liam Mark <lmark@codeaurora.org>
---
 drivers/iommu/Kconfig | 31 +++++++++++++++++++++++++++++++
 drivers/iommu/iova.c  | 20 +++++++++++++++++++-
 2 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index d2fade984999..9684a153cc72 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -3,6 +3,37 @@
 config IOMMU_IOVA
 	tristate
 
+if IOMMU_IOVA
+
+config IOMMU_LIMIT_IOVA_ALIGNMENT
+	bool "Limit IOVA alignment"
+	help
+	  When the IOVA framework applies IOVA alignment it aligns all
+	  IOVAs to the smallest PAGE_SIZE order which is greater than or
+	  equal to the requested IOVA size. This works fine for sizes up
+	  to several MiB, but for larger sizes it results in address
+	  space wastage and fragmentation. For example drivers with a 4
+	  GiB IOVA space might run out of IOVA space when allocating
+	  buffers great than 64 MiB.
+
+	  Enable this option to impose a limit on the alignment of IOVAs.
+
+	  If unsure, say N.
+
+config IOMMU_IOVA_ALIGNMENT
+	int "Maximum PAGE_SIZE order of alignment for IOVAs"
+	depends on IOMMU_LIMIT_IOVA_ALIGNMENT
+	range 4 9
+	default 9
+	help
+	  With this parameter you can specify the maximum PAGE_SIZE order for
+	  IOVAs. Larger IOVAs will be aligned only to this specified order.
+	  The order is expressed a power of two multiplied by the PAGE_SIZE.
+
+	  If unsure, leave the default value "9".
+
+endif
+
 # The IOASID library may also be used by non-IOMMU_API users
 config IOASID
 	tristate
diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 0e6a9536eca6..259884c8dbd1 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -177,6 +177,24 @@ int init_iova_flush_queue(struct iova_domain *iovad,
 	rb_insert_color(&iova->node, root);
 }
 
+#ifdef CONFIG_IOMMU_LIMIT_IOVA_ALIGNMENT
+static unsigned long limit_align_shift(struct iova_domain *iovad,
+				       unsigned long shift)
+{
+	unsigned long max_align_shift;
+
+	max_align_shift = CONFIG_IOMMU_IOVA_ALIGNMENT + PAGE_SHIFT
+			- iova_shift(iovad);
+	return min_t(unsigned long, max_align_shift, shift);
+}
+#else
+static unsigned long limit_align_shift(struct iova_domain *iovad,
+				       unsigned long shift)
+{
+	return shift;
+}
+#endif
+
 static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
 		unsigned long size, unsigned long limit_pfn,
 			struct iova *new, bool size_aligned)
@@ -188,7 +206,7 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
 	unsigned long align_mask = ~0UL;
 
 	if (size_aligned)
-		align_mask <<= fls_long(size - 1);
+		align_mask <<= limit_align_shift(iovad, fls_long(size - 1));
 
 	/* Walk the tree backwards */
 	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
a Linux Foundation Collaborative Project
