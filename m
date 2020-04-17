Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D99C2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 15:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAC0C20644
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 15:13:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NjjjSCS8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbgDQPNe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 11:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728411AbgDQPNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 11:13:33 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB65AC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 08:13:32 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id g6so1186144ybh.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 08:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RtVmmjrP6HO9dhoYxX3s6oFRIAVH6KdXNjgWOgECeoM=;
        b=NjjjSCS8rScnBa/489Zt16Y6KM916Eq1Fnm8cMzBT2SxIqXOY8mnPZ+7qPMwfwITPr
         lz6CS9DVXf4dAFkRTrUVB2jddZfjpU7Qa7qtbg6WurYf++g2PmmK8P53bkX7yMeXoJk2
         xWa/AOS7Ok0Vfe2pmmAYQj1bsdXJ9XJRoZFbTCmNe0HJjO+wK9zZioBqPb1eE6Y5/BsR
         NFiC1pbkfINWBvnEh1fz0VJ/fRWO6ZliXb/7cG9JE0M4pXFm4xBCstV2jbD25uDttrvy
         epVUz+4y/1tevJ40dxkQE/M8cR9xZa+Ajod9wxHRxwWiuD8faV+MWMOgL3JGSOE3XJDI
         8VGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RtVmmjrP6HO9dhoYxX3s6oFRIAVH6KdXNjgWOgECeoM=;
        b=mByd3UI2u3aBaQNZY6liQ006Nh6v1yyRYja8VXjo7DRNccJ9cxqFxMRFM30SEM77ew
         Msdyqjj8RNU8qzYrpGq/KAhj5MrKkfBMEN/lVqiVEhzVp+R+pdqUhjqOavgIwZB3taF6
         zHtR+620iJszudFpdg9MwWshcSv6uMT+3v0vCvc7BpLTJqt/oyn/g+l7TZkuznABGSK8
         3n37PM35svvfBD4K5sGgI6mgfWZ1ojMr0bbjCDZIlFaBErhblhtcNQowqQtTYwlMa/g8
         dbtmGAL6K3knP0RJK+doVTMNZcPOKccDPYTTY20wcrqDhV34lQPLKU37yIAjyAm5AGsM
         Udpw==
X-Gm-Message-State: AGi0PuYIL3BhrWhLLGEq8h6rOMpQ+/AcOMlwQF3YqydOs202BstrBAZq
        fqmdHmjW3l4z/RigKBFf9BWyuR6zNuJO1bhdY4rRzQ==
X-Google-Smtp-Source: APiQypIdimcl/fK+LqHBMfTOxl3lLnAoIALiISIKuQMaY9pG55zJR5bjJgpyQnKGWfE1VAJwilD9WoZ9wzYei6/Llic=
X-Received: by 2002:a05:6902:505:: with SMTP id x5mr6584279ybs.286.1587136411058;
 Fri, 17 Apr 2020 08:13:31 -0700 (PDT)
MIME-Version: 1.0
References: <1587120084-18990-1-git-send-email-john.garry@huawei.com> <1587120084-18990-6-git-send-email-john.garry@huawei.com>
In-Reply-To: <1587120084-18990-6-git-send-email-john.garry@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 17 Apr 2020 08:13:19 -0700
Message-ID: <CAP-5=fX0yt73ASQm-XD0Nqj8yNn=UhiaBr9T808ot=66SjSg6w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 05/13] perf vendor events arm64: Add Architected
 events smmuv3-pmcg.json
To:     John Garry <john.garry@huawei.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, will@kernel.org,
        Andi Kleen <ak@linux.intel.com>, linuxarm@huawei.com,
        LKML <linux-kernel@vger.kernel.org>, qiangqing.zhang@nxp.com,
        robin.murphy@arm.com, zhangshaokun@hisilicon.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 3:45 AM John Garry <john.garry@huawei.com> wrote:
