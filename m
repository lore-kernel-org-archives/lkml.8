Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD02C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 05:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9ACE5206C9
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 05:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gWNQdR+4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgIDFsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 01:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgIDFs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 01:48:29 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21EA3C061244
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 22:48:28 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id g4so5450213wrs.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 22:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hgnV0PJQclKDTkxAfG3hekBCTTnrND7+WP2P78WYx4I=;
        b=gWNQdR+4V1WQ9kufk2M2A9iCehCi3ywVll+q5zq5gCxuHXHN1Ni3IwzRbp03VYPQon
         /yB1xoN7z+51HJOZaJ+19v+JPgAbBcUSIHTPYwmqpR22o2enjRXCvn5Jsb4FRPBLUKBz
         t4uogQyNNW9FnkImLSypRnvkFucfB5dlDAQzOfn8NcEbQXTuYX8NKHNpC7k3Gj/ld8hE
         GLYgqw3bm0pnm53224MrWis7rzEP51FOTiW/w72vlCyduMxXhr4/KFErIFuKMsq7r+wn
         5vNwvaQQP69O6H5X/dYrL9lJB9UfNTUoq6DXsmlcwsRA5PwfgMKN58urt2JBOCA42P+q
         zAEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hgnV0PJQclKDTkxAfG3hekBCTTnrND7+WP2P78WYx4I=;
        b=V1mp7HqxT5HfPHY22S854ddnBLngYhXMlfCktrn4DkAmBLLCQ1e5PMq7jVSwlgdNEx
         hraoVtaB6Ltqw2iO9elN2yVeIi1/zR7l4zU28nt/4/wv/5bsmRLenEhqlYvmkxpW7aVS
         H7wH7izzkfvsn7LrG21eA/Va2RkwFmQ5LDjSSxOpQWTRgu4+gaHf+jniAiA+0QRWFY0i
         bDpPRMIzLJpTxq6eJffwoWYToKyVhHQdMe11HUIqNqgwztPmT4NcxyInN5Y7nY4EXVph
         bwmIrtU+1fmiOL44zeE3wVGpW2X0Xyx6Synvf4Irn/i1Bh21Jo4ikZhzRtsNNC8SBBBk
         LGVg==
X-Gm-Message-State: AOAM530bJMSYFufXYdwy+26bRSIeoHRQ/IiayQeS6oO9v9V+PAYj3Q1g
        dId3kH0rdoM0jS7xPrEVAM6Gy4WYU4M53QhKa6gisw==
X-Google-Smtp-Source: ABdhPJxG9CdNtq7Rz86qVoKzyX22hy4nxOokgznSS3DezbrQUQO/Ws45wINqUQMiW9Tm4VubqYwnuQ5s3iUWZavLwyg=
X-Received: by 2002:adf:82b1:: with SMTP id 46mr6337985wrc.271.1599198506705;
 Thu, 03 Sep 2020 22:48:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200901220944.277505-1-kim.phillips@amd.com> <20200901220944.277505-3-kim.phillips@amd.com>
 <CAP-5=fVwuKOACD++6UyBVW_fgbTXrOwuOJHSYenD87dwVJk0OA@mail.gmail.com> <7a0b893d-8f65-6423-3818-5dafc880dca1@amd.com>
In-Reply-To: <7a0b893d-8f65-6423-3818-5dafc880dca1@amd.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 3 Sep 2020 22:48:15 -0700
Message-ID: <CAP-5=fW8zLRgxXgY-CFUnU0HiiZMKhJ6b1znMxT8WeLO5Z-wZA@mail.gmail.com>
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 3, 2020 at 11:27 AM Kim Phillips <kim.phillips@amd.com> wrote:
>
> On 9/3/20 1:19 AM, Ian Rogers wrote:
> > On Tue, Sep 1, 2020 at 3:10 PM Kim Phillips <kim.phillips@amd.com> wrote:
> >> The nps1_die_to_dram event may need perf stat's --metric-no-group
> >> switch if the number of available data fabric counters is less
> >> than the number it uses (8).
> >
> > These are really excellent additions! Does:
> > "MetricConstraint": "NO_NMI_WATCHDOG"
> > solve the grouping issue? Perhaps the MetricConstraint needs to be
> > named more generically to cover this case as it seems sub-optimal to
> > require the use of --metric-no-group.
>
> That metric uses data fabric (DFPMC/amd_df) events, not Core PMC
> events, which the watchdog uses, so NO_NMI_WATCHDOG wouldn't have
> an effect.  The event is defined as an approximation anyway.
>
> I'll have to get back to you on the other items.
>
> Thanks for your review!

NP, more nits than anything else.

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> Kim
