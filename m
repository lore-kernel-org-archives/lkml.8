Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 143BEC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 20:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE709206DB
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 20:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FNypNJwM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgFQULb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 16:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbgFQULa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 16:11:30 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB5DC06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 13:11:29 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x207so1680240pfc.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 13:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=iwU3Uapaa3onoSAa/cQNtCWQ+psb2ZF2Ycxgsf9m2No=;
        b=FNypNJwMhZyDwZF3X+cvlmqkSKN2xq4/vTmsDolgRgHjeD7GZEtLcshazHNC5R4KJK
         JoHIR9g5rAj9b0MCOtjGg20l4IroyzNnYPgUX7ViuQfDNrDdS4mp6YnIP3jqrfrQCn2e
         x01NZsfIs0REa95raOfTJgrxXW0+XlwgQMjWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=iwU3Uapaa3onoSAa/cQNtCWQ+psb2ZF2Ycxgsf9m2No=;
        b=NDh7sk7Jztge7kOoq6puceGx32dGZZkTHkfwonhIRo/e/ghIT6aAm9Kt4cmbOWO2yC
         zocp+00dPvQm5K1+hFix2OPNBw8uFJCATzP5P2vs2VSY0jD/68Kkln5ueNBdYAqALz2F
         MJp+GtWWpcpemvgPUj/yvTyJDta9TnJ46TPvty4//csQakmkKboTAQnhJHU6we/TDpfo
         syovBucmkQrvegnBudIEVg0AhweUBJgw/TNXfnNeFkhBnKUnAJFL5mM4jgnrfta2Yyns
         fMffsOeaPAuokNm9Jf/AD3hf65MZu4a2D3DwvmXJA1UQKVxezltwcw15IJWSPXgY+CNz
         82zw==
X-Gm-Message-State: AOAM531VNYp8ZXnSGJT7Ew9bOb85Z99epVDB7SdKx5p5H9fMetIAfpCP
        accOJEtx1E37KiXGB8dFcQa9hw==
X-Google-Smtp-Source: ABdhPJze7KWNIqZmmx4kM1KIUJsLbt7Ba+rKLjvtLlbz+ohTX+djkiHUsqJSJ+HCDqL6EjntToGD+A==
X-Received: by 2002:a62:dd97:: with SMTP id w145mr388087pff.23.1592424688381;
        Wed, 17 Jun 2020 13:11:28 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id 67sm584147pga.44.2020.06.17.13.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 13:11:27 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200617113851.607706-3-alexandru.elisei@arm.com>
References: <20200617113851.607706-1-alexandru.elisei@arm.com> <20200617113851.607706-3-alexandru.elisei@arm.com>
Subject: Re: [PATCH v5 2/7] arm64: perf: Avoid PMXEV* indirection
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     mark.rutland@arm.com, Julien Thierry <julien.thierry@arm.com>,
        Peter Zijlstra <peterz@infradead.org>, maz@kernel.org,
        Jiri Olsa <jolsa@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, catalin.marinas@arm.com,
        Namhyung Kim <namhyung@kernel.org>, will@kernel.org,
        Julien Thierry <julien.thierry.kdev@gmail.com>
To:     Alexandru Elisei <alexandru.elisei@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Wed, 17 Jun 2020 13:11:27 -0700
Message-ID: <159242468708.62212.1739215996563155762@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alexandru Elisei (2020-06-17 04:38:46)
> From: Mark Rutland <mark.rutland@arm.com>
>=20
> Currently we access the counter registers and their respective type
> registers indirectly. This requires us to write to PMSELR, issue an ISB,
> then access the relevant PMXEV* registers.
>=20
> This is unfortunate, because:
>=20
> * Under virtualization, accessing one registers requires two traps to

one register? Not plural presumably.