>
> Add JSON for Architected events from [0], Section 10.3 .
>
> [0] https://static.docs.arm.com/ihi0070/a/IHI_0070A_SMMUv3.pdf
>
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  tools/perf/pmu-events/arch/arm64/smmuv3-pmcg.json | 58 +++++++++++++++++++++++
>  tools/perf/pmu-events/jevents.c                   |  2 +
>  2 files changed, 60 insertions(+)
>  create mode 100644 tools/perf/pmu-events/arch/arm64/smmuv3-pmcg.json
>
> diff --git a/tools/perf/pmu-events/arch/arm64/smmuv3-pmcg.json b/tools/perf/pmu-events/arch/arm64/smmuv3-pmcg.json
> new file mode 100644
> index 000000000000..7ceb2b4372fa
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/smmuv3-pmcg.json
> @@ -0,0 +1,58 @@
> +[
> +    {
> +        "PublicDescription": "Clock cycles",
> +        "EventCode": "0x00",
> +        "EventName": "smmuv3_pmcg.CYCLES",
> +        "BriefDescription": "Clock cycles"
> +        "Unit": "smmuv3_pmcg",
> +    },
> +    {
> +        "PublicDescription": "Transaction",
> +        "EventCode": "0x01",
> +        "EventName": "smmuv3_pmcg.TRANSACTION",
> +        "BriefDescription": "Transaction"
> +        "Unit": "smmuv3_pmcg",
> +    },
> +    {
> +        "PublicDescription": "TLB miss caused by incomingtransaction or (ATS or non-ATS) translation request",

It looks like a space was missed in "incomingtransaction".

> +        "EventCode": "0x02",
> +        "EventName": "smmuv3_pmcg.TLB_MISS",
> +        "BriefDescription": "TLB miss caused by incomingtransaction or (ATS or non-ATS) translation request"

And here.

Thanks,
Ian

> +        "Unit": "smmuv3_pmcg",
> +    },
> +    {
> +        "PublicDescription": "Configuration cache miss caused by transaction or(ATS or non-ATS)translation request",
> +        "EventCode": "0x03",
> +        "EventName": "smmuv3_pmcg.CONFIG_CACHE_MISS",
> +        "BriefDescription": "Configuration cache miss caused by transaction or(ATS or non-ATS)translation request"
> +        "Unit": "smmuv3_pmcg",
> +    },
> +    {
> +        "PublicDescription": "Translation table walk access",
> +        "EventCode": "0x04",
> +        "EventName": "smmuv3_pmcg.TRANS_TABLE_WALK_ACCESS",
> +        "BriefDescription": "Translation table walk access"
> +        "Unit": "smmuv3_pmcg",
> +    },
> +    {
> +        "PublicDescription": "Configuration structure access",
> +        "EventCode": "0x05",
> +        "EventName": "smmuv3_pmcg.CONFIG_STRUCT_ACCESS",
> +        "BriefDescription": "Configuration structure access"
> +        "Unit": "smmuv3_pmcg",
> +    },
> +    {
> +        "PublicDescription": "PCIe ATS Translation Request received",
> +        "EventCode": "0x06",
> +        "EventName": "smmuv3_pmcg.PCIE_ATS_TRANS_RQ",
> +        "BriefDescription": "PCIe ATS Translation Request received"
> +        "Unit": "smmuv3_pmcg",
> +    },
> +    {
> +        "PublicDescription": "PCIe ATS Translated Transaction passed through SMMU",
> +        "EventCode": "0x07",
> +        "EventName": "smmuv3_pmcg.PCIE_ATS_TRANS_PASSED",
> +        "BriefDescription": "PCIe ATS Translated Transaction passed through SMMU"
> +        "Unit": "smmuv3_pmcg",
> +    }
> +]
> diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
> index acb6b77bddc0..76a84ec2ffc8 100644
> --- a/tools/perf/pmu-events/jevents.c
> +++ b/tools/perf/pmu-events/jevents.c
> @@ -256,6 +256,8 @@ static struct map {
>         { "hisi_sccl,ddrc", "hisi_sccl,ddrc" },
>         { "hisi_sccl,hha", "hisi_sccl,hha" },
>         { "hisi_sccl,l3c", "hisi_sccl,l3c" },
> +       /* it's not realistic to keep adding these, we need something more scalable ... */
> +       { "smmuv3_pmcg", "smmuv3_pmcg" },
>         { "L3PMC", "amd_l3" },
>         {}
>  };
> --
> 2.16.4
>
