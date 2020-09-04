Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6356EC433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 05:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23700206C9
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 05:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DcqLT4v+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgIDFxb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 01:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgIDFxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 01:53:30 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE248C061244
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 22:53:29 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id u18so4905034wmc.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 22:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yJDVwwbw1qOq4XNkIij/xlhDxBT/xq3FKFF20CPGobU=;
        b=DcqLT4v+5fdpGzNr4ozRUu4e6yGlxBRWxfuh7dN9DSDGBSMg6P54QlLkTXu4PjmH1c
         HLGk1kbfAGFMR++4HSA94tTlbgmkM/rlWTO4luox6JuzYY/wzKJDczpTJBzyZo4iM0DC
         ZvanobtsstemKYUTu4EWiHhA3K9YqOKXNL6B6J6MKMoB/xvm2wUqwgFQy61yrfIwofGo
         1Gk4CH2TzBr0vpv4uTgDUrk4dnMOhUbcJItLSRvjN6YHflB4QaOtR9qjQFa2FDNJQqpB
         Fe/lzSSeB8dEdQr5qZTN4WJvlIz7z8V7H2twdI4C9KRqZC8u7e/i3ngLHrgc+LTACHs5
         MuWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yJDVwwbw1qOq4XNkIij/xlhDxBT/xq3FKFF20CPGobU=;
        b=D/aI/eYILfd/3a1KwtsC/r/fPIJ5QDuzPZjx723zmNZtu7wi93sjChBxxM5cgzb9aj
         ZmGDCmcEgLPn+760OqvwZCjRW+bwUGzpTisqRKwxiAl0m8cGKvsuBQUg7Pad3Xhu0fCb
         1oTzQz2UUIc37aKgAoTt4VMEumkVfVpUetsk5cImW6UNdsdLKLlrpcZUPq4lb316Oylo
         yjNlM5jug5yVNCNcEiOfu2Gq0o560PIfx0UfyW3bGtD/CVG1abzLQK1t/bz0X0WwUcXx
         AvNtWzYIV/Q2qGs6tkAO20RJtcpcvkiuSc2fET/0nIk1UuBXn1+dOw1+uPDz/czQhN+x
         QzBg==
X-Gm-Message-State: AOAM531GmIj/0432dXa5kiB1wwXpSVGDoTmhfPgPrBgOBGaerVXn36OP
        3GAYfc2RCdhb0X5n7gw/KynakB1C+EQqvtjT/lA+rg==
X-Google-Smtp-Source: ABdhPJy9kzOmUmDIZbOHv/Hf/mNZCQV0G5MQPOvA7gtStOXSjLymmuZzu8sFRjYziY1ZdDjfNhcMWBrZNBfCQHC1pGQ=
X-Received: by 2002:a1c:f402:: with SMTP id z2mr5597873wma.87.1599198808198;
 Thu, 03 Sep 2020 22:53:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200826153055.2067780-1-irogers@google.com> <20200826155733.GB783610@krava>
 <4b6bc995-d468-3137-f00f-3867233740a3@linux.ibm.com>
In-Reply-To: <4b6bc995-d468-3137-f00f-3867233740a3@linux.ibm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 3 Sep 2020 22:53:16 -0700
Message-ID: <CAP-5=fUdK2Zuv9BMpkRw669n_SvQ3kDa0s0RA=Hj1GUtqqw0YQ@mail.gmail.com>
Subject: Re: [PATCH v2] perf expr: Force encapsulation on expr_id_data
To:     kajoljain <kjain@linux.ibm.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 12:00 AM kajoljain <kjain@linux.ibm.com> wrote:
>
>
>
> On 8/26/20 9:27 PM, Jiri Olsa wrote:
> > On Wed, Aug 26, 2020 at 08:30:55AM -0700, Ian Rogers wrote:
> >> This patch resolves some undefined behavior where variables in
> >> expr_id_data were accessed (for debugging) without being defined. To
> >> better enforce the tagged union behavior, the struct is moved into
> >> expr.c and accessors provided. Tag values (kinds) are explicitly
> >> identified.
>
> Reviewed-By: Kajol Jain<kjain@linux.ibm.com>
>
> Thanks,
> Kajol Jain
> >>
> >> Signed-off-by: Ian Rogers <irogers@google.com>
> >
> > great, thanks for doing this
> >
> > Acked-by: Jiri Olsa <jolsa@redhat.com>
> >
> > jirka
> >

Thanks for the reviews! Arnaldo could this get merged? Thanks!
Ian
