Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C24AFC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 23:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 960B62065D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 23:41:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dsMKM8Db"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgHQXlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 19:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgHQXkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 19:40:55 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C29C061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 16:40:54 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id x69so16701946qkb.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 16:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ORuHBCNbLVa1FbhFP8zeqzXUpQk/YDobehSYnTWGWAY=;
        b=dsMKM8DbG6ER2ctGpsW3hdmFCOHGOj5tnnPnl+5T5LQ6Av74CZU2gbPn35qSX3ZiLB
         IFRnqjpcg1lSD9WU0fWn53Vi6Zy4/vj1P/HbBS/cwShPkqOnrTyebmy95eCv1cc9rg3H
         FEA51qPMeqibPfm+QuQChi0UdqSZOfuCUD/Aquxbx8hNSsRNLQH0pOlT4Nh9W1yaj3e9
         jHxqHW8vfl4Cnjpoeu2kn/QgtDoRe7r3Z/E4fkj5S864BPa2naZnSvNAIyPSklBYTuQm
         MmMRl4GMkoI02/rBqjj0qHOqKyudD3G3wxEJk4wKIBNerZo1VpgtY3lObZtUZXKqb+s2
         6XcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ORuHBCNbLVa1FbhFP8zeqzXUpQk/YDobehSYnTWGWAY=;
        b=ugqxnG55hAGidae6nph6UoP7k8b8ABtrA0cue1BBsaEmHljm/FgoOw3nfshytP68sB
         GknsHCHZ5J91CId/LIEJJgd/I6+iMlRwlDNoT5roCSyiBB4K+gggen1A57i0A/2TGO5G
         6qzcsUgaRiAlw0FxxEg3EZ0NHglMHt20xu2rVrYVtDbP0TDDB0P+ynntkZrv9UkMIa40
         t5JrAe79tR+2EeMdSVGnzojV1/QGG8bs+Z2+U/6eWB6oKolJsrgr4JgF2zU3HqFwnZYc
         AtPntCZpF4uAEadY6znRKDqYOoI1+YPVjt0SPY3/ReGAnEtRRJCNwjwHHMu0sUaHYDKo
         fevw==
X-Gm-Message-State: AOAM531QldqKzWDy5/dAYb46xTjFW2gfhW/O6kFyinQCM4iy3RDGNwiX
        oT3j47ifwLix1x80AX5hAQk=
X-Google-Smtp-Source: ABdhPJziJJCx+WDnFX9u1tNv++M0FahXXzOdWg/jh6knz5428pgvDQW3lYA+UhMaTP7LtB2NGyhv2w==
X-Received: by 2002:ae9:e8cd:: with SMTP id a196mr14403875qkg.137.1597707653935;
        Mon, 17 Aug 2020 16:40:53 -0700 (PDT)
Received: from LeoBras.ibmuc.com ([177.35.193.93])
        by smtp.gmail.com with ESMTPSA id w58sm22342868qth.95.2020.08.17.16.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 16:40:53 -0700 (PDT)
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Leonardo Bras <leobras.c@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Brian King <brking@linux.vnet.ibm.com>,
        Murilo Fossa Vicentini <muvic@linux.ibm.com>,
        David Dai <zdai@linux.vnet.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 01/10] powerpc/pseries/iommu: Replace hard-coded page shift
Date:   Mon, 17 Aug 2020 20:40:24 -0300
Message-Id: <20200817234033.442511-2-leobras.c@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200817234033.442511-1-leobras.c@gmail.com>
References: <20200817234033.442511-1-leobras.c@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some functions assume IOMMU page size can only be 4K (pageshift == 12).
Update them to accept any page size passed, so we can use 64K pages.

In the process, some defines like TCE_SHIFT were made obsolete, and then
removed. TCE_RPN_MASK was updated to generate a mask according to
the pageshift used.

Most places had a tbl struct, so using tbl->it_page_shift was simple.
tce_free_pSeriesLP() was a special case, since callers not always have a
tbl struct, so adding a tceshift parameter seems the right thing to do.

Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
---
 arch/powerpc/include/asm/tce.h         | 10 ++----
 arch/powerpc/platforms/pseries/iommu.c | 42 ++++++++++++++++----------
 2 files changed, 28 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/include/asm/tce.h b/arch/powerpc/include/asm/tce.h
