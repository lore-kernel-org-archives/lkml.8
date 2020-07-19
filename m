Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC650C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 07:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B2802073A
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 07:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ghtU5skA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgGSHjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 03:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgGSHjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 03:39:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77411C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 00:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=cNsbswgmt5UoWdjIXqDw0mZBByTg/kfR0BZVwY68014=; b=ghtU5skADnySWERfccuHaUPDLU
        xw5ZNDLYS8qTNezw5W/6s6oEP0HWgA1JUGbQPw67eJ1PJhSBJXv5VOjjvMmQ1ZgAzDpRYYV6Ri9OK
        uIubRA4ivmUEKXzNFttfrPbrn03mPshlB7XAYf+amj8tfUf6dQmjwFjRNgB6vEH2imqVBJx2T5MAn
        WCNSIQSI5YYkxxdPz1fzt84g/5gMFF3PI+skmmQNxpJO/UclCJYSmBm+iQTU01ZExKMIvDGC22k1W
        0DkksMIwpiaXDNwT8r7I6QWwpWA9QIS1Bd3vrxoRYfXHrNP1Rws8IbFxNZCUn3wcfm8sh8O+N0K36
        XYcWTenA==;
Received: from [2001:4bb8:105:4a81:4ef5:9f24:cda4:103f] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jx3uy-0001IV-2o; Sun, 19 Jul 2020 07:39:28 +0000
Date:   Sun, 19 Jul 2020 09:39:27 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [GIT PULL] dma-mapping fixes for 5.8
Message-ID: <20200719073927.GA114439@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 0dc589da873b58b70f4caf4b070fb0cf70fdd1dc:

  Merge tag 'iommu-fixes-v5.8-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu (2020-07-13 12:34:05 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.8-6

for you to fetch changes up to d9765e41d8e9ea2251bf73735a2895c8bad546fc:

  dma-pool: do not allocate pool memory from CMA (2020-07-14 15:46:32 +0200)

----------------------------------------------------------------
dma-mapping fixes for 5.8:

 - ensure we always have fully addressable memory in the dma coherent
   pool (Nicolas Saenz Julienne)

----------------------------------------------------------------
Nicolas Saenz Julienne (5):
      dma-direct: provide function to check physical memory area validity
      dma-pool: get rid of dma_in_atomic_pool()
      dma-pool: introduce dma_guess_pool()
      dma-pool: make sure atomic pool suits device
      dma-pool: do not allocate pool memory from CMA

 include/linux/dma-direct.h |  1 +
 kernel/dma/direct.c        |  2 +-
 kernel/dma/pool.c          | 91 ++++++++++++++++++++++++++++------------------
 3 files changed, 58 insertions(+), 36 deletions(-)
