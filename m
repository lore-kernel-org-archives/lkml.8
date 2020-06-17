Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF902C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 07:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EBFA208B8
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 07:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fIldEh8F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbgFQH1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 03:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgFQH1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 03:27:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FA2C061573
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 00:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=NRn8O7QYdNpRrlpQXqZW82Rfx5PaLTNAyku21vFzCVU=; b=fIldEh8F0gwl0Xcrw20BWI7wS5
        mS05t+cN5LkOX+nposGs10vbzg0P6uJFl8vFD3VCSwGeEn4to17QJtaqmvbkmcgsooV1odPuO8QLv
        EmtvCecJoB6DVODf+B8IEMbXXR5HEMdrmNcTybSgXRZtAncvjjPmJsjHVti3Y+FdU2LIniiWQ4804
        XCWT7EtndQfzact0uZ4cgKPYO43d+xrUNR47ou3Ei4RMM3FFZ8gpgCMYxDiPQcI/7Bhd6PvovI33q
        Xyi8UstkcnnSulnbbJxy7b0osokUiNLYdeJd//ZL4crd+3tHi2JWGK9Rr0wSAGlG57wcVLzBWmkP0
        iFQzVATw==;
Received: from 195-192-102-148.dyn.cablelink.at ([195.192.102.148] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jlSTf-0003eU-IM; Wed, 17 Jun 2020 07:27:19 +0000
Date:   Wed, 17 Jun 2020 09:27:16 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [GIT PULL] dma-mapping fixes for 5.8
Message-ID: <20200617072716.GA7356@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit abfbb29297c27e3f101f348dc9e467b0fe70f919:

  Merge tag 'rproc-v5.8' of git://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc (2020-06-08 13:01:08 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.8-3

for you to fetch changes up to dbed452a078d56bc7f1abecc3edd6a75e8e4484e:

  dma-pool: decouple DMA_REMAP from DMA_COHERENT_POOL (2020-06-15 08:35:30 +0200)

----------------------------------------------------------------
dma-mapping fixes for 5.8

 - fixes for the SEV atomic pool (Geert Uytterhoeven and David Rientjes)

----------------------------------------------------------------
David Rientjes (1):
      dma-pool: decouple DMA_REMAP from DMA_COHERENT_POOL

Geert Uytterhoeven (1):
      dma-pool: fix too large DMA pools on medium memory size systems

 kernel/dma/Kconfig | 10 +++++-----
 kernel/dma/pool.c  |  7 +++----
 2 files changed, 8 insertions(+), 9 deletions(-)
