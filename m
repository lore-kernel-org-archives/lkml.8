Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92AF4C2BA2B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 08:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69A292078E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 08:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SNfkwFxF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbgDKI2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 04:28:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34504 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgDKI2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 04:28:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=KfuGWUe+2Mm9mM6Tq6DQzvlxZlTVJLQ8Twm6DUylGx0=; b=SNfkwFxFTzvmT9W6Vu4e3A3hT2
        bTlFmVVNjr1HLot9N1LHO/aY0mV5b1s+LHhNHfhIBf09UW9QQcHaK4ZqUzSchx+lThpnTAA+2kju+
        SIgkS85jYu802NOc6Cb9oq/FNbHzjY6JZUxKLtZX92zG4Z7W4hQBFDyLEYiF0tmqpf8KeJfEPpphG
        /oyFF0r35c9F+RMiHB5CORzlap4qGWYN+3jbNKhO/uU6rFQ+AVlU4QW8UkT2Muv+EEeLJIbNx5aGL
        5FME3ZaDTwgpXMMUsRBiXF+myUU006aZDscpsINyoDYqdHGHNFdb+4X20r8I8boyuzYXuv8DbpH3z
        eBlWitcQ==;
Received: from [2001:4bb8:180:5765:8cdf:b820:7ed9:b80c] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jNBUf-0002nz-VN; Sat, 11 Apr 2020 08:28:02 +0000
Date:   Sat, 11 Apr 2020 10:28:00 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [GIT PULL] dma-mapping fixes for 5.7
Message-ID: <20200411082800.GA1807013@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit f5e94d10e4c468357019e5c28d48499f677b284f:

  Merge tag 'drm-next-2020-04-08' of git://anongit.freedesktop.org/drm/drm (2020-04-07 20:24:34 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.7-1

for you to fetch changes up to 9bb50ed7470944238ec8e30a94ef096caf9056ee:

  dma-debug: fix displaying of dma allocation type (2020-04-08 21:46:57 +0200)

----------------------------------------------------------------
dma-mapping fixes for 5.7

 - fix an integer truncation in dma_direct_get_required_mask
   (Kishon Vijay Abraham)
 - fix the display of dma mapping types (Grygorii Strashko)

----------------------------------------------------------------
Grygorii Strashko (1):
      dma-debug: fix displaying of dma allocation type

Kishon Vijay Abraham I (1):
      dma-direct: fix data truncation in dma_direct_get_required_mask()

 kernel/dma/debug.c  | 9 ++++++---
 kernel/dma/direct.c | 3 ++-
 2 files changed, 8 insertions(+), 4 deletions(-)
