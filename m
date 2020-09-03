Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50100C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 06:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1606320737
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 06:20:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ncT8skM7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbgICGUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 02:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbgICGUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 02:20:01 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0353C061245
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 23:20:00 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id g4so1814152wrs.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 23:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=O2AS852CncZJaAMqTSSdS3jrNCcIpoZq5ZcfQ5cPtp4=;
        b=ncT8skM7qF/KVkiDoAx6IBn20U6ahnKdiw3NCOuq3+VGuCYlscYY0ErZPKQApEYJPK
         t+yK1u2TU3ItSndLlcoQG82NM1RBBI2iOu/xffTJL75D5JJGur7AWDnma4wCy4FYzh0H
         oqYgWtdFTksnB89M3JHS5NeG3zNzq58QkfAeiGT8q9ZHuEC0Ma0yCI9cxfxWdCzEWviN
         Y4r5kDeAYf+tf5/5BvX3HKNLYmhpdcZrlMwTP0xQfw8XTCHThRWtrOSsEGTqx9itiXMp
         UTwNIDw/M8JEISLNiFTlL21mtUWmCFd4Y2Ol2tRkz4bC6WNhQIbc+5LX7mt/6bEtQC1K
         gZnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=O2AS852CncZJaAMqTSSdS3jrNCcIpoZq5ZcfQ5cPtp4=;
        b=QrhDJAcxIP2rzuzhwp4C+Q2hfPU+faBwrQiLmhc76dZcgysDv0FtYNwQsCP9In5LaU
         Ou2uLmQALtcx6M1EDT9fWQJDSMePc1szVbBTaWaCwDsofLZLhgApmT5sw6l6OJ/fdplQ
         JALV0hUADJUbJH6EcyzTB2Ew/aQ/Yo5d/xfwGcC/8fhcAvzUfhsuNm/sGinIuMZjMufR
         nJprZ8JDL35II2ydsDLoFqMC6PdgaNReV5Hv1goKzlpj+z9hE3f+HKR29h72PlL+VKhH
         A1PjyjYt8RvIFZHX+mZ5x0833k2rqlyDI4GOb4LqjvxCy2SG9I6VPlGdNpxTVtrLxfek
         O1Mw==
X-Gm-Message-State: AOAM533jylAYrnk7F8kSOYgzNis0XB0rMzPm4PcDyRCxmQ+NT3m4N3ZJ
        AeHPhnhstTmlEOEn1gb8iWFYCq0NRCt+U8jxZXeFLA==
X-Google-Smtp-Source: ABdhPJypkAd0Il1XNFi+HQXV3FZbZY4cfhqSWOaRT2o7cSM0/Bz/I/od87mquwl2KSi/eypGROTz2PmxtF4PVXSubTw=
X-Received: by 2002:a5d:608a:: with SMTP id w10mr573959wrt.48.1599113998508;
 Wed, 02 Sep 2020 23:19:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200901220944.277505-1-kim.phillips@amd.com> <20200901220944.277505-3-kim.phillips@amd.com>
In-Reply-To: <20200901220944.277505-3-kim.phillips@amd.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 2 Sep 2020 23:19:47 -0700
Message-ID: <CAP-5=fVwuKOACD++6UyBVW_fgbTXrOwuOJHSYenD87dwVJk0OA@mail.gmail.com>
Subject: Re: [PATCH 3/4] perf vendor events amd: Add recommended events
To:     Kim Phillips <kim.phillips@amd.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Vijay Thakkar <vijaythakkar@me.com>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Yunfeng Ye <yeyunfeng@huawei.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        =?UTF-8?Q?Martin_Li=C5=A1ka?= <mliska@suse.cz>,
        Borislav Petkov <bp@suse.de>, Jon Grimm <jon.grimm@amd.com>,
        Martin Jambor <mjambor@suse.cz>,
        Michael Petlan <mpetlan@redhat.com>,
        William Cohen <wcohen@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 1, 2020 at 3:10 PM Kim Phillips <kim.phillips@amd.com> wrote:
>
> Add support for events listed in Section 2.1.15.2 "Performance
> Measurement" of "PPR for AMD Family 17h Model 31h B0 - 55803
> Rev 0.54 - Sep 12, 2019".
>
> perf now supports these new events (-e):
>
>   all_dc_accesses
>   all_tlbs_flushed
>   l1_dtlb_misses
>   l2_cache_accesses_from_dc_misses
>   l2_cache_accesses_from_ic_misses
>   l2_cache_hits_from_dc_misses
>   l2_cache_hits_from_ic_misses
>   l2_cache_misses_from_dc_misses
>   l2_cache_misses_from_ic_miss
>   l2_dtlb_misses
>   l2_itlb_misses
>   sse_avx_stalls
>   uops_dispatched
>   uops_retired
>   l3_accesses
>   l3_misses
>
> and these metrics (-M):
>
>   branch_misprediction_ratio
>   all_l2_cache_accesses
>   all_l2_cache_hits
>   all_l2_cache_misses
>   ic_fetch_miss_ratio
>   l2_cache_accesses_from_l2_hwpf
>   l2_cache_hits_from_l2_hwpf
>   l2_cache_misses_from_l2_hwpf
>   l3_read_miss_latency
>   l1_itlb_misses
>   all_remote_links_outbound
>   nps1_die_to_dram
>
> The nps1_die_to_dram event may need perf stat's --metric-no-group
> switch if the number of available data fabric counters is less
> than the number it uses (8).

