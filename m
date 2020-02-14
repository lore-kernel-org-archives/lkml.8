Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2713C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B4732168B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581704265;
	bh=4oK1Sf0uQAo47wZc1HCZMY+2v3HU76VTHZsnsyKVW/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PJO6NbYB38zdN90wW1b38SgVfv3POm13xDSt/WzTT7MI103/4sRxuFskm2g9kLXtd
	 f6cWaVagTCeTkClogsfdc4Ly3//CH6G1tx77pS/iIBBibJUXkTdUvEeAy4LSoYCyAb
	 bEH2GCWES9mRsOXDzIEkJW1GgrFZwEeVaPvL3I28=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730061AbgBNPvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 10:51:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:55700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730033AbgBNPvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:51:02 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1CBD2467D;
        Fri, 14 Feb 2020 15:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581695461;
        bh=4oK1Sf0uQAo47wZc1HCZMY+2v3HU76VTHZsnsyKVW/A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mMI5bdUG93Tc8OrfTyfkzlsQDUUnAx+d7Z7jVmhf7nBfhULAeyTjM+OXOlyFHKkMo
         8hKuMzchs30NqrFfQhdxJwLky1xY7zqSoOuqy8mQSISPkshpdQSp7mXCJINkZfLL/j
         jeyGopgROQJuXHE+3rPZtHZIMpVslwCtIfP0E8Ls=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.5 098/542] x86/alternatives: add missing insn.h include
Date:   Fri, 14 Feb 2020 10:41:30 -0500
Message-Id: <20200214154854.6746-98-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Hansen <dave.hansen@linux.intel.com>

[ Upstream commit 3a1255396b5aba40299d5dd5bde67b160a44117f ]

From: Dave Hansen <dave.hansen@linux.intel.com>

While testing my MPX removal series, Borislav noted compilation
failure with an allnoconfig build.

Turned out to be a missing include of insn.h in alternative.c.
With MPX, it got it implicitly from:

	asm/mmu_context.h -> asm/mpx.h -> asm/insn.h

Fixes: c3d6324f841b ("x86/alternatives: Teach text_poke_bp() to emulate instructions")
Reported-by: Borislav Petkov <bp@alien8.de>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: x86@kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/alternative.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 9ec463fe96f2c..2f1e2333bd0af 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -23,6 +23,7 @@
 #include <asm/nmi.h>
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
+#include <asm/insn.h>
 #include <asm/io.h>
 #include <asm/fixmap.h>
 
-- 
2.20.1

