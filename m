Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C279FC433E6
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 06:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AA1B2078D
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 06:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cnqnp0AE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbgH3Gbk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 02:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgH3Gbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 02:31:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62597C061573
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 23:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=w4rdv8966e/ci26pS2v3qeUYzDOBI3t7rgVpxPk1vag=; b=cnqnp0AESXTufJkmw+5NN2Xb/N
        4VPK2PuL1Sb8xnYL1iTN85h2qjRgCTzmInTNmiD4bzi/dRt30jGHhWUJgBD9HoMUZHOEIxAlFOS/8
        6/uTTlDaGRYoM9B5M64KwwP0+/XACA1pkscZxMsyHnr+eGBQzuQff/XMVDpoYAtJ/LH5d76nES6W9
        jqNY6pn2xSfnaXvOXuWSbtxV1lfb1uuDxCLOLUX2zy3u0wPwBtuFyeyQs5buvRYcMM0CRZ1tCcvJq
        WZhHHvE6jh0mUlV2vvOCX7JwhwIby+dKVcp6vUlzYNP6YzYnpzwriIZxZaUlV8ikXrgSEBA/8t8lc
        nzBEVQ+w==;
Received: from [2001:4bb8:18c:45ba:9892:9e86:5202:32f0] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kCGsK-00035u-EN; Sun, 30 Aug 2020 06:31:36 +0000
Date:   Sun, 30 Aug 2020 08:31:35 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [GIT PULL] dma-mapping fix for 5.9
Message-ID: <20200830063135.GA1224156@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 15bc20c6af4ceee97a1f90b43c0e386643c071b4:

  Merge tag 'tty-5.9-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty (2020-08-26 10:58:20 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.9-2

for you to fetch changes up to 892fc9f6835ecf075efac20789b012c5c9997fcc:

  dma-pool: Fix an uninitialized variable bug in atomic_pool_expand() (2020-08-27 09:22:56 +0200)

----------------------------------------------------------------
dma-mapping fixes:

 - fix a possibly uninitialized variable (Dan Carpenter)

----------------------------------------------------------------
Dan Carpenter (1):
      dma-pool: Fix an uninitialized variable bug in atomic_pool_expand()

 kernel/dma/pool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
