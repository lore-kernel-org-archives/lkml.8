Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D601FC433E7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 06:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BE6B2071B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 06:03:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AeLgDdt/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgICGDy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 02:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbgICGDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 02:03:53 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03728C061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 23:03:51 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id a65so1553026wme.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 23:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vQb9UDrXDqmSt0Xa8o84FeHNgBwYVnlnU7l9z6zb3qU=;
        b=AeLgDdt/3nlyvF+odGDbNH/XlQV2nX0bj7UBbAr8dsT+MdwfZg0xJY2TMdeLSp4dlO
         FMvHbYP68ATzuhvoUe9g1UEJToETqhlsdxjZ7lREQ413DPKUGjoNWd98jQKfJwKW4Iwm
         Hbr235AK3foS+jwNONwZcRVKdPK3++SaB4PSlfuNIdfMTvdBDdDg9/oIvZ7cg+72Bb7C
         LhrS7RGPaDhLCZwKkmFCOSiGOxUrCGnMabtmFZ08Yxzidizi9GDTwFFnjPkKNt4Kg5qD
         dZuhmWg8QKYdm7XUmJuyG41QbpGoHt/R5EltVhKEFgQ3bCQtFlF5atT8SKGJhEJY802y
         qKag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vQb9UDrXDqmSt0Xa8o84FeHNgBwYVnlnU7l9z6zb3qU=;
        b=G3ilN/YOi9vGn4wxZfNEXJ9dVk4NsfAzi/oxQPncStpf2uybIGBY1w1VVuUH5Mf63e
         ++3cg6OOST/Q6lOkOQHU5TI4Kw8L1rhxIwJLRL9kTI3gqRewR/DbJK/sLYW6GGrFG4E6
         fN3q4Urwr4l1kURxZ/mDa9slNtep8K2qqEx/DIglk96DRNznVjfjwOwRS7AQ0LJ7hKT2
         8aOTAjl2A/iXqww+ct1JWT9jGaJSlwCRkDBBWIi3nqAHdxjnq8sjSNXBgef1FsgJR6g9
         iI5pw6UD3pHX5gF32Bf9fuKeiAqZC2Z+1o1Vi3usKoqHOQO/euMwM/glNXRbMPhOGzIw
         vgRg==
X-Gm-Message-State: AOAM530lkB2iEWcM4NtA7WZzQfLE9sBSQmLrNJuaEehYTnj1qfnKVX2L
        QzVU8t+t3iH1wsBLOIu98jJiFDjaWOVrJZWAWNJ4OQ==
X-Google-Smtp-Source: ABdhPJy51NqQuudOM/K4olxt128gBiT7Xt0ZGTV03oBdMoz+KUOv2GJvcWGklS5K8C9Ak388IuKhBoRTciOCb5yA5SM=
X-Received: by 2002:a1c:7314:: with SMTP id d20mr584145wmb.76.1599113030133;
 Wed, 02 Sep 2020 23:03:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200901220944.277505-1-kim.phillips@amd.com> <20200901220944.277505-2-kim.phillips@amd.com>
In-Reply-To: <20200901220944.277505-2-kim.phillips@amd.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 2 Sep 2020 23:03:38 -0700
Message-ID: <CAP-5=fW84gvGr+RxovDrFaRozHEY-_9mV2K-_bG04pmg8SJGvw@mail.gmail.com>
Subject: Re: [PATCH 2/4] perf vendor events amd: Add ITLB Instruction Fetch
 Hits event for zen1
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
> The ITLB Instruction Fetch Hits event isn't documented even in
> later zen1 PPRs, but it seems to count correctly on zen1 hardware.
>
> Add it to zen1 group so zen1 users can use the upcoming IC Fetch Miss
> Ratio Metric.
>
> The IF1G, 1IF2M, IF4K (Instruction fetches to a 1 GB, 2 MB, and 4K page)
> unit masks are not added because unlike zen2 hardware, zen1 hardware
> counts all its unit masks with a 0 unit mask according to the old
> convention:
>
> zen1$ perf stat -e cpu/event=3D0x94/,cpu/event=3D0x94,umask=3D0xff/ sleep=
 1
>
>  Performance counter stats for 'sleep 1':
>
>            211,318      cpu/event=3D0x94/u
>            211,318      cpu/event=3D0x94,umask=3D0xff/u
>
> Rome/zen2:
>
> zen2$ perf stat -e cpu/event=3D0x94/,cpu/event=3D0x94,umask=3D0xff/ sleep=
 1
>
>  Performance counter stats for 'sleep 1':
>
>                  0      cpu/event=3D0x94/u
>            190,744      cpu/event=3D0x94,umask=3D0xff/u
>
> Signed-off-by: Kim Phillips <kim.phillips@amd.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

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
>  tools/perf/pmu-events/arch/x86/amdzen1/branch.json | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/tools/perf/pmu-events/arch/x86/amdzen1/branch.json b/tools/p=
erf/pmu-events/arch/x86/amdzen1/branch.json
> index a9943eeb8d6b..4ceb67a0db21 100644
> --- a/tools/perf/pmu-events/arch/x86/amdzen1/branch.json
> +++ b/tools/perf/pmu-events/arch/x86/amdzen1/branch.json
> @@ -19,5 +19,10 @@
>      "EventName": "bp_de_redirect",
>      "EventCode": "0x91",
>      "BriefDescription": "Decoder Overrides Existing Branch Prediction (s=
peculative)."
> +  },
> +  {
> +    "EventName": "bp_l1_tlb_fetch_hit",
> +    "EventCode": "0x94",
> +    "BriefDescription": "The number of instruction fetches that hit in t=
he L1 ITLB."
>    }
>  ]
> --
> 2.27.0
>
