Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B435FC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 05:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BEA92074A
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 05:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sKbygJay"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbgIDFbZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 01:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgIDFbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 01:31:23 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C648FC061244
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 22:31:22 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id x14so5378754wrl.12
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 22:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uMlM9XPLd0j8P0/aRabMWwa2svO4gw32t1kN1da6wwk=;
        b=sKbygJay1AwoLskDd1MWUiOlgyyJBzndTYFiOl0z6OlIOSNeUn4kYy8BAvFg5ggyG3
         BWcsGBWh0K+uqvDy8PsyClyYODivgvSC5bNxHo+zB5yGnGADMqMyqPDNnFDWcK2EcK1z
         tk+aa1IO+xyLnjJnXSwGkb1bOJoIPmxJjv/aydzY2Y738f58o4vgL8xXqOXNrNkW2/jh
         q33IwUv6x2xEB2/kvsEStS0WbiN+9ZkdJWrxF8oaTy7aavVE0eF9nj8PtDRr3C8UCxR9
         GDq5KM5aLnre7FkPRPICmKBw2wHW2pGlkcmR5NInZSPDh0Kb/GDHfSek/55trAdZMCni
         5w3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uMlM9XPLd0j8P0/aRabMWwa2svO4gw32t1kN1da6wwk=;
        b=PvR8SOyVq7s51Iz1m7ZDV5dnzi50byDfU3g+kwPAyNqTxdfFlAxqkcnrzt+DFGJW/x
         jnqSZFG8T4maCD+NA5XZNXRlbxZYA6kHKlJTtPXQ/sM8U88FGDhiJfL0pT0XZZuJh5sr
         9m+uie3IxlIZbdpdWS0VGZj+8JkY+Fr0B1QjhF6mUKm9kT4tTG9NvUjIt7cGYpcdTz3d
         bxE4i2/4IakUlA7I8Nb0jK5i3hGrHaR0ms/7sasQA1vMBMHXRcYE1Lz8GhwKupsuyfTJ
         Jaa4XjtXzrywCy09JbvdcpYi/3mxwpV5AKP7pldsRpS662gJXZfoabQz3NBHYveyLF9M
         7XGw==
X-Gm-Message-State: AOAM530Xa+dfcTIWmxnp6Ab4XHvb0u6TY+XgCBFFPArxTXc7cA5894fM
        PSPINHTn5tE2YWlChSkVRUjEun/f583i3TVVMDHZ9w==
X-Google-Smtp-Source: ABdhPJzC90134mJIKA/5mLEC4Flpm6LhaeVSioRuPKVsLD2wMugvVAPRM1RcpGtQe8iDsBxc2tT+dxBOj3xsMZmocls=
X-Received: by 2002:adf:82b1:: with SMTP id 46mr6279732wrc.271.1599197481136;
 Thu, 03 Sep 2020 22:31:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200903184359.GC3495158@kernel.org>
In-Reply-To: <20200903184359.GC3495158@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 3 Sep 2020 22:31:09 -0700
Message-ID: <CAP-5=fWvLaeuvQ6p0ep_uA0MNpk3o0hxim5tPQf+RXCafj8E=A@mail.gmail.com>
Subject: Re: [PATCH] perf parse-events: Use uintptr_t when casting numbers to pointers
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jin Yao <yao.jin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jiri Olsa <jolsa@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Stephane Eranian <eranian@google.com>,
        Yonghong Song <yhs@fb.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 3, 2020 at 11:44 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Hi Ian,
>
>         Please check that this is ok with you,
>
> Thanks,
>
> - Arnaldo

Thanks Arnaldo, this looks good to me! There is a separate issue, the
casts are necessary as we have PE_VALUEs that are supposed to be
numbers but here are list*. It seems error prone to have something
that is a pointer or a number, and so I wonder if we can introduce new
tokens in parse-events.y to handle this. It'd also mean that
yydestructors and the like could clean up error states. I'll try to
take a look.

Thanks,
Ian

