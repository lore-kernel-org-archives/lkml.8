Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BEBC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 15:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2CF1206F6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 15:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZKSfrh08";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5iglhEsW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730349AbgGHP6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 11:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729022AbgGHP6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 11:58:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B42C061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 08:58:17 -0700 (PDT)
Date:   Wed, 8 Jul 2020 17:58:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594223895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hBBgGGCt/li9DGockH9AHi0xKPYeo4iYHq8uBfnLO+E=;
        b=ZKSfrh08hX+4yxiF/RyBk7gVBlMjP2EPeOe2MvB7y0tvEx59m9JHg2wmOwuW4yYoHS7nlF
        sqHj3mzdQVBxCyad/227LTKrofpbNHOM9EGE7PEtqzagjVQCAWPBGzhCHs2sPTy/VruGFm
        HSjEvYocou73NixpKemfeRt0J4ZilKftSUGrBDlVhjSF32VILCfA7fUgahLpahtf4bm5F8
        5HSvj0At6q6H/v1rtmXYXN+w2EQ3Z2Kj5+zl1LzwbxpQtyY7P+nm05BUoZyjP80uo5dHqy
        Ny39o9LaWDvrGVrSaTNLYpnuqlXulA3i0Ny6SFdbBf7j9CcXFayJDq3/rvbKTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594223895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hBBgGGCt/li9DGockH9AHi0xKPYeo4iYHq8uBfnLO+E=;
        b=5iglhEsWyiEC377p8t3Lp5pHhU7L32NfzceoswF8C7tsnnJgnq8u9BmKvBAjPmuz1yXvXA
        Sy6+y4kEu/Mh2dCw==
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 06/20] seqlock: Extend seqcount API with associated
 locks
Message-ID: <20200708155813.GA147953@debian-buster-darwi.lab.linutronix.de>
References: <20200630054452.3675847-1-a.darwish@linutronix.de>
 <20200630054452.3675847-7-a.darwish@linutronix.de>
 <20200706212148.GE5523@worktop.programming.kicks-ass.net>
 <20200707084024.GA4097637@debian-buster-darwi.lab.linutronix.de>
 <20200707130410.GO4800@hirez.programming.kicks-ass.net>
 <20200707143726.GO117543@hirez.programming.kicks-ass.net>
 <20200708103314.GB4151780@debian-buster-darwi.lab.linutronix.de>
 <20200708122938.GQ4800@hirez.programming.kicks-ass.net>
 <20200708150930.GA147323@debian-buster-darwi.lab.linutronix.de>
 <20200708153522.GR4800@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708153522.GR4800@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 08, 2020 at 05:35:22PM +0200, Peter Zijlstra wrote:
...
>
> And while the gcc-4.8 code is horrendous crap, the rest should be pretty
> straight forward and concentrates on the pieces where there are
> differences.
>

Is there any possibility of upgrading the minimum gcc version to 4.9? Is
there any supported architecture that is still stuck on 4.8?

...
> I even considered:
>
> #define __SEQPROP(name, prop, expr) \
> static __always_inline __seqprop_##prop##_t \
> __seqprop##name##_##prop(seqcount##name##_t *s) \
> { \
> 	expr; \
> }
>
> Such that we could write:
>
> __SEQPROP(, ptr, return s)
> __SEQPROP(, preempt, return false)
> __SEQPROP(, assert, )
>
> __SEQPROP(_##locktype, ptr, return &s->seqcount) \
> __SEQPROP(_##locktype, preempt, return preempt) \
> __SEQPROP(_##locktype, assert, __SEQCOUNT_LOCKDEP(lockdep_assert_held(s->lockmember))) \
>
> But I figured _that_ might've been one step too far ;-)

Initially I implemented something like this during internal,
pre-upstream, versions of this patch series. We've decided afterwards
that the macro compression level is so high that the whole thing is not
so easily understandable.

Thanks,

--
Ahmed S. Darwish
Linutronix GmbH
