Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3169EC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07C8C20637
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581700681;
	bh=mZ3fx8mTTL31/4gxDSr6omrV4zrRgZozY8m6tMPa8Eg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Gd/cWJYOLfj8AXcMBxvVkQzC/RiFNyufGN52qBD8wY1hTFC3eEVPiEQkGSe3/NeOt
	 +JDpeqyFe/bs3Nla4Ps+XKGJ6GQRMP0/xWO/CPEo/q8m82wB/iyzk+rFhJZaQmuAda
	 uDj+F7jZf4GlSWM1Glkmw+mKdLWDFFPjhq893aMs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391981AbgBNRRq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:17:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:37936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391760AbgBNQLS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:11:18 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11AC924680;
        Fri, 14 Feb 2020 16:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696678;
        bh=mZ3fx8mTTL31/4gxDSr6omrV4zrRgZozY8m6tMPa8Eg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QjNnFqsaecpd5ka4YiuDSVmlz3lSABWDsH/mWpqzJSR3lVnGd1K82F1z81SxE75Vt
         TQ+0I4jfAy7otG4lakBoJS5GP+AhLFsyrhR6YVZGNtFIOwD3MoloHFq9pFlnXMjU3U
         xBgVatwAj2k0IjXcgDVjuGuNjbrSPKoXDRKW9rc0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 446/459] asm-generic/tlb: add missing CONFIG symbol
Date:   Fri, 14 Feb 2020 11:01:36 -0500
Message-Id: <20200214160149.11681-446-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214160149.11681-1-sashal@kernel.org>
References: <20200214160149.11681-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit 27796d03c9c4b2b937ed4cc2b10f21559ad5a8c9 ]

Without this the symbol will not actually end up in .config files.

Link: http://lkml.kernel.org/r/20200116064531.483522-6-aneesh.kumar@linux.ibm.com
Fixes: a30e32bd79e9 ("asm-generic/tlb: Provide generic tlb_flush() based on flush_tlb_mm()")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 43102756304c1..238dccfa76910 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -399,6 +399,9 @@ config HAVE_RCU_TABLE_FREE
 config HAVE_MMU_GATHER_PAGE_SIZE
 	bool
 
+config MMU_GATHER_NO_RANGE
+	bool
+
 config HAVE_MMU_GATHER_NO_GATHER
 	bool
 
-- 
2.20.1

