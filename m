Return-Path: <SRS0=ne2O=7T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 711E5C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 16:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44B9F20772
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 16:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="l9zrYwam"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbgFFQJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jun 2020 12:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbgFFQJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jun 2020 12:09:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49772C03E96A
        for <linux-kernel@vger.kernel.org>; Sat,  6 Jun 2020 09:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=13YtnQ2W0ggJKbLEu3bFimjEIxdnhaslWMy02eqYWY0=; b=l9zrYwamZIr/QfDf2aUeD7ffBG
        I0I0Ako+vDy/Jre5SIY9GzQifYG9b1oEDSlQll9rP0d0klsfvIdzcvrSJFG5wLQpcgnpUc7IZD9Jx
        fcO7YhGI5nBzKAYvkKH7epU/Ql4T7MiwMhrTwoDm5RmhFV9eb68Vg7kY69FLcMLS7aI3ED8zWEnmO
        YbV4PRnmIgd12P1WMer2dNopVBk2igda0koAjKZ4S1j/FruSa82nZnr+C6i5IpZt13+9AE2+krnxW
        9NNnPQb4gTY9zUfNR+N6dIelmgdENGPC0geo30zFF/uvCz7COP9E1ma0tgg9KOw95qlTcN6HjYXL1
        Uh5CdKdw==;
Received: from 213-225-38-56.nat.highway.a1.net ([213.225.38.56] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jhbNf-0002F7-N1; Sat, 06 Jun 2020 16:09:12 +0000
Date:   Sat, 6 Jun 2020 18:06:57 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] dma-mapping updates for 5.8, part 1
Message-ID: <20200606160657.GA3482728@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit ae83d0b416db002fe95601e7f97f64b59514d936:

  Linux 5.7-rc2 (2020-04-19 14:35:30 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.8

for you to fetch changes up to 298f3db6ee690259927b105d5ad1079563361323:

  dma-contiguous: fix comment for dma_release_from_contiguous (2020-04-25 13:17:06 +0200)

----------------------------------------------------------------
dma-mapping updates for 5.8, part 1

 - enhance the dma pool to allow atomic allocation on x86 with AMD SEV
   (David Rientjes)
 - two small cleanups (Jason Yan and Peter Collingbourne)

----------------------------------------------------------------
David Rientjes (7):
      dma-remap: separate DMA atomic pools from direct remap code
      dma-pool: add additional coherent pools to map to gfp mask
      dma-pool: dynamically expanding atomic pools
      dma-direct: atomic allocations must come from atomic coherent pools
      dma-pool: add pool sizes to debugfs
      x86/mm: unencrypted non-blocking DMA allocations use coherent pools
      dma-pool: scale the default DMA coherent pool size with memory capacity

Jason Yan (1):
      dma-debug: make __dma_entry_alloc_check_leak() static

Peter Collingbourne (1):
      dma-contiguous: fix comment for dma_release_from_contiguous

 arch/x86/Kconfig            |   1 +
 drivers/iommu/dma-iommu.c   |   5 +-
 include/linux/dma-direct.h  |   2 +
 include/linux/dma-mapping.h |   6 +-
 kernel/dma/Kconfig          |   6 +-
 kernel/dma/Makefile         |   1 +
 kernel/dma/contiguous.c     |   4 +-
 kernel/dma/debug.c          |   2 +-
 kernel/dma/direct.c         |  56 ++++++++--
 kernel/dma/pool.c           | 264 ++++++++++++++++++++++++++++++++++++++++++++
 kernel/dma/remap.c          | 121 +-------------------
 11 files changed, 327 insertions(+), 141 deletions(-)
 create mode 100644 kernel/dma/pool.c
