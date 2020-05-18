Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA12C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 13:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3081620671
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 13:13:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgERNN1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 09:13:27 -0400
Received: from foss.arm.com ([217.140.110.172]:40206 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726726AbgERNN1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 09:13:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 45039101E;
        Mon, 18 May 2020 06:13:26 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.29.34])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F09183F305;
        Mon, 18 May 2020 06:13:23 -0700 (PDT)
Date:   Mon, 18 May 2020 14:13:17 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jann Horn <jannh@google.com>, Ard Biesheuvel <ardb@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, kernel-team@android.com
Subject: Re: [PATCH 3/6] arm64: scs: Use 'scs_sp' register alias for x18
Message-ID: <20200518131317.GA2787@C02TD0UTHF1T.local>
References: <20200515172756.27185-1-will@kernel.org>
 <20200515172756.27185-4-will@kernel.org>
 <20200518115547.GC1957@C02TD0UTHF1T.local>
 <20200518130335.GC32394@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518130335.GC32394@willie-the-truck>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 02:03:36PM +0100, Will Deacon wrote:
> On Mon, May 18, 2020 at 12:55:47PM +0100, Mark Rutland wrote:
> > On Fri, May 15, 2020 at 06:27:53PM +0100, Will Deacon wrote:
> > > x18 holds the SCS stack pointer value, so introduce a register alias to
> > > make this easier to read in assembly code.
> > > 
> > > Signed-off-by: Will Deacon <will@kernel.org>
> > 
> > I scanned through arm64 for all instances of x18, and it looks like
> > you've covered all the relevant uses here. In kvm we save/restore x18 a
> > bunch becasue it might be a platform register, but we do that
> > unconditionally and without knowledge of what it contains, so I think
> > that's fine to leave as-is. Therefore:
> > 
> > Reviewed-by: Mark Rutland <mark.rutland@arm.com>
> > 
> > As an aside, the comment in entry-ftrace.S is now stale where it says
> > that x18 is safe to clobber. I can send a patch to clean that up, unless
> > you want to do that yourself.
> 
> Thanks, I'll fix that up (see below). Also, apologies for typo'ing your
> email address when I sent this out on Friday.

No worries; I'd already forgotten!

> 
> Will
> 
> --->8
> 
> From 7e86208cd6541c1229bc1fcd206596308d1727f8 Mon Sep 17 00:00:00 2001
> From: Will Deacon <will@kernel.org>
> Date: Mon, 18 May 2020 14:01:01 +0100
> Subject: [PATCH] arm64: entry-ftrace.S: Update comment to indicate that x18 is
>  live
> 
> The Shadow Call Stack pointer is held in x18, so update the ftrace
> entry comment to indicate that it cannot be safely clobbered.
> 
> Reported-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  arch/arm64/kernel/entry-ftrace.S | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/entry-ftrace.S b/arch/arm64/kernel/entry-ftrace.S
> index 833d48c9acb5..a338f40e64d3 100644
> --- a/arch/arm64/kernel/entry-ftrace.S
> +++ b/arch/arm64/kernel/entry-ftrace.S
> @@ -23,8 +23,9 @@
>   *
>   * ... where <entry> is either ftrace_caller or ftrace_regs_caller.
>   *
> - * Each instrumented function follows the AAPCS, so here x0-x8 and x19-x30 are
> - * live, and x9-x18 are safe to clobber.
> + * Each instrumented function follows the AAPCS, so here x0-x8 and x18-x30 are
> + * live (x18 holds the Shadow Call Stack pointer), and x9-x17 are safe to
> + * clobber.

I'd have called out x18 a bit more specifically:

| Each instrumented function follows the AAPCS, so here x0-x8 and x19-x30 are
| live, x18 is potentially live with a shadow call stack pointer, and
| x9-x17 are safe to clobber.

... but either way this looks good; thanks!

Mark.
