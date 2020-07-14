Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA25C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 21:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4691620663
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 21:07:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rywsZE8M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbgGNVHW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 17:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728075AbgGNVHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 17:07:21 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFE8C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 14:07:21 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z2so237256wrp.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 14:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sYFj9/i+aUbs/mCeLmpyFo7UqQJ2JsN4UUIr9kbw2Aw=;
        b=rywsZE8M6HmZZx8BUzKG7f8USqXKuzqtTTBdSOVOq9PfcUDN4TQq2S0zYrbDxaE2WM
         cwXoTaSLY5gXyxk+BI5wUN9vOzFmDzQimnepQueuv/xy1D600yK++bFQImfF/vczUkja
         fX37ngssdzPaI0bcqxt3fOqacIfOSxPuwcru0NaiKFG4zHV5Mp7SZwBk+RQh1AXtANwF
         TI2PM4Vz0GwyIpsCQJzXFvFmv3iPLdZ6B3sOP/TppkcJECYam1VfhrjC+DZJh07ipkb2
         i/DNjl5KYdKSKlxw7HCuDo0tvKNZCmmIpc25QcO32wA9IOuzrg+GqYc33ihRaFKgU204
         s3bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sYFj9/i+aUbs/mCeLmpyFo7UqQJ2JsN4UUIr9kbw2Aw=;
        b=mAZVIK59ChHwlNU8UNS6BImMPl+vvxvZpFxcJpqSQkqHsiJNh31pJsTnSgLtIJg2V3
         /aq+Q04XkdM2STl6VYCttWQGBkmTgBPsfWyp3PAaohpakUinLDCHsmr+dh7q5KeE3XZf
         EwEgvoQYSv2hEBvN0KZYhWlCK9dm9L7rPSEm3UAwczqBETi/LSQZgEe8ANTF2aD7OUVC
         oMqwdoq8m0a016baJVWJGCKtpmZBR2/9wcaSPxVKyEcSfCx32Hlwyk7Qk7Isb7ldGWct
         OQ3Cbds8KSaXYxKVvrVgyOI5o40sigyRqCM42wOrBu9392iLPLIDH1+KxSH1OzX8lUnw
         Mrsg==
X-Gm-Message-State: AOAM531eJuitMx3RP2kjsHDYqKen0qeE7y4ghUBWu7mlAxnVNHb3pGdQ
        s9vlfnOyPiCVsumYQ5pY15TqLJ88Pkdwcn/kvYf+IVU9ufdONw==
X-Google-Smtp-Source: ABdhPJwDzDaDsQB8APRfzYyupV70rs9H0ijoNO2+CqK9d2rIzlBSj+qumRJ5mY+ZOVzgmHf1j5i2B5Q2UWNdUhzHSqk=
X-Received: by 2002:adf:82e1:: with SMTP id 88mr7596337wrc.376.1594760839869;
 Tue, 14 Jul 2020 14:07:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200712132634.138901-1-jolsa@kernel.org> <20200712132634.138901-6-jolsa@kernel.org>
In-Reply-To: <20200712132634.138901-6-jolsa@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 14 Jul 2020 14:07:08 -0700
Message-ID: <CAP-5=fX4pjM70pdaUJPqv1x_YWyk2Ua44Q7qVCz-jbtOcwBNAw@mail.gmail.com>
Subject: Re: [PATCH 05/18] perf metric: Add expr__del_id function
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

On Sun, Jul 12, 2020 at 6:27 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding expr__del_id function to remove ID from hashmap.
> It will save us few lines in following changes.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/expr.c | 21 +++++++++++++--------
>  tools/perf/util/expr.h |  1 +
>  2 files changed, 14 insertions(+), 8 deletions(-)
>
> diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
> index 7d02d29286bc..91142d4c3419 100644
> --- a/tools/perf/util/expr.c
> +++ b/tools/perf/util/expr.c
> @@ -75,6 +75,17 @@ int expr__get_id(struct expr_parse_ctx *ctx, const char *id,
>         return hashmap__find(&ctx->ids, id, (void **)data) ? 0 : -1;
>  }
>
> +void expr__del_id(struct expr_parse_ctx *ctx, const char *id)
> +{
> +       struct expr_id_data *old_val = NULL;
> +       char *old_key = NULL;
> +
> +       hashmap__delete(&ctx->ids, id,
> +                       (const void **)&old_key, (void **)&old_val);
> +       free(old_key);
> +       free(old_val);
> +}
> +
>  void expr__ctx_init(struct expr_parse_ctx *ctx)
>  {
>         hashmap__init(&ctx->ids, key_hash, key_equal, NULL);
> @@ -132,16 +143,10 @@ int expr__parse(double *final_val, struct expr_parse_ctx *ctx,
>  int expr__find_other(const char *expr, const char *one,
>                      struct expr_parse_ctx *ctx, int runtime)
>  {
> -       struct expr_id_data *old_val = NULL;
> -       char *old_key = NULL;
>         int ret = __expr__parse(NULL, ctx, expr, EXPR_OTHER, runtime);
>
> -       if (one) {
> -               hashmap__delete(&ctx->ids, one,
> -                               (const void **)&old_key, (void **)&old_val);
> -               free(old_key);
> -               free(old_val);
> -       }
> +       if (one)
> +               expr__del_id(ctx, one);
>
>         return ret;
>  }
> diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
> index f38292fdab19..2462abd0ac65 100644
> --- a/tools/perf/util/expr.h
> +++ b/tools/perf/util/expr.h
> @@ -26,6 +26,7 @@ struct expr_scanner_ctx {
>
>  void expr__ctx_init(struct expr_parse_ctx *ctx);
>  void expr__ctx_clear(struct expr_parse_ctx *ctx);
> +void expr__del_id(struct expr_parse_ctx *ctx, const char *id);
>  int expr__add_id(struct expr_parse_ctx *ctx, const char *id);
>  int expr__add_id_val(struct expr_parse_ctx *ctx, const char *id, double val);
>  int expr__get_id(struct expr_parse_ctx *ctx, const char *id,
> --
> 2.25.4
>
