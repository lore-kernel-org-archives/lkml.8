Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87728C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 20:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F1DB207E8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 20:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b2s4V3Jk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbgFZUZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 16:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbgFZUZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 16:25:58 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285A3C03E979
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 13:25:58 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id l2so9019295wmf.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 13:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KYaO6UWR7tEDUVmbX0CA/QaFyBfIOK2zkzOWu/73Z80=;
        b=b2s4V3JkbxuaAQOra2SCuw/IoqU6RCOh1LWePv3qo3azcPsXtzQnaTzZFfXvppW39M
         j/O+84FRuV5e0xzpuDApQwWC6/bVnYz/gjUofsPAeYNtDJ2SHecZLJgre/ZXFDDnKQ2M
         uyRxXG2CuDM5eZ5705db8VuSE9/UOiwzU1dwPArr4xX3T0uNK69jhPM00FZE3oggcK+B
         IMHB/rZWRzU33IQ74m4QWRwiEXxbEh6ldc36xr3jD87t/uwvBVnGIOdDxcIwDZKTD4MC
         CdZOCnipTqLLNKDav7o0iiqWS/mQslYIY4S/ty5ARLtlawgiPr1RW32frUqqAeRAEZGO
         fzRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KYaO6UWR7tEDUVmbX0CA/QaFyBfIOK2zkzOWu/73Z80=;
        b=QMqxt5HPEEKozjdeS7fQDV2gvLmjbp5WTx/GycdjJ9ySBpnEvkMfvO0xUYfmdVUFz0
         WMwuKD+lx6+ECSJg4YlMVyuHBU9JmS4pUfsSi9lvd03omFV5KWBEctzxg/Lf9KSS5ga2
         9h6blA5irguJPytoWjNSdIZpeCwIq6q2r5o9668kgcja9TMXnBEp0OJmewDKorCU+gJS
         YJ7IOyUbI+pe5iHcn81XcwOrqmfdemlNgOoGl6/d+0/NqPtfFd1zRqlQYI2MMHstvSza
         LrTngBJ7Gl7XASD4NJVQsu35dZYY6PgeeP9tSoF8hsHDYXd/0X+m+RisSE461ufFfwFT
         88WQ==
X-Gm-Message-State: AOAM532EN8TFWxXMjcNKN0U1i8PNGdkGLDCPgbM0kI/MVXkkq9qFeMtS
        PcaB9Syr03BO5X1B/wmUnhUX5pcREelxh5OsC4CzTcl1
X-Google-Smtp-Source: ABdhPJyqVzGjdopmPcUrXkk2Xcz1YRDm3nFoTu840E49pJBinF2n+PGmkHb9E1rZ8iGqjY6gZgpow+pZkd1lEqXYLMQ=
X-Received: by 2002:a05:600c:2295:: with SMTP id 21mr5028078wmf.87.1593203156013;
 Fri, 26 Jun 2020 13:25:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200626194720.2915044-1-jolsa@kernel.org> <20200626194720.2915044-5-jolsa@kernel.org>
In-Reply-To: <20200626194720.2915044-5-jolsa@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 26 Jun 2020 13:25:44 -0700
Message-ID: <CAP-5=fWDoFrUL5ieFGYZ=W-4aq3OJMN=vCNoDDTP1z9x4mic6g@mail.gmail.com>
Subject: Re: [PATCH 04/10] perf tools: Change expr__get_id to return struct expr_parse_data
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        "Paul A. Clarke" <pc@us.ibm.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 12:47 PM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Changing expr__get_id to use and return struct expr_parse_data
> pointer as value for the ID. This way we can access data other
> than value for given ID in following changes.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/expr.c | 10 +++-------
>  tools/perf/util/expr.h |  3 ++-
>  tools/perf/util/expr.y | 14 +++++++++-----
>  3 files changed, 14 insertions(+), 13 deletions(-)
>
> diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
> index 0b6d3a6ce88e..29cdef18849c 100644
> --- a/tools/perf/util/expr.c
> +++ b/tools/perf/util/expr.c
> @@ -69,14 +69,10 @@ int expr__add_val(struct expr_parse_ctx *ctx, const char *name, double val)
>         return ret;
>  }
>
> -int expr__get_id(struct expr_parse_ctx *ctx, const char *id, double *val_ptr)
> +int expr__get_id(struct expr_parse_ctx *ctx, const char *id,
> +                struct expr_parse_data **data)
>  {
> -       struct expr_parse_data *data;
> -
> -       if (!hashmap__find(&ctx->ids, id, (void **)&data))
> -               return -1;
> -       *val_ptr = (data == NULL) ?  0.0 : data->val;
> -       return 0;
> +       return hashmap__find(&ctx->ids, id, (void **)data) ? 0 : -1;
>  }

Nit, the 0 vs -1 here is a bit sad given hashmap__find is using true
to mean present. I'm also guilty of not trying to clean this up.

Acked-by: Ian Rogers <irogers@google.com>

>  void expr__ctx_init(struct expr_parse_ctx *ctx)
> diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
> index 5452e641acf4..0af5b887b6c7 100644
> --- a/tools/perf/util/expr.h
> +++ b/tools/perf/util/expr.h
> @@ -28,7 +28,8 @@ void expr__ctx_init(struct expr_parse_ctx *ctx);
>  void expr__ctx_clear(struct expr_parse_ctx *ctx);
>  int expr__add_id(struct expr_parse_ctx *ctx, const char *name);
>  int expr__add_val(struct expr_parse_ctx *ctx, const char *id, double val);
> -int expr__get_id(struct expr_parse_ctx *ctx, const char *id, double *val_ptr);
> +int expr__get_id(struct expr_parse_ctx *ctx, const char *id,
> +                struct expr_parse_data **data);
>  int expr__parse(double *final_val, struct expr_parse_ctx *ctx,
>                 const char *expr, int runtime);
>  int expr__find_other(const char *expr, const char *one,
> diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
> index ac4b119877e0..6252d9f6cfc8 100644
> --- a/tools/perf/util/expr.y
> +++ b/tools/perf/util/expr.y
> @@ -87,12 +87,16 @@ if_expr:
>         ;
>
>  expr:    NUMBER
> -       | ID                    { if (expr__get_id(ctx, $1, &$$)) {
> -                                       pr_debug("%s not found\n", $1);
> +       | ID                    {
> +                                       struct expr_parse_data *data;
> +
> +                                       if (expr__get_id(ctx, $1, &data) || !data) {
> +                                               pr_debug("%s not found\n", $1);
> +                                               free($1);
> +                                               YYABORT;
> +                                       }
> +                                       $$ = data->val;
>                                         free($1);
> -                                       YYABORT;
> -                                 }
> -                                 free($1);
>                                 }
>         | expr '|' expr         { $$ = (long)$1 | (long)$3; }
>         | expr '&' expr         { $$ = (long)$1 & (long)$3; }
> --
> 2.25.4
>
