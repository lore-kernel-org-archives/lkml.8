Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD195C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 17:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AD00207EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 17:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lisUJLL2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgIBRhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 13:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgIBRhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 13:37:01 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA77CC061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 10:36:59 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id cr8so2596016qvb.10
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 10:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vgaKAzdGE8hK8jX5VIAMg2rIsFKjVZ+G64RGVHPspFk=;
        b=lisUJLL2WukHfkTnc5Q5MLvsfNQo3NRV7V1bKtu/7/1+zzIpFACD4j0K0w1MVuVGjL
         TzO9kHzuh9SUWXYJsu7bWUre/gCLdfapig834pwjTwWShvYRN7q1FGWwkts4Hr3ey0Q2
         8vC9qioheml5zBF0ENAMozGKejPeLRIeH5r0do8bh0nEL6B4VVZlystOjWHuVBec6DkP
         JPpnmadxpWnNNzZoGRzgbuhomEUO7Xi/4mJvBjlsUJ9LbrGtIvLPFaX7FLjeiQKWufPd
         E+sZBqVpOIUxssjpQOetHy512+lLj1bfBw8fToUPlBdUIWHrBDQGFgwmBY7+utZOgqYX
         xWFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=vgaKAzdGE8hK8jX5VIAMg2rIsFKjVZ+G64RGVHPspFk=;
        b=B3hiAGCTTDQMcUfYKo7nAqOB3h77RRQMAsqIfuT9HUPI5g1AScAI3q7vzMYJ25g8zC
         pGhuCF9eQ2s6UKlr0XeHEN/cDy47yAd0J3nB34VDDN1Y/8I8sXY72wVoK2r6fgRRID/g
         ihj7gygDUNslQ+rHgddRh/0WPiUPm4JHiAkWLBPgNfz+RwMyMR2kFxdC/D4ldT/DVuu+
         WRfnL2jCb+FefmzMvUnGZoPqIwx0R0tMaNT1+IRDnyHktj++gFonPQgZv8Lvh4gd0hrk
         U+VGAYcUwSFEJWmhJ8hIkiYBmN5dYZZrTNWPUYtMdY060Xk4g4c2d0W9p5AE3695t7SF
         vxKA==
X-Gm-Message-State: AOAM530G4Vz3dWHlCRU+2c4JOEJ/+L+Z+H7BuqcRrd4fXOBRmK8iOd1M
        9j8Q9Y0ucMZkkdcPJFaqyIk=
X-Google-Smtp-Source: ABdhPJwt2RKyrYQUbm1s63bYhaah8JToYSP8XiIC9AsuTQ96utJqr3oTknK4v/7NdbXy/k1wuLrTMw==
X-Received: by 2002:ad4:4ae1:: with SMTP id cp1mr7825524qvb.216.1599068218772;
        Wed, 02 Sep 2020 10:36:58 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id y9sm260036qka.0.2020.09.02.10.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 10:36:57 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 2 Sep 2020 13:36:55 -0400
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Will Deacon <will@kernel.org>, nadav.amit@gmail.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH v2] x86/asm: Replace __force_order with memory clobber
Message-ID: <20200902173655.GA3469316@rani.riverdale.lan>
References: <20200823212550.3377591-1-nivedita@alum.mit.edu>
 <20200902153346.3296117-1-nivedita@alum.mit.edu>
 <20200902171624.GX28786@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200902171624.GX28786@gate.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 12:16:24PM -0500, Segher Boessenkool wrote:
> On Wed, Sep 02, 2020 at 11:33:46AM -0400, Arvind Sankar wrote:
> > The CRn accessor functions use __force_order as a dummy operand to
> > prevent the compiler from reordering the inline asm.
> > 
> > The fact that the asm is volatile should be enough to prevent this
> > already, however older versions of GCC had a bug that could sometimes
> > result in reordering. This was fixed in 8.1, 7.3 and 6.5. Versions prior
> > to these, including 5.x and 4.9.x, may reorder volatile asm.
> 
> Reordering them amongst themselves.  Yes, that is bad.  Reordering them
> with "random" code is Just Fine.

Right, that's what I meant, but the text isn't clear. I will edit to clarify.

> 
> Volatile asm should be executed on the real machine exactly as often as
> on the C abstract machine, and in the same order.  That is all.
> 
> > + * The compiler should not reorder volatile asm,
> 
> So, this comment needs work.  And perhaps the rest of the patch as well?
> 
> 
> Segher

I think the patch itself is ok, we do only want to avoid reordering
volatile asm vs volatile asm. But the comment needs clarification.

Thanks.
