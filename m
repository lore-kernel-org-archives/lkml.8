Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED2FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 07:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 884AD20772
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 07:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597130824;
	bh=SlBBfxhicPcmNPHmcSqS00lC2qQq+8KUG83SZfmwYjQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=inhpCj800kyrsa3axmxwFjz0UtaD3XZkLYC/BL22mqiE5Q6pOJ7T2aWE4UbVZGLCg
	 H5GxFtW6wJwxvAGJk3X2PPomUrFqBVpXvCV+slaHLDGw8TkqcStVEEUJBouXHj4VOb
	 QuRIgnXPOBwiDWBqUrSvDDWQEzH4nbf+8nCIeu9U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbgHKH1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 03:27:03 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52571 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbgHKH1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 03:27:03 -0400
Received: by mail-wm1-f68.google.com with SMTP id x5so1677032wmi.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 00:27:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tr8EM1xdbvBUWk9egHsW5lCZAPw5FQcJwP6Fhs9U/EE=;
        b=rZo0d0HJ8R6XbH+Oehi5qU1bYpgcZmA7fzIyUPgPy8n5ZQkpqxfUzyTTn7rM5GiEOh
         wbeDPCuBK5mS1b1j/7h+GVudFCengujWL4wDFyxmpp8rPeOj3+bBkFsWwMa9SbeWtgBU
         8yvdW4HxuhV1NYoZjw/s8Ryk8xrBsaXs9ycbwiMSZicEfKJ6L4gAV5p2ijjc8jXyQioF
         9flTYQ6mJe7f7YiYfSdDBRkk+1Xg5e7bWjEu45yjfXMmr1/j3zcKOocRxRic3oUs0/a7
         Sx+KsM7szb93YOMjO3uzKn6T4vABCYldM1VBSHOa07mElGsZM2q72/zQFbMtwPLvguV/
         dLzw==
X-Gm-Message-State: AOAM530umorFa7vUMqB6CEMWmr6J1GlOFmh496X4kpkWuKQ/4wkuOPnT
        7MV0MjE+7m6vWhzTIEK3TBMo35A4bTsl7QCQrM8=
X-Google-Smtp-Source: ABdhPJwp8vgVH9bCn97E+CSbWlWznZDbOwci5FR9FFiH+FDI4OCEubsxYf/CCXw6tO2blCGIefjz84c28WOVBVKCGDc=
X-Received: by 2002:a1c:1f85:: with SMTP id f127mr2921479wmf.154.1597130821317;
 Tue, 11 Aug 2020 00:27:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1597004831.git.agordeev@linux.ibm.com> <a002ebf17a3970e5d2dc7b9869dc180e68b88db4.1597004831.git.agordeev@linux.ibm.com>
In-Reply-To: <a002ebf17a3970e5d2dc7b9869dc180e68b88db4.1597004831.git.agordeev@linux.ibm.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 11 Aug 2020 16:26:50 +0900
Message-ID: <CAM9d7cjLA29eOm6UU5FVE-Zeg7wm4bJaSdwMOH=ghDn=hfBo=A@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] perf bench numa: use numa_node_to_cpus() to bind
 tasks to nodes
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Balamuruhan S <bala24@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Aug 10, 2020 at 3:22 PM Alexander Gordeev
<agordeev@linux.ibm.com> wrote:
>
> It is currently assumed that each node contains at most
> nr_cpus/nr_nodes CPUs and node CPU ranges do not overlap.
> That assumption is generally incorrect as there are archs
> where a CPU number does not depend on to its node number.
>
> This update removes the described assumption by simply calling
> numa_node_to_cpus() interface and using the returned mask for
> binding CPUs to nodes. It also tightens a cpumask allocation
> failure check a bit.
>
> Cc: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
> Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> Cc: Balamuruhan S <bala24@linux.vnet.ibm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> ---
>  tools/perf/bench/numa.c | 27 +++++++++++++--------------
>  1 file changed, 13 insertions(+), 14 deletions(-)
>
> diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
> index 5797253..23e224e 100644
> --- a/tools/perf/bench/numa.c
> +++ b/tools/perf/bench/numa.c
> @@ -247,12 +247,13 @@ static int is_node_present(int node)
>   */
>  static bool node_has_cpus(int node)
>  {
> -       struct bitmask *cpu = numa_allocate_cpumask();
> +       struct bitmask *cpumask = numa_allocate_cpumask();
>         unsigned int i;
>
> -       if (cpu && !numa_node_to_cpus(node, cpu)) {
> -               for (i = 0; i < cpu->size; i++) {
> -                       if (numa_bitmask_isbitset(cpu, i))
> +       BUG_ON(!cpumask);
> +       if (!numa_node_to_cpus(node, cpumask)) {
> +               for (i = 0; i < cpumask->size; i++) {
> +                       if (numa_bitmask_isbitset(cpumask, i))
>                                 return true;
>                 }
>         }
> @@ -288,14 +289,10 @@ static cpu_set_t bind_to_cpu(int target_cpu)
>
>  static cpu_set_t bind_to_node(int target_node)
>  {
> -       int cpus_per_node = g->p.nr_cpus / nr_numa_nodes();
>         cpu_set_t orig_mask, mask;
>         int cpu;
>         int ret;
>
> -       BUG_ON(cpus_per_node * nr_numa_nodes() != g->p.nr_cpus);
> -       BUG_ON(!cpus_per_node);
> -
>         ret = sched_getaffinity(0, sizeof(orig_mask), &orig_mask);
>         BUG_ON(ret);
>
> @@ -305,13 +302,15 @@ static cpu_set_t bind_to_node(int target_node)
>                 for (cpu = 0; cpu < g->p.nr_cpus; cpu++)
>                         CPU_SET(cpu, &mask);
>         } else {
> -               int cpu_start = (target_node + 0) * cpus_per_node;
> -               int cpu_stop  = (target_node + 1) * cpus_per_node;
> -
> -               BUG_ON(cpu_stop > g->p.nr_cpus);
> +               struct bitmask *cpumask = numa_allocate_cpumask();
>
> -               for (cpu = cpu_start; cpu < cpu_stop; cpu++)
> -                       CPU_SET(cpu, &mask);
> +               BUG_ON(!cpumask);
> +               if (!numa_node_to_cpus(target_node, cpumask)) {
> +                       for (cpu = 0; cpu < (int)cpumask->size; cpu++) {
> +                               if (numa_bitmask_isbitset(cpumask, cpu))
> +                                       CPU_SET(cpu, &mask);
> +                       }
> +               }

It seems you need to call numa_free_cpumask() for both functions.

Thanks
Namhyung

>         }
>
>         ret = sched_setaffinity(0, sizeof(mask), &mask);
> --
> 1.8.3.1
>
