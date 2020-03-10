Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A4CC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 18:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 807E921927
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 18:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJcjnsoR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgCJSEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 14:04:30 -0400
Received: from mail-qv1-f66.google.com ([209.85.219.66]:32854 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgCJSEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 14:04:30 -0400
Received: by mail-qv1-f66.google.com with SMTP id cz10so3114945qvb.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 11:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Jrx7ubFINctPX04p6Hf8KyJKt25rJORd6jzd4KzVUBU=;
        b=QJcjnsoR/ICUsOvsk9dQb33SdBP+Nx3DJbB+PJFiGW5YeW6eQemNP1mPoec5JheE6B
         PjrRD5f7RjJ2bG8VXa79EwpfzFMyiqesvlrAEjReFR3Luy7wBzeI5ZwdDQG97Awvfyga
         Le45/UsBRrSWrKpekob3XB9GHWIRIqlEUhXI8nuI1iXxCY9TxHsJpgv+dLo7wNfnTxWH
         kS9PBkZsjdRXutsubq7n4PHWEQDx+9NH2TP/eOmQ0apCp0vehWSPsCDAC7HZ864U357q
         45HCZwUGTi7yV1yAH8IzDyynI5mDtA4SnODRDEMtdyfZJxInuT4gk6GZ+E4HgtGK4N1t
         Z3Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Jrx7ubFINctPX04p6Hf8KyJKt25rJORd6jzd4KzVUBU=;
        b=TbQlOLITjZ5Unnph7yNxMoC8o+Vo7ORVoQ+KaI8qC9AVzy+ht24ephBF8Fo1NxQQfI
         VixB3RI1Y3k17aC6oz2GjG2YuT3acazmdTf2RgZpAMyQppUVUPtOcKVRxop6ZaIJ4u3p
         Fy9pZJKbz7CIFhXcabmeLEPkIT3RSC68InwRkOZdQWc3TfROfQpPDzl8iAfYfYQOmbXi
         p1W1FUDDPhYF+n+wjsiBkTFlYuktHTcDI5rjbjQOOnMS2LaglKN6kMcpEjNhkRP/3JKA
         g8AQbgSpRV46QHCEMmDoLqKt5Of8gq5OMcfJfKtC07GnGs/EruFfv/gOGggGgmhYvSKv
         aQyQ==
X-Gm-Message-State: ANhLgQ3tSv6KkhPE0gmvJvViu7+43hEfSd/CogR80wRrDbZhN0rkvQHB
        GgQEWBYahtxLW8Wz7LkH8vYmE0d0HWg=
X-Google-Smtp-Source: ADFU+vtqyMZH7+Mmz//SVO+EiV7Ri8P7wdBYUGHREoEbLP2wvHALJni1hoQWBEI2OE/qaoZtd0tJDQ==
X-Received: by 2002:ad4:4e26:: with SMTP id dm6mr19330987qvb.229.1583863468511;
        Tue, 10 Mar 2020 11:04:28 -0700 (PDT)
Received: from quaco.ghostprotocols.net (179-240-149-111.3g.claro.net.br. [179.240.149.111])
        by smtp.gmail.com with ESMTPSA id g3sm8980446qke.89.2020.03.10.11.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 11:04:27 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D7CC740009; Tue, 10 Mar 2020 15:04:23 -0300 (-03)
Date:   Tue, 10 Mar 2020 15:04:23 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     kan.liang@linux.intel.com, mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        namhyung@kernel.org, ravi.bangoria@linux.ibm.com,
        yao.jin@linux.intel.com, ak@linux.intel.com
Subject: Re: [PATCH V2 0/5] Support metric group constraint
Message-ID: <20200310180423.GL15931@kernel.org>
References: <1582581564-184429-1-git-send-email-kan.liang@linux.intel.com>
 <20200226153549.GD217283@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226153549.GD217283@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Feb 26, 2020 at 04:35:49PM +0100, Jiri Olsa escreveu:
> On Mon, Feb 24, 2020 at 01:59:19PM -0800, kan.liang@linux.intel.com wrote:
> > From: Kan Liang <kan.liang@linux.intel.com>
> > 
> > Changes since V1:
> > - Remove global static flag violate_nmi_constraint, and add a new
> >   function metricgroup___watchdog_constraint_hint() for all
> >   watchdog constraint hints in patch 4.
> >   The rest of the patches are not changed.
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks, tested, applied,

- Arnaldo
 
> thanks,
> jirka
> 
> > 
> > Some metric groups, e.g. Page_Walks_Utilization, will never count when
> > NMI watchdog is enabled.
> > 
> >  $echo 1 > /proc/sys/kernel/nmi_watchdog
> >  $perf stat -M Page_Walks_Utilization
> > 
> >  Performance counter stats for 'system wide':
> > 
> >  <not counted>      itlb_misses.walk_pending       (0.00%)
> >  <not counted>      dtlb_load_misses.walk_pending  (0.00%)
> >  <not counted>      dtlb_store_misses.walk_pending (0.00%)
> >  <not counted>      ept.walk_pending               (0.00%)
> >  <not counted>      cycles                         (0.00%)
> > 
> >        2.343460588 seconds time elapsed
> > 
> >  Some events weren't counted. Try disabling the NMI watchdog:
> >         echo 0 > /proc/sys/kernel/nmi_watchdog
> >         perf stat ...
> >         echo 1 > /proc/sys/kernel/nmi_watchdog
> >  The events in group usually have to be from the same PMU. Try
> >  reorganizing the group.
> > 
> > A metric group is a weak group, which relies on group validation
> > code in the kernel to determine whether to be opened as a group or
> > a non-group. However, group validation code may return false-positives,
> > especially when NMI watchdog is enabled. (The metric group is allowed
> > as a group but will never be scheduled.)
> > 
> > The attempt to fix the group validation code has been rejected.
> > https://lore.kernel.org/lkml/20200117091341.GX2827@hirez.programming.kicks-ass.net/
> > Because we cannot accurately predict whether the group can be scheduled
> > as a group, only by checking current status.
> > 
> > This patch set provides another solution to mitigate the issue.
> > Add "MetricConstraint" in event list, which provides a hint for perf tool,
> > e.g. "MetricConstraint": "NO_NMI_WATCHDOG". Perf tool can change the
> > metric group to non-group (standalone metrics) if NMI watchdog is enabled.
> > 
> > After applying the patch,
> > 
> >  $echo 1 > /proc/sys/kernel/nmi_watchdog
> >  $perf stat -M Page_Walks_Utilization
> >   Splitting metric group Page_Walks_Utilization into standalone metrics.
> >   Try disabling the NMI watchdog to comply NO_NMI_WATCHDOG metric constraint:
> >         echo 0 > /proc/sys/kernel/nmi_watchdog
> >         perf stat ...
> >         echo 1 > /proc/sys/kernel/nmi_watchdog
> > 
> >  Performance counter stats for 'system wide':
> > 
> >         18,253,454      itlb_misses.walk_pending  #      0.0
> >                               Page_Walks_Utilization   (50.55%)
> >         78,051,525      dtlb_load_misses.walk_pending  (50.55%)
> >         29,213,063      dtlb_store_misses.walk_pending (50.55%)
> >                  0      ept.walk_pending               (50.55%)
> >      2,542,132,364      cycles                         (49.92%)
> > 
> >        1.037095993 seconds time elapsed
> > 
> > Kan Liang (5):
> >   perf jevents: Support metric constraint
> >   perf metricgroup: Factor out metricgroup__add_metric_weak_group()
> >   perf util: Factor out sysctl__nmi_watchdog_enabled()
> >   perf metricgroup: Support metric constraint
> >   perf vendor events: Add NO_NMI_WATCHDOG metric constraint
> > 
> >  .../arch/x86/cascadelakex/clx-metrics.json         |   3 +-
> >  .../pmu-events/arch/x86/skylake/skl-metrics.json   |   3 +-
> >  .../pmu-events/arch/x86/skylakex/skx-metrics.json  |   3 +-
> >  tools/perf/pmu-events/jevents.c                    |  19 ++--
> >  tools/perf/pmu-events/jevents.h                    |   2 +-
> >  tools/perf/pmu-events/pmu-events.h                 |   1 +
> >  tools/perf/util/metricgroup.c                      | 109 ++++++++++++++++-----
> >  tools/perf/util/stat-display.c                     |   6 +-
> >  tools/perf/util/util.c                             |  18 ++++
> >  tools/perf/util/util.h                             |   2 +
> >  10 files changed, 128 insertions(+), 38 deletions(-)
> > 
> > -- 
> > 2.7.4
> > 
> 

-- 

- Arnaldo
