Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50ED2C10F25
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 20:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20D1B206E2
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 20:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RA3xZa1v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgCFUNg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 15:13:36 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40709 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgCFUNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 15:13:35 -0500
Received: by mail-qk1-f196.google.com with SMTP id m2so3535112qka.7
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 12:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fJc4U5WY7cWL3ePtlUY+8JsXidAJkBExvKvPimDhOVw=;
        b=RA3xZa1vk1bG2lkUp5CfDJuaLxlkHx2IBfSqqZfPejSuOmK4KjRpSukURhttjMEDCK
         27VGeMxrcjhb/agq82UiCA6ThP059BjmS+wz5eUkE+K1rI1Zo2SsIPb3JewJ+3TKfA2q
         geHT1JOI8oudPA7IBuPA1B6mWKEUXZ3siVqAEq3GLsobGEkBS+FHb8Dj+JDRl27fnY1O
         Zl0R4eya+UxlOhRiDOArkb54m2I9XhOLjt+9m/R9vJz40IhJT99PVeD8ULgp/LKuViu7
         kd2CeplKt8M3/1sxJdWRxK+8xHyHtC//eQvmGeIpuRXIqBE5KGNx//zbalIbexAFm4jZ
         jqiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fJc4U5WY7cWL3ePtlUY+8JsXidAJkBExvKvPimDhOVw=;
        b=A3EoTXga5PKTJSKhYUVbQWRxI/MSsufugtHdaEvqSIXxLhR5YnRMbdU54gj+0CB9so
         d7EpEoKpgnD616jTBvEnd6oZKlFNCQTgReWQcNNWe+qgX+yOxzc7+ZJxg6ODEQnSF6Sz
         KRzHem3WpiNHGSxv/x9LFU7dA/7tg2eAMZwbaR2xjghAHuOtNAPB2ItYAY9z7s8Lx3BT
         NNNjIZG5fPjxIZ81L85ZbGuYsl8FWRkFeoc2fp8etApl6mdg0GHHGgvTSnSFFty7xjKo
         avodsONOX5VYrATqJ2Qfii2LqxJeh7qb/cwKhTwwLFdqFh7dBBDfv02it0Qu3SGMPpWH
         fIrg==
X-Gm-Message-State: ANhLgQ1GgfMn0fGfIUPJi97e3lT9ALzSc7qyhuo0qvASFZlI/O+F5R3k
        sQoBkOba+hUBc6w8GgbjwaE=
X-Google-Smtp-Source: ADFU+vt++FntelhXMyS7L4AAUXOX7QtCMBXm+5EcfOiEQwzH6ntDJZuG1brPA/5qVMRWGLJnF9fw1Q==
X-Received: by 2002:a37:888:: with SMTP id 130mr4326961qki.261.1583525614465;
        Fri, 06 Mar 2020 12:13:34 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id k202sm5268342qke.134.2020.03.06.12.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 12:13:33 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 96743403AD; Fri,  6 Mar 2020 17:13:31 -0300 (-03)
Date:   Fri, 6 Mar 2020 17:13:31 -0300
To:     Ian Rogers <irogers@google.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Igor Lubashev <ilubashe@akamai.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wei Li <liwei391@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 1/3] tools: fix off-by 1 relative directory includes
Message-ID: <20200306201331.GC13774@kernel.org>
References: <20200306071110.130202-1-irogers@google.com>
 <20200306071110.130202-2-irogers@google.com>
 <20200306093355.GB281906@krava>
 <CAP-5=fUAjMxGDWfev_q6vKhe1M5D1UdXhPK6x5Y9bxUbrJ-tNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fUAjMxGDWfev_q6vKhe1M5D1UdXhPK6x5Y9bxUbrJ-tNw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Mar 06, 2020 at 08:47:51AM -0800, Ian Rogers escreveu:
> On Fri, Mar 6, 2020 at 1:34 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Thu, Mar 05, 2020 at 11:11:08PM -0800, Ian Rogers wrote:
> > > This is currently working due to extra include paths in the build.
> >
> > if you're fixing this, why not remove that extra include path then?
> 
> TL;DR it is complicated, but the include paths are all currently
> necessary I believe and doing this way is necessary due to how header
> files may be copied out of the kernel.

TL;DR response: yeah, lets make incremental fixes to this, like applying
this patch :)

- Arnaldo
 
> The current build uses multiple -Is to ensure the correct version of a
> file is included, for example there are 27 files called bitops.h and
> 29 called bitsperlong.h. In
> Google we're using libraries and bazel build files:
> https://docs.bazel.build/versions/master/be/c-cpp.html#cc_library
> and there's no way to say if you depend on this library then you need
> this include path. We've tried to make perf this way but having tied
> ourselves in knots we decided instead to emulate the include path
> behaviour by rewriting includes when we import code using copybara:
> https://github.com/google/copybara
> We are able when doing this to prioritize the include paths we rewrite
> so that a local directory version of a header is preferred over say
> one in tools/lib/perf and perhaps tools/perf. Having full include
> paths isn't really an option upstream as the same header file may be
> copied into a libc project that has a different directory layout.
> As we have absolute include paths at the time of building we need
> relative include paths to be correct. Upstream -Is allow the build to
> find the file but it is a bit of a quirk of the C preprocessor, so
> fixing these off-by 1s feels like value add both for us and upstream.
> For upstream to do anything different I think is going to be a
> significant rewrite of how the Makefile build works and I'm not sure
> what the result would look like.
> 
> Thanks!
> Ian
> 
> > jirka
> >

-- 

- Arnaldo