These are really excellent additions! Does:
"MetricConstraint": "NO_NMI_WATCHDOG"
solve the grouping issue? Perhaps the MetricConstraint needs to be
named more generically to cover this case as it seems sub-optimal to
require the use of --metric-no-group.

>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D206537
> Signed-off-by: Kim Phillips <kim.phillips@amd.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Vijay Thakkar <vijaythakkar@me.com>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: John Garry <john.garry@huawei.com>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Yunfeng Ye <yeyunfeng@huawei.com>
> Cc: Jin Yao <yao.jin@linux.intel.com>
> Cc: "Martin Li=C5=A1ka" <mliska@suse.cz>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Jon Grimm <jon.grimm@amd.com>
> Cc: Martin Jambor <mjambor@suse.cz>
> Cc: Michael Petlan <mpetlan@redhat.com>
> Cc: William Cohen <wcohen@redhat.com>
> Cc: Stephane Eranian <eranian@google.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: linux-perf-users@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  .../pmu-events/arch/x86/amdzen1/cache.json    |  23 +++
>  .../arch/x86/amdzen1/data-fabric.json         |  98 ++++++++++
>  .../arch/x86/amdzen1/recommended.json         | 178 ++++++++++++++++++
>  .../pmu-events/arch/x86/amdzen2/cache.json    |  23 +++
>  .../arch/x86/amdzen2/data-fabric.json         |  98 ++++++++++
>  .../arch/x86/amdzen2/recommended.json         | 178 ++++++++++++++++++
>  tools/perf/pmu-events/jevents.c               |   1 +
>  7 files changed, 599 insertions(+)
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen1/data-fabric.js=
on
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen1/recommended.js=
on
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/data-fabric.js=
on
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/recommended.js=
on
>
> diff --git a/tools/perf/pmu-events/arch/x86/amdzen1/cache.json b/tools/pe=
rf/pmu-events/arch/x86/amdzen1/cache.json
> index 695ed3ffa3a6..4ea7ec4f496e 100644
> --- a/tools/perf/pmu-events/arch/x86/amdzen1/cache.json
> +++ b/tools/perf/pmu-events/arch/x86/amdzen1/cache.json
> @@ -117,6 +117,11 @@
>      "BriefDescription": "Miscellaneous events covered in more detail by =
l2_request_g2 (PMCx061).",
>      "UMask": "0x1"
>    },
> +  {
> +    "EventName": "l2_request_g1.all_no_prefetch",
> +    "EventCode": "0x60",
> +    "UMask": "0xf9"
> +  },

Would it be possible to have a BriefDescription here?

>    {
>      "EventName": "l2_request_g2.group1",
>      "EventCode": "0x61",
> @@ -243,6 +248,24 @@
>      "BriefDescription": "Core to L2 cacheable request access status (not=
 including L2 Prefetch). Instruction cache request miss in L2.",
>      "UMask": "0x1"
>    },
> +  {
> +    "EventName": "l2_cache_req_stat.ic_access_in_l2",
> +    "EventCode": "0x64",
> +    "BriefDescription": "Core to L2 cacheable request access status (not=
 including L2 Prefetch). Instruction cache requests in L2.",
> +    "UMask": "0x7"
> +  },
> +  {
> +    "EventName": "l2_cache_req_stat.ic_dc_miss_in_l2",
> +    "EventCode": "0x64",
> +    "BriefDescription": "Core to L2 cacheable request access status (not=
 including L2 Prefetch). Instruction cache request miss in L2 and Data cach=
e request miss in L2 (all types).",
> +    "UMask": "0x9"
> +  },
> +  {
> +    "EventName": "l2_cache_req_stat.ic_dc_hit_in_l2",
> +    "EventCode": "0x64",
> +    "BriefDescription": "Core to L2 cacheable request access status (not=
 including L2 Prefetch). Instruction cache request hit in L2 and Data cache=
 request hit in L2 (all types).",
