Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A706C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 20:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D78F212CC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 20:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mN/NJPwU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgFQUiA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 16:38:00 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:59985 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgFQUh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 16:37:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592426279; x=1623962279;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=obXSQxEjICW+Yt8ftMsGWA6aehYecXRDu+nvKJxbC/w=;
  b=mN/NJPwUGOGyYNpvlp5VVG9kdV8a8eQdeh1BWWsub8WiR2QIawmAzLux
   BMQS7G+Pu1UGOOBWPv4HZrq19qs70EU0mru7hVoyGWqcwsJPClEOj86z6
   15ihlbRA2leTMAnYKQ4it91p7C7CgzhKnYk83VTSKh0DtjIjCfSdTeD7d
   OWvZPeg4N1VcNfpHvwO1lurJmoASeobbssyqvV9wyKaRlqjQyrXxqrk+w
   SWdgMEp8OxN5uY/ZNdSj9XhL0sRjvECjz3qvtAdmlhqPsFAYPqBYevdvB
   dmLnhBYylp0m4nGSiTQXeAgrWHlL4U5DcNZoAmSWDDbRFjH9Y5D6J6SgP
   g==;
IronPort-SDR: Aex0+pkaLi0mrqaVfYxXlK94sepPh8W/HDhkfQ3SElshnt5OkmE2jU2xoKjgf+phBdOso7N8nd
 iyi2kOv8oAlyNCCYg/+ckARR6a8mR8cELoBTfscC9XzlG3qI1VUXkcnYCYLb93WV+BNn8nwqza
 +CkWEesTHF/JAjO6N+rcDxPYKlIR2KpMMzSg/kJFihZZOTx5FJ0wnI2acoJYnrQVOzmRKJYrG3
 KNV4UxxFBC5Bu9VromB27xHeKGM3JKwpGKY+GKZ+nnpPoHBmcj9JLWfRMP4wTGDOLTPN7noqTO
 PVs=
X-IronPort-AV: E=Sophos;i="5.73,523,1583164800"; 
   d="scan'208";a="140260279"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jun 2020 04:37:58 +0800
IronPort-SDR: lTzWhojd+ewzzxtiLfo2OzynO2z3D1LBR/pVSrcYh/3VPb7LDmTVb01YLlAAohz3oNoU0ETBZh
 p7TdEtlodqQ59mpbXqwBYhAHFU+ds3Zj4=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2020 13:27:12 -0700
IronPort-SDR: zhUy0TZrnbjXxnnsfrT0zttZ0ocHgV32WRoVPnh+Xsp3azyEDgqpotxGdu7x6cjHL7aX3S004I
 Fk5DgEo8B6iA==
WDCIronportException: Internal
Received: from usa003792.ad.shared (HELO yoda.hgst.com) ([10.86.58.133])
  by uls-op-cesaip01.wdc.com with ESMTP; 17 Jun 2020 13:37:59 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        linux-riscv@lists.infradead.org,
        Michel Lespinasse <walken@google.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Zong Li <zong.li@sifive.com>
Subject: [PATCH] RISC-V: Acquire mmap lock before invoking walk_page_range
Date:   Wed, 17 Jun 2020 13:37:32 -0700
Message-Id: <20200617203732.2076611-1-atish.patra@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per walk_page_range documentation, mmap lock should be acquired by the
caller before invoking walk_page_range. mmap_assert_locked gets triggered
without that. The details can be found here.

http://lists.infradead.org/pipermail/linux-riscv/2020-June/010335.html

Fixes: 395a21ff859c(riscv: add ARCH_HAS_SET_DIRECT_MAP support)
Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/mm/pageattr.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
index ec2c70f84994..289a9a5ea5b5 100644
--- a/arch/riscv/mm/pageattr.c
+++ b/arch/riscv/mm/pageattr.c
@@ -151,6 +151,7 @@ int set_memory_nx(unsigned long addr, int numpages)
 
 int set_direct_map_invalid_noflush(struct page *page)
 {
+	int ret;
 	unsigned long start = (unsigned long)page_address(page);
 	unsigned long end = start + PAGE_SIZE;
 	struct pageattr_masks masks = {
@@ -158,11 +159,16 @@ int set_direct_map_invalid_noflush(struct page *page)
 		.clear_mask = __pgprot(_PAGE_PRESENT)
 	};
 
-	return walk_page_range(&init_mm, start, end, &pageattr_ops, &masks);
+	mmap_read_lock(&init_mm);
+	ret = walk_page_range(&init_mm, start, end, &pageattr_ops, &masks);
+	mmap_read_unlock(&init_mm);
+
+	return ret;
 }
 
 int set_direct_map_default_noflush(struct page *page)
 {
+	int ret;
 	unsigned long start = (unsigned long)page_address(page);
 	unsigned long end = start + PAGE_SIZE;
 	struct pageattr_masks masks = {
@@ -170,7 +176,11 @@ int set_direct_map_default_noflush(struct page *page)
 		.clear_mask = __pgprot(0)
 	};
 
-	return walk_page_range(&init_mm, start, end, &pageattr_ops, &masks);
+	mmap_read_lock(&init_mm);
+	ret = walk_page_range(&init_mm, start, end, &pageattr_ops, &masks);
+	mmap_read_unlock(&init_mm);
+
+	return ret;
 }
 
 void __kernel_map_pages(struct page *page, int numpages, int enable)
-- 
2.26.2

