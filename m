Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B07C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 20:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65B0D206C3
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 20:07:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XuzDc5/F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbgFZUHh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 16:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbgFZUHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 16:07:37 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B595C03E979
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 13:07:37 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id o11so10601230wrv.9
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 13:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g0y1yBCUar1RcebjU46sNh4usOJdB5GLaAUIgcV2ggI=;
        b=XuzDc5/FQBS6MzrKTnE+8TXtblP/VKGGTWDP0da2I7mlvPq3wkHUMscELHo4zjRodF
         INDn0AXf18ttd3kK1yZqX0X1XFLof1FRp/7M86k+XNbVNjBJTiMbYoPhy0G5WyKJdbAh
         s2Y2h/ORQjSpEPAPMZ191e+qDzj1kPwsydqSUgd+7SxyT9BS1WdfR9uSqzgrkqCrn8od
         aHrDdoAhd3eHJMiQcjvfws0iS7Zvo9D1F2PnqnsfPAMbUo7G7LdpCkKQRSTkMABEs6XE
         fM3Hpbh206m/+QjPqdgrJM8rLwZwm3Tu6UP/Fhda5fJtX4TCSSJ7tB+2QwBpXoKNS8ri
         mvfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g0y1yBCUar1RcebjU46sNh4usOJdB5GLaAUIgcV2ggI=;
        b=YsKgIBNxAJpihGIDHtc6fkcJ4FxbcYVr+xPWGW6plaLDsrWJYywMbdvzXen0wCoio9
         Hd3/My4dZJc2I5XIYFyFYKmXMrKoRAatwTBhvKymtG3jeA+Krd7Z0pYp3F9B9Lzkwd3I
         4pq2sQ7/ukB1dpv6kTaYPC5iJwHma40DhYiaRmg8ANmegfX6SI9pjS1jWpBaDJAGHXTH
         mLnHPykHSoRKkVY1O01ukf7lAY/VVSXRjWLkpE2E333ydXOcIpLvzuiejABJsZVwumc6
         1e2oow1kPAi3LkXjn384EWvMRTRG4kMEkW+GxfLE/eJY4re0y4fdKRurSrguotYBB4sp
         BB3Q==
X-Gm-Message-State: AOAM533UcfyrYxKVdi6rgSO4O5YO712cx/GBwJE5gll8JpJ7wN0hdfVt
        nUSpc8LFm7b+0uj4bd/JiQypth61YdyN3iCFl4hOUg==
X-Google-Smtp-Source: ABdhPJz7l2WsWMqLVyok7yN+jNgtktiSdjau6yVf7k1wSYIx1DHVmoRdYKS+7jhpq7PX5XDMCW7ilJgM/zRa4qJnMs0=
X-Received: by 2002:a5d:4bd2:: with SMTP id l18mr5257109wrt.119.1593202055747;
 Fri, 26 Jun 2020 13:07:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200626194720.2915044-1-jolsa@kernel.org> <20200626194720.2915044-4-jolsa@kernel.org>
In-Reply-To: <20200626194720.2915044-4-jolsa@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 26 Jun 2020 13:07:24 -0700
Message-ID: <CAP-5=fXHKWeFCpG3mWchj5Oa+WPnsQBbt00K5MHdJ+u3U=extg@mail.gmail.com>
Subject: Re: [PATCH 03/10] perf tools: Add expr__add_id function
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
> Adding expr__add_id function to data for ID
> with zero value, which is used when scanning
> the expression for IDs.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/expr.c | 29 +++++++++++++++++++++++------
>  tools/perf/util/expr.h |  1 +
>  tools/perf/util/expr.y |  2 +-
>  3 files changed, 25 insertions(+), 7 deletions(-)
>
> diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
> index 7573b21e73df..0b6d3a6ce88e 100644
> --- a/tools/perf/util/expr.c
> +++ b/tools/perf/util/expr.c
> @@ -32,6 +32,24 @@ static bool key_equal(const void *key1, const void *key2,
>         return !strcmp((const char *)key1, (const char *)key2);
>  }
>
> +/* Caller must make sure id is allocated */
> +int expr__add_id(struct expr_parse_ctx *ctx, const char *name)

Nit, perhaps "id" is more consistent than "name". Perhaps also change
add_val below.

Acked-by: Ian Rogers <irogers@google.com>

> +{
> +       struct expr_parse_data *data_ptr = NULL, *old_data = NULL;
> +       char *old_key = NULL;
> +       int ret;
> +
> +       data_ptr = malloc(sizeof(*data_ptr));
> +       if (!data_ptr)
> +               return -ENOMEM;
> +
> +       ret = hashmap__set(&ctx->ids, name, data_ptr,
> +                          (const void **)&old_key, (void **)&old_data);
> +       free(old_key);
> +       free(old_data);
> +       return ret;
> +}
> +
>  /* Caller must make sure id is allocated */
>  int expr__add_val(struct expr_parse_ctx *ctx, const char *name, double val)
>  {
> @@ -39,12 +57,11 @@ int expr__add_val(struct expr_parse_ctx *ctx, const char *name, double val)
>         char *old_key = NULL;
>         int ret;
>
> -       if (val != 0.0) {
> -               data_ptr = malloc(sizeof(*data_ptr));
> -               if (!data_ptr)
> -                       return -ENOMEM;
> -               data_ptr->val = val;
> -       }
> +       data_ptr = malloc(sizeof(*data_ptr));
> +       if (!data_ptr)
> +               return -ENOMEM;
> +       data_ptr->val = val;
> +
>         ret = hashmap__set(&ctx->ids, name, data_ptr,
>                            (const void **)&old_key, (void **)&old_data);
>         free(old_key);
> diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
> index f9f16efe76bc..5452e641acf4 100644
> --- a/tools/perf/util/expr.h
> +++ b/tools/perf/util/expr.h
> @@ -26,6 +26,7 @@ struct expr_scanner_ctx {
>
>  void expr__ctx_init(struct expr_parse_ctx *ctx);
>  void expr__ctx_clear(struct expr_parse_ctx *ctx);
> +int expr__add_id(struct expr_parse_ctx *ctx, const char *name);
>  int expr__add_val(struct expr_parse_ctx *ctx, const char *id, double val);
>  int expr__get_id(struct expr_parse_ctx *ctx, const char *id, double *val_ptr);
>  int expr__parse(double *final_val, struct expr_parse_ctx *ctx,
> diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
> index ff5e5f6e170d..ac4b119877e0 100644
> --- a/tools/perf/util/expr.y
> +++ b/tools/perf/util/expr.y
> @@ -71,7 +71,7 @@ all_other: all_other other
>
>  other: ID
>  {
> -       expr__add_val(ctx, $1, 0.0);
> +       expr__add_id(ctx, $1);
>  }
>  |
>  MIN | MAX | IF | ELSE | SMT_ON | NUMBER | '|' | '^' | '&' | '-' | '+' | '*' | '/' | '%' | '(' | ')' | ','
> --
> 2.25.4
>