> +    "UMask": "0xf6"
> +  },
>    {
>      "EventName": "l2_fill_pending.l2_fill_busy",
>      "EventCode": "0x6d",
> diff --git a/tools/perf/pmu-events/arch/x86/amdzen1/data-fabric.json b/to=
ols/perf/pmu-events/arch/x86/amdzen1/data-fabric.json
> new file mode 100644
> index 000000000000..40271df40015
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/x86/amdzen1/data-fabric.json
> @@ -0,0 +1,98 @@
> +[
> +  {
> +    "EventName": "remote_outbound_data_controller_0",
> +    "PublicDescription": "Remote Link Controller Outbound Packet Types: =
Data (32B): Remote Link Controller 0",
> +    "EventCode": "0x7c7",
> +    "UMask": "0x02",
> +    "PerPkg": "1",
> +    "Unit": "DFPMC"
> +  },
> +  {
> +    "EventName": "remote_outbound_data_controller_1",
> +    "PublicDescription": "Remote Link Controller Outbound Packet Types: =
Data (32B): Remote Link Controller 1",
> +    "EventCode": "0x807",
> +    "UMask": "0x02",
> +    "PerPkg": "1",
> +    "Unit": "DFPMC"
> +  },
> +  {
> +    "EventName": "remote_outbound_data_controller_2",
> +    "PublicDescription": "Remote Link Controller Outbound Packet Types: =
Data (32B): Remote Link Controller 2",
> +    "EventCode": "0x847",
> +    "UMask": "0x02",
> +    "PerPkg": "1",
> +    "Unit": "DFPMC"
> +  },
> +  {
> +    "EventName": "remote_outbound_data_controller_3",
> +    "PublicDescription": "Remote Link Controller Outbound Packet Types: =
Data (32B): Remote Link Controller 3",
> +    "EventCode": "0x887",
> +    "UMask": "0x02",
> +    "PerPkg": "1",
> +    "Unit": "DFPMC"
> +  },
> +  {
> +    "EventName": "dram_channel_data_controller_0",
> +    "PublicDescription": "DRAM Channel Controller Request Types: Request=
s with Data (64B): DRAM Channel Controller 0",
> +    "EventCode": "0x07",
> +    "UMask": "0x38",
> +    "PerPkg": "1",
> +    "Unit": "DFPMC"
> +  },
> +  {
> +    "EventName": "dram_channel_data_controller_1",
> +    "PublicDescription": "DRAM Channel Controller Request Types: Request=
s with Data (64B): DRAM Channel Controller 0",
> +    "EventCode": "0x47",
> +    "UMask": "0x38",
> +    "PerPkg": "1",
> +    "Unit": "DFPMC"
> +  },
> +  {
> +    "EventName": "dram_channel_data_controller_2",
> +    "PublicDescription": "DRAM Channel Controller Request Types: Request=
s with Data (64B): DRAM Channel Controller 0",
> +    "EventCode": "0x87",
> +    "UMask": "0x38",
> +    "PerPkg": "1",
> +    "Unit": "DFPMC"
> +  },
> +  {
> +    "EventName": "dram_channel_data_controller_3",
> +    "PublicDescription": "DRAM Channel Controller Request Types: Request=
s with Data (64B): DRAM Channel Controller 0",
> +    "EventCode": "0xc7",
> +    "UMask": "0x38",
> +    "PerPkg": "1",
> +    "Unit": "DFPMC"
> +  },
> +  {
> +    "EventName": "dram_channel_data_controller_4",
> +    "PublicDescription": "DRAM Channel Controller Request Types: Request=
s with Data (64B): DRAM Channel Controller 0",
> +    "EventCode": "0x107",
> +    "UMask": "0x38",
> +    "PerPkg": "1",
> +    "Unit": "DFPMC"
> +  },
> +  {
> +    "EventName": "dram_channel_data_controller_5",
> +    "PublicDescription": "DRAM Channel Controller Request Types: Request=
s with Data (64B): DRAM Channel Controller 0",
> +    "EventCode": "0x147",
> +    "UMask": "0x38",
> +    "PerPkg": "1",
> +    "Unit": "DFPMC"
> +  },
> +  {
> +    "EventName": "dram_channel_data_controller_6",
> +    "PublicDescription": "DRAM Channel Controller Request Types: Request=
s with Data (64B): DRAM Channel Controller 0",
> +    "EventCode": "0x187",
> +    "UMask": "0x38",
> +    "PerPkg": "1",
> +    "Unit": "DFPMC"
> +  },
> +  {
> +    "EventName": "dram_channel_data_controller_7",
> +    "PublicDescription": "DRAM Channel Controller Request Types: Request=
s with Data (64B): DRAM Channel Controller 0",
> +    "EventCode": "0x1c7",
> +    "UMask": "0x38",
> +    "PerPkg": "1",
> +    "Unit": "DFPMC"
> +  }
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/amdzen1/recommended.json b/to=
ols/perf/pmu-events/arch/x86/amdzen1/recommended.json
> new file mode 100644
> index 000000000000..2cfe2d2f3bfd
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/x86/amdzen1/recommended.json
> @@ -0,0 +1,178 @@
> +[
> +  {
> +    "MetricName": "branch_misprediction_ratio",
> +    "BriefDescription": "Execution-Time Branch Misprediction Ratio (Non-=
Speculative)",
> +    "MetricExpr": "d_ratio(ex_ret_brn_misp, ex_ret_brn)",
> +    "MetricGroup": "branch_prediction",
> +    "ScaleUnit": "100%"
> +  },
> +  {
> +    "EventName": "all_dc_accesses",
> +    "EventCode": "0x29",
> +    "BriefDescription": "All L1 Data Cache Accesses",
> +    "UMask": "0x7"
> +  },
> +  {
> +    "MetricName": "all_l2_cache_accesses",
> +    "BriefDescription": "All L2 Cache Accesses",
> +    "MetricExpr": "l2_request_g1.all_no_prefetch + l2_pf_hit_l2 + l2_pf_=
miss_l2_hit_l3 + l2_pf_miss_l2_l3",
> +    "MetricGroup": "l2_cache"
> +  },
> +  {
> +    "EventName": "l2_cache_accesses_from_ic_misses",
> +    "EventCode": "0x60",
> +    "BriefDescription": "L2 Cache Accesses from L1 Instruction Cache Mis=
ses (including prefetch)",
> +    "UMask": "0x10"
> +  },
> +  {
> +    "EventName": "l2_cache_accesses_from_dc_misses",
> +    "EventCode": "0x60",
> +    "BriefDescription": "L2 Cache Accesses from L1 Data Cache Misses (in=
cluding prefetch)",
> +    "UMask": "0xc8"
> +  },
> +  {
> +    "MetricName": "l2_cache_accesses_from_l2_hwpf",
> +    "BriefDescription": "L2 Cache Accesses from L2 HWPF",
> +    "MetricExpr": "l2_pf_hit_l2 + l2_pf_miss_l2_hit_l3 + l2_pf_miss_l2_l=
3",
> +    "MetricGroup": "l2_cache"
> +  },
> +  {
> +    "MetricName": "all_l2_cache_misses",
> +    "BriefDescription": "All L2 Cache Misses",
> +    "MetricExpr": "l2_cache_req_stat.ic_dc_miss_in_l2 + l2_pf_miss_l2_hi=
t_l3 + l2_pf_miss_l2_l3",
> +    "MetricGroup": "l2_cache"
> +  },
> +  {
> +    "EventName": "l2_cache_misses_from_ic_miss",
> +    "EventCode": "0x64",
> +    "BriefDescription": "L2 Cache Misses from L1 Instruction Cache Misse=
s",
> +    "UMask": "0x01"
> +  },
> +  {
> +    "EventName": "l2_cache_misses_from_dc_misses",
> +    "EventCode": "0x64",
> +    "BriefDescription": "L2 Cache Misses from L1 Data Cache Misses",
> +    "UMask": "0x08"
> +  },
> +  {
> +    "MetricName": "l2_cache_misses_from_l2_hwpf",
> +    "BriefDescription": "L2 Cache Misses from L2 HWPF",
> +    "MetricExpr": "l2_pf_miss_l2_hit_l3 + l2_pf_miss_l2_l3",
> +    "MetricGroup": "l2_cache"
> +  },
> +  {
> +    "MetricName": "all_l2_cache_hits",
> +    "BriefDescription": "All L2 Cache Hits",
> +    "MetricExpr": "l2_cache_req_stat.ic_dc_hit_in_l2 + l2_pf_hit_l2",
> +    "MetricGroup": "l2_cache"
> +  },
> +  {
> +    "EventName": "l2_cache_hits_from_ic_misses",
> +    "EventCode": "0x64",
> +    "BriefDescription": "L2 Cache Hits from L1 Instruction Cache Misses"=
,
> +    "UMask": "0x06"
> +  },
> +  {
> +    "EventName": "l2_cache_hits_from_dc_misses",
> +    "EventCode": "0x64",
> +    "BriefDescription": "L2 Cache Hits from L1 Data Cache Misses",
> +    "UMask": "0x70"
> +  },
> +  {
> +    "MetricName": "l2_cache_hits_from_l2_hwpf",
> +    "BriefDescription": "L2 Cache Hits from L2 HWPF",
> +    "MetricExpr": "l2_pf_hit_l2 + l2_pf_miss_l2_hit_l3 + l2_pf_miss_l2_l=
3",
> +    "MetricGroup": "l2_cache"
> +  },
> +  {
> +    "EventName": "l3_accesses",
> +    "EventCode": "0x04",
> +    "BriefDescription": "L3 Accesses",
> +    "UMask": "0xff",
> +    "Unit": "L3PMC"
> +  },
> +  {
> +    "EventName": "l3_misses",
> +    "EventCode": "0x04",
> +    "BriefDescription": "L3 Misses (includes Chg2X)",

Would it be possible to add a slightly more expanded description of
what Chg2X means? I don't see it in the PPR either :-(

> +    "UMask": "0x01",
> +    "Unit": "L3PMC"
> +  },
> +  {
> +    "MetricName": "l3_read_miss_latency",
> +    "BriefDescription": "Average L3 Read Miss Latency (in core clocks)",
> +    "MetricExpr": "(xi_sys_fill_latency * 16) / xi_ccx_sdp_req1.all_l3_m=
iss_req_typs",
> +    "MetricGroup": "l3_cache",
> +    "ScaleUnit": "1core clocks"
> +  },
> +  {
> +    "MetricName": "ic_fetch_miss_ratio",
> +    "BriefDescription": "L1 Instruction Cache (32B) Fetch Miss Ratio",
> +    "MetricExpr": "d_ratio(l2_cache_req_stat.ic_access_in_l2, bp_l1_tlb_=
fetch_hit + bp_l1_tlb_miss_l2_hit + bp_l1_tlb_miss_l2_miss)",
> +    "MetricGroup": "l2_cache",
> +    "ScaleUnit": "100%"
> +  },
> +  {
> +    "MetricName": "l1_itlb_misses",
> +    "BriefDescription": "L1 ITLB Misses",
> +    "MetricExpr": "bp_l1_tlb_miss_l2_hit + bp_l1_tlb_miss_l2_miss",
> +    "MetricGroup": "tlb"
> +  },
> +  {
> +    "EventName": "l2_itlb_misses",
> +    "EventCode": "0x85",
> +    "BriefDescription": "L2 ITLB Misses & Instruction page walks",
> +    "UMask": "0x07"
> +  },
> +  {
> +    "EventName": "l1_dtlb_misses",
> +    "EventCode": "0x45",
> +    "BriefDescription": "L1 DTLB Misses",
> +    "UMask": "0xff"
> +  },
> +  {
> +    "EventName": "l2_dtlb_misses",
> +    "EventCode": "0x45",
> +    "BriefDescription": "L2 DTLB Misses & Data page walks",
> +    "UMask": "0xf0"
> +  },
> +  {
> +    "EventName": "all_tlbs_flushed",
> +    "EventCode": "0x78",
> +    "BriefDescription": "All TLBs Flushed",
> +    "UMask": "0xdf"
> +  },
> +  {
> +    "EventName": "uops_dispatched",
> +    "EventCode": "0xaa",
> +    "BriefDescription": "Micro-ops Dispatched",
> +    "UMask": "0x03"
> +  },
> +  {
> +    "EventName": "sse_avx_stalls",
> +    "EventCode": "0x0e",
> +    "BriefDescription": "Mixed SSE/AVX Stalls",
> +    "UMask": "0x0e"
> +  },
> +  {
> +    "EventName": "uops_retired",
> +    "EventCode": "0xc1",
> +    "BriefDescription": "Micro-ops Retired"
> +  },
> +  {
> +    "MetricName": "all_remote_links_outbound",
> +    "BriefDescription": "Approximate: Outbound data bytes for all Remote=
 Links for a node (die)",
> +    "MetricExpr": "remote_outbound_data_controller_0 + remote_outbound_d=
ata_controller_1 + remote_outbound_data_controller_2 + remote_outbound_data=
_controller_3",
> +    "MetricGroup": "data_fabric",
> +    "PerPkg": "1",
> +    "ScaleUnit": "3e-5MiB"
> +  },
> +  {
> +    "MetricName": "nps1_die_to_dram",
> +    "BriefDescription": "Approximate: Combined DRAM B/bytes of all chann=
els on a NPS1 node (die) (may need --metric-no-group)",
> +    "MetricExpr": "dram_channel_data_controller_0 + dram_channel_data_co=
ntroller_1 + dram_channel_data_controller_2 + dram_channel_data_controller_=
3 + dram_channel_data_controller_4 + dram_channel_data_controller_5 + dram_=
channel_data_controller_6 + dram_channel_data_controller_7",
> +    "MetricGroup": "data_fabric",
> +    "PerPkg": "1",
> +    "ScaleUnit": "6.1e-5MiB"
> +  }
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/amdzen2/cache.json b/tools/pe=
rf/pmu-events/arch/x86/amdzen2/cache.json
> index 1c60bfa0f00b..f61b982f83ca 100644
> --- a/tools/perf/pmu-events/arch/x86/amdzen2/cache.json
> +++ b/tools/perf/pmu-events/arch/x86/amdzen2/cache.json
> @@ -47,6 +47,11 @@
>      "BriefDescription": "Miscellaneous events covered in more detail by =
l2_request_g2 (PMCx061).",
>      "UMask": "0x1"
>    },
> +  {
> +    "EventName": "l2_request_g1.all_no_prefetch",
> +    "EventCode": "0x60",
> +    "UMask": "0xf9"
> +  },

