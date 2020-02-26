Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB9AC4BA13
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 15:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA61524687
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 15:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N5qPntD2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbgBZPgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 10:36:04 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42005 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728174AbgBZPgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 10:36:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582731362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vX7Ec2sHhMrhT4BnHbuMJeMNQ59KqT36BEsL1Y44tMI=;
        b=N5qPntD2KrB4L4eGJXFvVk5GLx9+4w5hSYWLhflfgZFc8YKRG5kaG7Rdrxa69kF4fAyQTK
        ZnDSf074zNG37WpxeJp7zFNSKQL2BdB2i5SXIO3Ve2JAVpAqiQ9qCxNyzRED4YCCTOu8NC
        zt5+e3VpU+pbQefw5x5gr5gfLzmypSo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-Fzg95hI4PKqK32W_dgD4mw-1; Wed, 26 Feb 2020 10:35:55 -0500
X-MC-Unique: Fzg95hI4PKqK32W_dgD4mw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 82EA71005513;
        Wed, 26 Feb 2020 15:35:53 +0000 (UTC)
Received: from krava (unknown [10.43.17.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7F1905C54A;
        Wed, 26 Feb 2020 15:35:51 +0000 (UTC)
Date:   Wed, 26 Feb 2020 16:35:49 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        namhyung@kernel.org, ravi.bangoria@linux.ibm.com,
        yao.jin@linux.intel.com, ak@linux.intel.com
Subject: Re: [PATCH V2 0/5] Support metric group constraint
Message-ID: <20200226153549.GD217283@krava>
References: <1582581564-184429-1-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582581564-184429-1-git-send-email-kan.liang@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 01:59:19PM -0800, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> Changes since V1:
> - Remove global static flag violate_nmi_constraint, and add a new
>   function metricgroup___watchdog_constraint_hint() for all
>   watchdog constraint hints in patch 4.
>   The rest of the patches are not changed.

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> 
> Some metric groups, e.g. Page_Walks_Utilization, will never count when
> NMI watchdog is enabled.
> 
>  $echo 1 > /proc/sys/kernel/nmi_watchdog
>  $perf stat -M Page_Walks_Utilization
> 
>  Performance counter stats for 'system wide':
> 
>  <not counted>      itlb_misses.walk_pending       (0.00%)
>  <not counted>      dtlb_load_misses.walk_pending  (0.00%)
>  <not counted>      dtlb_store_misses.walk_pending (0.00%)
>  <not counted>      ept.walk_pending               (0.00%)
>  <not counted>      cycles                         (0.00%)
> 
>        2.343460588 seconds time elapsed
> 
>  Some events weren't counted. Try disabling the NMI watchdog:
>         echo 0 > /proc/sys/kernel/nmi_watchdog
>         perf stat ...
>         echo 1 > /proc/sys/kernel/nmi_watchdog
>  The events in group usually have to be from the same PMU. Try
>  reorganizing the group.
> 
> A metric group is a weak group, which relies on group validation
> code in the kernel to determine whether to be opened as a group or
> a non-group. However, group validation code may return false-positives,
> especially when NMI watchdog is enabled. (The metric group is allowed
> as a group but will never be scheduled.)
> 
> The attempt to fix the group validation code has been rejected.
> https://lore.kernel.org/lkml/20200117091341.GX2827@hirez.programming.kicks-ass.net/
> Because we cannot accurately predict whether the group can be scheduled
> as a group, only by checking current status.
> 
> This patch set provides another solution to mitigate the issue.
> Add "MetricConstraint" in event list, which provides a hint for perf tool,
> e.g. "MetricConstraint": "NO_NMI_WATCHDOG". Perf tool can change the
> metric group to non-group (standalone metrics) if NMI watchdog is enabled.
> 
> After applying the patch,
> 
>  $echo 1 > /proc/sys/kernel/nmi_watchdog
>  $perf stat -M Page_Walks_Utilization
>   Splitting metric group Page_Walks_Utilization into standalone metrics.
>   Try disabling the NMI watchdog to comply NO_NMI_WATCHDOG metric constraint:
>         echo 0 > /proc/sys/kernel/nmi_watchdog
>         perf stat ...
>         echo 1 > /proc/sys/kernel/nmi_watchdog
> 
>  Performance counter stats for 'system wide':
> 
>         18,253,454      itlb_misses.walk_pending  #      0.0
>                               Page_Walks_Utilization   (50.55%)
>         78,051,525      dtlb_load_misses.walk_pending  (50.55%)
>         29,213,063      dtlb_store_misses.walk_pending (50.55%)
>                  0      ept.walk_pending               (50.55%)
>      2,542,132,364      cycles                         (49.92%)
> 
>        1.037095993 seconds time elapsed
> 
> Kan Liang (5):
>   perf jevents: Support metric constraint
>   perf metricgroup: Factor out metricgroup__add_metric_weak_group()
>   perf util: Factor out sysctl__nmi_watchdog_enabled()
>   perf metricgroup: Support metric constraint
>   perf vendor events: Add NO_NMI_WATCHDOG metric constraint
> 
>  .../arch/x86/cascadelakex/clx-metrics.json         |   3 +-
>  .../pmu-events/arch/x86/skylake/skl-metrics.json   |   3 +-
>  .../pmu-events/arch/x86/skylakex/skx-metrics.json  |   3 +-
>  tools/perf/pmu-events/jevents.c                    |  19 ++--
>  tools/perf/pmu-events/jevents.h                    |   2 +-
>  tools/perf/pmu-events/pmu-events.h                 |   1 +
>  tools/perf/util/metricgroup.c                      | 109 ++++++++++++++++-----
>  tools/perf/util/stat-display.c                     |   6 +-
>  tools/perf/util/util.c                             |  18 ++++
>  tools/perf/util/util.h                             |   2 +
>  10 files changed, 128 insertions(+), 38 deletions(-)
> 
> -- 
> 2.7.4
> 

