Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A1FCC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 22:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F06F322B3F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 22:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mVJEatOd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgGaWmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 18:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbgGaWmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 18:42:45 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202A8C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 15:42:45 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id g26so30365689qka.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 15:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=lRZ/kR3FPznmCCnlDUPcWOWNypb4IUdQs0XDm4EnSj8=;
        b=mVJEatOdpZmLW30aR48yBFjHb8S7x4SAbT77qK6AaYgDGQSDCzGY9Y3UsB24mnSvfA
         R00DDxoTsD22KVRReSifcxXQTO1lGIyYoTSfZaN6IJuthCgxz0j6UVbpZQKtWVkxve0O
         RvsGjeodMLQdBtLwX2ytXjdENqKtkmISqlnp/0G9adSvF1CjQ5WazDY/IxPDK1qbn4JY
         0uds93uxkkV+Fm7x+Kz14hWUsrUVBa9xF4nrgyAY42qOxCi0eEalRvbeZ0LlLc8g1B1r
         GIQp+jy2k4J6CwEsm1CeLPpQIbHvtV0EYVj4so6ZbdqNmJ7feyr/DZ/+BkLkl/MZxKhz
         wYcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=lRZ/kR3FPznmCCnlDUPcWOWNypb4IUdQs0XDm4EnSj8=;
        b=frkotNk4CTacFB4R4+OHmfsei7M7tQoqj8/YLtNx3nT4kmyEe7vPao9IpMr2xxgk06
         dWGmZoBuG5AXQV7JcGP1E5HjbTGRpQ1zN16RaVu7eHkUXwCZl0cubTvERyiatE9MBFmt
         kHbM3gfsGC65JIwnz4erWCQ37V9/TAKK7DF2jOITEBF5t2cfPHlCiEW9fmiRYmELkrKm
         Bi1+F4p5X2L/h9bnXHrFqjwBqUSTXvpl+XGm/MD6cQtT5une39DtDTf1APzHa5bGK6Or
         Ql3DjVmB5wiOPNftljcj+3KSOQc2KzTqfBRzuitYOoxh3fPrzNo5UidMn2CDOjCHEKcG
         1yWg==
X-Gm-Message-State: AOAM530oI3lZUWfApt8lj7NloQV4MIU0VosND3iZj5qSdgwQKwWYee0Y
        fqWWMHNvfJ/ReiW/QrqCKaU=
X-Google-Smtp-Source: ABdhPJwYdm8xexJCBGkctwGpjYnAhSHzYZYCQHQnBckfpjFWM/zosnA0+2AWE6+yB608XbD7mdemhQ==
X-Received: by 2002:a37:e41:: with SMTP id 62mr6349870qko.429.1596235363786;
        Fri, 31 Jul 2020 15:42:43 -0700 (PDT)
Received: from RedmiNote8Pro-Redmi.localdomain ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id n85sm10112052qkn.80.2020.07.31.15.42.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2020 15:42:42 -0700 (PDT)
Date:   Fri, 31 Jul 2020 19:42:20 -0300
User-Agent: K-9 Mail for Android
In-Reply-To: <20200731173520.x3edhuk73zt7tyuo@mail.google.com>
References: <20200718064826.9865-1-changbin.du@gmail.com> <20200731173520.x3edhuk73zt7tyuo@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v7 00/18] perf: ftrace enhancement
To:     Changbin Du <changbin.du@gmail.com>
CC:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Message-ID: <391BF8A0-1025-478A-965E-1BB85DB87F7D@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On July 31, 2020 2:35:20 PM GMT-03:00, Changbin Du <changbin=2Edu@gmail=2E=
com> wrote:
>Hi Arnaldo,
>Are we ready to merge this serias now Thanks=2E :)


Next week I'll be in vacation, do I'll have more time for upstream stuff,

- Arnaldo


