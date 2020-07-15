Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0067C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 16:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8ADFE2065E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 16:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TPcNI+yE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbgGOQb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 12:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbgGOQb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 12:31:28 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19386C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 09:31:28 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z13so3383616wrw.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 09:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HR86dtd69KxS8U5z7Eh67ZbzR9hjXJRAZgL6KZAW0g0=;
        b=TPcNI+yEKzMqIgrrareTRt4MvTwnIGlgTKAnFdP4TsDKZ7MOVwibtqy/t5J7XD6Pfn
         Nfq3mvK4Mh5jtQx7D4XXaBRUmr5c80bJ3pekWEMY7wkkPLNO+tvQIyuAq8lk5bGXWGzy
         f68Iao1ZBCUH9Pu5YBEpzA4VBlN9SOz6bX94l49ycLHqIjFihkR9c3/aYoaU9LAquVWo
         5wROvDaRNqyV40NSOOEIyM6kjtRl++kKGC0An9loLa/XSM1eFmRhXIIunwOwq9S2/E0O
         IiBXQ4DnzHFw1v9DBbj+6bZj/nUzywjB4ubl0x/KNPxiBaNETGoS4bAZ6K/Cx+0/cM/j
         ZSRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HR86dtd69KxS8U5z7Eh67ZbzR9hjXJRAZgL6KZAW0g0=;
        b=DnNCon7pBsPFA65CuTv/MSTVuMovh2e1oMc/eNIuB/devuSexa+7N8WXLgPpxMMP1X
         6RJlu+4/FZdDIpYNxh6CKOwLcqZiTRkpRm8OhkiPoCfWGw8s+RIynx52aOC+Kfudtd6e
         74ZSwF2exC/JqnkgYehkH4Yocxh+M3iILGxRJdHy7lU/+f4nRTFKkE5SvjOwTBVBm9wM
         3cCQFmMfX6EO/8Ex9I3l2TBYCFw8PqXiuegDKp5RzCKzQlYUNp41i5DatCLiBww8kA3h
         lkBE0MNuYrZgIA9mlfpGaTNNnnUQ6d7Gf6ReWaZumQRFOEaShYWOf7xjm4YX4w8979Gu
         ZIgw==
X-Gm-Message-State: AOAM530E6I5SUcsbzomgFjBNyXdO8pMjUO5JLVaBGzsfHl4zy6k8nwae
        Zu9ikVmaGoJQ0sor4yffI6J0hcgTee5H0LU0sf0fSQ==
X-Google-Smtp-Source: ABdhPJxuro4/NbgOc/TLRc0mVw5pRIq4w1ip/4/RcpD+99LsLWJ/9hDTEwuSXXaVbGTVa3TeGNFLn2Tm8AL4/szaX+M=
X-Received: by 2002:a5d:4bd2:: with SMTP id l18mr182700wrt.119.1594830686491;
 Wed, 15 Jul 2020 09:31:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200715023401.23988-1-leo.yan@linaro.org>
In-Reply-To: <20200715023401.23988-1-leo.yan@linaro.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 15 Jul 2020 09:31:14 -0700
Message-ID: <CAP-5=fVaLA8C5Cd=jLR1TeCe9ktF5eqMmE++Wb4JHmJxrcfsJg@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] Perf tool: Enable Arm arch timer counter and
 arm-spe's timestamp
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kemeng Shi <shikemeng@huawei.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Igor Lubashev <ilubashe@akamai.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 7:34 PM Leo Yan <leo.yan@linaro.org> wrote:
>
> This patch set is to enable Arm arch timer counter and Arm SPE is the
> first customer to use arch timer counter for its timestamp.
>
> The patch 01 is to retrieve arch timer's parameters from mmaped page;
> patch 02 provides APIs for the conversion between arch timer's counter
> and time; patch 03 is to enable timestamp based on the new introduced
> APIs for timestamp related calculation.
>
> Note, this patch set is depend on the kernel changes for "arm64: perf:
> Proper cap_user_time* support" [1].
>
> This patch set has been rebased on mainline kernel with the latest
> commit 11ba468877bb ("Linux 5.8-rc5") and also applied on top of patch
> set [1].  After enabling the timestamp, the samples can show the
> timestamp, and the timestamp is consistent with the kernel's timestamp
> by checking the kernel log:
>
>   $ perf script -F,+time
>     dd  6799 [034] 25496.733475:          1              l1d-access:      ffff87f37b88 _dl_start+0x288 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
>     dd  6799 [034] 25496.733475:          1              tlb-access:      ffff87f37b88 _dl_start+0x288 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
>     dd  6799 [034] 25496.733479:          1              l1d-access:      ffff87f37c74 _dl_start+0x374 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
>     dd  6799 [034] 25496.733479:          1              tlb-access:      ffff87f37c74 _dl_start+0x374 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
>     dd  6799 [034] 25496.733485:          1              l1d-access:      ffff87f49af4 __GI___tunables_init+0x3c (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
>     dd  6799 [034] 25496.733485:          1              tlb-access:      ffff87f49af4 __GI___tunables_init+0x3c (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
>
> [1] https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=318401

This looks good to me! Would it be possible to add a test on the
functionality? It's possible to add a C test in
tools/perf/arch/arm64/tests or something related to you perf script
command line in tools/perf/tests/shell.

Thanks,
Ian

> Leo Yan (3):
>   perf tools: Support Arm arch timer counter
>   perf arm_arch_timer: Convert between counter and timestamp
>   perf arm-spe: Enable timestamp with arch timer counter
>
>  tools/perf/arch/arm64/util/Build        |  1 +
>  tools/perf/arch/arm64/util/arch_timer.c | 50 +++++++++++++++++++++++++
>  tools/perf/arch/arm64/util/arm-spe.c    | 17 +++++++++
>  tools/perf/util/Build                   |  1 +
>  tools/perf/util/arm-spe.c               | 16 +++++++-
>  tools/perf/util/arm-spe.h               |  5 +++
>  tools/perf/util/arm_arch_timer.c        | 28 ++++++++++++++
>  tools/perf/util/arm_arch_timer.h        | 23 ++++++++++++
>  8 files changed, 139 insertions(+), 2 deletions(-)
>  create mode 100644 tools/perf/arch/arm64/util/arch_timer.c
>  create mode 100644 tools/perf/util/arm_arch_timer.c
>  create mode 100644 tools/perf/util/arm_arch_timer.h
>
> --
> 2.17.1
>
