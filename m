Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7646CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B4BA206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aF3rgGsV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbgFBTMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 15:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbgFBTMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 15:12:44 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527EAC08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 12:12:44 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id 64so5532405pfg.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 12:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dT5kVRE874bAh/32tBP4Sh3AXgtH1D6NYtRpFWupE3o=;
        b=aF3rgGsVucoqTFL9DBKIHSdjDv/8WvRZSiBIVVf60e6AT0HNk3E+34gBPf9s4PZ4ZO
         jUKSRhlGtA2DfRJVB7/Lp0WeCbAw/DfAZizLBN17SMTtA0x8AX613w4NiSFtWipDUmVl
         usHs3I8ToR/vLv32fOqLgnrsirIqfdbXa9An368qUpcnfnjPcU0/ev+ToFECNKqQDWMX
         alceUJ10GL1iBjP79DClTkishkiMNkOKrdqoGKfxuVoAUpnvtMhq2pFrayuEmKq2g+Z4
         oVXTkk+orShMRauMZXpxcSZ6MiAxNtBnP+/0hW+yHpuCneheZhAo3N5N8lsiGi93/8FP
         RiSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dT5kVRE874bAh/32tBP4Sh3AXgtH1D6NYtRpFWupE3o=;
        b=BiglN1G2jeTIQesN+6tiiICL0gfabK/P/gddYzm20j6pCRkiY8JgnijtSn03PLD4AK
         GGu0dzJqaXCaXV8wqsIQLc/tlYfkWj3u1+MXOtjnfn3/yajsjsxxvdKbDW+eaoxXTQms
         3ONx0DsuRDVaK61RQi0im9lY4SvCh3QmIOIE1oXLgDuuUz2LZGHti1jvz5UOqRI4JY4Q
         +QkHY+EVK4jZtSUj0tq2I/cNz0yEZHZINSRLt2h6IjEjqqAEv9U/jGnKH1qn2Oap3khA
         pS0B7cGEDVd34l8Xq/mBDsOQi9oGkpLgQ09BYcSDEXcs7Om0aX71nTPBiCeEBJI0gj07
         ap4w==
X-Gm-Message-State: AOAM532qkl5UH2aOsiX17gvzNEdPjFqtaSR36tpQlu2+p760fz/zE9L0
        +1kqNhJE7keOCYToYQ9tlOPtv9ZArNEQ1jEWjEe68g==
X-Google-Smtp-Source: ABdhPJwT9gTGint0hghkYz14ouqHH7+uFDGL5WMSYOHxNfRVZULf5trJkSa2fKlxjx3BV3GGIhXolLOO6KsBn4QykEI=
X-Received: by 2002:a63:724a:: with SMTP id c10mr25112669pgn.130.1591125163555;
 Tue, 02 Jun 2020 12:12:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200602184409.22142-1-elver@google.com> <CAAeHK+wh-T4aGDeQM5Z9tTgZM+Y4xkOavjT7QuR+FHQkY-CHuw@mail.gmail.com>
 <CANpmjNPi2AD5jECNf6NBUuFk0+j+0-RA6ceFCOPPvw5PtoQu2g@mail.gmail.com>
In-Reply-To: <CANpmjNPi2AD5jECNf6NBUuFk0+j+0-RA6ceFCOPPvw5PtoQu2g@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 2 Jun 2020 21:12:32 +0200
Message-ID: <CAAeHK+y2kfX32TbzcosCLSmr6sMB2BvEfKF8B1_4PrxgjKeLdg@mail.gmail.com>
Subject: Re: [PATCH -tip 1/2] Kconfig: Bump required compiler version of KASAN
 and UBSAN
To:     Marco Elver <elver@google.com>
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

On Tue, Jun 2, 2020 at 9:07 PM Marco Elver <elver@google.com> wrote:
>
> On Tue, 2 Jun 2020 at 20:53, Andrey Konovalov <andreyknvl@google.com> wrote:
> >
> > On Tue, Jun 2, 2020 at 8:44 PM Marco Elver <elver@google.com> wrote:
> > >
> > > Adds config variable CC_HAS_WORKING_NOSANITIZE, which will be true if we
> > > have a compiler that does not fail builds due to no_sanitize functions.
> > > This does not yet mean they work as intended, but for automated
> > > build-tests, this is the minimum requirement.
> > >
> > > For example, we require that __always_inline functions used from
> > > no_sanitize functions do not generate instrumentation. On GCC <= 7 this
> > > fails to build entirely, therefore we make the minimum version GCC 8.
> >
> > Could you also update KASAN docs to mention this requirement? As a
> > separate patch or in v2, up to you.
>
> I can do a v2 tomorrow. But all this is once again tangled up with
> KCSAN, so I was hoping to keep changes minimal. ;-)

OK, we can do a separate patch after all this is merged.
