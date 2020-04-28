Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F6ECC83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 19:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B5E022205
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 19:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tva7EJtJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbgD1TpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 15:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728987AbgD1TpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 15:45:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE135C03C1AB;
        Tue, 28 Apr 2020 12:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=n/mwyxuh6jEA/eyR9En+7lR2Ld3WWTxEHQLarZr3GYc=; b=tva7EJtJFel515fW/3FbcvC4rY
        BvyFUdgCP+lN/F5qXTHVweJ2W0ck56r0CArRjqfeVTPTZqOa5Xi40cdqtCIflTfxhH10QyzxZ7/TY
        ApbmnE+Tiw2yker64AMaa27S6DcIy+74W/CJ2z/BV5gbuRKrKqewE5TXckJODmT/OKpb2wYUBajij
        7bRQkBThPrR00i8beic6xJZlczWpIGpA01ps4NVmE1uw1zeXFKOD5E2dRGWJ0YBZqQ9zhpDjSie/S
        HevTSyQulWZjBzfSlvsQvdui777JEaZD4KwGuNROpLfQtZESEHsqQThzu6W/Qh036Ry73tkytKM8o
        BXDI7ucw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTW9y-0005uN-SM; Tue, 28 Apr 2020 19:44:50 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
Subject: [PATCH 0/7] Record the mm_struct in the page table pages
Date:   Tue, 28 Apr 2020 12:44:42 -0700
Message-Id: <20200428194449.22615-1-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Pages which are in use as page tables have some space unused in struct
page.  It would be handy to have a pointer to the struct mm_struct that
they belong to so that we can handle uncorrectable errors in page tables
more gracefully.  There are a few other things we could use it for too,
such as checking that the page table entry actually belongs to the task
we think it ought to.  This patch series does none of that, but does
lay the groundwork for it.

Matthew Wilcox (Oracle) (7):
  mm: Document x86 uses a linked list of pgds
  mm: Move pt_mm within struct page
  arm: Thread mm_struct throughout page table allocation
  arm64: Thread mm_struct throughout page table allocation
  m68k: Thread mm_struct throughout page table allocation
  mm: Set pt_mm in PTE constructor
  mm: Set pt_mm in PMD constructor

 arch/arc/include/asm/pgalloc.h           |  2 +-
 arch/arm/mm/mmu.c                        | 66 ++++++++---------
 arch/arm64/include/asm/pgalloc.h         |  2 +-
 arch/arm64/mm/mmu.c                      | 93 ++++++++++++------------
 arch/m68k/include/asm/mcf_pgalloc.h      |  2 +-
 arch/m68k/include/asm/motorola_pgalloc.h | 10 +--
 arch/m68k/mm/motorola.c                  |  4 +-
 arch/openrisc/include/asm/pgalloc.h      |  2 +-
 arch/powerpc/mm/book3s64/pgtable.c       |  2 +-
 arch/powerpc/mm/pgtable-frag.c           |  2 +-
 arch/s390/include/asm/pgalloc.h          |  2 +-
 arch/s390/mm/pgalloc.c                   |  2 +-
 arch/sparc/mm/init_64.c                  |  2 +-
 arch/sparc/mm/srmmu.c                    |  2 +-
 arch/x86/include/asm/pgalloc.h           |  2 +-
 arch/x86/mm/pgtable.c                    |  3 +-
 arch/xtensa/include/asm/pgalloc.h        |  2 +-
 include/asm-generic/pgalloc.h            |  2 +-
 include/linux/mm.h                       | 18 ++++-
 include/linux/mm_types.h                 | 12 +--
 20 files changed, 122 insertions(+), 110 deletions(-)


base-commit: 6a8b55ed4056ea5559ebe4f6a4b247f627870d4c
-- 
2.26.2

