Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D20DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 21:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52122205CB
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 21:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="kooqm401"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgESVpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 17:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgESVpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 17:45:40 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4FAAC08C5C0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 14:45:39 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id l21so777969eji.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 14:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cSRyYwL1zh4grnM+TNINN+oD+vS6Z1eKKyNnOMI4spM=;
        b=kooqm401yr9fOYTBZtBz68VkWQLqOCDxgT2Rq5cmtiNGVkoyO+ziEo9wVOwcB6SECM
         Rk8oAvW39vwRMGGmhe3BmE0pIX+CPBAQFj4V0sW0Q8Mjr3MG9RMFMPPXCTgw+sN7x6T5
         SJbSgylBl7DdBAeSrRo97mzs3DWFB9QUsSshAWmL5cqk/iadLv7wzaeBaMOqczn+JNAC
         Ky5v6fPs21vi7tVclq+4k69VrXLPLYAGdL9OnfSHk2eDEfQJSZdPhkokuw8SPH9Tlpvo
         wUnkLOyslyQrEbvsZ3MkXnkAtfu6fYm229ySD4pt6W0nyAlDuGq8D8cIz5tHySGCAjdO
         gzQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cSRyYwL1zh4grnM+TNINN+oD+vS6Z1eKKyNnOMI4spM=;
        b=oN07MuxRaCsROek7d3LVLT+NCCByihhqK3rDYo6wkUAIwY1+tShw8mRvors6f1pvuF
         jC6gm/Xl3dDK6LaKxihvMPc+OdLS0wLOa0qgrw+D+402LSv9iX6Z+iCRs1kX6zpNwNa2
         PInZbA6Sz2aLhykoZrzwtPcbxFc0GuNdqPm1MEKn0l2NiOO+bYdlUh1ZIrI0bfkIgDge
         nb+TyybjrQvFXCxiR9jAO7tMrEbJr16jSAhkrCh69Wj0UA5Sa7D07UtOi7Whb6Lpt4qX
         Nkc/d9UAPeezgy/ZxTIv3dr/monNaMUCFZJBbqiLkebv8XMLOFZ96AsPz20SKfrKYorS
         nFHg==
X-Gm-Message-State: AOAM531slTwdEw1Skiw97kREUjsguTMO5uuCrtTBNbC0Oi27HZZvs2Vi
        yiGKY0vQnNmm3bzDQ+//HtjgpM4lz1l+VUWyxPw4fg==
X-Google-Smtp-Source: ABdhPJy1GoTrnWDrOVkvzM8wYuajaS8dLQXgdmDEIfLXKTKo3/mEzrwI9bzUAi343IxzoHsb/+yRmxGSjHMfDpis7r4=
X-Received: by 2002:a17:907:2711:: with SMTP id w17mr1256244ejk.8.1589924738593;
 Tue, 19 May 2020 14:45:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200512183839.2373-1-elver@google.com> <20200512190910.GM2957@hirez.programming.kicks-ass.net>
 <CAG=TAF5S+n_W4KM9F8QuCisyV+s6_QA_gO70y6ckt=V7SS2BXw@mail.gmail.com> <CANpmjNMxvMpr=KaJEoEeRMuS3PGZEyi-VkeSmNywpQTAzFMSVA@mail.gmail.com>
In-Reply-To: <CANpmjNMxvMpr=KaJEoEeRMuS3PGZEyi-VkeSmNywpQTAzFMSVA@mail.gmail.com>
From:   Qian Cai <cai@lca.pw>
Date:   Tue, 19 May 2020 17:45:27 -0400
Message-ID: <CAG=TAF7zVCMLj5US0uw-piwBUSmWpmPSPV3Thjbh7_kGsO88hQ@mail.gmail.com>
Subject: Re: [PATCH] READ_ONCE, WRITE_ONCE, kcsan: Perform checks in __*_ONCE variants
To:     Marco Elver <elver@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 5:26 PM Marco Elver <elver@google.com> wrote:
>
> On Tue, 19 May 2020 at 23:10, Qian Cai <cai@lca.pw> wrote:
> >
> > On Tue, May 12, 2020 at 3:09 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Tue, May 12, 2020 at 08:38:39PM +0200, Marco Elver wrote:
> > > > diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> > > > index 741c93c62ecf..e902ca5de811 100644
> > > > --- a/include/linux/compiler.h
> > > > +++ b/include/linux/compiler.h
> > > > @@ -224,13 +224,16 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
> > > >   * atomicity or dependency ordering guarantees. Note that this may result
> > > >   * in tears!
> > > >   */
> > > > -#define __READ_ONCE(x)       (*(const volatile __unqual_scalar_typeof(x) *)&(x))
> > > > +#define __READ_ONCE(x)                                                       \
> > > > +({                                                                   \
> > > > +     kcsan_check_atomic_read(&(x), sizeof(x));                       \
> > > > +     data_race((*(const volatile __unqual_scalar_typeof(x) *)&(x))); \
> > > > +})
> > >
> > > NAK
> > >
> > > This will actively insert instrumentation into __READ_ONCE() and I need
> > > it to not have any.
> >
> > Any way to move this forward? Due to linux-next commit 6bcc8f459fe7
> > (locking/atomics: Flip fallbacks and instrumentation), it triggers a
> > lots of KCSAN warnings due to atomic ops are no longer marked.
>
> This is no longer the right solution we believe due to the various
> requirements that Peter also mentioned. See the discussion here:
>     https://lkml.kernel.org/r/CANpmjNOGFqhtDa9wWpXs2kztQsSozbwsuMO5BqqW0c0g0zGfSA@mail.gmail.com
>
> The new solution is here:
>     https://lkml.kernel.org/r/20200515150338.190344-1-elver@google.com
> While it's a little inconvenient that we'll require Clang 11
> (currently available by building yourself from LLVM repo), but until
> we get GCC fixed (my patch there still pending :-/), this is probably
> the right solution going forward.   If possible, please do test!

That would be quite unfortunate. The version here is still gcc-8.3.1
and clang-9.0.1 on RHEL 8.2 here. It will probably need many years to
be able to get the fixed compilers having versions that high. Sigh...
Also, I want to avoid compiling compilers on my own.
