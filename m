Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CCC9C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 07:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4167E208C7
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 07:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aAeel0Tk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbgF0HtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 03:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgF0HtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 03:49:24 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A88C03E979
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 00:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=VISRGRVX3KTYFQ5h7gP2VwYP1BiwOz4Oy4J0zolFtuE=; b=aAeel0Tk4D0FgLHXHU22f2R1z0
        kItD/+v4kQfOgGNPMUZJCFliF5C8/S9d9XdqLvIMK8u68LEys7hOBBn57WWaNTD1g4ytQdZTkUrQM
        BPhPjU/XbeRkVc7VwWi44UdY7CgAvlQyPMogGuYIYwPSHyH2llS1DY3QVwWTjFZa5Kzx+lQOnGCF8
        XLi07T7Do/BzvkUQXhtRsqA79TThw6jyxzvwE7Pfpm+NeieVls7UOkphIG7/kucx8TDLm/xZEPD5O
        9FJPKRm8mzRLtIopZt5eLzAL+3B/yjYjRvR1sCyZmz6FokT11nvdRshlpce94T1QLmtteOAJajd07
        STxBmgkw==;
Received: from [2001:4bb8:184:76e3:595:ba65:ae56:65a6] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jp5aC-0007Xl-DJ; Sat, 27 Jun 2020 07:49:05 +0000
Date:   Sat, 27 Jun 2020 09:49:02 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [GIT PULL] dma-mapping fixes for 5.8
Message-ID: <20200627074902.GA2447682@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit dbed452a078d56bc7f1abecc3edd6a75e8e4484e:

  dma-pool: decouple DMA_REMAP from DMA_COHERENT_POOL (2020-06-15 08:35:30 +0200)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.8-4

for you to fetch changes up to 8e36baf97b252cdcafa53589e8227cbb1e85f0b0:

  dma-remap: align the size in dma_common_*_remap() (2020-06-23 14:14:41 +0200)

----------------------------------------------------------------
dma-mapping fixes for 5.8:

 - fix dma coherent mmap in nommu (me)
 - more AMD SEV fallout (David Rientjes, me)
 - fix alignment in dma_common_*_remap (Eric Auger)

----------------------------------------------------------------
Christoph Hellwig (3):
      dma-direct: re-enable mmap for !CONFIG_MMU
      dma-direct: mark __dma_direct_alloc_pages static
      dma-mapping: DMA_COHERENT_POOL should select GENERIC_ALLOCATOR

David Rientjes (4):
      dma-direct: always align allocation size in dma_direct_alloc_pages()
      dma-direct: re-encrypt memory if dma_direct_alloc_pages() fails
      dma-direct: check return value when encrypting or decrypting memory
      dma-direct: add missing set_memory_decrypted() for coherent mapping

Eric Auger (1):
      dma-remap: align the size in dma_common_*_remap()

 include/linux/dma-direct.h |  2 --
 kernel/dma/Kconfig         |  3 ++-
 kernel/dma/direct.c        | 59 ++++++++++++++++++++++++++--------------------
 kernel/dma/remap.c         |  5 ++--
 4 files changed, 39 insertions(+), 30 deletions(-)
