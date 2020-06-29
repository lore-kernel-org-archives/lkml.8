Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD421C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A3D820768
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="JsdaplOx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389965AbgF2U4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731286AbgF2TNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:13:11 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4451C08C5F7
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 21:40:23 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id q15so14053681wmj.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 21:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v+vh0YRkjfXDBi4WqGzqlGWgLTl569iyBt5v4XRdv9Q=;
        b=JsdaplOxCqhWcYR1l1SGdDFbOgk6Ejz4quLs8nbWekspLf8vrR/CxuQa6CWdpaQ1k/
         xxySz00MJZnDOgHQYevB9z7B8OXSU8CuxksH3HWSsJ5K+FPIsNniuDFI+7wV+KFnP6Ac
         hqslUoO5TUAYyhdBbZYhm9NBAPT6BH0jmAe/LsQMX+UdnG0oiaH390pEd058uabGJl68
         Qfug+RQZnA5oEJWQoY/KDLFgHZXDhUds69f5VRJgVbby6I3pNlQjYNzllSES41WrAdx1
         zOBh/ksXyk1Q4lCB3CKBNi1l2vV743UVIaa1k6l770HkuiYWqFhwP2FBbTeyBprRoxrs
         B1hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v+vh0YRkjfXDBi4WqGzqlGWgLTl569iyBt5v4XRdv9Q=;
        b=pU/g95mm1Xz8Yr6nI4/Gheye2Jdh1orivOXQXuWDuZI6xJryd5MQbNs3shYyQRWQNZ
         PpbHSc+HiiBUYkwhJcDlGmQ2NOeyfxh9FOMqcvxmytMEj0aK06+MZoXpLmZCJuxY/OaN
         1UmZjsbGsbzOFHXQC1exEptM2nwQO1ycR0QXn3K5u2tdtVc4wDdzWo9+fWQPJea6ncXz
         1jSLRXnTG/q/CgdCS+0eYgYefUZNJ31w8CrLAC992nJ58FP4mTMIyElctIfgGqKxrjrL
         awQPkqgDgYGmJuExG78fB3mDbB5slq1PLNE6YzlPuHCJlrefa1INdOWfhaHeOZR5LfRZ
         iSRQ==
X-Gm-Message-State: AOAM531YSTp7e1QW/+G+lmza3/GKqn2ohd9O7jgmeLlU8RTir3fWY1E0
        WnU2zCNPPaUB7yJ+oXLjQbiEuXbCno5rc5ENf1RcHQ==
X-Google-Smtp-Source: ABdhPJwCKApA7CX01DiCPLR1Ghu8fn3u/jutBa19j4nO4JXmPIyUTS6B2FmmN5zgW9TQpxPPQuNKoxD91BvBQOiBpiE=
X-Received: by 2002:a1c:4303:: with SMTP id q3mr15409572wma.134.1593405622199;
 Sun, 28 Jun 2020 21:40:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1593397455.git.zong.li@sifive.com> <8b9f52c19bdb11a4ad741ad1a3695526a1d061b8.1593397455.git.zong.li@sifive.com>
 <CAAhSdy1Jbvs1+X5A_ej39YOevioUA7f3o2fOi=VT_AQWBgLjXw@mail.gmail.com> <CANXhq0oeDty5ec9So5cR1W3qoLgHXbMXrb_POoRYoG1E3Eiw9w@mail.gmail.com>
In-Reply-To: <CANXhq0oeDty5ec9So5cR1W3qoLgHXbMXrb_POoRYoG1E3Eiw9w@mail.gmail.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 29 Jun 2020 10:10:09 +0530
Message-ID: <CAAhSdy38r2biaR7PLdoVLerQz4K5yCpN0e2-fQV4KoDYU1cW6g@mail.gmail.com>
Subject: Re: [RFC PATCH 4/6] riscv: perf: Add raw event support
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

