Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 706A1C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 03:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 476D920732
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 03:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XDd+bpkQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbgHVDz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 23:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbgHVDz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 23:55:56 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61910C061573
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 20:55:56 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id e5so2699498qth.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 20:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sis1RtWjjJmCniMLQ4buZziqruFCYDRbS5Oahbaa7xE=;
        b=XDd+bpkQppuofPbNYUrPg19hMiwkgibTgQkz9I7rtaHJW4k4dOIK6n6m4QMtEzqJTX
         hPjz8BZFzLJqvXdh2w92mRO2niHkFK/EwJSyysUgtyPMnLj+cjz2mH4n3JYG37c0MxgA
         Thou7c9mb2LK3ITMKPOTJCkzJNt+X5G7Djt/o2isimi06X2e26QPf+VjH5ZIOFpLqM0+
         tregyYR3KQ8uY/Uww05P/wTWCpq/nWyPb5ZLwBidyH/kUedfaVJke9aFgTOB56Ak5oLU
         wROdMx83wa/7O5oSFEDgUyHGSnChZy8Z3iHr+VfB7EehKFCCnVX5JtQw/k8TLsbcCwcD
         SbeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=sis1RtWjjJmCniMLQ4buZziqruFCYDRbS5Oahbaa7xE=;
        b=UWWkS1W3HtmA5o2qdd0N8RoDDWlkrYen/QBt9b7y6oLG2PwDpWRre2YDEhJYqYp1FX
         99406vrhrAOBjwCmQc8dVMNLUizogQgLjh3mRHzgh1jcpCXw/1cDs2xZB+ipqn06IREj
         SntOMh2t+iSwoINiYtj43dHJjHWbC/yRaY7/NbslW/Q2ZbEX3w8xIpJRHOW2VgOXFX3b
         u6yVxnaG/Rr/KUyB6GaNTLLNByNbGtRKB/PGPm2B4rdqm12v6CsykLY/3v1auo71rZol
         R4btR1h0GSCVhR5zFs7uvN6Ev1+Mz49ovVHfxD1PHAFCPVz7ZnoO22FjlBl+l82FWEUS
         yzOQ==
X-Gm-Message-State: AOAM532jHpR5UEBzaWzBj47LM+uPJwa95BSYiS6V3ghiBJc2pu74JpIR
        oW1r26JKWdBERnFali0elqI=
X-Google-Smtp-Source: ABdhPJxedn35Qz4LQohp3bn4561WJJkK6OamAOW8s6BY7Xrm3YhxZ9mcKnY5123/ZDctX5hciqMNxQ==
X-Received: by 2002:ac8:1adc:: with SMTP id h28mr5386850qtk.153.1598068555057;
        Fri, 21 Aug 2020 20:55:55 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id q34sm4396912qtk.32.2020.08.21.20.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 20:55:54 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Fri, 21 Aug 2020 23:55:52 -0400
To:     Thomas Gleixner <tglx@linutronix.de>,
        Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Will Deacon <will@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] x86: work around clang IAS bug referencing __force_order
Message-ID: <20200822035552.GA104886@rani.riverdale.lan>
References: <CAKwvOdnOh3H3ga2qpTktywvcgfXW5QJaB7r4XMhigmDzLhDNeA@mail.gmail.com>
 <87h7t6tpye.fsf@nanos.tec.linutronix.de>
 <20200813173701.GC4295@paulmck-ThinkPad-P72>
 <20200813180933.GA532283@rani.riverdale.lan>
 <875z9dioll.fsf@nanos.tec.linutronix.de>
 <20200820130641.GA536306@rani.riverdale.lan>
 <87zh6ohm03.fsf@nanos.tec.linutronix.de>
 <20200821230435.GA56974@rani.riverdale.lan>
 <CAKwvOdkoB+fT9tt7vgg1R6J-NEr77EWP5X8nFat_L-HvEzWGzA@mail.gmail.com>
 <87eenzqzmr.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87eenzqzmr.fsf@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 22, 2020 at 02:43:08AM +0200, Thomas Gleixner wrote:
> On Fri, Aug 21 2020 at 16:16, Nick Desaulniers wrote:
> > On Fri, Aug 21, 2020 at 4:04 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >> On Fri, Aug 21, 2020 at 02:37:48AM +0200, Thomas Gleixner wrote:
> >> The gcc bug I linked to earlier is only fixed in gcc-6 onwards. Is that
> >
> > (based on https://gcc.gnu.org/bugzilla/show_bug.cgi?id=82602#c14)
> >
> >> good enough to remove force_order? I can test gcc-4.9 and gcc-5 to check
> >> if it would currently have any impact.
> 
> And that test tells you what exactly? That your particular build of
> those compilers does not have the problem. A truly scientific approach.

More that the current kernel code doesn't have that problem, but yeah,
it might creep in later.

> 
> > I think checking the disassemblies with a pre-gcc-6 would be good
> > enough then; that bug isn't specific to this particular case.
> 
> What? I clearly want a statement from the GCC people that this won't
> happen on pre gcc6 compilers and not just some 'works for me' statement
> based on a randomly picked compiler build.

Presumably also from clang that the compiler does have protections
against this, as opposed to doesn't happen today.

> 
> Thanks,
> 
>         tglx

Cc Segher.

Segher, we were looking at gcc PR82602, where IRA could reorder volatile
asm's (reported on ARM). The fix was backported to gcc-6. Do you know if
there is any reason the problem couldn't occur on x86 on older gcc
without the fix?

Thanks.

Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=82602
