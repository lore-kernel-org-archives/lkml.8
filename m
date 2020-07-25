Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E84C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 16:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24E2C206F6
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 16:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nKIgy4ti"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgGYQlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 12:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgGYQlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 12:41:10 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04EFDC08C5C0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 09:41:10 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f7so10974552wrw.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 09:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RiXVo3AMimnhVv7/19uNQl81O8qD2MfnX5iUSVdBFlI=;
        b=nKIgy4ti9DcsBsbxwF/WwMoQFRPUN5l9UJK7/4VGP9Me5METBwGWRl42iztnpN3KYj
         8oy+fAJeKiw8lYjz1KdjzrSs/8Th0lRTBIL/xEK5PW+MY6Jj1ampISpFR769hVXRGXIV
         XxmMlehAbTVvRbBvwo5EfEZ+4sSAkUISnzR4WrXjbRbQ25iix02M+A9q+JtX/MpMOANl
         /wb43/0Ym+Hc8TKhy6QwGd6HLYe39VRUALPsZqXS8RYlWrW5lvzPO29ywJvl0GyiTKoO
         QajrZkBnao8VlQL/eUmzSg4XQyT1VnQQqw52sdELspnqCGFUH1cgq8TvTf6rVHlz62gz
         JTbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RiXVo3AMimnhVv7/19uNQl81O8qD2MfnX5iUSVdBFlI=;
        b=JxnPQZZay6y2YvjQWt5pPdzR6PxXyY8INJaW6FU/FCohGVwgYXDn+l6qScYX4o/g9T
         IFUUIOwHM40ZT3u82fGlRyBznHKekE5Lh9GcRhp6uA6SRCqtHWTEdGYdwHwuEFZdmAct
         JgYT/0Z91/wyXy8LoDni4EJGek9uQak1T1r4nChbg8wwmjbnPOUt50oR96YWsWtesTE0
         l+bqvm/K3ur1ne1HkMt6edHk7zBCG5LHN2Ac1vl6PutUiezK5XWw8snM1MgVSYkbC5ep
         QA+rq6s3CfTZ658rZCYdeV1Mjr+/UQ5h1bo71gHVtGTXgK/jB4TbCiugoFhjd6QLULrb
         llCA==
X-Gm-Message-State: AOAM532RfnQ+NKxoipUaJBtu9B6DEyG4a1Z6EAhv/3/SvTkaMD3oSfPA
        UCPwQ1Jtf8saKR3Gpspzr0QP9SETLop4DRJc0FKUpw==
X-Google-Smtp-Source: ABdhPJzQue3Kr6IRVtroTmFlA1Nqqv0J+V7IMpPgDlXfGUOCLfFYFTjqkXxJPFIc/Gg9bqW0bf2K0Jz9iPu/2qeV4BY=
X-Received: by 2002:adf:edd0:: with SMTP id v16mr14345300wro.271.1595695266958;
 Sat, 25 Jul 2020 09:41:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200725121959.1181869-1-jolsa@kernel.org>
In-Reply-To: <20200725121959.1181869-1-jolsa@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Sat, 25 Jul 2020 09:40:55 -0700
Message-ID: <CAP-5=fU5HOmOR6XekgZsHG1a1wzh=1=kdFsddOYbGYK_U4fG7A@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf tools: Allow r0x<HEX> event syntax
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 25, 2020 at 5:20 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding support to specify raw event with 'r0<HEX>' syntax within
> pmu term syntax like:
>
>   -e cpu/r0xdead/
>
> It will be used to specify raw events in cases where they conflict
> with real pmu terms, like 'read', which is valid raw event syntax,
> but also a possible pmu term name as reported by Jin Yao.
>
> Reported-by: Jin Yao <yao.jin@linux.intel.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

> ---
>  tools/perf/Documentation/perf-list.txt | 1 +
>  tools/perf/tests/parse-events.c        | 5 +++++
>  tools/perf/util/parse-events.l         | 1 +
>  3 files changed, 7 insertions(+)
>
> diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
> index 376a50b3452d..10ed539a8859 100644
> --- a/tools/perf/Documentation/perf-list.txt
> +++ b/tools/perf/Documentation/perf-list.txt
> @@ -119,6 +119,7 @@ It's also possible to use pmu syntax:
>
>   perf record -e r1a8 -a sleep 1
>   perf record -e cpu/r1a8/ ...
> + perf record -e cpu/r0x1a8/ ...
>
>  You should refer to the processor specific documentation for getting these
>  details. Some of them are referenced in the SEE ALSO section below.
> diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
> index 895188b63f96..5aaddcb0058a 100644
> --- a/tools/perf/tests/parse-events.c
> +++ b/tools/perf/tests/parse-events.c
> @@ -1766,6 +1766,11 @@ static struct evlist_test test__events_pmu[] = {
>                 .check = test__checkevent_raw_pmu,
>                 .id    = 4,
>         },
> +       {
> +               .name  = "software/r0x1a/",
> +               .check = test__checkevent_raw_pmu,
> +               .id    = 4,
> +       },
>  };
>
>  struct terms_test {
> diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
> index 56912c9641f5..44c85fea5d00 100644
> --- a/tools/perf/util/parse-events.l
> +++ b/tools/perf/util/parse-events.l
> @@ -293,6 +293,7 @@ percore                     { return term(yyscanner, PARSE_EVENTS__TERM_TYPE_PERCORE); }
>  aux-output             { return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_OUTPUT); }
>  aux-sample-size                { return term(yyscanner, PARSE_EVENTS__TERM_TYPE_AUX_SAMPLE_SIZE); }
>  r{num_raw_hex}         { return raw(yyscanner); }
> +r0x{num_raw_hex}       { return raw(yyscanner); }
>  ,                      { return ','; }
>  "/"                    { BEGIN(INITIAL); return '/'; }
>  {name_minus}           { return str(yyscanner, PE_NAME); }
> --
> 2.25.4
>