On Mon, Jun 29, 2020 at 10:05 AM Zong Li <zong.li@sifive.com> wrote:
>
> On Mon, Jun 29, 2020 at 12:17 PM Anup Patel <anup@brainfault.org> wrote:
> >
> > On Mon, Jun 29, 2020 at 8:49 AM Zong Li <zong.li@sifive.com> wrote:
> > >
> > > Add support for raw events and hardware cache events. Currently, we set
> > > the events by writing the mhpmeventN CSRs, it would raise an illegal
> > > instruction exception and trap into m-mode to emulate event selector
> > > CSRs access. It doesn't make sense because we shouldn't write the
> > > m-mode CSRs in s-mode, it would be better that set events through SBI
> > > call or the shadow CSRs of s-mode. We would change it later.
> > >
> > > Signed-off-by: Zong Li <zong.li@sifive.com>
> > > ---
> > >  arch/riscv/include/asm/perf_event.h |  65 ++++++---
> > >  arch/riscv/kernel/perf_event.c      | 204 +++++++++++++++++++++++-----
> > >  2 files changed, 215 insertions(+), 54 deletions(-)
> > >
> > > diff --git a/arch/riscv/include/asm/perf_event.h b/arch/riscv/include/asm/perf_event.h
> > > index 062efd3a1d5d..41d515a1f331 100644
> > > --- a/arch/riscv/include/asm/perf_event.h
> > > +++ b/arch/riscv/include/asm/perf_event.h
> > > @@ -14,39 +14,64 @@
> > >
> > >  #ifdef CONFIG_RISCV_BASE_PMU
> > >  #define RISCV_BASE_COUNTERS    2
> > > +#define RISCV_EVENT_COUNTERS   29
> >
> > Same comment as DT documentation related to naming.
>
> Change it as well. Thanks.
>
> >
> > Regards,
> > Anup
> >
> >
> > > +#define RISCV_TOTAL_COUNTERS   (RISCV_BASE_COUNTERS + RISCV_EVENT_COUNTERS)
> > >
> > >  /*
> > > - * The RISCV_MAX_COUNTERS parameter should be specified.
> > > - */
> > > -
> > > -#define RISCV_MAX_COUNTERS     2
> > > -
> > > -/*
> > > - * These are the indexes of bits in counteren register *minus* 1,
> > > - * except for cycle.  It would be coherent if it can directly mapped
> > > - * to counteren bit definition, but there is a *time* register at
> > > - * counteren[1].  Per-cpu structure is scarce resource here.
> > > - *
> > >   * According to the spec, an implementation can support counter up to
> > >   * mhpmcounter31, but many high-end processors has at most 6 general
> > >   * PMCs, we give the definition to MHPMCOUNTER8 here.
> > >   */
> > > -#define RISCV_PMU_CYCLE                0
> > > -#define RISCV_PMU_INSTRET      1
> > > -#define RISCV_PMU_MHPMCOUNTER3 2
> > > -#define RISCV_PMU_MHPMCOUNTER4 3
> > > -#define RISCV_PMU_MHPMCOUNTER5 4
> > > -#define RISCV_PMU_MHPMCOUNTER6 5
> > > -#define RISCV_PMU_MHPMCOUNTER7 6
> > > -#define RISCV_PMU_MHPMCOUNTER8 7
> > > +#define RISCV_PMU_CYCLE                        0
> > > +#define RISCV_PMU_INSTRET              2
> > > +#define RISCV_PMU_HPMCOUNTER3          3
> > > +#define RISCV_PMU_HPMCOUNTER4          4
> > > +#define RISCV_PMU_HPMCOUNTER5          5
> > > +#define RISCV_PMU_HPMCOUNTER6          6
> > > +#define RISCV_PMU_HPMCOUNTER7          7
> > > +#define RISCV_PMU_HPMCOUNTER8          8
> > > +
> > > +#define RISCV_PMU_HPMCOUNTER_FIRST     3
> > > +#define RISCV_PMU_HPMCOUNTER_LAST                                      \
> > > +       (RISCV_PMU_HPMCOUNTER_FIRST + riscv_pmu->num_counters - 1)
> > >
> > >  #define RISCV_OP_UNSUPP                (-EOPNOTSUPP)
> > >
> > > +/* Hardware cache event encoding */
> > > +#define PERF_HW_CACHE_TYPE             0
> > > +#define PERF_HW_CACHE_OP               8
> > > +#define PERF_HW_CACHE_RESULT           16
> > > +#define PERF_HW_CACHE_MASK             0xff
> > > +
> > > +/* config_base encoding */
> > > +#define RISCV_PMU_TYPE_MASK            0x3
> > > +#define RISCV_PMU_TYPE_BASE            0x1
> > > +#define RISCV_PMU_TYPE_EVENT           0x2
> > > +#define RISCV_PMU_EXCLUDE_MASK         0xc
> > > +#define RISCV_PMU_EXCLUDE_USER         0x3
> > > +#define RISCV_PMU_EXCLUDE_KERNEL       0x4
> > > +
> > > +/*
> > > + * Currently, machine-mode supports emulation of mhpmeventN. Setting mhpmeventN
> > > + * to raise an illegal instruction exception to set event types in machine-mode.
> > > + * Eventually, we should set event types through standard SBI call or the shadow
> > > + * CSRs of supervisor-mode, because it is weird for writing CSR of machine-mode
> > > + * explicitly in supervisor-mode. These macro should be removed in the future.
> > > + */
> > > +#define CSR_MHPMEVENT3 0x323
> > > +#define CSR_MHPMEVENT4 0x324
> > > +#define CSR_MHPMEVENT5 0x325
> > > +#define CSR_MHPMEVENT6 0x326
> > > +#define CSR_MHPMEVENT7 0x327
> > > +#define CSR_MHPMEVENT8 0x328
> > > +
> > >  struct cpu_hw_events {
> > >         /* # currently enabled events*/
> > >         int                     n_events;
> > >         /* currently enabled events */
> > > -       struct perf_event       *events[RISCV_MAX_COUNTERS];
> > > +       struct perf_event       *events[RISCV_EVENT_COUNTERS];
> > > +       /* bitmap of used event counters */
> > > +       unsigned long           used_cntr_mask;
> > >         /* vendor-defined PMU data */
> > >         void                    *platform;
> > >  };
> > > diff --git a/arch/riscv/kernel/perf_event.c b/arch/riscv/kernel/perf_event.c
> > > index c835f0362d94..0cfcd6f1e57b 100644
> > > --- a/arch/riscv/kernel/perf_event.c
> > > +++ b/arch/riscv/kernel/perf_event.c
> > > @@ -139,6 +139,53 @@ static const int riscv_cache_event_map[PERF_COUNT_HW_CACHE_MAX]
> > >         },
> > >  };
> > >
> > > +/*
> > > + * Methods for checking and getting PMU information
> > > + */
> > > +
> > > +static inline int is_base_counter(int idx)
> > > +{
> > > +       return (idx == RISCV_PMU_CYCLE || idx == RISCV_PMU_INSTRET);
> > > +}
> > > +
> > > +static inline int is_event_counter(int idx)
> > > +{
> > > +       return (idx >= RISCV_PMU_HPMCOUNTER_FIRST &&
> > > +               idx <= RISCV_PMU_HPMCOUNTER_LAST);
> > > +}
> > > +
> > > +static inline int get_available_counter(struct perf_event *event)
> > > +{
> > > +       struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> > > +       struct hw_perf_event *hwc = &event->hw;
> > > +       unsigned long config_base = hwc->config_base & RISCV_PMU_TYPE_MASK;
> > > +       unsigned long mask;
> > > +       int ret;
> > > +
> > > +       switch (config_base) {
> > > +       case RISCV_PMU_TYPE_BASE:
> > > +               ret = hwc->config;
> > > +               if (WARN_ON_ONCE(!is_base_counter(ret)))
> > > +                       return -ENOSPC;
> > > +               break;
> > > +       case RISCV_PMU_TYPE_EVENT:
> > > +               mask = ~cpuc->used_cntr_mask;
> > > +               ret = find_next_bit(&mask, RISCV_PMU_HPMCOUNTER_LAST, 3);
> > > +               if (WARN_ON_ONCE(!is_event_counter(ret)))
> > > +                       return -ENOSPC;
> > > +               break;
> > > +       default:
> > > +               return -ENOENT;
> > > +       }
> > > +
> > > +       __set_bit(ret, &cpuc->used_cntr_mask);
> > > +
> > > +       return ret;
> > > +}
> > > +
> > > +/*
> > > + * Map generic hardware event
> > > + */
> > >  static int riscv_map_hw_event(u64 config)
> > >  {
> > >         if (config >= riscv_pmu->max_events)
> > > @@ -147,32 +194,28 @@ static int riscv_map_hw_event(u64 config)
> > >         return riscv_pmu->hw_events[config];
> > >  }
> > >
> > > -static int riscv_map_cache_decode(u64 config, unsigned int *type,
> > > -                          unsigned int *op, unsigned int *result)
> > > -{
> > > -       return -ENOENT;
> > > -}
> > > -
> > > +/*
> > > + * Map generic hardware cache event
> > > + */
> > >  static int riscv_map_cache_event(u64 config)
> > >  {
> > >         unsigned int type, op, result;
> > > -       int err = -ENOENT;
> > > -               int code;
> > > +       int ret;
> > >
> > > -       err = riscv_map_cache_decode(config, &type, &op, &result);
> > > -       if (!riscv_pmu->cache_events || err)
> > > -               return err;
> > > +       type    = (config >> PERF_HW_CACHE_TYPE) & PERF_HW_CACHE_MASK;
> > > +       op      = (config >> PERF_HW_CACHE_OP) & PERF_HW_CACHE_MASK;
> > > +       result  = (config >> PERF_HW_CACHE_RESULT) & PERF_HW_CACHE_MASK;
> > >
> > >         if (type >= PERF_COUNT_HW_CACHE_MAX ||
> > >             op >= PERF_COUNT_HW_CACHE_OP_MAX ||
> > >             result >= PERF_COUNT_HW_CACHE_RESULT_MAX)
> > >                 return -EINVAL;
> > >
> > > -       code = (*riscv_pmu->cache_events)[type][op][result];
> > > -       if (code == RISCV_OP_UNSUPP)
> > > +       ret = riscv_cache_event_map[type][op][result];
> > > +       if (ret == RISCV_OP_UNSUPP)
> > >                 return -EINVAL;
> > >
> > > -       return code;
> > > +       return ret == RISCV_OP_UNSUPP ? -ENOENT : ret;
> > >  }
> > >
> > >  /*
> > > @@ -190,8 +233,27 @@ static inline u64 read_counter(int idx)
> > >         case RISCV_PMU_INSTRET:
> > >                 val = csr_read(CSR_INSTRET);
> > >                 break;
> > > +       case RISCV_PMU_HPMCOUNTER3:
> > > +               val = csr_read(CSR_HPMCOUNTER3);
> > > +               break;
> > > +       case RISCV_PMU_HPMCOUNTER4:
> > > +               val = csr_read(CSR_HPMCOUNTER4);
> > > +               break;
> > > +       case RISCV_PMU_HPMCOUNTER5:
> > > +               val = csr_read(CSR_HPMCOUNTER5);
> > > +               break;
> > > +       case RISCV_PMU_HPMCOUNTER6:
> > > +               val = csr_read(CSR_HPMCOUNTER6);
> > > +               break;
> > > +       case RISCV_PMU_HPMCOUNTER7:
> > > +               val = csr_read(CSR_HPMCOUNTER7);
> > > +               break;
> > > +       case RISCV_PMU_HPMCOUNTER8:
> > > +               val = csr_read(CSR_HPMCOUNTER8);
> >
> > This is broken for RV32 because for RV32 we have to read two
> > CSRs to get a counter value.
>
> Oh yes, thanks for your reminder. Add them in the next version.
>
> >
> > Also, for correctly reading a 64bit counter on RV32 we have
> > to read just like get_cycles64() does for RV32.
> >
> > static inline u64 get_cycles64(void)
> > {
> >     u32 hi, lo;
> >
> >     do {
> >         hi = get_cycles_hi();
> >         lo = get_cycles();
> >     } while (hi != get_cycles_hi());
> >
> >     return ((u64)hi << 32) | lo;
> > }
> >
> > Regards,
> > Anup
> >
> >
> > > +               break;
> > >         default:
> > > -               WARN_ON_ONCE(idx < 0 || idx > RISCV_MAX_COUNTERS);
> > > +               WARN_ON_ONCE(idx < RISCV_PMU_CYCLE ||
> > > +                            idx > RISCV_TOTAL_COUNTERS);
> > >                 return -EINVAL;
> > >         }
> > >
> > > @@ -204,6 +266,68 @@ static inline void write_counter(int idx, u64 value)
> > >         WARN_ON_ONCE(1);
> > >  }
> > >
> > > +static inline void write_event(int idx, u64 value)
> > > +{
> > > +       /* TODO: We shouldn't write CSR of m-mode explicitly here. Ideally,
> > > +        * it need to set the event selector by SBI call or the s-mode
> > > +        * shadow CSRs of them. Exploit illegal instruction exception to
> > > +        * emulate mhpmcounterN access in m-mode.
> > > +        */
> > > +       switch (idx) {
> > > +       case RISCV_PMU_HPMCOUNTER3:
> > > +               csr_write(CSR_MHPMEVENT3, value);
> > > +               break;
> > > +       case RISCV_PMU_HPMCOUNTER4:
> > > +               csr_write(CSR_MHPMEVENT4, value);
> > > +               break;
> > > +       case RISCV_PMU_HPMCOUNTER5:
> > > +               csr_write(CSR_MHPMEVENT5, value);
> > > +               break;
> > > +       case RISCV_PMU_HPMCOUNTER6:
> > > +               csr_write(CSR_MHPMEVENT6, value);
> > > +               break;
> > > +       case RISCV_PMU_HPMCOUNTER7:
> > > +               csr_write(CSR_MHPMEVENT7, value);
> > > +               break;
> > > +       case RISCV_PMU_HPMCOUNTER8:
> > > +               csr_write(CSR_MHPMEVENT8, value);
> > > +               break;
> > > +       default:
> > > +               WARN_ON_ONCE(idx < RISCV_PMU_HPMCOUNTER3 ||
> > > +                            idx > RISCV_TOTAL_COUNTERS);
> > > +               return;
> > > +       }
> > > +}
>
> I was also wondering if you have any suggestions about the PMU SBI
> extension as I mentioned in the cover letter. Currently, we set the
> event selectors by emulation of OpenSBI, so just write the m-mode CSRs
> as above.

