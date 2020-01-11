Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D512AC33CA4
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A23F62084D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578738417;
	bh=hSGYfNe8GPP70YoHWEbU36WYd8TDtFyPd8AnsakfnoE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W9iFvSXVs9Q4T3pwblC01YcluJGrNDPVt17evsKkRitUZkRXLlHgJWYFHmBCw4+C5
	 XVpi3ovrE+SM2KSnLgPct8jwMmyMrjfVdGtAgnUA22Ox0z5qXhqhnIrzWOSa9dc17y
	 2mYl9QefYCxoF9LR2/p4qJA4WvDBvzs2eecMz2kI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731140AbgAKK04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 05:26:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:60202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729122AbgAKK0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 05:26:54 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41DA92082E;
        Sat, 11 Jan 2020 10:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578738414;
        bh=hSGYfNe8GPP70YoHWEbU36WYd8TDtFyPd8AnsakfnoE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lTsJMpOxvE73nemt0GArLND8GY+/1FkrpFkhBheSFCwQ8q6DT+cBFvwdfwF/Q5L7v
         uz1OhsUHS8VY3aT5Wcp87uisf6aoxtNozuvpO8B+EoGPs9t7O1KBH1q0z1kOYIC3n1
         /BlDJ7miuObhsbeRwipEariMu+Q49XabtPS9X5Ac=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christian Zigotzky <chzigotzky@xenosoft.de>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 072/165] powerpc: Ensure that swiotlb buffer is allocated from low memory
Date:   Sat, 11 Jan 2020 10:49:51 +0100
Message-Id: <20200111094927.187543235@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200111094921.347491861@linuxfoundation.org>
References: <20200111094921.347491861@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

[ Upstream commit 8fabc623238e68b3ac63c0dd1657bf86c1fa33af ]

Some powerpc platforms (e.g. 85xx) limit DMA-able memory way below 4G.
If a system has more physical memory than this limit, the swiotlb
buffer is not addressable because it is allocated from memblock using
top-down mode.

Force memblock to bottom-up mode before calling swiotlb_init() to
ensure that the swiotlb buffer is DMA-able.

Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20191204123524.22919-1-rppt@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/mm/mem.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index d30a2e6e68b4..9f5b32163bda 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -282,6 +282,14 @@ void __init mem_init(void)
 	BUILD_BUG_ON(MMU_PAGE_COUNT > 16);
 
 #ifdef CONFIG_SWIOTLB
+	/*
+	 * Some platforms (e.g. 85xx) limit DMA-able memory way below
+	 * 4G. We force memblock to bottom-up mode to ensure that the
+	 * memory allocated in swiotlb_init() is DMA-able.
+	 * As it's the last memblock allocation, no need to reset it
+	 * back to to-down.
+	 */
+	memblock_set_bottom_up(true);
 	swiotlb_init(0);
 #endif
 
-- 
2.20.1



