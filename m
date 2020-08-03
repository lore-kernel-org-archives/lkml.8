Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E54DBC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 14:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF6AB206DA
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 14:15:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EliOTm2U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbgHCOPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 10:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbgHCOPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 10:15:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2508FC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 07:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=tAS11sJpElMBs2Pfs6KLa4qx/lgKKhsfUzhtsaRTmoY=; b=EliOTm2U9G2AnO8zvDaIC4l0Yk
        s9QE3PYEN+MjTLkLvLN3iT78LpVL6fJkdOmsvYe8TpxcMT0A+QzEgi33wM+24VrVr2Xr1laEDhhIm
        SAibRNjK+KGNSalwfKqbXjblaK/DzDlVo4KklgJ10ACHz6KEt0R6Qx7FNsfCr/tKYfTxPl40G/+2q
        ZAH87xvPiPivlT5x63I6H1RDl0V3y2CXwL/PmeQLvTsI5o+b3AxxnIXZ+67ziGX1dk1ZtY5yawHml
        Ctr6ZdBvYORw91KD6xCoIGmpbu5WDSnCWrpg6AmISv4RPP6VpNBV54LUrVQs7xUWNbSyLE/c98c2D
        ZqT29rGw==;
Received: from 93-43-212-104.ip93.fastwebnet.it ([93.43.212.104] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k2bFj-0003E4-Sh; Mon, 03 Aug 2020 14:15:48 +0000
Date:   Mon, 3 Aug 2020 16:15:47 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [GIT PULL] dma-mapping updates for 5.9
Message-ID: <20200803141547.GA752173@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Note that this adds a select to drivers/iommu/Kconfig symbols which moves
to drivers/iommu/intel/Kconfig in the iommu tree. 

The following changes since commit d9765e41d8e9ea2251bf73735a2895c8bad546fc:

  dma-pool: do not allocate pool memory from CMA (2020-07-14 15:46:32 +0200)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.9

for you to fetch changes up to 274b3f7bf34415eed106e479e4815e897ce5d763:

  dma-contiguous: cleanup dma_alloc_contiguous (2020-07-28 13:42:15 +0200)

----------------------------------------------------------------
dma-mapping updates for 5.9

 - make support for dma_ops optional
 - move more code out of line
 - add generic support for a dma_ops bypass mode
 - misc cleanups

----------------------------------------------------------------
Christoph Hellwig (7):
      dma-mapping: move the remaining DMA API calls out of line
      dma-mapping: inline the fast path dma-direct calls
      dma-mapping: make support for dma ops optional
      dma-mapping: add a dma_ops_bypass flag to struct device
      powerpc: use the generic dma_ops_bypass mode
      dma-debug: use named initializers for dir2name
      dma-contiguous: cleanup dma_alloc_contiguous

 arch/alpha/Kconfig                |   1 +
 arch/arm/Kconfig                  |   1 +
 arch/ia64/Kconfig                 |   1 +
 arch/mips/Kconfig                 |   1 +
 arch/parisc/Kconfig               |   1 +
 arch/powerpc/Kconfig              |   2 +
 arch/powerpc/include/asm/device.h |   5 -
 arch/powerpc/kernel/dma-iommu.c   |  90 ++------------
 arch/s390/Kconfig                 |   1 +
 arch/sparc/Kconfig                |   1 +
 arch/x86/Kconfig                  |   1 +
 drivers/infiniband/core/device.c  |   6 +-
 drivers/iommu/Kconfig             |   2 +
 drivers/macintosh/macio_asic.c    |   4 +-
 drivers/misc/mic/Kconfig          |   4 +
 drivers/vdpa/Kconfig              |   1 +
 drivers/xen/Kconfig               |   1 +
 include/linux/device.h            |  11 +-
 include/linux/dma-direct.h        | 104 ++++++++++++++++
 include/linux/dma-mapping.h       | 251 +++++---------------------------------
 kernel/dma/Kconfig                |  12 ++
 kernel/dma/Makefile               |   3 +-
 kernel/dma/contiguous.c           |  31 +++--
 kernel/dma/debug.c                |   8 +-
 kernel/dma/direct.c               |  74 -----------
 kernel/dma/mapping.c              | 214 ++++++++++++++++++++++++++++++--
 26 files changed, 415 insertions(+), 416 deletions(-)
