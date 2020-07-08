Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A595C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 15:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34036206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 15:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="viyDx+ee"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730108AbgGHP32 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 11:29:28 -0400
Received: from casper.infradead.org ([90.155.50.34]:37122 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729022AbgGHP32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 11:29:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=N8lHywqGbtnmlIc888+bV79uuU+fuqr8NT0KCg3mTcg=; b=viyDx+ee5J2iBJ3SHuhkTe64ex
        nPggVaOCNbVbq3gLYgaZn/l9njs3icaTSUoD2+VtbEHFctvNdK67a4IcxTeamhz9ucJm5ski4dEO9
        SUMBENSbNZVJ61wfmqFFiqHdlbUGQXpCZc+u/1FF1jRy62DxPVVzMdSRobfQ4xjGEZu/cciBdvZXu
        wacHtK8QaMqFAMl3xVXcdP9QTzFIy/Dvafd40JRsN0fjgpoYKuFaDepQybQwX13pVKyXQcnZISmPZ
        Q5q3+RdAwhwGOaH14t0dGyNhFA6pQpsNfGKTwS7qChg1UbMSaJtGEKdacdn7hZ4CLrnGSFSNGb8EU
        FA572Rtg==;
Received: from 213-225-32-40.nat.highway.a1.net ([213.225.32.40] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jtByQ-0002A2-VT; Wed, 08 Jul 2020 15:27:13 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org,
        Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     linuxppc-dev@lists.ozlabs.org, Lu Baolu <baolu.lu@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        linux-kernel@vger.kernel.org
Subject: generic DMA bypass flag v4
Date:   Wed,  8 Jul 2020 17:24:44 +0200
Message-Id: <20200708152449.316476-1-hch@lst.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I've recently beeing chatting with Lu about using dma-iommu and
per-device DMA ops in the intel IOMMU driver, and one missing feature
in dma-iommu is a bypass mode where the direct mapping is used even
when an iommu is attached to improve performance.  The powerpc
code already has a similar mode, so I'd like to move it to the core
DMA mapping code.  As part of that I noticed that the current
powerpc code has a little bug in that it used the wrong check in the
dma_sync_* routines to see if the direct mapping code is used.

These two patches just add the generic code and move powerpc over,
the intel IOMMU bits will require a separate discussion.

The x86 AMD Gart code also has a bypass mode, but it is a lot
strange, so I'm not going to touch it for now.

Note that as-is this breaks the XSK buffer pool, which unfortunately
poked directly into DMA internals.  A fix for that is already queued
up in the netdev tree.

Jesper and XDP gang: this should not regress any performance as
the dma-direct calls are now inlined into the out of line DMA mapping
calls.  But if you can verify the performance numbers that would be
greatly appreciated.

A git tree is available here:

    git://git.infradead.org/users/hch/misc.git dma-bypass.4

Gitweb:

    git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-bypass.4


Changes since v3:
 - add config options for the dma ops bypass and dma ops themselves
   to not increase the size of tinyconfig builds

Changes since v2:
 - move the dma mapping helpers out of line
 - check for possible direct mappings using the dma mask

Changes since v1:
 - rebased to the current dma-mapping-for-next tree


Diffstat:
 arch/alpha/Kconfig                |    1 
 arch/arm/Kconfig                  |    1 
 arch/ia64/Kconfig                 |    1 
 arch/mips/Kconfig                 |    1 
 arch/parisc/Kconfig               |    1 
 arch/powerpc/Kconfig              |    2 
 arch/powerpc/include/asm/device.h |    5 
 arch/powerpc/kernel/dma-iommu.c   |   90 +------------
 arch/s390/Kconfig                 |    1 
 arch/sparc/Kconfig                |    1 
 arch/x86/Kconfig                  |    1 
 drivers/iommu/Kconfig             |    2 
 drivers/misc/mic/Kconfig          |    1 
 drivers/vdpa/Kconfig              |    1 
 drivers/xen/Kconfig               |    1 
 include/linux/device.h            |   11 +
 include/linux/dma-direct.h        |  104 +++++++++++++++
 include/linux/dma-mapping.h       |  251 ++++----------------------------------
 kernel/dma/Kconfig                |   12 +
 kernel/dma/Makefile               |    3 
 kernel/dma/direct.c               |   74 -----------
 kernel/dma/mapping.c              |  214 ++++++++++++++++++++++++++++++--
 22 files changed, 385 insertions(+), 394 deletions(-)
