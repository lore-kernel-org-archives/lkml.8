Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D01D5C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 19:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD69D2253D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 19:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbgAWTGI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 14:06:08 -0500
Received: from mga01.intel.com ([192.55.52.88]:29413 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728792AbgAWTGI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 14:06:08 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jan 2020 11:06:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,354,1574150400"; 
   d="scan'208";a="220764449"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by orsmga008.jf.intel.com with ESMTP; 23 Jan 2020 11:06:00 -0800
Subject: [PATCH 1/5] x86/alternatives: add missing insn.h include
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, bp@alien8.de,
        peterz@infradead.org, luto@kernel.org, x86@kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Thu, 23 Jan 2020 11:04:58 -0800
References: <20200123190456.8E05ADE6@viggo.jf.intel.com>
In-Reply-To: <20200123190456.8E05ADE6@viggo.jf.intel.com>
Message-Id: <20200123190458.00285A85@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


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
---

 b/arch/x86/kernel/alternative.c |    1 +
 1 file changed, 1 insertion(+)

diff -puN arch/x86/kernel/alternative.c~x86-alternatives-include arch/x86/kernel/alternative.c
--- a/arch/x86/kernel/alternative.c~x86-alternatives-include	2020-01-23 10:41:03.811942442 -0800
+++ b/arch/x86/kernel/alternative.c	2020-01-23 10:41:03.815942442 -0800
@@ -23,6 +23,7 @@
 #include <asm/nmi.h>
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
+#include <asm/insn.h>
 #include <asm/io.h>
 #include <asm/fixmap.h>
 
_
