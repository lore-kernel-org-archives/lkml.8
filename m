Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3447C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 02:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A44432068D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 02:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591065353;
	bh=qkZU3Brj/5fem/dHlJ2+v9OVbb5qfguEJj+iftH8kXc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=yO6VwstF1Te+Puuj7RyaSeJZfRGsQ0lAvEIMAUU97O857eAMAYcTIxXHneJkg/HTH
	 RSScm0v8dY3/+/cOqBFBjid1MQoM4ElFxqNzavSstzIMXOPvNR5ySZLmwiXOxhY0u9
	 N7UWIbGaF06dhg9bb37e/V1qJ9h40EVQPVFyLz6w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgFBCfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 22:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgFBCfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 22:35:52 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03448C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 19:35:52 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id m18so10694000ljo.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 19:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uTv3a3ynCKyz8zZO4LnRj5qEXUco16tlu2MClhf7vNM=;
        b=NbdiMaFUG4ymtVXM6YxhnNENU5R3hbIcTnKRa7PoopIkM/yuZoFHwAKY/feab5Q+Yb
         QZpOqE2gfixpvsPZ0iCxTkouiCxg7BA6EWFa0LosTUY2a1oILHTYRs0gGx4Cq3caedGw
         dNy1lFvhiDsH7SQ8x+eg1pTD1ZiNiRDgvYDrA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uTv3a3ynCKyz8zZO4LnRj5qEXUco16tlu2MClhf7vNM=;
        b=iHhVjqt5xY8aVy8llJj131LTDtt5mhaTZemnxdaiOxUkBn1jOryYuKhzpqYSIvF/Dk
         rHImFbC5G8RItRtmY4CQLPES1UswFt8bDcC70S6UACz1EHRjYEaHM7kLG/+paSZj77mI
         p9cf+ulOfQ+GvXHhLnOtxFKe9jXb3RGNNW72LNrdgC02B9MjwqznEsFs+Lj92NsXOHAM
         Mq5cLHRx/SJvWiinwgVaHaxA++MeRG36lj0k66vrK6SN/jOQEX4jleNrXGgPx9yq5WGS
         ZY5TZaDN9/1cEvBZWOrEP0rjcc91DDK6Wd+9EgnsfGQ6tzIZydxdbI04LQ5+gl1hnEKd
         VuDA==
X-Gm-Message-State: AOAM531pw7Z5Y2aNEH1sA3VgOIA2Jgfsoyt+lFX2Bu3tu+yitCZQpFsy
        MemvZ2lp4ZaYdUkRROirMll2ELaYuRc=
X-Google-Smtp-Source: ABdhPJz4eqr9CIZVEOkoOKYu3yRpkRbnmW5gadQETDjVOeitO5wEfJC5y8Tpb06VyFdCULr8K9TXCA==
X-Received: by 2002:a2e:8e22:: with SMTP id r2mr463638ljk.240.1591065349061;
        Mon, 01 Jun 2020 19:35:49 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id v7sm253751ljv.40.2020.06.01.19.35.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2020 19:35:48 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id h188so5201534lfd.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 19:35:47 -0700 (PDT)
X-Received: by 2002:ac2:5a0a:: with SMTP id q10mr12869466lfn.142.1591065347463;
 Mon, 01 Jun 2020 19:35:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200601170102.GA1346815@gmail.com> <CAHk-=wgXf_wQ9zrJKv2Hy4EpEbLuqty-Cjbs2u00gm7XcYHBfw@mail.gmail.com>
In-Reply-To: <CAHk-=wgXf_wQ9zrJKv2Hy4EpEbLuqty-Cjbs2u00gm7XcYHBfw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 1 Jun 2020 19:35:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjVLSOJ+uyEOhze_AaJi2mpmOAn7QtKahO1DC-Oj5teuA@mail.gmail.com>
Message-ID: <CAHk-=wjVLSOJ+uyEOhze_AaJi2mpmOAn7QtKahO1DC-Oj5teuA@mail.gmail.com>
Subject: Re: [GIT PULL] x86/mm changes for v5.8
To:     Balbir Singh <sblbir@amazon.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 1, 2020 at 6:06 PM Balbir Singh <sblbir@amazon.com> wrote:
>
> I think apps can do this independently today as in do the flush
> via software fallback in the app themselves.

Sure, but they can't force the kernel to do crazy things for every task switch.

> But I see your concern with
> respect to an overall admin override, I thought about it, but I stopped
> because of the reason above.

