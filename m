Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 889B8C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 07:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 549F320734
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 07:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HEoK9zFx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbgFAHo1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 03:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgFAHo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 03:44:27 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F69C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 00:44:27 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id g3so2845170ilq.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 00:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CtBfdUmSpMfChZ+04fO1/PnCkCR9cy8vE+I/1XbSCTI=;
        b=HEoK9zFxIOpFBiyMJPU9gnaonVBO3sErxoajwL23Iw1/e3IOy2X1ea4AdqdcUFHojM
         iLiBKknrK/CyRtptF5ko1Wh8Mp24vu2zIBCGrouE3ECfyg6r9YKYdMEt44W5gj3lHTeQ
         bxlJgDtVl4vJBhkz3vyHlTnvY0BaLWmuGAuiVcvQx8lyn6XT/axzthj4rEAhN+ta/OX0
         H9bo7+1TRq/sRt1xExFP3+lcyUMBpYuwwe9q8Qiwj0nKb2MZkWQPCXBkt/5aXkriKVtN
         57KP07cQ8kWACdJweSrOq8Iw+EfAWYn5wqe3QjpZqUs7WNRaOQ3ek6PzuMqk2DCvdPvq
         H5AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CtBfdUmSpMfChZ+04fO1/PnCkCR9cy8vE+I/1XbSCTI=;
        b=OVMnPRwWG1H8BLXBAQBmcef42b9MuJ0cCBCkJRDjI3SXStNqwZPsBscxgwhtzznIuu
         U+Nto036Cgjvw6HYdXq3vOzVV3RuDujCM48F/IKeVfXkNowf91v0bNxVi+0WBnrvWBZ/
         HzKqI7dC/3enDNcEQu6lvkgAYdN+FvleQ+idjIlq9MDibbFe97famKrq0M9vF5AAOWMV
         sZsCRX3XD7QB7uy+HAcsbcdKFbIgIKqoHnfJWAX72JPguKM3E1htDMKxJtVE+V/aqczo
         rUgku5GdgR1+ll7pMpRnkJEQOMk0h+hvKNNi7CnrepSx19FH794AFaEH1lQSK1y0TEYN
         Crdw==
X-Gm-Message-State: AOAM533BKOUvKNpqFO31NopoV3D3S7a+CDO20ADxC3yYtLYdioFT6v4k
        3CNuHRxZ8prhqHeqyrnEDzZBOZkH7CVvXZvqa38PVA==
X-Google-Smtp-Source: ABdhPJwK5Yh7EapWjnya1WqulswWiiXrBvvQM5+WKDIPWc0WxU9UQqqAiksmg8dDaJJr//BGLQrMQujFx1XidxQlKYs=
X-Received: by 2002:a92:de41:: with SMTP id e1mr10893648ilr.199.1590997466208;
 Mon, 01 Jun 2020 00:44:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200524224219.234847-1-jolsa@kernel.org> <20200524224219.234847-7-jolsa@kernel.org>
