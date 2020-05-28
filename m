Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2178BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 15:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1B1220888
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 15:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MJ6IPLKC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404344AbgE1PZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 11:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404080AbgE1PZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 11:25:00 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFCA5C08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 08:24:59 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id y18so13661413pfl.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 08:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K6IkMqHyEOHSemzUNyydLbaMTsC3stHLolm7i5u2aKU=;
        b=MJ6IPLKCL3BbYt5HrzBgdjmJbBhdT0Y7aR5qj1lzrPRCpT32m6O+qTkG072Vjfpg4E
         6qUxUnMWUVot3+11G5mUYMv6+30dHT45ueCvHmTFA2S1P2L2xzIehRL6iMJ39pTKFWos
         E3jJRlxKdVvzP9qx6LknS7/uzQor9Ag7ujaiP8tG0sDitIDgzeTXmfNeZ14Gp2sNmw4Z
         G5b2SW/y4pvCeIjSGiSB6wv3dzk7bB7cmJDW1dxMIoZm1NvrrtHtpTpW0L+NiIUP+ezb
         cfwq9hYaCkS9l2Od3q84t1VNi/QmYE84JvrEOQjVZj9IK6VO63V6trDji3dqxlTXzk92
         JL3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K6IkMqHyEOHSemzUNyydLbaMTsC3stHLolm7i5u2aKU=;
        b=ESlVNZegLGUlYKjEg25Ztd9ndfQ+JjP6xfCzQQFdn0R3Xg2gWl3oBQlkkaiZcrBlNR
         OAQnZZ+j7V1j7XAnkQGo4hlqJ7ccmyJPTSS8CzI7h41VUkR29hOaJNqh55t9HCAwEaLK
         a5cevxLm4WikZ/qVVYxJe30uqzUZ73kGcyXAa490vDwynIQLSQ2xTOYTW2tWsSahtslJ
         8RYTq5r7rkBLki0mOpiNvpNWlbWJMJvIROi5lCGtvFPemU87Jyj7NhG021V2w+Ai3bFc
         +1NgWbVmSCIfx+KMiT4l08HojILVBke+JzyfCyTsvuMCNx8JuT27mxME0HZvBTetSAzP
         AS8Q==
X-Gm-Message-State: AOAM5308hX/ypoJJ8Ylw9XbNJVdUbs+VDtsknO7syy/N3uQ2kr/+BjEZ
        rfPzRJ6/+0j0hU99Nl1Hwq7EtlfLsoH6EZE4Cxhi1g==
X-Google-Smtp-Source: ABdhPJzb46j9Fosln5iIXPCZSG4xxvZzygau6CMkfYKM9Q34XVINmbmAFQNDprRayqtCOnau3ppm8+ujuQlTC+8JD+E=
X-Received: by 2002:a63:e454:: with SMTP id i20mr3439315pgk.440.1590679494343;
 Thu, 28 May 2020 08:24:54 -0700 (PDT)
MIME-Version: 1.0
References: <29bd753d5ff5596425905b0b07f51153e2345cc1.1589297433.git.andreyknvl@google.com>
 <78a81fde6eeda9db72a7fd55fbc33173a515e4b1.1589297433.git.andreyknvl@google.com>
 <20200528134913.GA1810@lca.pw> <CAAeHK+zELpKm7QA7PCxRtvRDTCXpjef9wOcOuRwjc-RcT2HSiA@mail.gmail.com>
 <20200528151554.GC2702@lca.pw>
In-Reply-To: <20200528151554.GC2702@lca.pw>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 28 May 2020 17:24:43 +0200
Message-ID: <CAAeHK+xKDJ-=GRDEoSNoaqbKcAYbEWS0a=Cg-_gijE7NXVWE_w@mail.gmail.com>
Subject: Re: [PATCH 2/3] kasan: move kasan_report() into report.c
To:     Qian Cai <cai@lca.pw>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Leon Romanovsky <leonro@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 5:15 PM Qian Cai <cai@lca.pw> wrote:
>
> On Thu, May 28, 2020 at 05:00:54PM +0200, 'Andrey Konovalov' via kasan-dev wrote:
> > On Thu, May 28, 2020 at 3:49 PM Qian Cai <cai@lca.pw> wrote:
> > >
> > > On Tue, May 12, 2020 at 05:33:20PM +0200, 'Andrey Konovalov' via kasan-dev wrote:
> > > > The kasan_report() functions belongs to report.c, as it's a common
> > > > functions that does error reporting.
> > > >
> > > > Reported-by: Leon Romanovsky <leon@kernel.org>
> > > > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > >
> > > Today's linux-next produced this with Clang 11.
> > >
> > > mm/kasan/report.o: warning: objtool: kasan_report()+0x8a: call to __stack_chk_fail() with UACCESS enabled
> > >
> > > kasan_report at mm/kasan/report.c:536
> >
> > Hm, the first patch in the series ("kasan: consistently disable
> > debugging features") disables stack protector for kasan files. Is that
> > patch in linux-next?
>
> Yes, it is there,
>
> +CFLAGS_report.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
>
> It seems that will not work for Clang?

Ah, Clang doesn't have -fno-conserve-stack and that makes the whole
cc-option expression fail? OK, I'll send a fix.
