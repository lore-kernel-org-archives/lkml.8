Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7919C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 13:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CDB3207E8
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 13:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589807023;
	bh=cqBFppFXywtZsKM/FNOE0/NVU4loKWJIwGTdFBK4NK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IRcUv+3CZ6sDlqcTrh6wx8jdEZqfTkbLQhRrBhCIlpBuZ0UYAByMDTNme+NJD1vEL
	 iWvZwxCVcEM9YXmqVPywECudnYSsidxb6Aho/OkQTLv7FNJyAcsdSmXTjK1Hze4260
	 jlcqcxC1e9iW5Fgp3X2zfiTWpn35q0/6Tr0FZuSs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbgERNDm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 09:03:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:46768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726726AbgERNDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 09:03:42 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5893B207D3;
        Mon, 18 May 2020 13:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589807022;
        bh=cqBFppFXywtZsKM/FNOE0/NVU4loKWJIwGTdFBK4NK4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AQzs1Mwk69tSsp5qxInzTbdXkv04DyufsIs1+gjF3sXZ9S60tnJpxVJ7p0o34FOVa
         0UDle+HFNXG2qYLjQrqK2hI0w2jrwrTjxLLvyI2MTmKnJRaV/nZ3Qi4Lg3FNyK9O2D
         MfKT2JzwFunN6II9sHmMU3UzvAPLXEJaYoucP8vI=
Date:   Mon, 18 May 2020 14:03:36 +0100
From:   Will Deacon <will@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jann Horn <jannh@google.com>, Ard Biesheuvel <ardb@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, kernel-team@android.com
Subject: Re: [PATCH 3/6] arm64: scs: Use 'scs_sp' register alias for x18
Message-ID: <20200518130335.GC32394@willie-the-truck>
References: <20200515172756.27185-1-will@kernel.org>
 <20200515172756.27185-4-will@kernel.org>
 <20200518115547.GC1957@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518115547.GC1957@C02TD0UTHF1T.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 12:55:47PM +0100, Mark Rutland wrote:
> On Fri, May 15, 2020 at 06:27:53PM +0100, Will Deacon wrote:
> > x18 holds the SCS stack pointer value, so introduce a register alias to
> > make this easier to read in assembly code.
> > 
> > Signed-off-by: Will Deacon <will@kernel.org>
> 
> I scanned through arm64 for all instances of x18, and it looks like
> you've covered all the relevant uses here. In kvm we save/restore x18 a
> bunch becasue it might be a platform register, but we do that
> unconditionally and without knowledge of what it contains, so I think
> that's fine to leave as-is. Therefore:
> 
> Reviewed-by: Mark Rutland <mark.rutland@arm.com>
> 
> As an aside, the comment in entry-ftrace.S is now stale where it says
> that x18 is safe to clobber. I can send a patch to clean that up, unless
> you want to do that yourself.

Thanks, I'll fix that up (see below). Also, apologies for typo'ing your
email address when I sent this out on Friday.

Will

--->8

From 7e86208cd6541c1229bc1fcd206596308d1727f8 Mon Sep 17 00:00:00 2001
From: Will Deacon <will@kernel.org>
Date: Mon, 18 May 2020 14:01:01 +0100
Subject: [PATCH] arm64: entry-ftrace.S: Update comment to indicate that x18 is
 live

The Shadow Call Stack pointer is held in x18, so update the ftrace
entry comment to indicate that it cannot be safely clobbered.

Reported-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/kernel/entry-ftrace.S | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/entry-ftrace.S b/arch/arm64/kernel/entry-ftrace.S
index 833d48c9acb5..a338f40e64d3 100644
--- a/arch/arm64/kernel/entry-ftrace.S
+++ b/arch/arm64/kernel/entry-ftrace.S
@@ -23,8 +23,9 @@
  *
  * ... where <entry> is either ftrace_caller or ftrace_regs_caller.
  *
- * Each instrumented function follows the AAPCS, so here x0-x8 and x19-x30 are
- * live, and x9-x18 are safe to clobber.
+ * Each instrumented function follows the AAPCS, so here x0-x8 and x18-x30 are
+ * live (x18 holds the Shadow Call Stack pointer), and x9-x17 are safe to
+ * clobber.
  *
  * We save the callsite's context into a pt_regs before invoking any ftrace
  * callbacks. So that we can get a sensible backtrace, we create a stack record
-- 
2.26.2.761.g0e0b3e54be-goog