>   the hypervisor, even though we could access the register directly with
>   a single trap.
>=20
> * We have to issue an ISB which we could otherwise avoid the cost of.
>=20
> * When we use NMIs, the NMI handler will have to save/restore the select
>   register in case the code it preempted was attempting to access a
>   counter or its type register.
>=20
> We can avoid these issues by directly accessing the relevant registers.
> This patch adds helpers to do so.
>=20
> In armv8pmu_enable_event() we still need the ISB to prevent the PE from
> reordering the write to PMINTENSET_EL1 register. If the interrupt is
> enabled before we disable the counter and the new event is configured,
> we might get an interrupt triggered by the previously programmed event
> overflowing, but which we wrongly attribute to the event that we are
> enabling.
>=20
> In the process, remove the comment that refers to the ARMv7 PMU.
>=20
> Cc: Julien Thierry <julien.thierry.kdev@gmail.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> [Julien T.: Don't inline read/write functions to avoid big code-size
>         increase, remove unused read_pmevtypern function,
>         fix counter index issue.]
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> [Removed comment, removed trailing semicolons in macros, added ISB]
> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> ---
>  arch/arm64/kernel/perf_event.c | 95 +++++++++++++++++++++++++++++-----
>  1 file changed, 81 insertions(+), 14 deletions(-)
>=20
> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_even=
t.c
> index ee180b2a5b39..e95b5ca70a53 100644
> --- a/arch/arm64/kernel/perf_event.c
> +++ b/arch/arm64/kernel/perf_event.c
> @@ -323,6 +323,73 @@ static inline bool armv8pmu_event_is_chained(struct =
perf_event *event)
>  #define        ARMV8_IDX_TO_COUNTER(x) \
>         (((x) - ARMV8_IDX_COUNTER0) & ARMV8_PMU_COUNTER_MASK)
> =20
> +/*
> + * This code is really good
> + */

Superb!

