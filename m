Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 001B9C11D10
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 17:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C278D208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 17:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uSibnpG4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbgBTRCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 12:02:01 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33378 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbgBTRB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 12:01:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=dLNx8yX02Kzj1oRWP3mQD5vnGq79lBQ8cwVKhpycAZU=; b=uSibnpG4et9iRS/SQKSZvPJsfe
        BNFYB6zM8VxBcUm+5sWKKTywGlUovha7UjiuM6nmUPPtjn97te4EUKaR7o8HMOhU8KQNJSIkj73x4
        hA6CyflXuURlc7KE+Fl9Zmm2pHBliqPY/WIuZpukZjf9cziZ3V5j1TgeZ0uv2MK5na+1VgxBd9ccm
        hXqSYX1MVuq1qT/edFquvfjDnXFvAl8F+TEXDuLz/UHYbJnK1Frlt3UDyuy485gpeeH9doY8Z33+W
        QgS1wyszKEEpVdZ7LTw6mCYUBwEePrRmT5dQSFSOlwxjIjoMPTNO0M7pOpbfZuFLEPLt8ekGXtL/G
        v6wEkOQw==;
Received: from [38.126.112.138] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4pCl-0000Dh-7w; Thu, 20 Feb 2020 17:01:39 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        openrisc@lists.librecores.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: provide in-place uncached remapping for dma-direct (resend)
Date:   Thu, 20 Feb 2020 09:01:37 -0800
Message-Id: <20200220170139.387354-1-hch@lst.de>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

this series provides support for remapping places uncached in-place in
the generic dma-direct code, and moves openrisc over from its own
in-place remapping scheme.  The arm64 folks also had interest in such
a scheme to avoid problems with speculating into cache aliases.

Also all architectures that always use small page mappings for the
kernel and have non-coherent DMA should look into enabling this
scheme, as it is much more efficient than the vmap remapping.