index db5fc2f2262d..971cba2d87cc 100644
--- a/arch/powerpc/include/asm/tce.h
+++ b/arch/powerpc/include/asm/tce.h
@@ -19,15 +19,9 @@
 #define TCE_VB			0
 #define TCE_PCI			1
 
-/* TCE page size is 4096 bytes (1 << 12) */
-
-#define TCE_SHIFT	12
-#define TCE_PAGE_SIZE	(1 << TCE_SHIFT)
-
 #define TCE_ENTRY_SIZE		8		/* each TCE is 64 bits */
-
-#define TCE_RPN_MASK		0xfffffffffful  /* 40-bit RPN (4K pages) */
-#define TCE_RPN_SHIFT		12
+#define TCE_RPN_BITS		52		/* Bits 0-51 represent RPN on TCE */
+#define TCE_RPN_MASK(ps)	((1ul << (TCE_RPN_BITS - (ps))) - 1)
 #define TCE_VALID		0x800		/* TCE valid */
 #define TCE_ALLIO		0x400		/* TCE valid for all lpars */
 #define TCE_PCI_WRITE		0x2		/* write from PCI allowed */
diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index e4198700ed1a..8fe23b7dff3a 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -107,6 +107,9 @@ static int tce_build_pSeries(struct iommu_table *tbl, long index,
 	u64 proto_tce;
 	__be64 *tcep;
 	u64 rpn;
+	const unsigned long tceshift = tbl->it_page_shift;
+	const unsigned long pagesize = IOMMU_PAGE_SIZE(tbl);
+	const u64 rpn_mask = TCE_RPN_MASK(tceshift);
 
 	proto_tce = TCE_PCI_READ; // Read allowed
 
@@ -117,10 +120,10 @@ static int tce_build_pSeries(struct iommu_table *tbl, long index,
 
 	while (npages--) {
 		/* can't move this out since we might cross MEMBLOCK boundary */
-		rpn = __pa(uaddr) >> TCE_SHIFT;
-		*tcep = cpu_to_be64(proto_tce | (rpn & TCE_RPN_MASK) << TCE_RPN_SHIFT);
+		rpn = __pa(uaddr) >> tceshift;
+		*tcep = cpu_to_be64(proto_tce | (rpn & rpn_mask) << tceshift);
 
-		uaddr += TCE_PAGE_SIZE;
+		uaddr += pagesize;
 		tcep++;
 	}
 	return 0;
@@ -146,7 +149,7 @@ static unsigned long tce_get_pseries(struct iommu_table *tbl, long index)
 	return be64_to_cpu(*tcep);
 }
 
-static void tce_free_pSeriesLP(unsigned long liobn, long, long);
+static void tce_free_pSeriesLP(unsigned long liobn, long, long, long);
 static void tce_freemulti_pSeriesLP(struct iommu_table*, long, long);
 
 static int tce_build_pSeriesLP(unsigned long liobn, long tcenum, long tceshift,
@@ -159,6 +162,7 @@ static int tce_build_pSeriesLP(unsigned long liobn, long tcenum, long tceshift,
 	u64 rpn;
 	int ret = 0;
 	long tcenum_start = tcenum, npages_start = npages;
+	const u64 rpn_mask = TCE_RPN_MASK(tceshift);
 
 	rpn = __pa(uaddr) >> tceshift;
 	proto_tce = TCE_PCI_READ;
@@ -166,12 +170,12 @@ static int tce_build_pSeriesLP(unsigned long liobn, long tcenum, long tceshift,
 		proto_tce |= TCE_PCI_WRITE;
 
 	while (npages--) {
-		tce = proto_tce | (rpn & TCE_RPN_MASK) << tceshift;
+		tce = proto_tce | (rpn & rpn_mask) << tceshift;
 		rc = plpar_tce_put((u64)liobn, (u64)tcenum << tceshift, tce);
 
 		if (unlikely(rc == H_NOT_ENOUGH_RESOURCES)) {
 			ret = (int)rc;
-			tce_free_pSeriesLP(liobn, tcenum_start,
+			tce_free_pSeriesLP(liobn, tcenum_start, tceshift,
 			                   (npages_start - (npages + 1)));
 			break;
 		}
@@ -205,10 +209,12 @@ static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
 	long tcenum_start = tcenum, npages_start = npages;
 	int ret = 0;
 	unsigned long flags;
+	const unsigned long tceshift = tbl->it_page_shift;
+	const u64 rpn_mask = TCE_RPN_MASK(tceshift);
 
 	if ((npages == 1) || !firmware_has_feature(FW_FEATURE_PUT_TCE_IND)) {
 		return tce_build_pSeriesLP(tbl->it_index, tcenum,
-					   tbl->it_page_shift, npages, uaddr,
+					   tceshift, npages, uaddr,
 		                           direction, attrs);
 	}
 
@@ -225,13 +231,13 @@ static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
 		if (!tcep) {
 			local_irq_restore(flags);
 			return tce_build_pSeriesLP(tbl->it_index, tcenum,
-					tbl->it_page_shift,
+					tceshift,
 					npages, uaddr, direction, attrs);
 		}
 		__this_cpu_write(tce_page, tcep);
 	}
 
-	rpn = __pa(uaddr) >> TCE_SHIFT;
+	rpn = __pa(uaddr) >> tceshift;
 	proto_tce = TCE_PCI_READ;
 	if (direction != DMA_TO_DEVICE)
 		proto_tce |= TCE_PCI_WRITE;
@@ -245,12 +251,12 @@ static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
 		limit = min_t(long, npages, 4096/TCE_ENTRY_SIZE);
 
 		for (l = 0; l < limit; l++) {
-			tcep[l] = cpu_to_be64(proto_tce | (rpn & TCE_RPN_MASK) << TCE_RPN_SHIFT);
+			tcep[l] = cpu_to_be64(proto_tce | (rpn & rpn_mask) << tceshift);
 			rpn++;
 		}
 
 		rc = plpar_tce_put_indirect((u64)tbl->it_index,
-					    (u64)tcenum << 12,
+					    (u64)tcenum << tceshift,
 					    (u64)__pa(tcep),
 					    limit);
 
@@ -277,12 +283,13 @@ static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
 	return ret;
 }
 
-static void tce_free_pSeriesLP(unsigned long liobn, long tcenum, long npages)
+static void tce_free_pSeriesLP(unsigned long liobn, long tcenum, long tceshift,
+			       long npages)
 {
 	u64 rc;
 
 	while (npages--) {
-		rc = plpar_tce_put((u64)liobn, (u64)tcenum << 12, 0);
+		rc = plpar_tce_put((u64)liobn, (u64)tcenum << tceshift, 0);
 
 		if (rc && printk_ratelimit()) {
 			printk("tce_free_pSeriesLP: plpar_tce_put failed. rc=%lld\n", rc);
@@ -301,9 +308,11 @@ static void tce_freemulti_pSeriesLP(struct iommu_table *tbl, long tcenum, long n
 	u64 rc;
 
 	if (!firmware_has_feature(FW_FEATURE_STUFF_TCE))
-		return tce_free_pSeriesLP(tbl->it_index, tcenum, npages);
+		return tce_free_pSeriesLP(tbl->it_index, tcenum,
+					  tbl->it_page_shift, npages);
 
-	rc = plpar_tce_stuff((u64)tbl->it_index, (u64)tcenum << 12, 0, npages);
+	rc = plpar_tce_stuff((u64)tbl->it_index,
+			     (u64)tcenum << tbl->it_page_shift, 0, npages);
 
 	if (rc && printk_ratelimit()) {
 		printk("tce_freemulti_pSeriesLP: plpar_tce_stuff failed\n");
@@ -319,7 +328,8 @@ static unsigned long tce_get_pSeriesLP(struct iommu_table *tbl, long tcenum)
 	u64 rc;
 	unsigned long tce_ret;
 
-	rc = plpar_tce_get((u64)tbl->it_index, (u64)tcenum << 12, &tce_ret);
+	rc = plpar_tce_get((u64)tbl->it_index,
+			   (u64)tcenum << tbl->it_page_shift, &tce_ret);
 
 	if (rc && printk_ratelimit()) {
 		printk("tce_get_pSeriesLP: plpar_tce_get failed. rc=%lld\n", rc);
-- 
2.25.4

