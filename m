Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38B8C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A0CE22D02
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbgH0PHn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 11:07:43 -0400
Received: from mga17.intel.com ([192.55.52.151]:30258 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728333AbgH0PHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 11:07:14 -0400
IronPort-SDR: hEEet2v6UNe2UEYvdtSPqln2TuYNuaivlczHhJKG6pMDTtU1702FYHlzIzDhy8zIdaN9w918c+
 fA3sZfxl/T3Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9726"; a="136563653"
X-IronPort-AV: E=Sophos;i="5.76,359,1592895600"; 
   d="scan'208";a="136563653"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2020 08:06:59 -0700
IronPort-SDR: Xg7voNoK5fZYuKFbJjlFDUYuGwghawCJyVA/W+yRYt3yxL+IngxtuYFfxWcY3uZCFHzrI4y+4y
 at7uvxqs31ZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,359,1592895600"; 
   d="scan'208";a="332212867"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga002.fm.intel.com with ESMTP; 27 Aug 2020 08:06:59 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "H Peter Anvin" <hpa@zytor.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Jean-Philippe Brucker" <jean-philippe@linaro.org>,
        "Christoph Hellwig" <hch@infradead.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "David Woodhouse" <dwmw2@infradead.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Ashok Raj" <ashok.raj@intel.com>,
        "Jacob Jun Pan" <jacob.jun.pan@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        "Sohil Mehta" <sohil.mehta@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, iommu@lists.linux-foundation.org,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v7 7/9] mm: Define pasid in mm
Date:   Thu, 27 Aug 2020 08:06:32 -0700
Message-Id: <1598540794-132666-8-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1598540794-132666-1-git-send-email-fenghua.yu@intel.com>
References: <1598540794-132666-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PASID is shared by all threads in a process. So the logical place to keep
track of it is in the "mm". Both ARM and X86 need to use the PASID in the
"mm".

Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
v4:
- Change PASID type to u32 (Christoph)

v3:
- Change CONFIG_PCI_PASID to CONFIG_IOMMU_SUPPORT because non-PCI device
  can have PASID in ARM (Jean)

v2:
- This new patch moves "pasid" from x86 specific mm_context_t to generic
  struct mm_struct per Christopher's comment: https://lore.kernel.org/linux-iommu/20200414170252.714402-1-jean-philippe@linaro.org/T/#mb57110ffe1aaa24750eeea4f93b611f0d1913911
- Jean-Philippe Brucker released a virtually same patch. I still put this
  patch in the series for better review. The upstream kernel only needs one
  of the two patches eventually.
https://lore.kernel.org/linux-iommu/20200519175502.2504091-2-jean-philippe@linaro.org/
- Change CONFIG_IOASID to CONFIG_PCI_PASID (Ashok)

 include/linux/mm_types.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 496c3ff97cce..1ff0615ef19f 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -542,6 +542,10 @@ struct mm_struct {
 		atomic_long_t hugetlb_usage;
 #endif
 		struct work_struct async_put_work;
+
+#ifdef CONFIG_IOMMU_SUPPORT
+		u32 pasid;
+#endif
 	} __randomize_layout;
 
 	/*
-- 
2.19.1