Possible BriefDescription?

>    {
>      "EventName": "l2_request_g2.group1",
>      "EventCode": "0x61",
> @@ -173,6 +178,24 @@
>      "BriefDescription": "Core to L2 cacheable request access status (not=
 including L2 Prefetch). Instruction cache request miss in L2.",
>      "UMask": "0x1"
>    },
> +  {
> +    "EventName": "l2_cache_req_stat.ic_access_in_l2",
> +    "EventCode": "0x64",
> +    "BriefDescription": "Core to L2 cacheable request access status (not=
 including L2 Prefetch). Instruction cache requests in L2.",
> +    "UMask": "0x7"
> +  },
> +  {
> +    "EventName": "l2_cache_req_stat.ic_dc_miss_in_l2",
> +    "EventCode": "0x64",
> +    "BriefDescription": "Core to L2 cacheable request access status (not=
 including L2 Prefetch). Instruction cache request miss in L2 and Data cach=
e request miss in L2 (all types).",
> +    "UMask": "0x9"
> +  },
> +  {
> +    "EventName": "l2_cache_req_stat.ic_dc_hit_in_l2",
> +    "EventCode": "0x64",
> +    "BriefDescription": "Core to L2 cacheable request access status (not=
 including L2 Prefetch). Instruction cache request hit in L2 and Data cache=
 request hit in L2 (all types).",
