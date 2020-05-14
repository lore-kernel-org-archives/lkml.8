Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA8CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 15:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3F4F20657
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 15:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eYVph7M9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgENP3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 11:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbgENP3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 11:29:37 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41EBBC061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 08:29:36 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id p67so790029ooa.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 08:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ird8FEm72ENlHkterOqnEy09/dOc2zCxjzNTKKGHbAU=;
        b=eYVph7M92L+Hgp6wyxFgWbeRBHK9Qc6YlvnLZPAT1pUtKCSdeDkDRqZunoaYoZJJzC
         2U5cjd4JF5COsvCFu7iADKRAK5QzjVbuNt5C7VOpgwfQAt4+WcgkfF2RHQmk88dAf6Kx
         t8HmVeEeCaZPVSsN2zfWzQLRvV8btvgPrjesPoCn/JP22eOQQTr6Wi1XLLWdg77b6GN3
         N8VTcFAdDJKLJvQabExfyLrAzOgMC4DLOsMColRl0JZq69FKFY1uLscbGVsDT/EWFEdc
         YtB6EwhZZ/7ygN769/VIeBMLRUxaiFwhka5hqG+BBo+3LuShHM3Gqf7lWhJyXiV5KSwo
         xScA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ird8FEm72ENlHkterOqnEy09/dOc2zCxjzNTKKGHbAU=;
        b=gXHJP5c/gNbuTw+oPzW/lFjrJ/Albn8R596kYkW/9lqixGOqpBF4ixZ1RCa0bjOE4n
         LVzGv4+fTCSxl0J7M3DNk4DyAiE7Vwg2s8EhcIEO20dnnsedCwEkOJkAgbLmtHbFo0Tx
         am8PrIvzG1rpWlq4ROXERbxQUnVuLlwjph3I80r8DIHN4ngrLcbapDgvWv/Ui74HdVQL
         70a4r8FOyTogeff/2IoIBEu51/FTtAHHxts4bE1bY4xY1A85v+x8qlt4NokBdP0zKb07
         v/u2d9Xdz1W58t/kqqgcFI18jkoT0VVKr+5SNnjrFC9sU4c6QudsuwgFZcpR6yXI78YM
         JEjA==
X-Gm-Message-State: AOAM5321VtuM2CNovSIokrRk5tdCItJ0XJkosPaMYMgOhvoBUW0BtJp4
        oSKC4XH0msWdAstjaasg2osEVZGcHXk+9/aritCDZg==
X-Google-Smtp-Source: ABdhPJx0U5QIQrCiuYGFWAvI8Zzc+7LKLdUsPNHplqp9J9QbGQuyvwEj22Ma4KlWo69TnY9ecZsYJLH0Lil603CeeQQ=
X-Received: by 2002:a4a:2809:: with SMTP id h9mr4056657ooa.36.1589470175434;
 Thu, 14 May 2020 08:29:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200513124021.GB20278@willie-the-truck> <CANpmjNM5XW+ufJ6Mw2Tn7aShRCZaUPGcH=u=4Sk5kqLKyf3v5A@mail.gmail.com>
 <20200513165008.GA24836@willie-the-truck> <CANpmjNN=n59ue06s0MfmRFvKX=WB2NgLgbP6kG_MYCGy2R6PHg@mail.gmail.com>
 <20200513174747.GB24836@willie-the-truck> <CANpmjNNOpJk0tprXKB_deiNAv_UmmORf1-2uajLhnLWQQ1hvoA@mail.gmail.com>
 <20200513212520.GC28594@willie-the-truck> <CANpmjNOAi2K6knC9OFUGjpMo-rvtLDzKMb==J=vTRkmaWctFaQ@mail.gmail.com>
 <20200514110537.GC4280@willie-the-truck> <CANpmjNMTsY_8241bS7=XAfqvZHFLrVEkv_uM4aDUWE_kh3Rvbw@mail.gmail.com>
 <20200514142450.GC2978@hirez.programming.kicks-ass.net> <875zcyzh6r.fsf@nanos.tec.linutronix.de>
In-Reply-To: <875zcyzh6r.fsf@nanos.tec.linutronix.de>
From:   Marco Elver <elver@google.com>
Date:   Thu, 14 May 2020 17:29:23 +0200
Message-ID: <CANpmjNOGFqhtDa9wWpXs2kztQsSozbwsuMO5BqqW0c0g0zGfSA@mail.gmail.com>
Subject: Re: [PATCH v5 00/18] Rework READ_ONCE() to improve codegen
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 May 2020 at 17:09, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Peter Zijlstra <peterz@infradead.org> writes:
> > On Thu, May 14, 2020 at 03:35:58PM +0200, Marco Elver wrote:
> >> Any preferences?
> >
> > I suppose DTRT, if we then write the Makefile rule like:
> >
> > KCSAN_SANITIZE := KCSAN_FUNCTION_ATTRIBUTES
> >
> > and set that to either 'y'/'n' depending on the compiler at hand
> > supporting enough magic to make it all work.
> >
> > I suppose all the sanitize stuff is most important for developers and
> > we tend to have the latest compiler versions anyway, right?
>
> Developers and CI/testing stuff. Yes we really should require a sane
> compiler instead of introducing boatloads of horrible workarounds all
> over the place which then break when the code changes slightly.

In which case, let me prepare a series on top of -tip for switching at
least KCSAN to Clang 11. If that's what we'll need, I don't see a
better option right now.

Thanks,
-- Marco