> +
> +#define PMEVN_CASE(n, case_macro) \
> +       case n: case_macro(n); break
> +
> +#define PMEVN_SWITCH(x, case_macro)                            \
> +       do {                                                    \
> +               switch (x) {                                    \
> +               PMEVN_CASE(0,  case_macro);                     \
> +               PMEVN_CASE(1,  case_macro);                     \
> +               PMEVN_CASE(2,  case_macro);                     \
> +               PMEVN_CASE(3,  case_macro);                     \
> +               PMEVN_CASE(4,  case_macro);                     \
> +               PMEVN_CASE(5,  case_macro);                     \
> +               PMEVN_CASE(6,  case_macro);                     \
> +               PMEVN_CASE(7,  case_macro);                     \
> +               PMEVN_CASE(8,  case_macro);                     \
> +               PMEVN_CASE(9,  case_macro);                     \
> +               PMEVN_CASE(10, case_macro);                     \
> +               PMEVN_CASE(11, case_macro);                     \
> +               PMEVN_CASE(12, case_macro);                     \
> +               PMEVN_CASE(13, case_macro);                     \
> +               PMEVN_CASE(14, case_macro);                     \
> +               PMEVN_CASE(15, case_macro);                     \
> +               PMEVN_CASE(16, case_macro);                     \
> +               PMEVN_CASE(17, case_macro);                     \
> +               PMEVN_CASE(18, case_macro);                     \
> +               PMEVN_CASE(19, case_macro);                     \
> +               PMEVN_CASE(20, case_macro);                     \
> +               PMEVN_CASE(21, case_macro);                     \
> +               PMEVN_CASE(22, case_macro);                     \
> +               PMEVN_CASE(23, case_macro);                     \
> +               PMEVN_CASE(24, case_macro);                     \
> +               PMEVN_CASE(25, case_macro);                     \
> +               PMEVN_CASE(26, case_macro);                     \
> +               PMEVN_CASE(27, case_macro);                     \
> +               PMEVN_CASE(28, case_macro);                     \
> +               PMEVN_CASE(29, case_macro);                     \
> +               PMEVN_CASE(30, case_macro);                     \
> +               default: WARN(1, "Invalid PMEV* index");        \

Missing newline on that WARN message?

> +               }                                               \
> +       } while (0)
> +
> +#define RETURN_READ_PMEVCNTRN(n) \
> +       return read_sysreg(pmevcntr##n##_el0)
> +static unsigned long read_pmevcntrn(int n)
> +{
> +       PMEVN_SWITCH(n, RETURN_READ_PMEVCNTRN);
> +       return 0;
> +}
> +
> +#define WRITE_PMEVCNTRN(n) \
> +       write_sysreg(val, pmevcntr##n##_el0)
> +static void write_pmevcntrn(int n, unsigned long val)
> +{
> +       PMEVN_SWITCH(n, WRITE_PMEVCNTRN);
> +}
> +
> +#define WRITE_PMEVTYPERN(n) \
> +       write_sysreg(val, pmevtyper##n##_el0)
> +static void write_pmevtypern(int n, unsigned long val)
> +{
> +       PMEVN_SWITCH(n, WRITE_PMEVTYPERN);
> +}
> +
>  static inline u32 armv8pmu_pmcr_read(void)
>  {
>         return read_sysreg(pmcr_el0);
> @@ -351,17 +418,11 @@ static inline int armv8pmu_counter_has_overflowed(u=
32 pmnc, int idx)
>         return pmnc & BIT(ARMV8_IDX_TO_COUNTER(idx));
>  }
> =20
> -static inline void armv8pmu_select_counter(int idx)
> +static inline u32 armv8pmu_read_evcntr(int idx)
>  {
>         u32 counter =3D ARMV8_IDX_TO_COUNTER(idx);
> -       write_sysreg(counter, pmselr_el0);
> -       isb();
> -}
> =20
> -static inline u64 armv8pmu_read_evcntr(int idx)
> -{
> -       armv8pmu_select_counter(idx);
> -       return read_sysreg(pmxevcntr_el0);
> +       return read_pmevcntrn(counter);
>  }
> =20
>  static inline u64 armv8pmu_read_hw_counter(struct perf_event *event)
> @@ -433,8 +494,9 @@ static u64 armv8pmu_read_counter(struct perf_event *e=
vent)
> =20
>  static inline void armv8pmu_write_evcntr(int idx, u64 value)
>  {
> -       armv8pmu_select_counter(idx);
> -       write_sysreg(value, pmxevcntr_el0);
> +       u32 counter =3D ARMV8_IDX_TO_COUNTER(idx);

Might be a good idea to make ARMV8_IDX_TO_COUNTER a static inline
function that has a return type of u32. I had to go check the code to
make sure it wasn't something larger.

> +
> +       write_pmevcntrn(counter, value);
>  }
> =20
>  static inline void armv8pmu_write_hw_counter(struct perf_event *event,
> @@ -469,9 +531,10 @@ static void armv8pmu_write_counter(struct perf_event=
 *event, u64 value)
> =20
>  static inline void armv8pmu_write_evtype(int idx, u32 val)
>  {
> -       armv8pmu_select_counter(idx);
> +       u32 counter =3D ARMV8_IDX_TO_COUNTER(idx);
> +
>         val &=3D ARMV8_PMU_EVTYPE_MASK;
> -       write_sysreg(val, pmxevtyper_el0);
> +       write_pmevtypern(counter, val);
>  }
> =20
>  static inline void armv8pmu_write_event_type(struct perf_event *event)
> @@ -491,7 +554,10 @@ static inline void armv8pmu_write_event_type(struct =
perf_event *event)
>                 armv8pmu_write_evtype(idx - 1, hwc->config_base);
>                 armv8pmu_write_evtype(idx, chain_evt);
>         } else {
> -               armv8pmu_write_evtype(idx, hwc->config_base);
> +               if (idx =3D=3D ARMV8_IDX_CYCLE_COUNTER)
> +                       write_sysreg(hwc->config_base, pmccfiltr_el0);
> +               else
> +                       armv8pmu_write_evtype(idx, hwc->config_base);
>         }
>  }
> =20
> @@ -595,9 +661,10 @@ static void armv8pmu_enable_event(struct perf_event =
*event)
>          * Disable counter
>          */
>         armv8pmu_disable_event_counter(event);
> +       isb();

Same comment about uncommented isb().

> =20
>         /*
> -        * Set event (if destined for PMNx counters).
> +        * Set event.
>          */
>         armv8pmu_write_event_type(event);
>
