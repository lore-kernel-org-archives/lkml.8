Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52770C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DFF220734
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591125308;
	bh=MPJoOJczUd3f6NnqVCxcSVLinPk16S+G1HcN0dZImeE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=f0T3ZpmbjDVCY/u6jXuHltzZw25v0IiuWO8L8aNrntrHAKko7LDJERK7T2T2mG/d2
	 q3wrxfbD3OeB+kSpu/+JMA136LI0YLqYsO0zM8LEYqC8ea3rHJKcsBCa3cNlCHfwLp
	 WKKV1IeX0oXAHVFHHXmFmh8uv++SvHe74IRIYO+k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgFBTPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 15:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgFBTPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 15:15:05 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F6CC08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 12:15:04 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id e4so13997843ljn.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 12:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J7K6RLoEkQCH+vhugjTF9x/szy4b7JRZyTG6dDIP/ho=;
        b=VxqSqgaEO6IhaVqpktIQNoWvOOfyxQjP0DlHWFLcbaK56dzdAlhqGE3imh4rSi2fxL
         kwXUXO3x9TZuVGFLQuNBGy93l1TJ33LJZjZ2R2DYHViAJmHYTe6/8Qhi3+TJEpaM519o
         u67wDm8vzjkSMBYJU6AozDDhfbA9vs1ULOCEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J7K6RLoEkQCH+vhugjTF9x/szy4b7JRZyTG6dDIP/ho=;
        b=I5ETwrT0yGwtJFjz9Az4L4Gd96ujg3BzOW+AOz38Q4CUjJu3oxMxAJAfsV8fJjVIke
         Z+mvbZiwG2B296GWs6O3cyi+FWcYmoXorAS0BweIA2WFh6Isy4zJyyUicFPjNRkgghr2
         N+sWaLGAVa5Q3VYvMJZfBb5f7Q36mABWuk6jo/qg54F5SC8B7Tf9HKG9ZX55b2Uhzun8
         3dvzTNfdRczlEkBfOuZ2FynF89ikA0pncAobSI9TANaVW0+iwUyYkMlg01eeHK0krOit
         MbQqA+MXIFrH3KPN3VAsOwifAcsRrHJKjBtMrp6+bSrt60UUu2qO8p2xTlL6LsYKCiOB
         yCZA==
X-Gm-Message-State: AOAM530aRpSXgezaecu4VVQWb25L7QVxNNxf7ys8Jt2GoCPS5ZWnY+wD
        2kghEnkcgDQcjRAdZW/wriVkYpCZhaI=
X-Google-Smtp-Source: ABdhPJxsEPRtYW/NTLU05UTt1X4KIYjNpgyMrMkDevO16Esrvqv4aCWWOXeGd9ySOpAFa0Fcf/F8rQ==
X-Received: by 2002:a2e:7406:: with SMTP id p6mr301881ljc.198.1591125300863;
        Tue, 02 Jun 2020 12:15:00 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id s28sm902112lfs.3.2020.06.02.12.14.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2020 12:15:00 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id u16so6867126lfl.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 12:14:59 -0700 (PDT)
X-Received: by 2002:a19:d52:: with SMTP id 79mr430715lfn.125.1591125299390;
 Tue, 02 Jun 2020 12:14:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200601170102.GA1346815@gmail.com> <CAHk-=wgXf_wQ9zrJKv2Hy4EpEbLuqty-Cjbs2u00gm7XcYHBfw@mail.gmail.com>
 <20200602073350.GA481221@gmail.com> <b159ba4c53fcf04cc4eb747c45e1d4d2d83310a3.camel@kernel.crashing.org>
 <871rmxgw4d.fsf@nanos.tec.linutronix.de>
In-Reply-To: <871rmxgw4d.fsf@nanos.tec.linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 2 Jun 2020 12:14:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgOFnMW-EgymmrTyqTPLrpGJrUJ_wBzehMpyT=SO4-JRQ@mail.gmail.com>
Message-ID: <CAHk-=wgOFnMW-EgymmrTyqTPLrpGJrUJ_wBzehMpyT=SO4-JRQ@mail.gmail.com>
Subject: Re: [GIT PULL] x86/mm changes for v5.8
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ingo Molnar <mingo@kernel.org>,
        Balbir Singh <sblbir@amazon.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 2, 2020 at 11:29 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> It's trivial enough to fix. We have a static key already which is
> telling us whether SMT scheduling is active.

.. but should we do it here, in switch_mm() in the first place?

Should it perhaps just return an error if user land tries to set the
"flush L1$" thing on an SMT system? And no, I don't think we care at
all if people then start playing games and enabling/disabling SMT
dynamically while applications are working. At that point the admin
kets to keep both of the broken pieces.

Also, see my other point about how "switch_mm()" really isn't even a
protection domain switch to begin with. We're still in the exact same
protection domain we used to be in, with the exact same direct access
to L1D$.

Why would we flush the caches on a random and irrelevant event in
kernel space? switch_mm() simply isn't relevant for caches (well,
unless you have fully virtual ones, but that's a completely different
issue).

Wouldn't it be more sensible to treat it more like TIF_NEED_FPU_LOAD -
have a per-cpu "I need to flush the cache" variable, and then the only
thing a context switch does is to see if the user changed (or
whatever) and then set the bit, and set TIF_NOTIFY_RESUME in the
thread.

Because the L1D$ flush isn't a kernel issue, it's a "don't let user
space try to attack it" issue. The kernel can already read it if it
wants to.

And that's just the "big picture" issues I see. In the big picture,
doing this when SMT is enabled is unbelievably stupid. And in the big
picture, context switch really isn't a security domain change wrt the
L1D$.

The more I look at those patches, the more I go "that's just wrong" on
some of the "small picture" implementation details.

Here's just a few cases that I reacted to

Actual low-level flushing code:

 (1) the SW fallback

     (a) is only defined on Intel, and initializing the silly cache
flush pages on any other vendor will fail.

     (b) seems to assume that 16 pages (order-4) is sufficient and
necessary. Probably "good enough", but it's also an example of "yeah,
that's expensive".

     (c) and if I read the code correctly, trying to flush the L1D$ on
non-intel without the HW support, it causes a WARN_ON_ONCE()! WTF?

 (2) the HW case is done for any vendor, if it reports the "I have the MSR"

 (3) the VMX support certainly has various sanity checks like "oh, CPU
doesn't have X86_BUG_L1TF, then I won't do this even if there was some
kernel command line to say I should". But the new prctrl doesn't have
anything like that. It just enables that L1D$ thing mindlessly,
thinking that user-land software somehow knows what it's doing. BS.

 (4) what does L1D_FLUSH_POPULATE_TLB mean?

   That "option" makes zero sense. It pre-populates the TLB before
doing the accesses to the L1D$ pages in the SW case, but nothing at
all explains why that is needed. It's clearly not needed for the
caller, since the TLB population only happens for the SW fallback, not
for the HW one.

   No documentation, no nothing. It's enabled for the VMX case, not
for the non-vmx case, which makes me suspect it's some crazy "work
around vm monitor page faults, because we know our SW flush fallback
is just random garbage".

In other words, there are those big "high-level design" questions, but
also several oddities in just the implementation details.

I really get the feeling that this feature just isn't ready.

Ingo - would you mind sending me a pull request for the (independent)
TLB cleanups part of that x86/mm tree? Because everything up to and
including commit bd1de2a7aace ("x86/tlb/uv: Add a forward declaration
for struct flush_tlb_info") looks sane.

It's only this L1D$ flushing thing at the end of that branch that I
think isn't fully cooked.

               Linus
