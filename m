Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C990FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 16:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9704720709
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 16:32:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lop/y0Dk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbgETQc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 12:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgETQcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 12:32:55 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28152C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 09:32:55 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id y198so1815657pfb.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 09:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yx+SO7MaZlAD9vie5x6QfkffO8b6beNlaHDdml9CWsM=;
        b=Lop/y0Dk/PKz4/TytS22NKD43pau7LZ+Fme380JvbUlJTAhjKp0xU5ZbSauz5iBBby
         8FsNQuISGXT6xReynlqdGwOru/n8HVgF9PpzEuE3Op3eNzVDIVdKHuUEsB/JTI8/kg8o
         0AKf9ceni4CrSkZfXCzguuqYuKuFtk3BpElBIVrClAx+T8PyGFAtGvqUAyVctmXw+XGt
         4tYMLf3bHsSqSlDXngMSdaPIZkjiFyCqLz10LeG47GZIf0OFqDJOlTkVieltDdtYXeXQ
         fyUbZ2HU9s1mSUDjTSw0eUVfXST8kD8Mt0rL+0zF/jNiiTJhECsa/ADDdbKs5Wv1CRYR
         5NXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yx+SO7MaZlAD9vie5x6QfkffO8b6beNlaHDdml9CWsM=;
        b=Sx28FJ9BbpuTSAtpVAohDaNYkizxhhxEC5kTxp+AedLHVK9kIz1nlKmPQPIHybcV8/
         IiRdJbf4+fC4uI1ZFgLcuXPVwIpOY4nN2g04ZA6TU3xoSCEsZ46V8h1FqdcU8f/sML7n
         Seqh1ivl+pqphrp4F5Y20Mi5sdS0NOn2ngdVXa7Y8xTb05fkQ6s1PdY/L/CCj2PynwmV
         s7OzTWNBaBWK5ahbZ2bxb86ha9r1+sFILWy3bi1wKt51LePB2Qa0w0ned2hHvTAjOo/h
         P5H/ijN35RmKImocQbkXPERBqKEBew2tvGRClBvj5t4oUgfq58kRB0QQ5+g+A+EtfKM2
         18qg==
X-Gm-Message-State: AOAM5304iDFDwAybhZ2ZXq3nrzjmyQN0rjfRb3E9TeDaA2+bfbh06SLa
        KU2FJHfz/BlLcf1PT/AYrnXlRpKycRjYmS2z3n+3eg==
X-Google-Smtp-Source: ABdhPJzgLDlNilfBZKmbbH8H2Uk2UVDjvBIrQsW0+oLdeyZRHKrR5jlzW/kUKD8yBXXhCpILuvveGrj5ub9Jg+5NS9U=
X-Received: by 2002:aa7:8084:: with SMTP id v4mr5089195pff.39.1589992374419;
 Wed, 20 May 2020 09:32:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200517011732.GE24705@shao2-debian> <20200517034739.GO2869@paulmck-ThinkPad-P72>
 <CANpmjNNj37=mgrZpzX7joAwnYk-GsuiE8oOm13r48FYAK0gSQw@mail.gmail.com>
 <CANpmjNMx0+=Cac=WvHuzKb2zJvgNVvVxjo_W1wYWztywxDKeCQ@mail.gmail.com>
 <CANpmjNPcOHAE5d=gaD327HqxTBegf75qeN_pjoszahdk6_i5=Q@mail.gmail.com>
 <CAKwvOd=Gi2z_NjRfpTigCCcV5kUWU7Bm7h1eHLeQ6DZCmrsR8w@mail.gmail.com>
 <20200518180513.GA114619@google.com> <CANpmjNMTRO0TxxTQxFt8EaRLggcPXKLJL2+G2WFL+vakgd2OUg@mail.gmail.com>
 <CANpmjNO0kDVW4uaLcOF95L3FKc8WjawJqXKQtYbCad+W2r=75g@mail.gmail.com> <CANpmjNOeXmD5E3O50Z3MjkiuCYaYOPyi+1rq=GZvEKwBvLR0Ug@mail.gmail.com>
In-Reply-To: <CANpmjNOeXmD5E3O50Z3MjkiuCYaYOPyi+1rq=GZvEKwBvLR0Ug@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 20 May 2020 09:32:43 -0700
Message-ID: <CAKwvOd=ga4cjJCQASVH=Vwjkk5_Qh7b_TtoTSBBoLiMENL8hOQ@mail.gmail.com>
Subject: Re: [rcu] 2f08469563: BUG:kernel_reboot-without-warning_in_boot_stage
To:     Marco Elver <elver@google.com>
Cc:     george.burgess.iv@gmail.com, Kan Liang <kan.liang@linux.intel.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        kernel test robot <rong.a.chen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, LKP <lkp@lists.01.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 11:32 AM Marco Elver <elver@google.com> wrote:
>
> This fixes the problem:
> https://lkml.kernel.org/r/20200519182459.87166-1-elver@google.com
>
> I suppose there are several things that happened that caused the above
> bisected changes to trigger this. Hard to say how exactly the above
> bisected changes caused this to manifest, because during early boot
> (while uninitialized) KASAN may just randomly enter kasan_report()
> before the branch (annotated with likely(), which is caught by the
> branch tracer) prevents it from actually generating a report. However,
> if it goes branch tracer -> KASAN -> branch tracers -> KASAN ..., then
> we crash. If I had to guess some combination of different code gen,
> different stack and/or data usage. So all the above bisected changes
> (AFAIK) were red herrings. :-)

Thanks for chasing to resolution.  Consider using a variable to store
a list of flags, as that code (before your patch) invokes the compiler
multiple times to answer the same question.
-- 
Thanks,
~Nick Desaulniers