In-Reply-To: <20200524224219.234847-7-jolsa@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 1 Jun 2020 00:44:15 -0700
Message-ID: <CAP-5=fV5tKwyMCpwt2VFkSFwCCk6qJ3S2_ajNy2P6ZWVxvbC-w@mail.gmail.com>
Subject: Re: [PATCH 06/14] perf tests: Add another pmu-events tests
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 24, 2020 at 3:42 PM Jiri Olsa <jolsa@kernel.org> wrote:
>
> The test goes through all metrics compiled for arch
> within pmu events and try to parse them.
>
> The test also defines its own list of metrics and
> tries to parse them. It's handy for developing.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/tests/pmu-events.c | 120 ++++++++++++++++++++++++++++++++++
>  1 file changed, 120 insertions(+)
>
> diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
> index ab64b4a4e284..f100df025440 100644
> --- a/tools/perf/tests/pmu-events.c
> +++ b/tools/perf/tests/pmu-events.c
> @@ -490,6 +490,122 @@ static int test_parsing(void)
>         return ret == 0 ? TEST_OK : TEST_SKIP;
>  }
>
> +struct test_metric {
> +       const char *str;
> +};
> +
> +static struct test_metric metrics[] = {
> +       { "(unc_p_power_state_occupancy.cores_c0 / unc_p_clockticks) * 100." },
> +       { "imx8_ddr0@read\\-cycles@ * 4 * 4", },
> +       { "imx8_ddr0@axid\\-read\\,axi_mask\\=0xffff\\,axi_id\\=0x0000@ * 4", },
> +       { "(cstate_pkg@c2\\-residency@ / msr@tsc@) * 100", },
> +       { "(imx8_ddr0@read\\-cycles@ + imx8_ddr0@write\\-cycles@)", },
> +};
> +
> +static int check_id(const char *id)
> +{
> +       struct parse_events_error error;
> +       struct evlist *evlist;
> +       int ret;
> +
> +       /* Numbers are always valid. */
> +       if (is_number(id))
> +               return 0;
> +
> +       evlist = evlist__new();
> +       if (!evlist)
> +               return -1;
> +
> +       memset(&error, 0, sizeof(error));
> +       ret = parse_events_fake(evlist, id, &error);
> +       if (ret) {
> +               pr_debug("str        : %s\n", error.str);
> +               pr_debug("help       : %s\n", error.help);
> +               pr_debug("first_str  : %s\n", error.first_str);
> +               pr_debug("first_help : %s\n", error.first_help);
> +       }
> +
> +       evlist__delete(evlist);
> +       free(error.str);
> +       free(error.help);
> +       free(error.first_str);
> +       free(error.first_help);
> +       return ret;
> +}

This is quite similar to check_parse_id, fold them together?

> +
> +static int metric_parse_fake(const char *str)
> +{
> +       struct expr_parse_ctx ctx;
> +       struct hashmap_entry *cur;
> +       double result;
> +       int ret = -1;
> +       size_t bkt;
> +       int i;
> +
> +       pr_debug("parsing '%s'\n", str);
> +
> +       expr__ctx_init(&ctx);
> +       if (expr__find_other(str, NULL, &ctx, 0) < 0) {
> +               pr_err("expr__find_other failed\n");
> +               return -1;
> +       }
> +
> +       i = 1;
> +       hashmap__for_each_entry((&ctx.ids), cur, bkt)
> +               expr__add_id(&ctx, strdup(cur->key), i++);

It might make sense to share the code here with that in test_parsing.
This initialization of ids is commented there and it is a bit special.

Thanks,
Ian

> +
> +       hashmap__for_each_entry((&ctx.ids), cur, bkt) {
> +               if (check_id(cur->key)) {
> +                       pr_err("check_id failed\n");
> +                       goto out;
> +               }
> +       }
> +
> +       if (!expr__parse(&result, &ctx, str, 1))
> +               ret = 0;
> +       else
> +               pr_err("expr__parse failed\n");
> +
> +out:
> +       expr__ctx_clear(&ctx);
> +       return ret;
> +
> +}
> +
> +static int test_parsing_fake(void)
> +{
> +       struct pmu_events_map *map;
> +       struct pmu_event *pe;
> +       unsigned int i, j;
> +       int err = 0;
> +
> +       for (i = 0; !err && i < ARRAY_SIZE(metrics); i++)
> +               err = metric_parse_fake(metrics[i].str);
> +
> +       if (err)
> +               return err;
> +
> +       i = 0;
> +       for (;;) {
> +               map = &pmu_events_map[i++];
> +               if (!map->table)
> +                       break;
> +               j = 0;
> +               for (;;) {
> +                       pe = &map->table[j++];
> +                       if (!pe->name && !pe->metric_group && !pe->metric_name)
> +                               break;
> +                       if (!pe->metric_expr)
> +                               continue;
> +                       err = metric_parse_fake(pe->metric_expr);
> +                       if (err)
> +                               return err;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
>  static const struct {
>         int (*func)(void);
>         const char *desc;
> @@ -506,6 +622,10 @@ static const struct {
>                 .func = test_parsing,
>                 .desc = "Parsing of PMU event table metrics",
>         },
> +       {
> +               .func = test_parsing_fake,
> +               .desc = "Parsing of PMU event table metrics with fake PMUs",
> +       },
>  };
>
>  const char *test__pmu_events_subtest_get_desc(int subtest)
> --
> 2.25.4
>
