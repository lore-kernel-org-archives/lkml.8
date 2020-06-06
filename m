Return-Path: <SRS0=ne2O=7T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C2A6C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 16:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DADC02077D
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 16:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nE5fDrqk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbgFFQLr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jun 2020 12:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbgFFQLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jun 2020 12:11:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61790C03E96A
        for <linux-kernel@vger.kernel.org>; Sat,  6 Jun 2020 09:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Mm+5DhSxR2Kbdc/sLQObOdz1Pr0vn51n7mq4wVieKGw=; b=nE5fDrqkNkWTT6na+5H7yEMIpS
        GaU3WO7WZp/+z4VEPR/nLdOh3xstH3JgOKJfCaox9btWKqNbTIRoYsFXDgyRJAycd8kpBSUC7tdMH
        jvWfP7AZLQBzyRlFslkZT35tb5gunfuJpPcYQ2dI4LgCSPPmxvi1lRERWV2XcQzGYPlOrfR3CVTRp
        Ejy5W3NYIbgdh7MxzjDcJajl+yKch/xh/eTlSQ2kfd8m9Y1K8ojxXH5Wu7yvfu/Q5/Pbt2f9QcZGH
        3zb0oZuzRiNkF32hgwx0/yDPY1/1y/E42JRbP0VQqK9XBT/Jb7q3awxFi+dO8hZaBTuqgvmqoRGyn
        eNEoZceg==;
Received: from 213-225-38-56.nat.highway.a1.net ([213.225.38.56] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jhbQ9-0004up-Gi; Sat, 06 Jun 2020 16:11:46 +0000
Date:   Sat, 6 Jun 2020 18:09:32 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [GIT PULL] dma-mapping updates for 5.8, part 2
Message-ID: <20200606160932.GB3482728@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These were in a separate stable branch so that various media and drm
trees could pull the in for bug fixes, but looking at linux-next that
hasn't actually happened yet.  Still sending the APIs to you in the
hope that these bug fixes get picked up for 5.8 in one way or another.


The following changes since commit 24085f70a6e1b0cb647ec92623284641d8270637:

  Merge tag 'trace-v5.7-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace (2020-05-12 11:06:26 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.8-2

for you to fetch changes up to 48530d9fab0d3bf08827f9167be54acf66d4d457:

  iommu: add generic helper for mapping sgtable objects (2020-05-13 15:48:20 +0200)

----------------------------------------------------------------
dma-mapping updates for 5.8, part 2

 - add DMA mapping helpers for struct sg_table (Marek Szyprowski)

----------------------------------------------------------------
Marek Szyprowski (3):
      dma-mapping: add generic helpers for mapping sgtable objects
      scatterlist: add generic wrappers for iterating over sgtable objects
      iommu: add generic helper for mapping sgtable objects

 include/linux/dma-mapping.h | 80 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/iommu.h       | 16 +++++++++
 include/linux/scatterlist.h | 50 ++++++++++++++++++++++++++--
 3 files changed, 143 insertions(+), 3 deletions(-)
