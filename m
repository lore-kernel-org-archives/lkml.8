Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A4EDC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 024D2206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:13:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="OmSP7K/F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730099AbgF2TNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731394AbgF2TN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:13:28 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D21C08C5F3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 21:37:13 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id q15so14050374wmj.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 21:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9BuRZbsQSVawCPMcscVv5I1a2tQ7JLUzF77XaHSUmes=;
        b=OmSP7K/Fp8ycjP0MQRFzk3m0N05+BXFdvrBWIKNIflOxOaygzKAl3/jWKF8mlQLMV9
         7nDQ8zacSRXcaeBDszwo9uWFqT0DbvbUQ2kyLRP3mYc/GMdvOfJe5EEIXW5oQepaqCNN
         9FjTdxCfQiEwYwcrjHkXGxj7mE586/fAQdNbQG82hENixj86aKnv6rvqQ5Z2XaB7zxaB
         vmJGzEFqDmLJGyp5bPlKNC2mXoW2dsc0PPuJLxTXGFjD5SIQ8JD/0Mm4wYHsXvtBRe1G
         9/svfs+lR+nTNzD4wP5XrQXNKWrEARDI0m8PWPw5rmkKAK3VQmVSRHO+ExIWVvDNLnLg
         /ilA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9BuRZbsQSVawCPMcscVv5I1a2tQ7JLUzF77XaHSUmes=;
        b=XaKEagHNeWEr0T8oAT/A5l+zrlT5vW1jCUHSi6c9cxn9SRHbZWzdLe7msOs+siw7mh
         Il/hK84d40rTSxwmGWpMiL/XJrUPxn3KDUDSGaYCx7nNQsKKURHteWyQNgLlv2OXA7Tz
         uF841uEL0svTjoeP/GcmllvlCv6z/kc9aKweYPUYAhvuPUVHNm3yKxLE1hv5xhaazXUB
         PueGz4n8Zn3y7dXUAdko/jKidTazqYh61nK+UJKVaVasrB5+CqCt5k/0ZOVkbyCpUE5Y
         t7H9/bYPBzV1av/zr42c/Ypucn5RZKgIpYQ0MuGXzwy4rkS0une1b1Jfk7cO+h0OWDS0
         UaOw==
X-Gm-Message-State: AOAM531JRCFWeOPKUDMARcy1J1I2NHh8aAOwn3ushXdK3hNBj8jZ6RJ5
        hAADgprdeerqky3FWDZez3ZC+ycHUuo7EQoJ/MvtJg==
X-Google-Smtp-Source: ABdhPJxwMKc1T/xx1mGxQmMC31/mbZKHBDAGZiJ1dAaiWIEmGnv0plAQ8rDW+U3JTAXPnSFFk6fHBZvXajAum94ocYI=
X-Received: by 2002:a1c:a3c5:: with SMTP id m188mr14496922wme.152.1593405430040;
 Sun, 28 Jun 2020 21:37:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1593397455.git.zong.li@sifive.com> <da261dc8b456fc0dd67508d98b16838bcd697220.1593397455.git.zong.li@sifive.com>
