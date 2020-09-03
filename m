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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C9EC433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 06:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D87E20737
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 06:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GvhrioFC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbgICGUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 02:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgICGUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 02:20:33 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1590C061245
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 23:20:32 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x14so1768509wrl.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 23:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gseZPcqoBbLe7l5elm4wrxZ03UY9w4oxVD0+wOSRBi8=;
        b=GvhrioFC/awnqePyL7OWLgI483TwDUh4pNXzhGp5DlUzClcKmo8oJ0G1EwE+2MGr6W
         fA5P64lBpveVDojBagqnwkH+Z97tezsEsP5fIIKPDDpK6Viz8EIQE4RooPa43rl8wbnS
         qgBPn1Ho4X7witnmB2CIBN0HknNn0ArV87UDLBR4kKWaWha7ZQeW/hsiZUXf4SuK7SJH
         rEfa95R2OHQSQ/RHQ/0zylP0CujV3XBFIRx7AIk+4hwXUwEV0qYOZe/KJb4YTW5l+hZv
         pDIRO6YS7lZhSJYWzi9m+8xlP9RGV61yFMojonH3CCrea3gHH4aF2AyTLtDEjSkB5aMQ
         7v7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gseZPcqoBbLe7l5elm4wrxZ03UY9w4oxVD0+wOSRBi8=;
        b=GbCdxGuhwHAXykRZvrY6zQCgsA72+NyJXtg1O/xAbjJR6DIVjb2aQUiHa0tuZYtxLP
         wad+f7U7GLKChXryBLIAVXbB3tB73RhLgG0nfwnW189Wv3g1zp0f0w56Z4j4YN0cQhOy
         L5JRMvRJCN28dHi0csHimdhePWJYJWOaynarv2SmMbIL7slcGj6QG2Kg80pRmZN0uysj
         SeCK0443FTiX2OdyYN+OBHKyUfcDzIjOeJFNLQoMxP0D9r1PdPuTJVxavVvsP4DS6Qik
         LBEpPItVHinHOgR+T5hmSZFhj3E1Hxu6TbssNGXEuOi31yomKum3KlMNZYtGGIg4+0G3
         9vBw==
X-Gm-Message-State: AOAM5325L1r5UFzc98d+QWPA/EiNOA5khXtmEhsuVxvkP5V7F5MGRwnR
        DxPnEx2fvTl9rXRld/PTb3y2on6IXG/0i2wkdvwAxw==
X-Google-Smtp-Source: ABdhPJyR9aGl8LR5njA7HO16prUYKakIULmUdV3AvyPWL2IkgrYewVU2UUtOdY/sLd4ZetJ5JhIn6NfHkvP74YCT+Vk=
X-Received: by 2002:adf:fb01:: with SMTP id c1mr546671wrr.119.1599114031437;
 Wed, 02 Sep 2020 23:20:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200901220944.277505-1-kim.phillips@amd.com> <20200901220944.277505-4-kim.phillips@amd.com>
In-Reply-To: <20200901220944.277505-4-kim.phillips@amd.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 2 Sep 2020 23:20:20 -0700
Message-ID: <CAP-5=fXs6WJoJ5HTkkgXVx=TR6=G1VaP6kcZHhf4Zq9Nhxb4Xw@mail.gmail.com>
Subject: Re: [PATCH 4/4] perf vendor events amd: Enable Family 19h users by
 matching Zen2 events
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
> This enables zen3 users by reusing mostly-compatible zen2 events
> until the official public list of zen3 events is published in a
> future PPR.
>
> Signed-off-by: Kim Phillips <kim.phillips@amd.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks!
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
>  tools/perf/pmu-events/arch/x86/mapfile.csv | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-=
events/arch/x86/mapfile.csv
> index 25b06cf98747..2f2a209e87e1 100644
> --- a/tools/perf/pmu-events/arch/x86/mapfile.csv
> +++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
> @@ -38,3 +38,4 @@ GenuineIntel-6-7E,v1,icelake,core
>  GenuineIntel-6-86,v1,tremontx,core
>  AuthenticAMD-23-([12][0-9A-F]|[0-9A-F]),v2,amdzen1,core
>  AuthenticAMD-23-[[:xdigit:]]+,v1,amdzen2,core
> +AuthenticAMD-25-[[:xdigit:]]+,v1,amdzen2,core
> --
> 2.27.0
>