> +    "UMask": "0xf6"
> +  },
>    {
>      "EventName": "l2_fill_pending.l2_fill_busy",
>      "EventCode": "0x6d",
> diff --git a/tools/perf/pmu-events/arch/x86/amdzen2/data-fabric.json b/to=
ols/perf/pmu-events/arch/x86/amdzen2/data-fabric.json
> new file mode 100644
> index 000000000000..40271df40015
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/x86/amdzen2/data-fabric.json
> @@ -0,0 +1,98 @@
> +[
> +  {
> +    "EventName": "remote_outbound_data_controller_0",
> +    "PublicDescription": "Remote Link Controller Outbound Packet Types: =
Data (32B): Remote Link Controller 0",
> +    "EventCode": "0x7c7",
> +    "UMask": "0x02",
> +    "PerPkg": "1",
> +    "Unit": "DFPMC"
> +  },
> +  {
> +    "EventName": "remote_outbound_data_controller_1",
> +    "PublicDescription": "Remote Link Controller Outbound Packet Types: =
Data (32B): Remote Link Controller 1",
> +    "EventCode": "0x807",
> +    "UMask": "0x02",
> +    "PerPkg": "1",
> +    "Unit": "DFPMC"
> +  },
> +  {
> +    "EventName": "remote_outbound_data_controller_2",
> +    "PublicDescription": "Remote Link Controller Outbound Packet Types: =
Data (32B): Remote Link Controller 2",
> +    "EventCode": "0x847",
> +    "UMask": "0x02",
> +    "PerPkg": "1",
> +    "Unit": "DFPMC"
> +  },
> +  {
> +    "EventName": "remote_outbound_data_controller_3",
> +    "PublicDescription": "Remote Link Controller Outbound Packet Types: =
Data (32B): Remote Link Controller 3",
> +    "EventCode": "0x887",
> +    "UMask": "0x02",
> +    "PerPkg": "1",
> +    "Unit": "DFPMC"
> +  },
> +  {
> +    "EventName": "dram_channel_data_controller_0",
> +    "PublicDescription": "DRAM Channel Controller Request Types: Request=
s with Data (64B): DRAM Channel Controller 0",
> +    "EventCode": "0x07",
> +    "UMask": "0x38",
> +    "PerPkg": "1",
> +    "Unit": "DFPMC"
> +  },
> +  {
> +    "EventName": "dram_channel_data_controller_1",
> +    "PublicDescription": "DRAM Channel Controller Request Types: Request=
s with Data (64B): DRAM Channel Controller 0",
> +    "EventCode": "0x47",
> +    "UMask": "0x38",
> +    "PerPkg": "1",
> +    "Unit": "DFPMC"
> +  },
> +  {
> +    "EventName": "dram_channel_data_controller_2",
> +    "PublicDescription": "DRAM Channel Controller Request Types: Request=
s with Data (64B): DRAM Channel Controller 0",
> +    "EventCode": "0x87",
> +    "UMask": "0x38",
> +    "PerPkg": "1",
> +    "Unit": "DFPMC"
> +  },
> +  {
> +    "EventName": "dram_channel_data_controller_3",
> +    "PublicDescription": "DRAM Channel Controller Request Types: Request=
s with Data (64B): DRAM Channel Controller 0",
> +    "EventCode": "0xc7",
> +    "UMask": "0x38",
> +    "PerPkg": "1",
> +    "Unit": "DFPMC"
> +  },
> +  {
> +    "EventName": "dram_channel_data_controller_4",
> +    "PublicDescription": "DRAM Channel Controller Request Types: Request=
s with Data (64B): DRAM Channel Controller 0",
> +    "EventCode": "0x107",
> +    "UMask": "0x38",
> +    "PerPkg": "1",
> +    "Unit": "DFPMC"
> +  },
> +  {
> +    "EventName": "dram_channel_data_controller_5",
> +    "PublicDescription": "DRAM Channel Controller Request Types: Request=
s with Data (64B): DRAM Channel Controller 0",
> +    "EventCode": "0x147",
> +    "UMask": "0x38",
> +    "PerPkg": "1",
> +    "Unit": "DFPMC"
> +  },
> +  {
> +    "EventName": "dram_channel_data_controller_6",
> +    "PublicDescription": "DRAM Channel Controller Request Types: Request=
s with Data (64B): DRAM Channel Controller 0",
> +    "EventCode": "0x187",
> +    "UMask": "0x38",
> +    "PerPkg": "1",
> +    "Unit": "DFPMC"
> +  },
> +  {
> +    "EventName": "dram_channel_data_controller_7",
> +    "PublicDescription": "DRAM Channel Controller Request Types: Request=
s with Data (64B): DRAM Channel Controller 0",
> +    "EventCode": "0x1c7",
> +    "UMask": "0x38",
> +    "PerPkg": "1",
> +    "Unit": "DFPMC"
> +  }
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/amdzen2/recommended.json b/to=
ols/perf/pmu-events/arch/x86/amdzen2/recommended.json
> new file mode 100644
> index 000000000000..2ef91e25e661
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/x86/amdzen2/recommended.json
> @@ -0,0 +1,178 @@
> +[
> +  {
> +    "MetricName": "branch_misprediction_ratio",
> +    "BriefDescription": "Execution-Time Branch Misprediction Ratio (Non-=
Speculative)",
> +    "MetricExpr": "d_ratio(ex_ret_brn_misp, ex_ret_brn)",
> +    "MetricGroup": "branch_prediction",
> +    "ScaleUnit": "100%"
> +  },
> +  {
> +    "EventName": "all_dc_accesses",
> +    "EventCode": "0x29",
> +    "BriefDescription": "All L1 Data Cache Accesses",
> +    "UMask": "0x7"
> +  },
> +  {
> +    "MetricName": "all_l2_cache_accesses",
> +    "BriefDescription": "All L2 Cache Accesses",
> +    "MetricExpr": "l2_request_g1.all_no_prefetch + l2_pf_hit_l2 + l2_pf_=
miss_l2_hit_l3 + l2_pf_miss_l2_l3",
> +    "MetricGroup": "l2_cache"
> +  },
> +  {
> +    "EventName": "l2_cache_accesses_from_ic_misses",
> +    "EventCode": "0x60",
> +    "BriefDescription": "L2 Cache Accesses from L1 Instruction Cache Mis=
ses (including prefetch)",
> +    "UMask": "0x10"
> +  },
> +  {
> +    "EventName": "l2_cache_accesses_from_dc_misses",
> +    "EventCode": "0x60",
> +    "BriefDescription": "L2 Cache Accesses from L1 Data Cache Misses (in=
cluding prefetch)",
> +    "UMask": "0xc8"
> +  },
> +  {
> +    "MetricName": "l2_cache_accesses_from_l2_hwpf",
> +    "BriefDescription": "L2 Cache Accesses from L2 HWPF",
> +    "MetricExpr": "l2_pf_hit_l2 + l2_pf_miss_l2_hit_l3 + l2_pf_miss_l2_l=
3",
> +    "MetricGroup": "l2_cache"
> +  },
> +  {
> +    "MetricName": "all_l2_cache_misses",
> +    "BriefDescription": "All L2 Cache Misses",
> +    "MetricExpr": "l2_cache_req_stat.ic_dc_miss_in_l2 + l2_pf_miss_l2_hi=
t_l3 + l2_pf_miss_l2_l3",
> +    "MetricGroup": "l2_cache"
> +  },
> +  {
> +    "EventName": "l2_cache_misses_from_ic_miss",
> +    "EventCode": "0x64",
> +    "BriefDescription": "L2 Cache Misses from L1 Instruction Cache Misse=
s",
> +    "UMask": "0x01"
> +  },
> +  {
> +    "EventName": "l2_cache_misses_from_dc_misses",
> +    "EventCode": "0x64",
> +    "BriefDescription": "L2 Cache Misses from L1 Data Cache Misses",
> +    "UMask": "0x08"
> +  },
> +  {
> +    "MetricName": "l2_cache_misses_from_l2_hwpf",
> +    "BriefDescription": "L2 Cache Misses from L2 HWPF",
> +    "MetricExpr": "l2_pf_miss_l2_hit_l3 + l2_pf_miss_l2_l3",
> +    "MetricGroup": "l2_cache"
> +  },
> +  {
> +    "MetricName": "all_l2_cache_hits",
> +    "BriefDescription": "All L2 Cache Hits",
> +    "MetricExpr": "l2_cache_req_stat.ic_dc_hit_in_l2 + l2_pf_hit_l2",
> +    "MetricGroup": "l2_cache"
> +  },
> +  {
> +    "EventName": "l2_cache_hits_from_ic_misses",
> +    "EventCode": "0x64",
> +    "BriefDescription": "L2 Cache Hits from L1 Instruction Cache Misses"=
,
> +    "UMask": "0x06"
> +  },
> +  {
> +    "EventName": "l2_cache_hits_from_dc_misses",
> +    "EventCode": "0x64",
> +    "BriefDescription": "L2 Cache Hits from L1 Data Cache Misses",
> +    "UMask": "0x70"
> +  },
> +  {
> +    "MetricName": "l2_cache_hits_from_l2_hwpf",
> +    "BriefDescription": "L2 Cache Hits from L2 HWPF",
> +    "MetricExpr": "l2_pf_hit_l2 + l2_pf_miss_l2_hit_l3 + l2_pf_miss_l2_l=
3",
> +    "MetricGroup": "l2_cache"
> +  },
> +  {
> +    "EventName": "l3_accesses",
> +    "EventCode": "0x04",
> +    "BriefDescription": "L3 Accesses",
> +    "UMask": "0xff",
> +    "Unit": "L3PMC"
> +  },
> +  {
> +    "EventName": "l3_misses",
> +    "EventCode": "0x04",
> +    "BriefDescription": "L3 Misses (includes Chg2X)",
> +    "UMask": "0x01",
> +    "Unit": "L3PMC"
> +  },
> +  {
> +    "MetricName": "l3_read_miss_latency",
> +    "BriefDescription": "Average L3 Read Miss Latency (in core clocks)",
> +    "MetricExpr": "(xi_sys_fill_latency * 16) / xi_ccx_sdp_req1.all_l3_m=
iss_req_typs",
> +    "MetricGroup": "l3_cache",
> +    "ScaleUnit": "1core clocks"
> +  },
> +  {
> +    "MetricName": "ic_fetch_miss_ratio",
> +    "BriefDescription": "L1 Instruction Cache (32B) Fetch Miss Ratio",
> +    "MetricExpr": "d_ratio(l2_cache_req_stat.ic_access_in_l2, bp_l1_tlb_=
fetch_hit + bp_l1_tlb_miss_l2_hit + bp_l1_tlb_miss_l2_tlb_miss)",
> +    "MetricGroup": "l2_cache",
> +    "ScaleUnit": "100%"
> +  },
> +  {
> +    "MetricName": "l1_itlb_misses",
> +    "BriefDescription": "L1 ITLB Misses",
> +    "MetricExpr": "bp_l1_tlb_miss_l2_hit + bp_l1_tlb_miss_l2_tlb_miss",
> +    "MetricGroup": "tlb"
> +  },
> +  {
> +    "EventName": "l2_itlb_misses",
> +    "EventCode": "0x85",
> +    "BriefDescription": "L2 ITLB Misses & Instruction page walks",
> +    "UMask": "0x07"
> +  },
> +  {
> +    "EventName": "l1_dtlb_misses",
> +    "EventCode": "0x45",
> +    "BriefDescription": "L1 DTLB Misses",
> +    "UMask": "0xff"
> +  },
> +  {
> +    "EventName": "l2_dtlb_misses",
> +    "EventCode": "0x45",
> +    "BriefDescription": "L2 DTLB Misses & Data page walks",
> +    "UMask": "0xf0"
> +  },
> +  {
> +    "EventName": "all_tlbs_flushed",
> +    "EventCode": "0x78",
> +    "BriefDescription": "All TLBs Flushed",
> +    "UMask": "0xdf"
> +  },
> +  {
> +    "EventName": "uops_dispatched",
> +    "EventCode": "0xaa",
> +    "BriefDescription": "Micro-ops Dispatched",
> +    "UMask": "0x03"
> +  },
> +  {
> +    "EventName": "sse_avx_stalls",
> +    "EventCode": "0x0e",
> +    "BriefDescription": "Mixed SSE/AVX Stalls",
> +    "UMask": "0x0e"
> +  },
> +  {
> +    "EventName": "uops_retired",
> +    "EventCode": "0xc1",
> +    "BriefDescription": "Micro-ops Retired"
> +  },
> +  {
> +    "MetricName": "all_remote_links_outbound",
> +    "BriefDescription": "Approximate: Outbound data bytes for all Remote=
 Links for a node (die)",
> +    "MetricExpr": "remote_outbound_data_controller_0 + remote_outbound_d=
ata_controller_1 + remote_outbound_data_controller_2 + remote_outbound_data=
_controller_3",
> +    "MetricGroup": "data_fabric",
> +    "PerPkg": "1",
> +    "ScaleUnit": "3e-5MiB"
> +  },
> +  {
> +    "MetricName": "nps1_die_to_dram",
> +    "BriefDescription": "Approximate: Combined DRAM B/bytes of all chann=
els on a NPS1 node (die) (may need --metric-no-group)",
> +    "MetricExpr": "dram_channel_data_controller_0 + dram_channel_data_co=
ntroller_1 + dram_channel_data_controller_2 + dram_channel_data_controller_=
3 + dram_channel_data_controller_4 + dram_channel_data_controller_5 + dram_=
channel_data_controller_6 + dram_channel_data_controller_7",
> +    "MetricGroup": "data_fabric",
> +    "PerPkg": "1",
> +    "ScaleUnit": "6.1e-5MiB"
> +  }
> +]
> diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jeve=
nts.c
> index fa86c5f997cc..5984906b6893 100644
> --- a/tools/perf/pmu-events/jevents.c
> +++ b/tools/perf/pmu-events/jevents.c
> @@ -240,6 +240,7 @@ static struct map {
>         { "hisi_sccl,hha", "hisi_sccl,hha" },
>         { "hisi_sccl,l3c", "hisi_sccl,l3c" },
>         { "L3PMC", "amd_l3" },
> +       { "DFPMC", "amd_df" },
>         {}
>  };
>
> --
> 2.27.0
>