>
>On Sat, Jul 18, 2020 at 02:48:08PM +0800, Changbin Du wrote:
>> The perf has basic kernel ftrace support but lack support of most
>tracing
>> options=2E This serias is target to enhance the perf ftrace
>functionality so
>> that we can make full use of kernel ftrace with perf=2E
>>=20
>> In general, this serias be cataloged into two main changes:
>>   1) Improve usability of existing functions=2E For example, we don't
>need to type
>>      extra option to select the tracer=2E
>>   2) Add new options to support all other ftrace functions=2E
>>=20
>> Here is a glance of all ftrace functions with this serias:
>>=20
>> $ sudo perf ftrace -h
>>=20
>>  Usage: perf ftrace [<options>] [<command>]
>>     or: perf ftrace [<options>] -- <command> [<options>]
>>=20
>>     -a, --all-cpus        system-wide collection from all CPUs
>>     -C, --cpu <cpu>       list of cpus to monitor
>>     -D, --delay <n>       ms to wait before starting tracing after
>program start
>>     -F, --funcs           Show available functions to filter
>>     -G, --graph-funcs <func>
>>                           trace given functions using function_graph
>tracer
>>     -g, --nograph-funcs <func>
>>                           Set nograph filter on given functions
>>     -m, --buffer-size <size>
>>                           size of per cpu buffer
>>     -N, --notrace-funcs <func>
>>                           do not trace given functions
>>     -p, --pid <pid>       trace on existing process id
>>     -T, --trace-funcs <func>
>>                           trace given functions using function tracer
>>     -t, --tracer <tracer>
>>                           tracer to use: function or function_graph
>(This option is deprecated)
>>     -v, --verbose         be more verbose
>>         --func-opts <options>
>>                           function tracer options, available options:
>call-graph,irq-info
>>         --graph-opts <options>
>>                           graph tracer options, available options:
>nosleep-time,noirqs,verbose,thresh=3D<n>,depth=3D<n>
>>         --inherit         trace children processes
>>         --tid <tid>       trace on existing thread id (exclusive to
>--pid)
>>=20
>> v7:
>>   o add back '--tid <tid>'=2E
>> v6:
>>   o fix return value of read_tracing_file_to_stdout()=2E
>>   o make __cmd_ftrace() shorter=2E
>>   o remove option '-t, --tid <tid>'=2E
>> v5:
>>   o trivial fixes=2E
>> v4:
>>   o add util/parse-sublevel-options=2Ec
>>   O remove -D/--graph-depth
>> v3:
>>   o add --func-opts and --graph-opts to set tracer specific options=2E
>>   o support units as a suffix for option '-m/--buffer-size'=2E
>> v2:
>>   o patches for option '-u/--userstacktrace' and '--no-pager' are
>dropped=2E
>>   o update all related perf documentation=2E
>>   o rename some options=2E Now all funcgraph tracer options are
>prefixed with
>>     '--graph-', while all function tracer options are prefixed with
>'--func-'=2E
>>   o mark old options deprecated instead of removing them=2E
>>=20
>>=20
>> Changbin Du (18):
>>   perf ftrace: select function/function_graph tracer automatically
>>   perf ftrace: add option '-F/--funcs' to list available functions
>>   perf ftrace: factor out function write_tracing_file_int()
>>   perf ftrace: add option '-m/--buffer-size' to set per-cpu buffer
>size
>>   perf ftrace: show trace column header
>>   perf ftrace: add option '--inherit' to trace children processes
>>   perf: util: add general function to parse sublevel options
>>   perf ftrace: add support for tracing option 'func_stack_trace'
>>   perf ftrace: add support for trace option sleep-time
>>   perf ftrace: add support for trace option funcgraph-irqs
>>   perf ftrace: add support for tracing option 'irq-info'
>>   perf ftrace: add option 'verbose' to show more info for graph
>tracer
>>   perf ftrace: add support for trace option tracing_thresh
>>   perf: ftrace: allow set graph depth by '--graph-opts'
>>   perf ftrace: add option -D/--delay to delay tracing
>>   perf ftrace: add option --tid to filter by thread id
>>   perf: ftrace: Add set_tracing_options() to set all trace options
>>   perf ftrace: add change log
>>=20
>>  tools/perf/Documentation/perf-config=2Etxt |   5 -
>>  tools/perf/Documentation/perf-ftrace=2Etxt |  36 +-
>>  tools/perf/builtin-ftrace=2Ec              | 415
>+++++++++++++++++++++--
>>  tools/perf/util/Build                    |   1 +
>>  tools/perf/util/debug=2Ec                  |  61 +---
>>  tools/perf/util/parse-sublevel-options=2Ec |  70 ++++
>>  tools/perf/util/parse-sublevel-options=2Eh |  11 +
>>  7 files changed, 513 insertions(+), 86 deletions(-)
>>  create mode 100644 tools/perf/util/parse-sublevel-options=2Ec
>>  create mode 100644 tools/perf/util/parse-sublevel-options=2Eh
>>=20
>> --=20
>> 2=2E25=2E1
>>=20

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
