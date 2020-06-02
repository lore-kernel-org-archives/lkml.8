Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C99D0C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 18:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A316B206A2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 18:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="thUds+DS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbgFBSzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 14:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbgFBSzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 14:55:51 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212EEC08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 11:55:50 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id a21so6593352oic.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 11:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rz+wRL+qx3pugwQiXrCHQNne2iVcMp5nHos/ewO2Exg=;
        b=thUds+DS7alvDg2CONmPKJvUo6F8MQkyeNoZCnCzcC0WOXQX3u8jmA6x5rl/6XPOyN
         CdJRBQWfu0FUBHafPqB1K3CzjaGgFBqDTWkBbAHgz/ZQt7Gxg5xh9uupHyJjL2wvLYuQ
         82GO8GSJ0zgMUXe8pB46AWR+XfcTeHkzGMO8bhdN1IeSnh3I4GPy2TaYBtUv3wVKJXD2
         IbGUkuoVCtBfP5MJoAPtNuHO/o0ZbBIH9uXgTjeAaq+DXwdUO5MPTgIbuAoRBrKu+XuZ
         ++Ynrb/ZBGCVeBf8PWXPYEj4z0LkVN2GYDa+n2EHL6vodekFMdAAYUajt3mYDOdJJhcG
         /zTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rz+wRL+qx3pugwQiXrCHQNne2iVcMp5nHos/ewO2Exg=;
        b=s5Ad2Sk9nWpTyZl2ojsptoUg/2KeA0fKj2oViiP0g/Rq0RwNUHvbNwQeND5C3ORPy1
         1R3a04QCfeEOEIJpLH3VyGIbCc0QVtZM0aEsKcLZJ1ogVDJIOadeepyLa8XgDJ0qcjLV
         3fnN8BdTmvMrRO+icX8ahoavun7gakH4w25DnIcYj4a1MrY/nqOatzs/yzKUNrMI8/jD
         bBszOnBVmTrJwAIIjLTLNOym4C9vsUaXv3wuo6Yi9mjFe4BBEAEthPcB5ZSNtbw+rme9
         v0WWjhm95bGOsVSKc2UZqigw5930YAJk6mdUwYhJ/xGtrZN+SUMqsza1ZRd431ByRNxJ
         kJ2A==
X-Gm-Message-State: AOAM530Kdr1ZxO2+/mp34dsD0wLHXMXneJWlayejdxLrVjMhuKwYp8yO
        gUl2ZGMIB6eCehxo7OHP9J/kVEPLTAA+Dr6of7R30w==
X-Google-Smtp-Source: ABdhPJyITIrnCdjh+zd8IGMUEoyPl/aedPZjnAmr5Khd2QeLaI41oGjkhcpkXilEDWUSGdNpLGPgPz0yK3eORLw+haw=
X-Received: by 2002:aca:ebc5:: with SMTP id j188mr4013382oih.70.1591124149338;
 Tue, 02 Jun 2020 11:55:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200602184409.22142-1-elver@google.com> <20200602184409.22142-2-elver@google.com>
 <CAKwvOdkXVcZa5UwnoZqX7_FytabYn2ZRi=zQy_DyzduVmyQNMA@mail.gmail.com>
In-Reply-To: <CAKwvOdkXVcZa5UwnoZqX7_FytabYn2ZRi=zQy_DyzduVmyQNMA@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 2 Jun 2020 20:55:37 +0200
Message-ID: <CANpmjNMeAhS9vemP=OOPBmj_9dDnmQ=nxXARHeOQnw8z-uZS7Q@mail.gmail.com>
Subject: Re: [PATCH -tip 2/2] compiler_types.h: Add __no_sanitize_{address,undefined}
 to noinstr
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Will Deacon <will@kernel.org>,
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
        LKML <linux-kernel@vger.kernel.org>,
        syzbot <syzbot+dc1fa714cb070b184db5@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jun 2020 at 20:49, 'Nick Desaulniers' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> On Tue, Jun 2, 2020 at 11:44 AM 'Marco Elver' via Clang Built Linux
> <clang-built-linux@googlegroups.com> wrote:
> >
> > Adds the portable definitions for __no_sanitize_address, and
> > __no_sanitize_undefined, and subsequently changes noinstr to use the
> > attributes to disable instrumentation via KASAN or UBSAN.
> >
> > Link: https://lore.kernel.org/lkml/000000000000d2474c05a6c938fe@google.com/
> > Reported-by: syzbot+dc1fa714cb070b184db5@syzkaller.appspotmail.com
> > Signed-off-by: Marco Elver <elver@google.com>
>
> Currently most of our compiler attribute detection is done in
> include/linux/compiler_attributes.h; I think this should be handled
> there. +Miguel Ojeda

GCC and Clang define these very differently, and the way to query for
them is different too. All we want is a portable __no_sanitize, and
compiler-{gcc,clang}.h is the right place for that. Similar to why we
define the other __no_sanitize above the places they were added.

Thanks,
-- Marco
