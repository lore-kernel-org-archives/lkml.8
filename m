Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3009C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 04:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98C92206CA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 04:02:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vDys8US/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726235AbgIDECz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 00:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgIDECw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 00:02:52 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F8CC061244
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 21:02:51 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id c15so5250647wrs.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 21:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qrKhsKZhf2Txjf5fFAkdlxZHe5upNmPoJGkajD1n6uQ=;
        b=vDys8US/kb836L98L+SGl0paujGIeqHxjpES46FIxyWzcbANIAnIv/sSNQSv8xp5z0
         LXUCF4ouFpBI5rUeJSaG5uPBOEsMl0AcfbdIldgILq1xbC42ZTZVLcwK267w+fDcaFc9
         iux+aw/qRVn+xfh0XZbTVs3JUFPumg3D4zMhBU/gDJQRRQBY2uvp4pFXtiSfBcELHAP6
         Ycmkg8hMiP5VXZV1kpmQQP0vtOAKpakb1PGnvVaAU+LGI0OgFtV13h1ar045YecehJyV
         eVDWL++bVEDaie23HmBE+yUsRm5z4GiiC9f5TsDgUaae3aB94EJmAm5kfv40E4cscgeJ
         IPpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qrKhsKZhf2Txjf5fFAkdlxZHe5upNmPoJGkajD1n6uQ=;
        b=bl+2oCY4p9dgzD06Ov3mQO9/yLhyg52dFXlUz25mc+zq2US29TFv+redOcqnpHBRvi
         omZG3Ne8vo1E0uuCEWPIL/9fDf1f9aanJHfjfXYy6bfyQESns72lEM3tagYCroJpyKpw
         aRyd6QRZeDc9fvkvUBk0urd9kZ6PIo1BnOg09b/nexLQnkKVkbv+B2sy0nNg5iU4gB3u
         gJZIwblVlqFfjKEB8eFlO9jc/9zVTeZvedHyldXB0zv1/dAb5yXJI93g7isSId/WnEFU
         Okx5nh51+yFcV/DWfUEYtNs7PI5nCWvTnml5TLa/y/MRffW6ck/zeAhyBwpvmmP5mOdU
         U2DA==
X-Gm-Message-State: AOAM531LoUBameU5tB5D91ZTj82B3LzU3tstURo/Orn5sfbRwy9nvkVF
        utA/HEOrLGJr8xMnx2HIzj35jG8TJFUjDN71dVhxyA==
X-Google-Smtp-Source: ABdhPJzrSjp5nE3pYC8OJrgRdr6bDs/8tsP6B2Tt3adLb5Edfk+Ewixgz+muHwuwH/Zt98d1IsuTcwRKPIAdjl2qOrU=
X-Received: by 2002:a5d:458a:: with SMTP id p10mr5369981wrq.282.1599192169835;
 Thu, 03 Sep 2020 21:02:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200904032142.516333-1-namhyung@kernel.org>
In-Reply-To: <20200904032142.516333-1-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 3 Sep 2020 21:02:38 -0700
Message-ID: <CAP-5=fXjeCBemNivMb6+9AH-PETTqTghaZHniOohd_1ms1rU2A@mail.gmail.com>
Subject: Re: [PATCH] perf metric: Fix some memory leaks
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <andi@firstfloor.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 3, 2020 at 8:21 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> I found some memory leaks while reading the metric code.  Some are
> real and others only occur in the error path.

Thanks Namhyung! Is it possible to get test coverage?
Ian

> Cc: Kajol Jain <kjain@linux.ibm.com>
> Cc: John Garry <john.garry@huawei.com>
> Cc: Ian Rogers <irogers@google.com>
> Fixes: 9afe5658a6fa8 ("perf tools: Release metric_events rblist")
> Fixes: 4ea2896715e67 ("perf metric: Collect referenced metrics in struct metric_expr")
> Fixes: 71b0acce78d12 ("perf list: Add metric groups to perf list")
> Fixes: b18f3e365019d ("perf stat: Support JSON metrics in perf stat")
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
> I'm not sure it'd better have them together or split each fix as
> they came from different commits.  Please let me know if you prefer
> split.
>
>  tools/perf/util/metricgroup.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 8831b964288f..7e31c4578ce8 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -85,6 +85,7 @@ static void metric_event_delete(struct rblist *rblist __maybe_unused,
>
>         list_for_each_entry_safe(expr, tmp, &me->head, nd) {
>                 free(expr->metric_refs);
> +               free(expr->metric_events);
>                 free(expr);
>         }
>
> @@ -316,6 +317,7 @@ static int metricgroup__setup_events(struct list_head *groups,
>                         if (!metric_refs) {
>                                 ret = -ENOMEM;
>                                 free(metric_events);
> +                               free(expr);
>                                 break;
>                         }
>
> @@ -530,6 +532,9 @@ void metricgroup__print(bool metrics, bool metricgroups, char *filter,
>                                                 continue;
>                                         strlist__add(me->metrics, s);
>                                 }
> +
> +                               if (!raw)
> +                                       free(s);
>                         }
>                         free(omg);
>                 }
> @@ -1048,11 +1053,11 @@ static int parse_groups(struct evlist *perf_evlist, const char *str,
>                 parse_events_print_error(&parse_error, extra_events.buf);
>                 goto out;
>         }
> -       strbuf_release(&extra_events);
>         ret = metricgroup__setup_events(&metric_list, metric_no_merge,
>                                         perf_evlist, metric_events);
>  out:
>         metricgroup__free_metrics(&metric_list);
> +       strbuf_release(&extra_events);
>         return ret;
>  }
>
> --
> 2.28.0.526.ge36021eeef-goog
>
