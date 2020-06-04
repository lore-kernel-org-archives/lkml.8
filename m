Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31EFCC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 05:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C8A8206C3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 05:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OHcY6D7S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgFDF76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 01:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgFDF75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 01:59:57 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA22DC05BD43
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 22:59:57 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id n31so1008859ooi.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 22:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0+kU4eqI2FNaJfdh4S9BVeiYnuZgar4HG9ySm5E8SrI=;
        b=OHcY6D7SjfyiNqv4OsozsFrhHNYC/2HbuN4cHIGabL5L59DvXIFMbjFCUCxxvV1wgB
         QGr0TtppWr2hT5BbmX74zXbJGUJDk8zt2cSpJDr7GqjzdyBOUwCUIKwrpw8solyuFe5i
         I63tDO6hFLqGxM7YubH4wiZQ0WChqvbd4v3M4iXtkYsrzjUe2RvkPVcGDhaAuk1iHVsy
         bUlgdhVF6FfYqmRSQ6syoHXkc+rWkIbaS6DuHy59Ja1sUE29j14Ne8zu10ipiX1edvSw
         VoDHqSOgX2jA22Fxjk2BjXHKhNiFoy5GC7KtiiZrZYMf99TAzu2nVgT2rdZl9eT06mbW
         +pZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0+kU4eqI2FNaJfdh4S9BVeiYnuZgar4HG9ySm5E8SrI=;
        b=LtgRCA2DvlLsFcgTx538hElnFMcMtPFGOYNbQ5zpx6ufRv7dC/axeSqjVYrRzxSfeh
         DcLoF3xLqYCPS/iojo5KMf1RQp1PEAr2XAStrx9KA7N8ATEggud8GEqGKucNPvJhKpCS
         Y0LkQusILoY4QjPQum8pLIUDTA3vUs4r02cljvV1BUNIvo/M4WlpxEZeO2BlUmrNqxPD
         kteKIMua/HqM5/JdzafucyRblvyP7+6IeGBpzQKlcQnXX2aXaIDyqoiqGzShahsyfSel
         JLffioPSFofRxduba+p+gg+FcMIUJXSFTI7RTS6Iinwt3HzULJZsh8XEgaKMQBlcy+Ri
         sRsg==
X-Gm-Message-State: AOAM531+NFgdtRmxVizOxe+4x2OuOnxkXMTYdtLcG2l2CzekUkLTMAx6
        C+++45QKy9gi87c6M651CFuSOmCFWK5gLo5H3ZcueA==
X-Google-Smtp-Source: ABdhPJwZndx8u+hE/MY89OZULGVz7Esx7/tTT6trWUkgZpPZbI9un5rklu43y9G1Slruq762x4lE5wzOHkukYbzFTGc=
X-Received: by 2002:a4a:e836:: with SMTP id d22mr2646851ood.54.1591250396888;
 Wed, 03 Jun 2020 22:59:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200602184409.22142-1-elver@google.com> <CAAeHK+yNmGB6mEQoogGhUh_F1fXFF_baA14G3=4NyYv=oz8Fdw@mail.gmail.com>
In-Reply-To: <CAAeHK+yNmGB6mEQoogGhUh_F1fXFF_baA14G3=4NyYv=oz8Fdw@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 4 Jun 2020 07:59:42 +0200
Message-ID: <CANpmjNMoOOr1irxkGHz9S+dP4M4h+mpGu_Ve6tmaGDb0zN-bMw@mail.gmail.com>
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

On Wed, 3 Jun 2020 at 15:35, 'Andrey Konovalov' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
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
> >
> > For KCSAN this is a non-functional change, however, we should add it in
> > case this variable changes in future.
> >
> > Link: https://lkml.kernel.org/r/20200602175859.GC2604@hirez.programming.kicks-ass.net
> > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Marco Elver <elver@google.com>
>
> Acked-by:  Andrey Konovalov <andreyknvl@google.com>

I've sent a v2 of this, which limits the compiler-bump to KASAN only.
It appears no_sanitize_undefined (for UBSAN) is not broken GCC <= 7,
and in general the no_sanitize attributes seem to behave differently
from sanitizer to sanitizer as we discovered for UBSAN.

https://lkml.kernel.org/r/20200604055811.247298-1-elver@google.com
