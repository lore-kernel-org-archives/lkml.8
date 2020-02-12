Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55DA8C352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 19:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14A0421569
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 19:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qusge0Cd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728954AbgBLT0X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 14:26:23 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36290 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbgBLT0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 14:26:22 -0500
Received: by mail-lf1-f66.google.com with SMTP id f24so2440806lfh.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 11:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L+NwtiOn+7IEAksmkohPg1lo6ZNmjobcpFN4LYw+c1A=;
        b=Qusge0CduME+HsZhT7UI7HXe8guM/LKvxaGQbvPHB0srVUm4oMrhSXJWwk+jEyAixP
         kKkBLFYZNKtICBu3ZqdVZB0C572i9fcM/wgFmd0PbdxqmYHA11TsFe7j7rCKm3mWR7fi
         78T1GBus6srA+xxrBW5KNOSKSkBRPhzyAfmQvCahhU/7u07fxaDSvx8s4RdJfP7DpBiG
         U63VUZH43LEjseAsp6cpvGdSJnXuYRZge3vjNPPq6n7BAo9o2WESTXehOphryaRtXLM/
         0pcJrAnf9SADma4z10iz+1GIs1w9CuGfZOWefIqqTmZO9SYC2wLeheKHN1qzq5WOGYeH
         tfOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L+NwtiOn+7IEAksmkohPg1lo6ZNmjobcpFN4LYw+c1A=;
        b=gTNkTsJjKIXb2XlzC480YOoR6Bl0q1ype1N64Rfp4Q4hI13o/NXo/B6dek7Q3chYL5
         H7E8ONvr3+gfjdZe+V7ivBK8N3nn58ZcgE0NJnIQ2+ujRKj95OUieNoL+wQ0vecTi/7/
         gOqvoxLVJLZ3ihSjIv7FyHqa64EHoM+F4Jc/DS1w9bAzT09U5/ID72CMF5INpxlIdNAv
         xJCcDU/h77NdL5RMLaR+T1uK47MC5d5vqawonjbKS4/wSRp7KWBbkNLPbrLCjMW3wUWk
         9sdGWc6D//SePMwx0nmqEbj3HrQjrcKm36f/kixySRinq10A8QufjthTQ40wEQMzq+1u
         9MPA==
X-Gm-Message-State: APjAAAXzhboL/4fkKyuE1bjcRXMCitjewnUvUVDJKhte8sc/y2C96N4X
        AbvPjJgBNCx3z3SSutv5PaFqTR+qTNHVZyFheqgk
X-Google-Smtp-Source: APXvYqy0jyTRayffuFBN/JSUCD8Vq33+ahPBI5fohPlHrvZbp1ez6TbfF5ALMHGLAD+bkdemOkakJkZTdFQpr6j8YRM=
X-Received: by 2002:ac2:47ec:: with SMTP id b12mr7463103lfp.162.1581535580425;
 Wed, 12 Feb 2020 11:26:20 -0800 (PST)
MIME-Version: 1.0
References: <20200211011631.7619-1-zzyiwei@google.com> <20200210211951.1633c7d0@rorschach.local.home>
 <CAKT=dDm+UKqa7j744iTsvYs+jqrdOHpTqdksRUjDe-6vqkigew@mail.gmail.com> <20200210221521.59928416@rorschach.local.home>
In-Reply-To: <20200210221521.59928416@rorschach.local.home>
From:   Yiwei Zhang <zzyiwei@google.com>
Date:   Wed, 12 Feb 2020 11:26:08 -0800
Message-ID: <CAKT=dDk+CiMQ_-f6Daa_ea2FOW=De6PKmcyiGrm4KEkVbH2fDQ@mail.gmail.com>
Subject: Re: [PATCH] Add gpu memory tracepoints
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        Prahlad Kilambi <prahladk@google.com>,
        Joel Fernandes <joelaf@google.com>,
        android-kernel <android-kernel@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

I can move the stuff out from the kernel/trace. Then can we still
leave include/trace/events/gpu_mem.h where it is right now? Or do we
have to move that out as well? Because we would need a non-drm common
header place for the tracepoint so that downstream drivers can find
the tracepoint definition.

Best,
Yiwei

On Mon, Feb 10, 2020 at 7:15 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Mon, 10 Feb 2020 19:05:35 -0800
> Yiwei Zhang <zzyiwei@google.com> wrote:
>
> > Thanks for the prompt reply!
> >
> > The tracepoint proposed here is for tracking global gpu memory usage
> > total counter and per-process gpu memory usage total counter. The
> > tracepoint is for gfx drivers who have implemented gpu memory tracking
> > system. The tracepoint expects the de-duplication of the shared memory
> > is done inside the tracking system.
> >
> > On Android, the graphics driver has implemented gpu memory tracking.
> > First, we'd like to profiler GPU memory with this tracepoint. Second,
> > we implement eBPF programs and attach to this tracepoint for tracking
> > GPU memory at runtime on production devices. However, the tracepoint +
> > eBPF approach requires the tracepoint to be upstreamed so that it's
> > considered a stable interface which Android common kernel can carry it
> > forever.
>
>
> Then it needs to live in the drivers/gpu directory. kernel/trace is for
> tracing infrastructure and not for adding trace points.
>
> -- Steve