> commit 0823f768b800cca2592fad3b5649766ae6bc4eba
> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date:   Thu Sep 3 15:34:20 2020 -0300
>
>     perf parse-events: Use uintptr_t when casting numbers to pointers
>
>     To address these errors found when cross building from x86_64 to MIPS
>     little endian 32-bit:
>
>         CC       /tmp/build/perf/util/parse-events-bison.o
>       util/parse-events.y: In function 'parse_events_parse':
>       util/parse-events.y:514:6: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
>         514 |      (void *) $2, $6, $4);
>             |      ^
>       util/parse-events.y:531:7: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
>         531 |       (void *) $2, NULL, $4)) {
>             |       ^
>       util/parse-events.y:547:6: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
>         547 |      (void *) $2, $4, 0);
>             |      ^
>       util/parse-events.y:564:7: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
>         564 |       (void *) $2, NULL, 0)) {
>             |       ^
>
>     Fixes: cabbf26821aa210f ("perf parse: Before yyabort-ing free components")
>     Cc: Adrian Hunter <adrian.hunter@intel.com>
>     Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>     Cc: Alexei Starovoitov <ast@kernel.org>
>     Cc: Andi Kleen <ak@linux.intel.com>
>     Cc: Daniel Borkmann <daniel@iogearbox.net>
>     Cc: Ian Rogers <irogers@google.com>
>     Cc: Jin Yao <yao.jin@linux.intel.com>
>     Cc: Jiri Olsa <jolsa@kernel.org>
>     Cc: John Garry <john.garry@huawei.com>
>     Cc: Kan Liang <kan.liang@linux.intel.com>
>     Cc: Mark Rutland <mark.rutland@arm.com>
>     Cc: Martin KaFai Lau <kafai@fb.com>
>     Cc: Namhyung Kim <namhyung@kernel.org>
>     Cc: Peter Zijlstra <peterz@infradead.org>
>     Cc: Song Liu <songliubraving@fb.com>
>     Cc: Stephane Eranian <eranian@google.com>
>     Cc: Yonghong Song <yhs@fb.com>
>     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
> index b9fb91fdc5de9177..645bf4f1859fd76b 100644
> --- a/tools/perf/util/parse-events.y
> +++ b/tools/perf/util/parse-events.y
> @@ -511,7 +511,7 @@ PE_PREFIX_MEM PE_VALUE '/' PE_VALUE ':' PE_MODIFIER_BP sep_dc
>         list = alloc_list();
>         ABORT_ON(!list);
>         err = parse_events_add_breakpoint(list, &parse_state->idx,
> -                                       (void *) $2, $6, $4);
> +                                       (void *)(uintptr_t) $2, $6, $4);
>         free($6);
>         if (err) {
>                 free(list);
> @@ -528,7 +528,7 @@ PE_PREFIX_MEM PE_VALUE '/' PE_VALUE sep_dc
>         list = alloc_list();
>         ABORT_ON(!list);
>         if (parse_events_add_breakpoint(list, &parse_state->idx,
> -                                               (void *) $2, NULL, $4)) {
> +                                               (void *)(uintptr_t) $2, NULL, $4)) {
>                 free(list);
>                 YYABORT;
>         }
> @@ -544,7 +544,7 @@ PE_PREFIX_MEM PE_VALUE ':' PE_MODIFIER_BP sep_dc
>         list = alloc_list();
>         ABORT_ON(!list);
>         err = parse_events_add_breakpoint(list, &parse_state->idx,
> -                                       (void *) $2, $4, 0);
> +                                       (void *)(uintptr_t) $2, $4, 0);
>         free($4);
>         if (err) {
>                 free(list);
> @@ -561,7 +561,7 @@ PE_PREFIX_MEM PE_VALUE sep_dc
>         list = alloc_list();
>         ABORT_ON(!list);
>         if (parse_events_add_breakpoint(list, &parse_state->idx,
> -                                               (void *) $2, NULL, 0)) {
> +                                               (void *)(uintptr_t) $2, NULL, 0)) {
>                 free(list);
>                 YYABORT;
>         }
