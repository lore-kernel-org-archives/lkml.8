Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B01D1C4CECD
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 20:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F4FF206D9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 20:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fiouDYCk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgD0UKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 16:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726205AbgD0UKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 16:10:47 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B1BC0610D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 13:10:47 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id l78so19452967qke.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 13:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3l2kWyAVHOWSuEUbycrT6AidP4si2/zy60pGuFCsUSE=;
        b=fiouDYCkHG4Eg7BHAQ8IO87s4LQMvzFHPr+C/vQRhOvTumCFZlYSShWEon1hlRmqk1
         PwGf/ZMdo7nWIUUdMc1fPHGRL3KxrCORb2J1B21nuRjtx1i9SjDjCUDei3VNO8ninfRu
         za1eREQ39+btOBBApTp3XECZGBjOnweWxH65KW9KCmcggEI3YsJwHgvDg9oy8P3I0TBU
         TsR+WpF76BbyuhrsXHUE6piBOV3UEoqtI4IBq37NKXOciILX8+9kleluJq3XpdGwZNQB
         1IT3JvFA943ipf8AUEpPgF/guw4uYQ+DhtGv63/GgBLo8a07o/CyXKUm81D1HeNjv0lJ
         GewA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3l2kWyAVHOWSuEUbycrT6AidP4si2/zy60pGuFCsUSE=;
        b=oOjHH6qG/C7LhiIoy/YLk35bnLjfLoWm0EKmEIA+KCF13VTOvx2myu2WO46GUzwdyg
         WreQ7i1IijEkCxsGUvC6/BUcPxsLW2AFbHTWLMIdSNEpuefcuefbWYovBiofEuXsEi4p
         znZW7Zf2FpBdn0mjSLWSWrJPbWiYZgPseY5SqbmrxexnTQ/EC+gVjD3wDsXn1Q2dlUlx
         SAWs0gnfpmzelOCpD1cVfzTRlIXEooJQROp3slyAjIKdOMJMpEUfemglpvROWEiXktq6
         lVfyGe2gAkggM2iqmKY6NVeZIsJSS18idAN0FqeXat5K6XgrQrAvcjuz61Fm8lydC9+a
         oiFg==
X-Gm-Message-State: AGi0PubGlXmV+GWgTOotWasZ+UYji9NcNwMxUAo9sWbfGzEx9kww5dkY
        HH+d4rhBS5luoyb3ELxZsQ0=
X-Google-Smtp-Source: APiQypKjxDYkx92awVftkfSXuPbisbGOLN1xeev4lT01j1fX1LHfj1aFnxHaT7WAIBOz4F6o03IZZQ==
X-Received: by 2002:ae9:ef0b:: with SMTP id d11mr23730219qkg.403.1588018246551;
        Mon, 27 Apr 2020 13:10:46 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id m12sm643597qtu.42.2020.04.27.13.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 13:10:45 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C1102409A3; Mon, 27 Apr 2020 17:10:43 -0300 (-03)
Date:   Mon, 27 Apr 2020 17:10:43 -0300
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6 08/15] ftrace: Add perf text poke events for ftrace
 trampolines
Message-ID: <20200427201043.GP19437@kernel.org>
References: <20200405201327.7332-1-adrian.hunter@intel.com>
 <20200405201327.7332-9-adrian.hunter@intel.com>
 <20200421134504.GQ20730@hirez.programming.kicks-ass.net>
 <ce16611a-8b6c-765d-c254-5bb98493b082@intel.com>
 <20200422114659.GE20730@hirez.programming.kicks-ass.net>
 <76de871f-fb0a-6918-68a9-94aa7b049d6b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76de871f-fb0a-6918-68a9-94aa7b049d6b@intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Apr 27, 2020 at 10:23:05AM +0300, Adrian Hunter escreveu:
> On 22/04/20 2:46 pm, Peter Zijlstra wrote:
> > On Wed, Apr 22, 2020 at 10:39:06AM +0300, Adrian Hunter wrote:
> >> On 21/04/20 4:45 pm, Peter Zijlstra wrote:
> >>> On Sun, Apr 05, 2020 at 11:13:20PM +0300, Adrian Hunter wrote:
> >>>> Add perf text poke events for ftrace trampolines when created and when
> >>>> freed.
> >>>
> >>> Maybe also put in a little more detail on the various events. Because
> >>> arch_ftrace_update_trampoline() can also generate text_poke_bp() events,
> >>> to update an existing trampoline.
> >>>
> >>> A diagram, like with the kprobes thing perhaps.
> >>
> >> How about adding this:
> >>
> >> There can be 3 text_poke events for ftrace trampolines:
> >>
> >> 1. NULL -> trampoline
> >>    By ftrace_update_trampoline() when !ops->trampoline
> >>    Trampoline created
> >>
> >> 2. [e.g. on x86] CALL rel32 -> CALL rel32
> >>    By arch_ftrace_update_trampoline() when ops->trampoline and
> >>                         ops->flags & FTRACE_OPS_FL_ALLOC_TRAMP
> >>    [e.g. on x86] via text_poke_bp() which generates text poke events
> >>    Trampoline-called function target updated
> >>
> >> 3. trampoline -> NULL
> >>    By ftrace_trampoline_free() when ops->trampoline and
> >>                  ops->flags & FTRACE_OPS_FL_ALLOC_TRAMP
> >>    Trampoline freed
> > 
> > Yes, very nice. Thanks!
> 
> Arnaldo, do you have this patchset on your radar?

Now it is, will look it into it,

- Arnaldo