That's a separate topic but design of this driver will pave way for
defining SBI perf counter calls. Let's get this driver in good shape
first so that it helps us in defining SBI calls for SBI-level perf counters.

Regards,
Anup

>
> > > +
> > > +/*
> > > + * Enable and disable event counters
> > > + */
> > > +
> > > +static inline void riscv_pmu_enable_event(struct perf_event *event)
> > > +{
> > > +       struct hw_perf_event *hwc = &event->hw;
> > > +       int idx = hwc->idx;
> > > +
> > > +       if (is_event_counter(idx))
> > > +               write_event(idx, hwc->config);
> > > +
> > > +       /*
> > > +        * Since we cannot write to counters, this serves as an initialization
> > > +        * to the delta-mechanism in pmu->read(); otherwise, the delta would be
> > > +        * wrong when pmu->read is called for the first time.
> > > +        */
> > > +       local64_set(&hwc->prev_count, read_counter(hwc->idx));
> > > +}
> > > +
> > > +static inline void riscv_pmu_disable_event(struct perf_event *event)
> > > +{
> > > +       struct hw_perf_event *hwc = &event->hw;
> > > +       int idx = hwc->idx;
> > > +
> > > +       if (is_event_counter(idx))
> > > +               write_event(idx, 0);
> > > +}
> > > +
> > >  /*
> > >   * pmu->read: read and update the counter
> > >   *
> > > @@ -232,6 +356,7 @@ static void riscv_pmu_read(struct perf_event *event)
> > >          */
> > >         delta = (new_raw_count - prev_raw_count) &
> > >                 ((1ULL << riscv_pmu->counter_width) - 1);
> > > +
> > >         local64_add(delta, &event->count);
> > >         /*
> > >          * Something like local64_sub(delta, &hwc->period_left) here is
> > > @@ -252,6 +377,11 @@ static void riscv_pmu_stop(struct perf_event *event, int flags)
> > >  {
> > >         struct hw_perf_event *hwc = &event->hw;
> > >
> > > +       if (WARN_ON_ONCE(hwc->idx == -1))
> > > +               return;
> > > +
> > > +       riscv_pmu_disable_event(event);
> > > +
> > >         WARN_ON_ONCE(hwc->state & PERF_HES_STOPPED);
> > >         hwc->state |= PERF_HES_STOPPED;
> > >
> > > @@ -271,6 +401,9 @@ static void riscv_pmu_start(struct perf_event *event, int flags)
> > >         if (WARN_ON_ONCE(!(event->hw.state & PERF_HES_STOPPED)))
> > >                 return;
> > >
> > > +       if (WARN_ON_ONCE(hwc->idx == -1))
> > > +               return;
> > > +
> > >         if (flags & PERF_EF_RELOAD) {
> > >                 WARN_ON_ONCE(!(event->hw.state & PERF_HES_UPTODATE));
> > >
> > > @@ -281,14 +414,10 @@ static void riscv_pmu_start(struct perf_event *event, int flags)
> > >         }
> > >
> > >         hwc->state = 0;
> > > -       perf_event_update_userpage(event);
> > >
> > > -       /*
> > > -        * Since we cannot write to counters, this serves as an initialization
> > > -        * to the delta-mechanism in pmu->read(); otherwise, the delta would be
> > > -        * wrong when pmu->read is called for the first time.
> > > -        */
> > > -       local64_set(&hwc->prev_count, read_counter(hwc->idx));
> > > +       riscv_pmu_enable_event(event);
> > > +
> > > +       perf_event_update_userpage(event);
> > >  }
> > >
> > >  /*
> > > @@ -298,21 +427,18 @@ static int riscv_pmu_add(struct perf_event *event, int flags)
> > >  {
> > >         struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> > >         struct hw_perf_event *hwc = &event->hw;
> > > +       int count_idx;
> > >
> > >         if (cpuc->n_events == riscv_pmu->num_counters)
> > >                 return -ENOSPC;
> > >
> > > -       /*
> > > -        * We don't have general conunters, so no binding-event-to-counter
> > > -        * process here.
> > > -        *
> > > -        * Indexing using hwc->config generally not works, since config may
> > > -        * contain extra information, but here the only info we have in
> > > -        * hwc->config is the event index.
> > > -        */
> > > -       hwc->idx = hwc->config;
> > > -       cpuc->events[hwc->idx] = event;
> > > +       count_idx = get_available_counter(event);
> > > +       if (count_idx < 0)
> > > +               return -ENOSPC;
> > > +
> > >         cpuc->n_events++;
> > > +       hwc->idx = count_idx;
> > > +       cpuc->events[hwc->idx] = event;
> > >
> > >         hwc->state = PERF_HES_UPTODATE | PERF_HES_STOPPED;
> > >
> > > @@ -330,8 +456,10 @@ static void riscv_pmu_del(struct perf_event *event, int flags)
> > >         struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> > >         struct hw_perf_event *hwc = &event->hw;
> > >
> > > -       cpuc->events[hwc->idx] = NULL;
> > >         cpuc->n_events--;
> > > +       __clear_bit(hwc->idx, &cpuc->used_cntr_mask);
> > > +
> > > +       cpuc->events[hwc->idx] = NULL;
> > >         riscv_pmu->pmu->stop(event, PERF_EF_UPDATE);
> > >         perf_event_update_userpage(event);
> > >  }
> > > @@ -385,6 +513,7 @@ static int riscv_event_init(struct perf_event *event)
> > >  {
> > >         struct perf_event_attr *attr = &event->attr;
> > >         struct hw_perf_event *hwc = &event->hw;
> > > +       unsigned long config_base = 0;
> > >         int err;
> > >         int code;
> > >
> > > @@ -406,11 +535,17 @@ static int riscv_event_init(struct perf_event *event)
> > >                 code = riscv_pmu->map_cache_event(attr->config);
> > >                 break;
> > >         case PERF_TYPE_RAW:
> > > -               return -EOPNOTSUPP;
> > > +               code = attr->config;
> > > +               break;
> > >         default:
> > >                 return -ENOENT;
> > >         }
> > >
> > > +       if (is_base_counter(code))
> > > +               config_base |= RISCV_PMU_TYPE_BASE;
> > > +       else
> > > +               config_base |= RISCV_PMU_TYPE_EVENT;
> > > +
> > >         event->destroy = riscv_event_destroy;
> > >         if (code < 0) {
> > >                 event->destroy(event);
> > > @@ -424,6 +559,7 @@ static int riscv_event_init(struct perf_event *event)
> > >          * But since we don't have such support, later in pmu->add(), we just
> > >          * use hwc->config as the index instead.
> > >          */
> > > +       hwc->config_base = config_base;
> > >         hwc->config = code;
> > >         hwc->idx = -1;
> > >
> > > --
> > > 2.27.0
> > >
