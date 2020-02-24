Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4920C38BE2
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 19:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79D6621556
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 19:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kOdWiO2R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbgBXTpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 14:45:25 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47728 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727306AbgBXTpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 14:45:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Gm+CZDA4foMEAz/S+YdRBY9FpP1n0eNdAAovqDbFGNg=; b=kOdWiO2RLPJPCA0ELRlD0fILnT
        Hi17mnHqCr3opBFn3tuitDQ9PxTd5CxA8RrpffuZlpZUQUuTCUbA/BMJ/yAzkokW5xwqVmVQl6DEo
        Hi0W2vxjbyZnTDPXfH7Ijkrysfk6fHLOAzCzJ3e88xupPe+U0VuVbftERt+dg39KCPM8wZZAxckFC
        9KFd7o9hjEIGnP0u6hKYx5GMF3xVd8rv/AS2KPITioAVtYya/wB/YIzTZX0VXITAt1pqDLfdSzekD
        SVtd+sn9CvtDhaY+TIbSPFpU1aQ52j6ym6jqrKZn1g3k+cLllQ2KdXym3e1aIJ/lbzDZw43sVXMFV
        13FNIrsA==;
Received: from [4.28.11.157] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j6Jeo-0006X6-W0; Mon, 24 Feb 2020 19:44:47 +0000
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
Subject: provide in-place uncached remapping for dma-direct v2
Date:   Mon, 24 Feb 2020 11:44:40 -0800
Message-Id: <20200224194446.690816-1-hch@lst.de>
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

Changes since v1:
 - share the arch hook for inline remap and uncached segment support
