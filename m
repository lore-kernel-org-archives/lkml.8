Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 461EFC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 14:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 236FD2072C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 14:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I8m8YrPT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgETOun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 10:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbgETOun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 10:50:43 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5216C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 07:50:42 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id m10so1109011ybf.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 07:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ajOsEVzBBmvLmCdJ2Fdc///Cfm2T2Xmx2TMwaA04DAo=;
        b=I8m8YrPTQXsy55nnqHyJdwIhm6QdarEOtspEoGcg9nkXM0Ew5AiYBTRIXjdtZxXD6S
         izOaYJYXE9XhaKVivA15X9QwZB3PnP3Qtl7QtzesZcYYMbCOjlRer0BjLRwvbWrr3bKz
         vk+zY7elcJGaeObSkGHGPxyQecLQW8tuncrc2tGZPsmNSar4qJEW9mJ2sKXaBeXLnFb1
         knwneHaygvC8zuiYEbffnkfuYqr7AB8BPsN2D0fzE8BkWD983alvNMTYO3pCTscKsJsU
         UoCgPcIVR5XrlFoUhmm56VsMLBd29uLTatSh8xwvQO3OY7NoruCYGaLLv2KyCDTa7hrJ
         7ZHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ajOsEVzBBmvLmCdJ2Fdc///Cfm2T2Xmx2TMwaA04DAo=;
        b=M5dxZLRD6Numbk7m9XBMq0Yypz23KPk2NWuBLzDmGQzhtTN5lrjFLY2YbJZCoxdEMk
         1Hcpn93IkWKDTD8nTkEFEcWnw4+59uOjI9msY6RKJeL/ABMliDfRsw/v4CRIHgYQAHLU
         VtKcDSMiTKpSjxO3ZTs9rwnAgIa8Qr+c0/vMTpwaDMGkr5svzGoqz2NnbI4UJU5IXxrj
         Yjh2BAlsoGLBZ/1Qsjdz96OaH2Xo4+q/gtN5JyxDSq/PpunoKiy6NvKuM+cLZM9HrUiO
         yAXO/0SImAj8RPymEQe64Py1pyZw+KPyz7/tvxlxuBLz0ZakNhAdVMbfzOGFDCKalT46
         iubQ==
X-Gm-Message-State: AOAM530FNKfnzVxXUcoSJV3DKEBmrHGfZie27+H8lrccxVOeKoy57XEj
        TSlngNhLvloRPk5zILDfHpkDRaU9/YGc47v+AA8MWw==
X-Google-Smtp-Source: ABdhPJwUG/n0zhdUFbriSJsXmMxGywwDOeEtiLHjve+29uytAAbLo+u0KRAoTbKvizTmfvhGt1A2X7ckmp17h3/0lU0=
X-Received: by 2002:a25:4446:: with SMTP id r67mr7502533yba.41.1589986241692;
 Wed, 20 May 2020 07:50:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200520072814.128267-1-irogers@google.com> <20200520131359.GJ157452@krava>
In-Reply-To: <20200520131359.GJ157452@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 20 May 2020 07:50:30 -0700
Message-ID: <CAP-5=fXZVmjuiGyRsjzjfsBOpN50SeA+Gi66Of_wa61j7f6X5Q@mail.gmail.com>
Subject: Re: [PATCH 0/7] Share events between metrics
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Paul Clarke <pc@us.ibm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 6:14 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Wed, May 20, 2020 at 12:28:07AM -0700, Ian Rogers wrote:
> > Metric groups contain metrics. Metrics create groups of events to
> > ideally be scheduled together. Often metrics refer to the same events,
> > for example, a cache hit and cache miss rate. Using separate event
> > groups means these metrics are multiplexed at different times and the
> > counts don't sum to 100%. More multiplexing also decreases the
> > accuracy of the measurement.
> >
> > This change orders metrics from groups or the command line, so that
> > the ones with the most events are set up first. Later metrics see if
> > groups already provide their events, and reuse them if
> > possible. Unnecessary events and groups are eliminated.
> >
> > The option --metric-no-group is added so that metrics aren't placed in
> > groups. This affects multiplexing and may increase sharing.
> >
> > The option --metric-mo-merge is added and with this option the
> > existing grouping behavior is preserved.
> >
> > Using skylakex metrics I ran the following shell code to count the
> > number of events for each metric group (this ignores metric groups
> > with a single metric, and one of the duplicated TopdownL1 and
> > TopDownL1 groups):
>
> hi,
> I'm getting parser error with:
>
> [jolsa@krava perf]$ sudo ./perf stat -M IPC,CPI -a -I 1000
> event syntax error: '..ed.thread}:W{inst_retired.any,cpu_clk_unhalted.thread}:W,{inst_retired.any,cycles}:W'
>                                   \___ parser error
>
> jirka

Ah, looks like an issue introduced by:
https://lore.kernel.org/lkml/20200520072814.128267-8-irogers@google.com/
as there is a missing comma. I'll investigate after some breakfast.

Thanks,
Ian
