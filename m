Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3BFFC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 07:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 688D220708
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 07:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BpqLqZ/J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgETHvh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 03:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbgETHvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 03:51:36 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1963BC061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 00:51:36 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id 67so480322ybn.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 00:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ms3aI/Ojt3aIz9YtHAH0CURmofegVxafgWmwlFS7hp4=;
        b=BpqLqZ/JEZCTbUqN7bGO5U/U5s0UtJjQ2D28oGz4gezSupEDNyovta/R0dtLlpnDI5
         dWBugc/yi4ltPuQscJt+ptTX+o4kcuBd57C7TOQVlKZxnk11jFY8FUVQ3s0YcfjIF9KN
         +TNtAudXmymMFhx6GZXlDQ29e/xkd8WsP6P+V7BbCKwK83IDcCWhjFGio1sOXTBLo33p
         DLE2kyT8Lymr34ziHZqmpp00Jy7psuYq8gpBfQvjlpaMUSIG0gTo6iyE2L4QTUtWm9yC
         gYX5wyXb6QogoipfllZOArxj5YYYCqx96aMgfVrQfMBcYXbTW2WMWfo4YZl452czLPUu
         MVNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ms3aI/Ojt3aIz9YtHAH0CURmofegVxafgWmwlFS7hp4=;
        b=aQK328CLUxZtM8FIY+mO2RFVOaXmfgDQhyRv+YGiQUdGoCewOYZROoc8a1s90IQpy6
         0y+PU2/IN5slKdFgh+2p1EXRQjWpC4yW74Q4HGUiAmaIyj5Hoe3JbNlmgV9yWgak3ATp
         l6RbvZKuYYhf6SBiyDSJblmGE2Bdc8HiOaHbjzLQ1Gdi2wWYf/nrXttDIxfdJpLXIP2p
         NXzOg/AYz5J2uvk9T80+XO8nz2LWVlL4lKwqUN6dBeMaRDeBitHpvvVWIQWKPCJzGdf0
         GPHAg8JlCjWM/WQ2PyEs90lTmBTKsztBKoivy6neTrIDKXrzRR53WGvO0jyk67WPL7kD
         x73A==
X-Gm-Message-State: AOAM530EhUUvyb1MfK//cmi7pmVwOOV7e1qnrfhwoXRgpo/JWO93KZAc
        IM7gKf4T/gJ9RFqyR9ukHWkehOjw95msvNxXyhVxuQ==
X-Google-Smtp-Source: ABdhPJxbwz3Mo9Ge2Gm6otHngICoDOTxO0VlVOruHGWdkK5LfXh6m7zDSbtgtlcPOFGJoST+K1m62hbktpHid1eCgxE=
X-Received: by 2002:a25:d450:: with SMTP id m77mr5143898ybf.177.1589961094983;
 Wed, 20 May 2020 00:51:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200520074050.156988-1-jolsa@kernel.org>
In-Reply-To: <20200520074050.156988-1-jolsa@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 20 May 2020 00:51:24 -0700
Message-ID: <CAP-5=fWaqofns-K1_q=0iAZOF1D0CVDEyE6v6r+3L=Sd9Mto6w@mail.gmail.com>
Subject: Re: [PATCH] perf stat: Fail on extra comma while parsing events
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 12:41 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Ian reported that we allow to parse following:
>
>   $ perf stat -e ,cycles true
>
> which is wrong and we should fail, like we do with this fix:
>
>   $ perf stat -e ,cycles true
>   event syntax error: ',cycles'
>                         \___ parser error
>
> The reason is that we don't have rule for ',' in 'event'
> start condition and it's matched and accepted by default
> rule.
>
> Adding scanner debug support (that Ian already added for
> expr code), which was really useful for finding this. It's
> enabled together with bison debug via 'make PARSER_DEBUG=1'.
>
> Reported-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

Ian

> ---
>  tools/perf/util/parse-events.c | 1 +
>  tools/perf/util/parse-events.l | 4 +++-
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index e37a6a3e6217..d251c8a778b8 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -2014,6 +2014,7 @@ static int parse_events__scanner(const char *str, void *parse_state, int start_t
>
>  #ifdef PARSER_DEBUG
>         parse_events_debug = 1;
> +       parse_events_set_debug(1, scanner);
>  #endif
>         ret = parse_events_parse(parse_state, scanner);
>
> diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
> index c589fc42f058..394132254447 100644
> --- a/tools/perf/util/parse-events.l
> +++ b/tools/perf/util/parse-events.l
> @@ -252,7 +252,9 @@ modifier_bp [rwx]{1,3}
>                         BEGIN(INITIAL);
>                         REWIND(0);
>                 }
> -
> +,              {
> +                       return ',';
> +               }
>  }
>
>  <array>{
> --
> 2.25.4
>
