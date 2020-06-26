Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9705EC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 20:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E4B4206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 20:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LGmQE5hi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725864AbgFZUzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 16:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbgFZUzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 16:55:50 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B427C03E979
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 13:55:50 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id o11so10702930wrv.9
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 13:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uAlllSD0H23jj94tfkcSrouzVa4Y67ZwB5wkJp7uohc=;
        b=LGmQE5hiXPBHZpB865RQ94Z/M0gae2D2z+IMKyfxZ9Sip8SC/SvEAAkBcC904QUsGV
         Q0clkDZQXkeaSgrO1XdXEkKb9QGAF4C8FjWSSpUigcia1X6mSBwYh+WjSZ3RBKVDMtxl
         lu8ucIvg5SebeG/+Xtrv4eNBreov22kHTdtElcrRjuAzn1IYsUzrtSYRUr4ZqB2PgVaU
         HzYsWROlMldcFx8oUcWsGPrUmpb5jAyCalWh/KsdfjuH9swK5Uqu2SkKUyGxruy13GLA
         QstXQ+6638aueWa5RGfBEt6Y4iNOLkY2y7r8MzE0Plu8UFdzeXBAHahEhB8bQYSDLHZR
         ki8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uAlllSD0H23jj94tfkcSrouzVa4Y67ZwB5wkJp7uohc=;
        b=U46njz5kjOBwZ2TF/gSGb6ItWB+3+WVmajvTqfQBL5fjOSLThy8NEiWY4RrdID7aHo
         W1IwTFK8Iu+F9d9ism7J/DQJvGtYJOu+uOtHiTRBgE1VXcPBkiihFcbBHybbpURUjtdb
         5DdbjxXyDwSZW0/iO1q/th0e5p8wfGYdALUlgCXJVvFXnHgfFl3JFeBJDUUFVox4PuTA
         JUcDx/LwfNVVIL9j6QDokPkhlKaU5VOBo34DkoimcPwDHnNqF1pAySjrk2/lNXH6wgAR
         VgWW1XZiCeiP/VTOCJ2BLO02mJpFqKxKBhrbG9tlNerlSN4xzkDMk8QAzuEGxyJJOsRc
         JJ6A==
X-Gm-Message-State: AOAM53153Cgu1TAQfPD84lPCKqIitpXVqG4OEs2+3Zx5eQq9dmhzIDGc
        Vks9sNV147c0LeTiLu8X9DBd2vR1PHF76gryCWsrrQ==
X-Google-Smtp-Source: ABdhPJy3aiZ1QgphJcN7AJpcF7aHVdpLfGGOz9/aK55uclLXWG6NpfQjhv7QFz9ZRI3xjvkWpL8q6H7J7OjEVQHg4os=
X-Received: by 2002:a5d:4bd2:: with SMTP id l18mr5413592wrt.119.1593204949089;
 Fri, 26 Jun 2020 13:55:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200626194720.2915044-1-jolsa@kernel.org> <20200626194720.2915044-6-jolsa@kernel.org>
In-Reply-To: <20200626194720.2915044-6-jolsa@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 26 Jun 2020 13:55:37 -0700
Message-ID: <CAP-5=fWKPRYJ3D264=qKVyRs15n-tNPqPfqv_dL2q15KGzTeaw@mail.gmail.com>
Subject: Re: [PATCH 05/10] perf tools: Add expr__del_id function
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
> Adding expr__del_id function to remove ID from hashmap.
> It will save us few lines in following changes.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/expr.c | 21 +++++++++++++--------
>  tools/perf/util/expr.h |  1 +
>  2 files changed, 14 insertions(+), 8 deletions(-)
>
> diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
> index 29cdef18849c..aa14c7111ecc 100644
> --- a/tools/perf/util/expr.c
> +++ b/tools/perf/util/expr.c
> @@ -75,6 +75,17 @@ int expr__get_id(struct expr_parse_ctx *ctx, const char *id,
>         return hashmap__find(&ctx->ids, id, (void **)data) ? 0 : -1;
>  }
>
> +void expr__del_id(struct expr_parse_ctx *ctx, const char *id)
> +{
> +       struct expr_parse_data *old_val = NULL;
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
> -       struct expr_parse_data *old_val = NULL;
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

Nit, I always have to read the code to know why we have "one" as an
argument. Could we remove it as an argument and have the caller use
expr__del_id?

Thanks,
Ian

>         return ret;
>  }
> diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
> index 0af5b887b6c7..1a76b002c576 100644
> --- a/tools/perf/util/expr.h
> +++ b/tools/perf/util/expr.h
> @@ -26,6 +26,7 @@ struct expr_scanner_ctx {
>
>  void expr__ctx_init(struct expr_parse_ctx *ctx);
>  void expr__ctx_clear(struct expr_parse_ctx *ctx);
> +void expr__del_id(struct expr_parse_ctx *ctx, const char *id);
>  int expr__add_id(struct expr_parse_ctx *ctx, const char *name);
>  int expr__add_val(struct expr_parse_ctx *ctx, const char *id, double val);
>  int expr__get_id(struct expr_parse_ctx *ctx, const char *id,
> --
> 2.25.4
>
