Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA92C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 16:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECD2C20787
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 16:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589559806;
	bh=HbqBHaV+XIZkFuflJY0Eucc7SercKD8lt8QIg3OGxhA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=08kzWhVIf+kImnIi2pcHsWnouvE2RwKefAngR4n+kqS/Z00pe5C3fFWVpM3/Eg/j7
	 WvmbnuZYoBLSm7qTltthlfc0GYLT8n/kBsgGLRMOHYHzrz8AGBhR7n3SUq7UE9ThcN
	 3idHI/8ZnV1Lnd8edXU28PSnBUMVwF6Mvkzf8D9M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgEOQXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 12:23:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:50554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbgEOQXY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 12:23:24 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81D412078C;
        Fri, 15 May 2020 16:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589559803;
        bh=HbqBHaV+XIZkFuflJY0Eucc7SercKD8lt8QIg3OGxhA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wemOiVm650T9QrpdqKpxsDYHLEdSK+CH1Ch20VwgfPR+Wr0MpSbf7XU+dxi/rFHj9
         rG92FNQGEworcfIAggrP2zo+/fwzxkNU6/nvba2DypmY6d9iI3lRyNmlfNrJrLtLDZ
         ZPS2stFk5fi2bPosg1Q7nmOMROrJX53BiKMTbiDk=
Date:   Fri, 15 May 2020 17:23:17 +0100
From:   Will Deacon <will@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net, liwei391@huawei.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        sumit.garg@linaro.org, Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Dave Martin <Dave.Martin@arm.com>,
        Enrico Weigelt <info@metux.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Zenghui Yu <yuzenghui@huawei.com>,
        jinho lim <jordan.lim@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: Call debug_traps_init() from trap_init() to help
 early kgdb
Message-ID: <20200515162316.GB23334@willie-the-truck>
References: <20200513160501.1.I0b5edf030cc6ebef6ab4829f8867cdaea42485d8@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513160501.1.I0b5edf030cc6ebef6ab4829f8867cdaea42485d8@changeid>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 04:06:37PM -0700, Douglas Anderson wrote:
> A new kgdb feature will soon land (kgdb_earlycon) that lets us run
> kgdb much earlier.  In order for everything to work properly it's
> important that the break hook is setup by the time we process
> "kgdbwait".
> 
> Right now the break hook is setup in debug_traps_init() and that's
> called from arch_initcall().  That's a bit too late since
> kgdb_earlycon really needs things to be setup by the time the system
> calls dbg_late_init().
> 
> We could fix this by adding call_break_hook() into early_brk64() and
> that works fine.  However, it's a little ugly.  Instead, let's just
> add a call to debug_traps_init() straight from trap_init().  There's
> already a documented dependency between trap_init() and
> debug_traps_init() and this makes the dependency more obvious rather
> than just relying on a comment.
> 
> NOTE: this solution isn't early enough to let us select the
> "ARCH_HAS_EARLY_DEBUG" KConfig option that is introduced by the
> kgdb_earlycon patch series.  That would only be set if we could do
> breakpoints when early params are parsed.  This patch only enables
> "late early" breakpoints, AKA breakpoints when dbg_late_init() is
> called.  It's expected that this should be fine for most people.
> 
> It should also be noted that if you crash you can still end up in kgdb
> earlier than debug_traps_init().  Since you don't need breakpoints to
> debug a crash that's fine.
> 
> Suggested-by: Will Deacon <will@kernel.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> ---
> This replaces the patch ("arm64: Add call_break_hook() to
> early_brk64() for early kgdb") in my recent kgdb series [1].  If I end
> up re-posting that series again I'll include this patch as a
> replacement, but I'm sending it separately to avoid spamming a pile of
> people another time with a 12-patch series.
> 
> Note that, because it doesn't select the "ARCH_HAS_EARLY_DEBUG"
> KConfig option it could be landed standalone.  However, it's still
> probably better to land together with that patch series.
> 
> If the kgdb_earlycon patch series lands without this patch then
> kgdbwait + kgdb_earlycon won't work well on arm64, but there would be
> no other bad side effects.
> 
> If this patch lands without the kgdb_earlycon patch series then there
> will be no known problems.
> 
> [1] https://lore.kernel.org/r/20200507130644.v4.5.I22067ad43e77ddfd4b64c2d49030628480f9e8d9@changeid
> 
>  arch/arm64/include/asm/debug-monitors.h | 2 ++
>  arch/arm64/kernel/debug-monitors.c      | 4 +---
>  arch/arm64/kernel/traps.c               | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)

[...]

Acked-by: Will Deacon <will@kernel.org>

I would prefer to take this via arm64, if possible, since we have quite lot
going in for 5.8, although I don't think this conflicts at the moment.

Daniel -- what do you want to do?

Will