So my real concern is that I had a hard time following all the logic,
but it _looked_ to me like it ends up doing the flushes even if SMT is
enabled, for example.

And that's not an "admin override". That's just a full no-no. If SMT
is on, then we don't do any L1D$ flushing in the kernel, because it
would ne entirely pointless.

But this all quite possibly interacts with all the subtle static
branches we have in this same area, so ...

> The software fallback was there and is the same algorithm that we use
> for L1TF. We could potentially remove the software fallback if there
> is a concern, having the software fallback provides a mechanism
> independent of the microcode version similar to L1TF.

So the SW fallback raises my hackles, because we had the exact same
kind of non-architected software fallback for clearing the data
buffers for MDS.

And that one turned out to be not only incredibly expensive, but it
didn't work reliably anyway, and was really only written for one
microarchitecture.

It's not clear that a (generic) SW routine _can_ reliably flush the
L1D$ simply because of replacement policy issues and possibly D$
cacheline management settings.

Again, I'm sure that for any particular microarchitecture, writing a
SW fallback is possible.

And I suspect that for most of them, "fill enough of the cache" ends
up making things very hard to trigger in practice, but at a very high
cost.

> >I have a hard time following whether this might all end up being
> >predicated on the STIBP static branch conditionals and might thus at
> >least be limited only to CPU's that have the problem in the first
> >place.
>
> No, this is at the moment restricted to just Intel CPUs and it is designed
> as a generic fallback mechanism for issues involving speculation and L1D
> flush for example CVE-2020-0550[1]. This mechanism addresses issues beyond
> what STIBP addresses.

Ok, so that was hard to see.

What is it that disables it exactly? I'm ok with the concept, but it
needs to be clearly targeted, and the target wasn't clear to me. In
fact, everything in the docs and changlog implied that the target was
"

> >Because I don't want a random "I can make the kernel do stupid things"
> >flag for people to opt into. I think it needs a double opt-in.
> >
>
> Are you happy for this controlled by CAP_SYS_ADMIN or are you suggesting
> a sysfs override by the administrator to completely disable this?

At a _minimum_, I want to make sure this code never possibly ever
starts flushing anything if SMT is on.

That may be the case already. The narrow twisty mazes here from
"enable this" to "do the flush" were too hard to follow for me, which
is why I'm asking for more clarification.

And yes, I did read the documentation you point to. That did not
clarify anything at all.

So to put this in very clear terms:

 - what happens if SMT is on, and a process does
"prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_L1D_FLUSH_OUT, PR_SPEC_ENABLE,
0, 0);"

Because if the answer is "the kernel starts flushing the L1D at
context switches" then I refuse to pull this.

Why? Because it's just an incredibly stupid waste of time and effort
to do that, and I can see some poor hapless ssh developer saying "yes,
I should enable this thing because ssh is very special", and then ssh
just starts wasting time on something that doesn't actually help.

See what I'm saying? I want to know this feature isn't doing crazy
things. And "flush L1D$ on SMT" is crazy, since an attacker would just
sit on a sibling core and attack the L1 contents *before* the task
switch happens.

I have some other questions about this approach in the first place. I
don't see why context switch is even relevant, and why it should be
the place we flush. The kernel is trustworthy in this situation, both
before and after the context switch. So context switch makes no
difference what-so-ever from a security domain transfer angle.

Also, shouldn't we avoid flushing if you just run as the same user all
the time? IOW, context switch in itself isn't really relevant as a
security domain transfer, but it *is* relevant in the sense that
switching from one user to another is a sign of "uhhuh, now maybe I
should be careful when returning to user mode".

IOW, think of a "pipe ping-pong" test program. Set the flag for "I
want L1D$ cache flushing". Run the program with nothing else
happening, and a _good_ implementation should never ever cache-flush,
because at no point did we ever enter untrusted space: we were either
in the kernel (not just for the system calls, but for idle threads),
or we were in user context that had the right to see the data anyway.

So despite asking for a L1D$ flush on context changes, such a
ping-pong test program that does millions of context switches per
second shouldn't actually ever cause a cache flush, because there was
never any point.

IOW, what mitigations are in place for this not doing unnecessary
cache flushes, either because they are fundamentally pointless (the
machine has SMT enabled) or because they just aren't necessary (no
transition to an untrusted security domain has happened)?

And maybe those mitigations are actually there, and I just couldn't
figure it out. Some of the code scares me ("cond_ibpb()" and friends,
even if you did rename it to "cond_mitigation()").

                   Linus
