Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2612EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E95BE206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VyfN57zV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgFBTHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 15:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbgFBTHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 15:07:14 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BDF7C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 12:07:14 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id o13so11794225otl.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 12:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RSAfpRmu4NBGjmiVQ1lcYcxOmmXpwec5mF9PhUPKqU0=;
        b=VyfN57zVgg4vT15oJ5+R03V6uwma9RoeQP2JrsgJ+WKA5BTAqaqC4Oz3nJqipgIgRa
         mT3B8peoS/TpnDlf2jX9g+HXKzdfyWFiow++WmD6WxHforesOaoxRWUlbNyOBq2e8VTh
         ygfqjb8hxoA6TNUkyzGczk7tDJrvwYVizyozyHlODRbjaaUiPYGjeL4UiROkvWJSbp5a
         UkbvMt32xrWhY1rX81V0SKFuGbg5cmVgHcVkYNkSI9wylFWW20wk01hvQZ9KZUEao8+v
         z3uFyogUMCpfWH5IB1aNBuW5ax9G+b4HJ5oQklIpqGkZcZA5vrkHOQDUwuzL+9UC/UBq
         TcRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RSAfpRmu4NBGjmiVQ1lcYcxOmmXpwec5mF9PhUPKqU0=;
        b=tO4aefvU+uAB3rCiSXWsWMCQZpSpBmFNbrSSGfLhbSzpDK5hSkxXjNivkeQncLqX5b
         B2sEPiL9Ab05S2nNXihCTJ13oijhB+UTJYPovZMs4PH9VnO+IX531H/tUKjsW1HCIS25
         lGnSNPfNcMVlVfmLznfRRJmSsbs6JlFUipDUYmu1Ub9lbYyBT2QfFUWY6yXgnXrU7/7V
         43PwBFbOrPxswAqmQQYntiOx4bm2Bgz83cJAhanhbewPlCbR5XSCOE1KtCG5i6WCUkzJ
         OBFfszB+KDQviBlfaINx+3d88K0sgJOBGRKETA67+/UzVI4+W/Z80slrbvaN2umfeNg2
         Lnyg==
X-Gm-Message-State: AOAM531i/2JYk9qNWa9ceSViRm2Icgch+15AkZhEQkoVjYrCaDBNzPC3
        CUhZvIFXSb6LWE7aSkLfOKHO8vR40V6wmuTvMD325A==
X-Google-Smtp-Source: ABdhPJzpoSz23uXzpKnRooChRSXtpE1Q6wYKBGasOdwkzEbABCqfh/kYA0WonHzHALhY3f2UB5uS3KQesOwxwH/bibY=
X-Received: by 2002:a9d:7dc4:: with SMTP id k4mr477503otn.251.1591124833330;
 Tue, 02 Jun 2020 12:07:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200602184409.22142-1-elver@google.com> <CAAeHK+wh-T4aGDeQM5Z9tTgZM+Y4xkOavjT7QuR+FHQkY-CHuw@mail.gmail.com>
In-Reply-To: <CAAeHK+wh-T4aGDeQM5Z9tTgZM+Y4xkOavjT7QuR+FHQkY-CHuw@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 2 Jun 2020 21:07:01 +0200
Message-ID: <CANpmjNPi2AD5jECNf6NBUuFk0+j+0-RA6ceFCOPPvw5PtoQu2g@mail.gmail.com>
Subject: Re: [PATCH -tip 1/2] Kconfig: Bump required compiler version of KASAN
 and UBSAN
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jun 2020 at 20:53, Andrey Konovalov <andreyknvl@google.com> wrote:
>
> On Tue, Jun 2, 2020 at 8:44 PM Marco Elver <elver@google.com> wrote:
> >
> > Adds config variable CC_HAS_WORKING_NOSANITIZE, which will be true if we
> > have a compiler that does not fail builds due to no_sanitize functions.
> > This does not yet mean they work as intended, but for automated
> > build-tests, this is the minimum requirement.
> >
> > For example, we require that __always_inline functions used from
> > no_sanitize functions do not generate instrumentation. On GCC <= 7 this
> > fails to build entirely, therefore we make the minimum version GCC 8.
>
> Could you also update KASAN docs to mention this requirement? As a
> separate patch or in v2, up to you.

I can do a v2 tomorrow. But all this is once again tangled up with
KCSAN, so I was hoping to keep changes minimal. ;-)

Thanks,
-- Marco
