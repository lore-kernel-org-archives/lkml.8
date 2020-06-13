Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0095C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 05:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB7A020739
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 05:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYEk1+sf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgFMFk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 01:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgFMFk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 01:40:28 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDEDEC03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 22:40:27 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id er17so5391421qvb.8
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 22:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZSHq0vMaz4NURNRNupZyQB7rnizDXqa6ngrG3A3AhI0=;
        b=jYEk1+sfMAFz+SrLypRsAkNDQ5RLJ+imA33j+umAGowJffc/gC0O75thPSf+L0OlcO
         5BQC2HF8cYzqXzH+2A9HJYoxbg4Ovhgls5Dwcs5FXFoRImBxItW3pPSntOX2oQ5Cm7/1
         rT4VimvLDXJq5Oqfxt2fbr/wOwkrnpThsfDhzetbNChyCaThpiFnkh4GXrngBQKEMyhC
         QwQZf3msp8lncBATu9K/IN0Zws1fDWFyHs2UiuItJaEktCiZiCZeAtB4FNoZJnHSErMp
         mhV5ewjawTWhA7FD9SawBKomKVn32xKXppae3sxjaML23JON/JSP6B3IeZPm140bJhva
         svKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZSHq0vMaz4NURNRNupZyQB7rnizDXqa6ngrG3A3AhI0=;
        b=gFBl/e37zzJqtUot3jpmWCTiBf2XIzv/DLCKEIb6V7qkpZkRtfk1lsybNx4UsOIxF9
         2qhoeAwjqE33/+pYCkrksESChGhwoUQWRt8zmiNVq6QtdaVm/4h1ZgcxLPNLnkjGb41E
         lTJm+jzXLqaIOVB0JYSbqRdv4gJkPpPHhU9MAA3jNpwN8g5/nGfbKHhdifc5Z1D9fEMc
         /ngmIHP83gmYziDl/m3Tw577j2r0cW7aaAIkTkGamjSsJlhScwq1kDjxp4Hb9YKr2vwr
         61eymU/dWT7/CjieceikTVQaP6UOCWzGg34EHhu4jRyLHMD6sdHY283mKNteU+Zx3bJK
         +EQw==
X-Gm-Message-State: AOAM533Oku5h1aOi6VL4MaYQjCsOKvoT6tG2LKVUXtQQxszjDELERj/m
        eHug0SKbp+hvHtsrxjYGejpEwmWWmBOjnfZF9AgCbg==
X-Google-Smtp-Source: ABdhPJywBFl9gueqSdscfDjudCkhUVPyPfhj7NAAGIg1WSS2TXBAr8ut2CHITYrZ7LTnAbe2QKSEemRn4jOamEvfgaI=
X-Received: by 2002:ad4:494c:: with SMTP id o12mr16181257qvy.102.1592026827023;
 Fri, 12 Jun 2020 22:40:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200612105026.GA22660@zn.tnic> <CAHk-=wjKr+eAdPg3q7S6N4Cwd1aMEOHc5qLaKE-wwhouZRo=uw@mail.gmail.com>
 <20200612174801.GE22660@zn.tnic> <20200612203935.GH2497@hirez.programming.kicks-ass.net>
In-Reply-To: <20200612203935.GH2497@hirez.programming.kicks-ass.net>
From:   Tony Luck <tony.luck@gmail.com>
Date:   Fri, 12 Jun 2020 22:40:14 -0700
Message-ID: <CA+8MBbKNB3a41rQDqYnLD1AcYDDuQOJeyA=68m17zj4Neg9ZpQ@mail.gmail.com>
Subject: Re: [RFC PATCH] x86/msr: Filter MSR writes
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 1:41 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Jun 12, 2020 at 07:48:01PM +0200, Borislav Petkov wrote:
> > On Fri, Jun 12, 2020 at 10:20:03AM -0700, Linus Torvalds wrote:
> > > Since you already added the filtering, this looks fairly sane.
> > >
> > > IOW, what MSR's do we expect people to maybe write to normally? You
> > > added MSR_IA32_ENERGY_PERF_BIAS as an allowed MST, maybe there are
> > > others?
> >
> > Right, this MSR is being written by cpupower in tools/. My search was
> > confined within the kernel source only so there very likely are others.
>
> So that tool writing to /dev/msr has already caused pain; the direct
> result is that the intel pstate driver doesn't want to use an MSR shadow
> variable to avoid RDMSR because that'd loose input.
>
> https://lkml.org/lkml/2019/3/25/310
>
> (sorry, that's what google found me)
>
> So ideally we'd just disallow it too. It already has a sysfs file (per
> those patches):
>
>   Documentation/admin-guide/pm/intel_epb.rst

Some group internal at Intel want something like this, but more extensive,
They want to limit RDMSR to a subset (not exactly sure why, I don't
know of MSRs that have side effects on read ... but then again
not all of the MSR space is documented).

On the write side they divide into categories:
1) Some MSRs can only be cleared.
2) Some MSRs can only have certain bits set
3) Some MSRs allow any write
4) Maybe something else ... this is from memory, and a somewhat
cursory read of their patch.

They have maybe a couple of dozen MSRs split between those classes.

-Tony
