Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8276DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5717F20734
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vrumBDaB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbgFBTCE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 15:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgFBTCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 15:02:04 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A93EC08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 12:02:04 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id d67so7978409oig.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 12:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fQp0wr55zKHTmcfSyP/aceC1T2FCV6dcgdAfq1cn0oY=;
        b=vrumBDaBdLtHuUdeqmBPBgdG37JoG5BinLfxYXZYPf128ntHICjAWuUP7iTiOGIWVd
         GcIbcddc42DLROf6kwk/K1q3nEmaspF2gqpezTcwJOUG7Bb7audPHhgV1f/x82ZrUcCW
         pIUASWlOZvBOQnFwb5u/u6Exwq+l/jtgXYxMQvTeHHLvRilWF0fO54H6wgVvx03DhHPP
         XfM/xVUB9UuQw4rlfl9u8bV+9Zt+HLpuxmQS4BBQRFFFBEqT3JMIGftqG4KMPDK8nJMk
         eqcQj0oT9KONh9qGv0w5cTvXYOHx1pUDxbwLFw+y1IbF03xcqxzjRsbqNFqp3N7Lz5kr
         GJaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fQp0wr55zKHTmcfSyP/aceC1T2FCV6dcgdAfq1cn0oY=;
        b=MyukOO5EjU6OpeW29vlAEcBV8OM588DiQI9afsOXZcDutJMWp3kZ/2cVcFQ6IjhX9E
         yGZfWCtpnqVRxwD6tZrofmg3dOSS6KpNtHw2x+ajGkynZ3tvB8DDPFRQqD0XjA0N/o3i
         Bs08L5gpQbMcGZVLD0d6gH768flF5Fv9FkH0dZ1Qnjk4NMpvUGGim+xU62hm1i3KEJtQ
         yrCKzoWBkxIG7JbbYJS856VJOmxFD4YPPh8OtnPzBGmmTPKeLjn8uSFdgaNLVZBYCyAf
         w+WpghK2t3V7p3kT5apvNVXpDtFK6qKDbqSMKUl5vvm/pjs00Ht+UskffABSwpK+buyT
         4ejQ==
X-Gm-Message-State: AOAM530nf8STd7rNCzfMXAUiVFZr5cut8kxTGGad6Ahv39/yEIezKXMb
        zVR4u/M+GNwWNAql/ga2HjD5/eyjvT4WQVWamIOBmQ==
X-Google-Smtp-Source: ABdhPJzKfAgUt3AL5z1M4ADvunPj1d4/0tkKh210HaZSsDFQY+YzFswOlFuKwpsOLdpP6ywughdQqCPskUSc9ehlkRc=
X-Received: by 2002:aca:ebc5:: with SMTP id j188mr4030323oih.70.1591124523224;
 Tue, 02 Jun 2020 12:02:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200602184409.22142-1-elver@google.com> <CAKwvOd=5_pgx2+yQt=V_6h7YKiCnVp_L4nsRhz=EzawU1Kf1zg@mail.gmail.com>
In-Reply-To: <CAKwvOd=5_pgx2+yQt=V_6h7YKiCnVp_L4nsRhz=EzawU1Kf1zg@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 2 Jun 2020 21:01:51 +0200
Message-ID: <CANpmjNP0jh=pwm5quCsXo75cfemyyJ=32vCUpEE5UygJ9g7R9A@mail.gmail.com>
Subject: Re: [PATCH -tip 1/2] Kconfig: Bump required compiler version of KASAN
 and UBSAN
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jun 2020 at 20:57, Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> On Tue, Jun 2, 2020 at 11:44 AM 'Marco Elver' via Clang Built Linux
> <clang-built-linux@googlegroups.com> wrote:
> >
> > Adds config variable CC_HAS_WORKING_NOSANITIZE, which will be true if we
> > have a compiler that does not fail builds due to no_sanitize functions.
> > This does not yet mean they work as intended, but for automated
> > build-tests, this is the minimum requirement.
> >
> > For example, we require that __always_inline functions used from
> > no_sanitize functions do not generate instrumentation. On GCC <= 7 this
> > fails to build entirely, therefore we make the minimum version GCC 8.
> >
> > For KCSAN this is a non-functional change, however, we should add it in
> > case this variable changes in future.
> >
> > Link: https://lkml.kernel.org/r/20200602175859.GC2604@hirez.programming.kicks-ass.net
> > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Marco Elver <elver@google.com>
>
> Is this a problem only for x86?  If so, that's quite a jump in minimal
> compiler versions for a feature that I don't think is currently
> problematic for other architectures?  (Based on
> https://lore.kernel.org/lkml/20200529171104.GD706518@hirez.programming.kicks-ass.net/
> )

__always_inline void foo(void) {}
__no_sanitize_address void bar(void) { foo(); }

where __no_sanitize_address is implied by 'noinstr' now, and 'noinstr'
is no longer just x86.

Therefore, it's broken on *all* architectures. The compiler will just
break the build with an error. I don't think we can fix that.

Thanks,
-- Marco
