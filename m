Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01EFCC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 18:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5AE320838
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 18:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597083098;
	bh=g/t91faDycY4mseqjHu9BMl29MuRrgmwUh+bEg6Hgsg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ou6TgHLU0t+0BZUJrJWebd/gRr1GYrI6+PW5bh6vX6TyKLfzOxW6oPC9n0sWgcKUb
	 KRubShyi+5vw1IdgmEMrVsK2jg1zBZjqg3cGaEQB2MTBHWnQqRVs5wK3EYCwvvMYaG
	 +vOIcIXvzS2TlMI4Tr0/6Wz2110ICOMyn8Pf5NP4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbgHJSLh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 14:11:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:51886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727972AbgHJSLg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 14:11:36 -0400
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0184220838
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 18:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597083096;
        bh=g/t91faDycY4mseqjHu9BMl29MuRrgmwUh+bEg6Hgsg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=spkSqZBpZi71Ys9ESVPWib9QM4a0+dUXn8Lcfqpqglpbs4m3Y2UCV5kdVpl+y9WFi
         F8EmYeN7eiWwiIXOanNvMDkHZIBZAWoQJ7AkWKzh/A7IPBGW6pLT7VMNIfvgAM/vvF
         Mh2Yzj0GVGlJ/NOBZQK5/wsgHdONLJgdNsHDylPE=
Received: by mail-ot1-f52.google.com with SMTP id v6so8002942ota.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 11:11:35 -0700 (PDT)
X-Gm-Message-State: AOAM533itX/x4tLjlebKw6mAv/4zwXt04+X5GowpleFyubF+6coKpGTE
        Bhu3WUmVyaas4qY4tonjKK+rTXTr5ViLhmk+YA==
X-Google-Smtp-Source: ABdhPJyIcpMR1q6VzAeE/qkvttTnUF6tMclUZpugrbOgbjhBSTkQcM3zw3f5rc5dQEF2DOUXdRFuMPxOcEW5p+HQ2VQ=
X-Received: by 2002:a9d:7f84:: with SMTP id t4mr1798410otp.192.1597083095312;
 Mon, 10 Aug 2020 11:11:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200807230517.57114-1-robh@kernel.org> <20200808102208.GA619980@krava>
In-Reply-To: <20200808102208.GA619980@krava>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 10 Aug 2020 12:11:23 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+gfqyqCx3Yuc6TsbXjYSLfJQhhPUnwRVjpJgwL24v1Qg@mail.gmail.com>
Message-ID: <CAL_Jsq+gfqyqCx3Yuc6TsbXjYSLfJQhhPUnwRVjpJgwL24v1Qg@mail.gmail.com>
Subject: Re: [RFC] libperf: Add support for user space counter access
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 8, 2020 at 4:22 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Fri, Aug 07, 2020 at 05:05:17PM -0600, Rob Herring wrote:
> > x86 and arm64 can both support direct access of event counters in
> > userspace. The access sequence is less than trivial and currently exists
> > in perf test code (tools/perf/arch/x86/tests/rdpmc.c) with copies in
> > projects such as PAPI and libpfm4.
> >
> > Patches to add arm64 userspace support are pending[1].
> >
> > For this RFC, looking for a yes, seems like a good idea, or no, go away we
> > don't want this in libperf.
>
> hi,
> looks great!
>
> I wanted to add this for very long time.. so yes, we want this ;-)

Thanks for the quick feedback. Would this be better implemented as a
fast path for perf_evsel__read()? If so, how to get the mmap data
which is associated with a evlist rather than a evsel?

Rob