In-Reply-To: <da261dc8b456fc0dd67508d98b16838bcd697220.1593397455.git.zong.li@sifive.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 29 Jun 2020 10:06:56 +0530
Message-ID: <CAAhSdy1qTtGvtYe+fUqVGOxOzfiLjXvy-7uDMCUJbbDEFp=nUw@mail.gmail.com>
Subject: Re: [RFC PATCH 5/6] riscv: perf: introduce DT mechanism
To:     Zong Li <zong.li@sifive.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 8:49 AM Zong Li <zong.li@sifive.com> wrote:
>
> Each architecture is responsible for mapping generic hardware and cache
> events to their own specific encoding of hardware events. For each
> architecture, it also have to distinguish the defination of hardware
> events of different platforms of each vendor. We use DT file to describe
> platform-specific information to make our perf implementation more
> generic and common.
>
> Signed-off-by: Zong Li <zong.li@sifive.com>
> ---
>  arch/riscv/include/asm/perf_event.h |  55 ++----
>  arch/riscv/kernel/perf_event.c      | 273 +++++++++++++---------------
>  2 files changed, 139 insertions(+), 189 deletions(-)
>
> diff --git a/arch/riscv/include/asm/perf_event.h b/arch/riscv/include/asm/perf_event.h
> index 41d515a1f331..e95d3bbaae3e 100644
> --- a/arch/riscv/include/asm/perf_event.h
> +++ b/arch/riscv/include/asm/perf_event.h
> @@ -17,6 +17,8 @@
>  #define RISCV_EVENT_COUNTERS   29
>  #define RISCV_TOTAL_COUNTERS   (RISCV_BASE_COUNTERS + RISCV_EVENT_COUNTERS)
>
> +#define RISCV_DEFAULT_WIDTH_COUNTER    64
> +
>  /*
>   * According to the spec, an implementation can support counter up to
>   * mhpmcounter31, but many high-end processors has at most 6 general
> @@ -33,9 +35,21 @@
>
>  #define RISCV_PMU_HPMCOUNTER_FIRST     3
>  #define RISCV_PMU_HPMCOUNTER_LAST                                      \
> -       (RISCV_PMU_HPMCOUNTER_FIRST + riscv_pmu->num_counters - 1)
> +       (RISCV_PMU_HPMCOUNTER_FIRST + riscv_pmu.num_event_cntr - 1)
> +
> +#define RISCV_OP_UNSUPP                        (-EOPNOTSUPP)
> +
> +#define RISCV_MAP_ALL_UNSUPPORTED                                      \
> +       [0 ... PERF_COUNT_HW_MAX - 1] = RISCV_OP_UNSUPP
>
> -#define RISCV_OP_UNSUPP                (-EOPNOTSUPP)
> +#define C(x) PERF_COUNT_HW_CACHE_##x
> +
> +#define RISCV_CACHE_MAP_ALL_UNSUPPORTED                                        \
> +[0 ... C(MAX) - 1] = {                                                 \
> +       [0 ... C(OP_MAX) - 1] = {                                       \
> +               [0 ... C(RESULT_MAX) - 1] = RISCV_OP_UNSUPP,            \
> +       },                                                              \
> +}
>
>  /* Hardware cache event encoding */
>  #define PERF_HW_CACHE_TYPE             0
> @@ -65,43 +79,6 @@
>  #define CSR_MHPMEVENT7 0x327
>  #define CSR_MHPMEVENT8 0x328
>
> -struct cpu_hw_events {
> -       /* # currently enabled events*/
> -       int                     n_events;
> -       /* currently enabled events */
> -       struct perf_event       *events[RISCV_EVENT_COUNTERS];
> -       /* bitmap of used event counters */
> -       unsigned long           used_cntr_mask;
> -       /* vendor-defined PMU data */
> -       void                    *platform;
> -};
> -
> -struct riscv_pmu {
> -       struct pmu      *pmu;
> -
> -       /* generic hw/cache events table */
> -       const int       *hw_events;
> -       const int       (*cache_events)[PERF_COUNT_HW_CACHE_MAX]
> -                                      [PERF_COUNT_HW_CACHE_OP_MAX]
> -                                      [PERF_COUNT_HW_CACHE_RESULT_MAX];
> -       /* method used to map hw/cache events */
> -       int             (*map_hw_event)(u64 config);
> -       int             (*map_cache_event)(u64 config);
> -
> -       /* max generic hw events in map */
> -       int             max_events;
> -       /* number total counters, 2(base) + x(general) */
> -       int             num_counters;
> -       /* the width of the counter */
> -       int             counter_width;
> -
> -       /* vendor-defined PMU features */
> -       void            *platform;
> -
> -       irqreturn_t     (*handle_irq)(int irq_num, void *dev);
> -       int             irq;
> -};
> -
>  #endif
>  #ifdef CONFIG_PERF_EVENTS
>  #define perf_arch_bpf_user_pt_regs(regs) (struct user_regs_struct *)regs
> diff --git a/arch/riscv/kernel/perf_event.c b/arch/riscv/kernel/perf_event.c
> index 0cfcd6f1e57b..3bdfbe4efd5c 100644
> --- a/arch/riscv/kernel/perf_event.c
> +++ b/arch/riscv/kernel/perf_event.c
> @@ -9,6 +9,7 @@
>   * Copyright (C) 2009 Google, Inc., Stephane Eranian
>   * Copyright 2014 Tilera Corporation. All Rights Reserved.
>   * Copyright (C) 2018 Andes Technology Corporation
> + * Copyright (C) 2020 SiFive
>   *
>   * Perf_events support for RISC-V platforms.
>   *
> @@ -30,113 +31,55 @@
>  #include <linux/perf_event.h>
>  #include <linux/atomic.h>
>  #include <linux/of.h>
> +#include <asm/csr.h>
>  #include <asm/perf_event.h>
>
> -static const struct riscv_pmu *riscv_pmu __read_mostly;
> +static struct riscv_pmu {
> +       struct pmu      *pmu;
> +
> +       /* number of event counters */
> +       int             num_event_cntr;
> +
> +       /* the width of base counters */
> +       int             width_base_cntr;
> +
> +       /* the width of event counters */
> +       int             width_event_cntr;
> +
> +       irqreturn_t     (*handle_irq)(int irq_num, void *dev);
> +
> +       int             irq;
> +} riscv_pmu;
> +
> +struct cpu_hw_events {
> +       /* # currently enabled events*/
> +       int                     n_events;
> +
> +       /* currently enabled events */
> +       struct perf_event       *events[RISCV_EVENT_COUNTERS];
> +
> +       /* bitmap of used event counters */
> +       unsigned long           used_cntr_mask;
> +};
> +
>  static DEFINE_PER_CPU(struct cpu_hw_events, cpu_hw_events);
>
>  /*
>   * Hardware & cache maps and their methods
>   */
>
> -static const int riscv_hw_event_map[] = {
> -       [PERF_COUNT_HW_CPU_CYCLES]              = RISCV_PMU_CYCLE,
> -       [PERF_COUNT_HW_INSTRUCTIONS]            = RISCV_PMU_INSTRET,
> -       [PERF_COUNT_HW_CACHE_REFERENCES]        = RISCV_OP_UNSUPP,
> -       [PERF_COUNT_HW_CACHE_MISSES]            = RISCV_OP_UNSUPP,
> -       [PERF_COUNT_HW_BRANCH_INSTRUCTIONS]     = RISCV_OP_UNSUPP,
> -       [PERF_COUNT_HW_BRANCH_MISSES]           = RISCV_OP_UNSUPP,
> -       [PERF_COUNT_HW_BUS_CYCLES]              = RISCV_OP_UNSUPP,
> +static int riscv_hw_event_map[PERF_COUNT_HW_MAX] = {
> +       RISCV_MAP_ALL_UNSUPPORTED,
> +
> +       /* Specify base pmu, even if they aren't present in DT file */
> +       [PERF_COUNT_HW_CPU_CYCLES]      = RISCV_PMU_CYCLE,
> +       [PERF_COUNT_HW_INSTRUCTIONS]    = RISCV_PMU_INSTRET,
>  };
>
> -#define C(x) PERF_COUNT_HW_CACHE_##x
> -static const int riscv_cache_event_map[PERF_COUNT_HW_CACHE_MAX]
> -[PERF_COUNT_HW_CACHE_OP_MAX]
> -[PERF_COUNT_HW_CACHE_RESULT_MAX] = {
> -       [C(L1D)] = {
> -               [C(OP_READ)] = {
> -                       [C(RESULT_ACCESS)] = RISCV_OP_UNSUPP,
> -                       [C(RESULT_MISS)] = RISCV_OP_UNSUPP,
> -               },
> -               [C(OP_WRITE)] = {
> -                       [C(RESULT_ACCESS)] = RISCV_OP_UNSUPP,
> -                       [C(RESULT_MISS)] = RISCV_OP_UNSUPP,
> -               },
> -               [C(OP_PREFETCH)] = {
> -                       [C(RESULT_ACCESS)] = RISCV_OP_UNSUPP,
> -                       [C(RESULT_MISS)] = RISCV_OP_UNSUPP,
> -               },
> -       },
> -       [C(L1I)] = {
> -               [C(OP_READ)] = {
> -                       [C(RESULT_ACCESS)] = RISCV_OP_UNSUPP,
> -                       [C(RESULT_MISS)] = RISCV_OP_UNSUPP,
> -               },
> -               [C(OP_WRITE)] = {
> -                       [C(RESULT_ACCESS)] = RISCV_OP_UNSUPP,
> -                       [C(RESULT_MISS)] = RISCV_OP_UNSUPP,
> -               },
> -               [C(OP_PREFETCH)] = {
> -                       [C(RESULT_ACCESS)] = RISCV_OP_UNSUPP,
> -                       [C(RESULT_MISS)] = RISCV_OP_UNSUPP,
> -               },
> -       },
> -       [C(LL)] = {
> -               [C(OP_READ)] = {
> -                       [C(RESULT_ACCESS)] = RISCV_OP_UNSUPP,
> -                       [C(RESULT_MISS)] = RISCV_OP_UNSUPP,
> -               },
> -               [C(OP_WRITE)] = {
> -                       [C(RESULT_ACCESS)] = RISCV_OP_UNSUPP,
> -                       [C(RESULT_MISS)] = RISCV_OP_UNSUPP,
> -               },
> -               [C(OP_PREFETCH)] = {
> -                       [C(RESULT_ACCESS)] = RISCV_OP_UNSUPP,
> -                       [C(RESULT_MISS)] = RISCV_OP_UNSUPP,
> -               },
> -       },
> -       [C(DTLB)] = {
> -               [C(OP_READ)] = {
> -                       [C(RESULT_ACCESS)] =  RISCV_OP_UNSUPP,
> -                       [C(RESULT_MISS)] =  RISCV_OP_UNSUPP,
> -               },
> -               [C(OP_WRITE)] = {
> -                       [C(RESULT_ACCESS)] = RISCV_OP_UNSUPP,
> -                       [C(RESULT_MISS)] = RISCV_OP_UNSUPP,
> -               },
> -               [C(OP_PREFETCH)] = {
> -                       [C(RESULT_ACCESS)] = RISCV_OP_UNSUPP,
> -                       [C(RESULT_MISS)] = RISCV_OP_UNSUPP,
> -               },
> -       },
> -       [C(ITLB)] = {
> -               [C(OP_READ)] = {
> -                       [C(RESULT_ACCESS)] = RISCV_OP_UNSUPP,
> -                       [C(RESULT_MISS)] = RISCV_OP_UNSUPP,
> -               },
> -               [C(OP_WRITE)] = {
> -                       [C(RESULT_ACCESS)] = RISCV_OP_UNSUPP,
> -                       [C(RESULT_MISS)] = RISCV_OP_UNSUPP,
> -               },
> -               [C(OP_PREFETCH)] = {
> -                       [C(RESULT_ACCESS)] = RISCV_OP_UNSUPP,
> -                       [C(RESULT_MISS)] = RISCV_OP_UNSUPP,
> -               },
> -       },
> -       [C(BPU)] = {
> -               [C(OP_READ)] = {
> -                       [C(RESULT_ACCESS)] = RISCV_OP_UNSUPP,
> -                       [C(RESULT_MISS)] = RISCV_OP_UNSUPP,
> -               },
> -               [C(OP_WRITE)] = {
> -                       [C(RESULT_ACCESS)] = RISCV_OP_UNSUPP,
> -                       [C(RESULT_MISS)] = RISCV_OP_UNSUPP,
> -               },
> -               [C(OP_PREFETCH)] = {
> -                       [C(RESULT_ACCESS)] = RISCV_OP_UNSUPP,
> -                       [C(RESULT_MISS)] = RISCV_OP_UNSUPP,
> -               },
> -       },
> +static int riscv_cache_event_map[PERF_COUNT_HW_CACHE_MAX]
> +                               [PERF_COUNT_HW_CACHE_OP_MAX]
> +                               [PERF_COUNT_HW_CACHE_RESULT_MAX] = {
> +       RISCV_CACHE_MAP_ALL_UNSUPPORTED,
>  };
>
>  /*
> @@ -154,6 +97,17 @@ static inline int is_event_counter(int idx)
>                 idx <= RISCV_PMU_HPMCOUNTER_LAST);
>  }
>
> +static inline int get_counter_width(int idx)
> +{
> +       if (is_base_counter(idx))
> +               return riscv_pmu.width_base_cntr;
> +
> +       if (is_event_counter(idx))
> +               return riscv_pmu.width_event_cntr;
> +
> +       return 0;
> +}
> +
>  static inline int get_available_counter(struct perf_event *event)
>  {
>         struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> @@ -188,10 +142,14 @@ static inline int get_available_counter(struct perf_event *event)
>   */
>  static int riscv_map_hw_event(u64 config)
>  {
> -       if (config >= riscv_pmu->max_events)
> +       int ret;
> +
> +       if (config >= PERF_COUNT_HW_MAX)
>                 return -EINVAL;
>
> -       return riscv_pmu->hw_events[config];
> +       ret = riscv_hw_event_map[config];
> +
> +       return ret == RISCV_OP_UNSUPP ? -ENOENT : ret;
>  }
>
>  /*
> @@ -355,7 +313,7 @@ static void riscv_pmu_read(struct perf_event *event)
>          * delta is the value to update the counter we maintain in the kernel.
>          */
>         delta = (new_raw_count - prev_raw_count) &
> -               ((1ULL << riscv_pmu->counter_width) - 1);
> +               ((1ULL << get_counter_width(idx)) - 1);
>
>         local64_add(delta, &event->count);
>         /*
> @@ -386,7 +344,7 @@ static void riscv_pmu_stop(struct perf_event *event, int flags)
>         hwc->state |= PERF_HES_STOPPED;
>
>         if ((flags & PERF_EF_UPDATE) && !(hwc->state & PERF_HES_UPTODATE)) {
> -               riscv_pmu->pmu->read(event);
> +               riscv_pmu_read(event);
>                 hwc->state |= PERF_HES_UPTODATE;
>         }
>  }
> @@ -429,7 +387,7 @@ static int riscv_pmu_add(struct perf_event *event, int flags)
>         struct hw_perf_event *hwc = &event->hw;
>         int count_idx;
>
> -       if (cpuc->n_events == riscv_pmu->num_counters)
> +       if (cpuc->n_events == riscv_pmu.num_event_cntr)
>                 return -ENOSPC;
>
>         count_idx = get_available_counter(event);
> @@ -437,13 +395,13 @@ static int riscv_pmu_add(struct perf_event *event, int flags)
>                 return -ENOSPC;
>
>         cpuc->n_events++;
> +
>         hwc->idx = count_idx;
> -       cpuc->events[hwc->idx] = event;
>
>         hwc->state = PERF_HES_UPTODATE | PERF_HES_STOPPED;
>
>         if (flags & PERF_EF_START)
> -               riscv_pmu->pmu->start(event, PERF_EF_RELOAD);
> +               riscv_pmu_start(event, PERF_EF_RELOAD);
>
>         return 0;
>  }
> @@ -459,8 +417,8 @@ static void riscv_pmu_del(struct perf_event *event, int flags)
>         cpuc->n_events--;
>         __clear_bit(hwc->idx, &cpuc->used_cntr_mask);
>
> -       cpuc->events[hwc->idx] = NULL;
> -       riscv_pmu->pmu->stop(event, PERF_EF_UPDATE);
> +       riscv_pmu_stop(event, PERF_EF_UPDATE);
> +
>         perf_event_update_userpage(event);
>  }
>
> @@ -470,7 +428,7 @@ static void riscv_pmu_del(struct perf_event *event, int flags)
>
>  static DEFINE_MUTEX(pmc_reserve_mutex);
>
> -static irqreturn_t riscv_base_pmu_handle_irq(int irq_num, void *dev)
> +static irqreturn_t riscv_pmu_handle_irq(int irq_num, void *dev)
>  {
>         return IRQ_NONE;
>  }
> @@ -480,8 +438,8 @@ static int reserve_pmc_hardware(void)
>         int err = 0;
>
>         mutex_lock(&pmc_reserve_mutex);
> -       if (riscv_pmu->irq >= 0 && riscv_pmu->handle_irq) {
> -               err = request_irq(riscv_pmu->irq, riscv_pmu->handle_irq,
> +       if (riscv_pmu.irq >= 0 && riscv_pmu.handle_irq) {
> +               err = request_irq(riscv_pmu.irq, riscv_pmu.handle_irq,
>                                   IRQF_PERCPU, "riscv-base-perf", NULL);
>         }
>         mutex_unlock(&pmc_reserve_mutex);
> @@ -492,8 +450,8 @@ static int reserve_pmc_hardware(void)
>  static void release_pmc_hardware(void)
>  {
>         mutex_lock(&pmc_reserve_mutex);
> -       if (riscv_pmu->irq >= 0)
> -               free_irq(riscv_pmu->irq, NULL);
> +       if (riscv_pmu.irq >= 0)
> +               free_irq(riscv_pmu.irq, NULL);
>         mutex_unlock(&pmc_reserve_mutex);
>  }
>
> @@ -529,10 +487,10 @@ static int riscv_event_init(struct perf_event *event)
>
>         switch (event->attr.type) {
>         case PERF_TYPE_HARDWARE:
> -               code = riscv_pmu->map_hw_event(attr->config);
> +               code = riscv_map_hw_event(attr->config);
>                 break;
>         case PERF_TYPE_HW_CACHE:
> -               code = riscv_pmu->map_cache_event(attr->config);
> +               code = riscv_map_cache_event(attr->config);
>                 break;
>         case PERF_TYPE_RAW:
>                 code = attr->config;
> @@ -555,9 +513,6 @@ static int riscv_event_init(struct perf_event *event)
>         /*
>          * idx is set to -1 because the index of a general event should not be
>          * decided until binding to some counter in pmu->add().
> -        *
> -        * But since we don't have such support, later in pmu->add(), we just
> -        * use hwc->config as the index instead.
>          */
>         hwc->config_base = config_base;
>         hwc->config = code;
> @@ -570,52 +525,70 @@ static int riscv_event_init(struct perf_event *event)
>   * Initialization
>   */
>
> -static struct pmu min_pmu = {
> -       .name           = "riscv-base",
> -       .event_init     = riscv_event_init,
> -       .add            = riscv_pmu_add,
> -       .del            = riscv_pmu_del,
> -       .start          = riscv_pmu_start,
> -       .stop           = riscv_pmu_stop,
> -       .read           = riscv_pmu_read,
> -};
> +static struct riscv_pmu riscv_pmu = {
> +       .pmu = &(struct pmu) {
> +               .name           = "riscv-pmu",
> +               .event_init     = riscv_event_init,
> +               .add            = riscv_pmu_add,
> +               .del            = riscv_pmu_del,
> +               .start          = riscv_pmu_start,
> +               .stop           = riscv_pmu_stop,
> +               .read           = riscv_pmu_read,
> +       },
>
> -static const struct riscv_pmu riscv_base_pmu = {
> -       .pmu = &min_pmu,
> -       .max_events = ARRAY_SIZE(riscv_hw_event_map),
> -       .map_hw_event = riscv_map_hw_event,
> -       .hw_events = riscv_hw_event_map,
> -       .map_cache_event = riscv_map_cache_event,
> -       .cache_events = &riscv_cache_event_map,
> -       .counter_width = 63,
> -       .num_counters = RISCV_BASE_COUNTERS + 0,
> -       .handle_irq = &riscv_base_pmu_handle_irq,
> +       .num_event_cntr = 0,
> +       .width_event_cntr = RISCV_DEFAULT_WIDTH_COUNTER,
> +       .width_base_cntr = RISCV_DEFAULT_WIDTH_COUNTER,
>
> +       .handle_irq = &riscv_pmu_handle_irq,
>         /* This means this PMU has no IRQ. */
>         .irq = -1,
>  };
>
> -static const struct of_device_id riscv_pmu_of_ids[] = {
> -       {.compatible = "riscv,base-pmu",        .data = &riscv_base_pmu},
> -       { /* sentinel value */ }
> -};
> +static int __init init_riscv_pmu(struct device_node *node)
> +{
> +       int num_events, key, value, i;
> +
> +       of_property_read_u32(node, "riscv,width-base-cntr", &riscv_pmu.width_base_cntr);
> +
> +       of_property_read_u32(node, "riscv,width-event-cntr", &riscv_pmu.width_event_cntr);
> +
> +       of_property_read_u32(node, "riscv,n-event-cntr", &riscv_pmu.num_event_cntr);
> +       if (riscv_pmu.num_event_cntr > RISCV_EVENT_COUNTERS)
> +               riscv_pmu.num_event_cntr = RISCV_EVENT_COUNTERS;
> +
> +       num_events = of_property_count_u32_elems(node, "riscv,hw-event-map");
> +       if (num_events > 0 && num_events % 2 == 0)
> +               for (i = 0; i < num_events;) {
> +                       of_property_read_u32_index(node, "riscv,hw-event-map", i++, &key);
> +                       of_property_read_u32_index(node, "riscv,hw-event-map", i++, &value);
> +                       riscv_hw_event_map[key] = value;
> +               }
> +
> +       num_events = of_property_count_u32_elems(node, "riscv,hw-cache-event-map");
> +       if (num_events > 0 && num_events % 2 == 0)
> +               for (i = 0; i < num_events;) {
> +                       of_property_read_u32_index(node, "riscv,hw-cache-event-map", i++, &key);
> +                       of_property_read_u32_index(node, "riscv,hw-cache-event-map", i++, &value);
> +                       riscv_cache_event_map
> +                               [(key >> PERF_HW_CACHE_TYPE) & PERF_HW_CACHE_MASK]
> +                               [(key >> PERF_HW_CACHE_OP) & PERF_HW_CACHE_MASK]
> +                               [(key >> PERF_HW_CACHE_RESULT) & PERF_HW_CACHE_MASK] = value;
> +               }
> +
> +       return 0;
> +}
>
>  static int __init init_hw_perf_events(void)
>  {
> -       struct device_node *node = of_find_node_by_type(NULL, "pmu");
> -       const struct of_device_id *of_id;
> +       struct device_node *node = of_find_compatible_node(NULL, NULL, "riscv,pmu");
>
> -       riscv_pmu = &riscv_base_pmu;
> +       if (node)
> +               init_riscv_pmu(node);
>
> -       if (node) {
> -               of_id = of_match_node(riscv_pmu_of_ids, node);
> -
> -               if (of_id)
> -                       riscv_pmu = of_id->data;
> -               of_node_put(node);
> -       }
> +       /* Even if there is no pmu node in DT, we reach here for base PMU. */
> +       perf_pmu_register(riscv_pmu.pmu, "cpu", PERF_TYPE_RAW);
>
> -       perf_pmu_register(riscv_pmu->pmu, "cpu", PERF_TYPE_RAW);
>         return 0;
>  }
>  arch_initcall(init_hw_perf_events);

Why does this have to arch_initcall() ??
Why can't we just probe this like a regular DT based driver ??

This driver needs total re-write because it has to be a platform driver.
Even the names of counters are not registered. The implementation
specific counter names should come from DT property.

Regards,
Anup

> --
> 2.27.0
>
