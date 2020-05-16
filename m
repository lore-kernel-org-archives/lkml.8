Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFFEC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 20:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFD61206D8
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 20:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jHGOapOX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgEPU33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 16:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726422AbgEPU32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 16:29:28 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64348C061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 13:29:28 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id y3so7380459wrt.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 13:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HT2TVJMFayGUD83EGAbk8hf3i1gxi7dkBOjvsWeu/kI=;
        b=jHGOapOXAI3oRxVWb3QmEM35rLrSSZyxRRMdKTuSibl7WIRZ4f68YCTl/fhYXIxl/t
         2pKXBNuVkvs8JDQukmlYEyeksSKj2VTRq/Gt6VMMchY6XN5LQJcTN+VndCWP0/Geu87q
         eSAn2J5FK7TqiOy2s3qgR3n3nsm/8kUFWpUWw341x6mHVvCGT8JxIiVDEhQu47n3ysvN
         bymsBeFi/Sw9FHw2Jp4V0/4Cy/Fkqs8i9kiPKD3BexyiEQGjZktsD5nwpXibKctwPARs
         65r07ygWDf2zc4tAt7/tFRN3Wx8pLmtH5tayuqfjNXvbZvxjv7Hwt9bi8UXLUHL9K4xP
         fKVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HT2TVJMFayGUD83EGAbk8hf3i1gxi7dkBOjvsWeu/kI=;
        b=lTEGWgvyZUzSafg0we2gnplb4haVhdhQtI3bqlUSdORSoCc3wSFZksKsi8awV5U7p5
         kko5O8J55rAuWGGZCZQ/KZ78xpX3UDFctXLCCMgylfeT4otCyKF+R/dqL4BGqtdzoFXo
         Xxux8y1EhH7SsB4ZeN342shVG9Giz/mqbP7wx1z4ItqWk3/VPjtSJrKvMnwJRj7Xecvh
         9i0Pyqaviukyb/SWihMCe0DVk9pgIcC0CC72P58yUnHTcZaaw7A3Lh9l8a/jSsaxiyAp
         EWZo6MFWY9Oz36Y1/OIyv6wh7NPusVtV1aJmU9sV3u18B+T5R2D8KBCX21aKN2FCQ2UB
         fwWQ==
X-Gm-Message-State: AOAM532GYKpdfVrOyR1CV2aLCMPAte6exP53wRNCvHvvUYUpevAQglBy
        4XX+E97OUxcVQSpBvGe6J+K5Bw==
X-Google-Smtp-Source: ABdhPJxD56c80RnLiAXEYv73ZxwFHD3aDDC2eWQq4okfk+viJypD6EhiHd4j2iC0mCNxdB97WtsohQ==
X-Received: by 2002:adf:dd50:: with SMTP id u16mr11815583wrm.58.1589660967004;
        Sat, 16 May 2020 13:29:27 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id o15sm7985249wrw.65.2020.05.16.13.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2020 13:29:26 -0700 (PDT)
Date:   Sat, 16 May 2020 21:29:22 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Will Deacon <will@kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Jason Wessel <jason.wessel@windriver.com>,
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
Message-ID: <20200516202922.j7t2kocavj3ppwjk@holly.lan>
References: <20200513160501.1.I0b5edf030cc6ebef6ab4829f8867cdaea42485d8@changeid>
 <20200515162316.GB23334@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515162316.GB23334@willie-the-truck>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 05:23:17PM +0100, Will Deacon wrote:
> On Wed, May 13, 2020 at 04:06:37PM -0700, Douglas Anderson wrote:
> > A new kgdb feature will soon land (kgdb_earlycon) that lets us run
> > kgdb much earlier.  In order for everything to work properly it's
> > important that the break hook is setup by the time we process
> > "kgdbwait".
> > 
> > Right now the break hook is setup in debug_traps_init() and that's
> > called from arch_initcall().  That's a bit too late since
> > kgdb_earlycon really needs things to be setup by the time the system
> > calls dbg_late_init().
> > 
> > We could fix this by adding call_break_hook() into early_brk64() and
> > that works fine.  However, it's a little ugly.  Instead, let's just
> > add a call to debug_traps_init() straight from trap_init().  There's
> > already a documented dependency between trap_init() and
> > debug_traps_init() and this makes the dependency more obvious rather
> > than just relying on a comment.
> > 
> > NOTE: this solution isn't early enough to let us select the
> > "ARCH_HAS_EARLY_DEBUG" KConfig option that is introduced by the
> > kgdb_earlycon patch series.  That would only be set if we could do
> > breakpoints when early params are parsed.  This patch only enables
> > "late early" breakpoints, AKA breakpoints when dbg_late_init() is
> > called.  It's expected that this should be fine for most people.
> > 
> > It should also be noted that if you crash you can still end up in kgdb
> > earlier than debug_traps_init().  Since you don't need breakpoints to
> > debug a crash that's fine.
> > 
> > Suggested-by: Will Deacon <will@kernel.org>
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > ---
> > This replaces the patch ("arm64: Add call_break_hook() to
> > early_brk64() for early kgdb") in my recent kgdb series [1].  If I end
> > up re-posting that series again I'll include this patch as a
> > replacement, but I'm sending it separately to avoid spamming a pile of
> > people another time with a 12-patch series.
> > 
> > Note that, because it doesn't select the "ARCH_HAS_EARLY_DEBUG"
> > KConfig option it could be landed standalone.  However, it's still
> > probably better to land together with that patch series.
> > 
> > If the kgdb_earlycon patch series lands without this patch then
> > kgdbwait + kgdb_earlycon won't work well on arm64, but there would be
> > no other bad side effects.
> > 
> > If this patch lands without the kgdb_earlycon patch series then there
> > will be no known problems.
> > 
> > [1] https://lore.kernel.org/r/20200507130644.v4.5.I22067ad43e77ddfd4b64c2d49030628480f9e8d9@changeid
> > 
> >  arch/arm64/include/asm/debug-monitors.h | 2 ++
> >  arch/arm64/kernel/debug-monitors.c      | 4 +---
> >  arch/arm64/kernel/traps.c               | 2 +-
> >  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> [...]
> 
> Acked-by: Will Deacon <will@kernel.org>
> 
> I would prefer to take this via arm64, if possible, since we have quite lot
> going in for 5.8, although I don't think this conflicts at the moment.
> 
> Daniel -- what do you want to do?

I'm very happy for you to take it!

On my side I hope to get the rest of the patchset into linux-next early
next week.


Daniel.
