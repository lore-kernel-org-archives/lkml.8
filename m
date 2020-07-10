Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEBD6C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 15:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9744420725
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 15:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XJBiP+/b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbgGJPrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 11:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgGJPrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 11:47:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C3CC08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 08:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=vCsywWVyci9HlOV4imkRZosCZdjmA3MYbicJkkOvp3w=; b=XJBiP+/bOFSCF5Jy4+oXiTpcf/
        GfMLG7vgyn7RjT7wuZPO8EsK9vVW7VtCui1m4vtMZAQdBruj/JiBXv7AFFNjDEDGLGjDH6d2k/DR4
        cQlTbrXt2FbA4yBDNeXJ6lWyyxsFbExvrx45MCi7plNEPHHN+/8Yj1yolOrDVIKoC44gayFlMF5U9
        j8UZ1oPrmmT/sJHAPzkcvQDhLuqfa9cTKyEFr17FCcqDaND4r2xEjp+Ty6H/6Rp58TUJfUdWijSiM
        oQfVYCo1N21McJfzmukC9lMz/NJTrA2/Z6kMPw+miERDkz2u3sRTaz2LZY7mjMDDIiWWAEvD/m4FU
        RmQcc/eQ==;
Received: from 089144201169.atnat0010.highway.a1.net ([89.144.201.169] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jtvF7-0001vd-8z; Fri, 10 Jul 2020 15:47:17 +0000
Date:   Fri, 10 Jul 2020 17:45:06 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [GIT PULL] dma-mapping fixes for 5.8
Message-ID: <20200710154506.GA540305@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 9ebcfadb0610322ac537dd7aa5d9cbc2b2894c68:

  Linux 5.8-rc3 (2020-06-28 15:00:24 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.8-5

for you to fetch changes up to 68d237056e007c88031d80900cdba0945121a287:

  scatterlist: protect parameters of the sg_table related macros (2020-07-06 16:07:25 +0200)

----------------------------------------------------------------
dma-mapping fixes for 5.8

 - add a warning when the atomic pool is depleted (David Rientjes)
 - protect the parameters of the new scatterlist helper macros
   (Marek Szyprowski )

----------------------------------------------------------------
David Rientjes (1):
      dma-mapping: warn when coherent pool is depleted

Marek Szyprowski (1):
      scatterlist: protect parameters of the sg_table related macros

 include/linux/scatterlist.h | 8 ++++----
 kernel/dma/pool.c           | 6 +++++-
 2 files changed, 9 insertions(+), 5 deletions(-)
