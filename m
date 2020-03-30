Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA717C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 08:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0ED320776
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 08:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wLmWxuLq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729761AbgC3IjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 04:39:07 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45714 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729743AbgC3IjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 04:39:03 -0400
Received: by mail-qk1-f196.google.com with SMTP id c145so18031971qke.12
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 01:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4xCc6G1fjYHS6JfynXvIUwvrt/yvbN0xlTjIkaNy98k=;
        b=wLmWxuLqn8KyJaQMB7X5bKCXwFjzc5aFDK54p9NPQtlgVlF2qRui1Xn+J/PqS4qYdz
         AxLC7N7UABn9fGxFWDIPvFekDu1Jaj4Qqquj0+qYV0+jNm47Nrh9Q+ql9OERMuHOW64I
         fXbROUpYZvtnx4heJlLaJK3lpjs7IcUK32hoVLJ7BhWF+SlCKPVU69yTC3EVQ/ag7puD
         TAF29OMOzh0T0AXrI6jehsr68PwCEZaIJQTR7XzZ74rB7ZNyGsC60Z+W+p8LcQD5e4lu
         HgU3SCJiO2lyWPfTmxhKfiTLO37E6vKkEY4EpCU7mbYrmffaw03ZICFZK8CGiE9d08mH
         iIwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4xCc6G1fjYHS6JfynXvIUwvrt/yvbN0xlTjIkaNy98k=;
        b=dPWuCOyUBJ0OLWFU4eU8nP+vyZXVrmxFrBQKbpyFi9eEEPYKilvB5gehJ5TIP7pFWI
         j8ysgtKTti7w+kjyx1YxZ8RLlTQM7puUogXGCSJHXgWOAmGB6FPu+WC621wMVIzGOCzu
         YV8DMliVnMrCjXdbvfFqS1WAc5TjqGWy0Srx2pwPRTLbKIPZ1Vm8EtUzabNhobUijZqg
         1EIw7h3LpYGGm1EPPwU4j6Ukt/cUD5CNgmSLjV6M4hQbIeHw/dpeXH6vRaI/CrkzwLnG
         7joqYez5Daq9Z5raz5t76NhpBDfGA8tGsg42W3+rWTwWWKnah76nv/ZZZOOSs/wG8u7z
         AXCQ==
X-Gm-Message-State: ANhLgQ2ui0hpuYYFbHrz0SxJqH+wd1xfoGq3sk/oO0fX2BJJfx1X5ofQ
        rr8xc5+DmbOzCIH7GYJwP26vgQ2plgGcczd5X64l2A==
X-Google-Smtp-Source: ADFU+vsrAoMtOj8G6dIUBTBViI6fwRdVWLliO+YLNi//6orndEbw72BFL0/0zwZiAeZ2r2/mJJfmAyqGgtwIMhlb/hY=
X-Received: by 2002:a37:bc47:: with SMTP id m68mr10748443qkf.8.1585557542372;
 Mon, 30 Mar 2020 01:39:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200226004608.8128-1-trishalfonso@google.com>
 <CAKFsvULd7w21T_nEn8QiofQGMovFBmi94dq2W_-DOjxf5oD-=w@mail.gmail.com>
 <4b8c1696f658b4c6c393956734d580593b55c4c0.camel@sipsolutions.net>
 <674ad16d7de34db7b562a08b971bdde179158902.camel@sipsolutions.net>
 <CACT4Y+bdxmRmr57JO_k0whhnT2BqcSA=Jwa5M6=9wdyOryv6Ug@mail.gmail.com>
 <ded22d68e623d2663c96a0e1c81d660b9da747bc.camel@sipsolutions.net>
 <CACT4Y+YzM5bwvJ=yryrz1_y=uh=NX+2PNu4pLFaqQ2BMS39Fdg@mail.gmail.com> <2cee72779294550a3ad143146283745b5cccb5fc.camel@sipsolutions.net>
In-Reply-To: <2cee72779294550a3ad143146283745b5cccb5fc.camel@sipsolutions.net>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 30 Mar 2020 10:38:50 +0200
Message-ID: <CACT4Y+YhwJK+F7Y7NaNpAwwWR-yZMfNevNp_gcBoZ+uMJRgsSA@mail.gmail.com>
Subject: Re: [PATCH] UML: add support for KASAN under x86_64
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Patricia Alfonso <trishalfonso@google.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        anton.ivanov@cambridgegreys.com,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>, linux-um@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 9:44 AM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> On Fri, 2020-03-20 at 16:18 +0100, Dmitry Vyukov wrote:
> >
> > > Wait ... Now you say 0x7fbfffc000, but that is almost fine? I think you
> > > confused the values - because I see, on userspace, the following:
> >
> > Oh, sorry, I copy-pasted wrong number. I meant 0x7fff8000.
>
> Right, ok.
>
> > Then I would expect 0x1000 0000 0000 to work, but you say it doesn't...
>
> So it just occurred to me - as I was mentioning this whole thing to
> Richard - that there's probably somewhere some check about whether some
> space is userspace or not.
>
> I'm beginning to think that we shouldn't just map this outside of the
> kernel memory system, but properly treat it as part of the memory that's
> inside. And also use KASAN_VMALLOC.
>
> We can probably still have it at 0x7fff8000, just need to make sure we
> actually map it? I tried with vm_area_add_early() but it didn't really
> work once you have vmalloc() stuff...

But we do mmap it, no? See kasan_init() -> kasan_map_memory() -> mmap.
