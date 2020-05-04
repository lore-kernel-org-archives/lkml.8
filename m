Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FEBC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 19:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1043C206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 19:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sfO9NULV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbgEDTIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 15:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725956AbgEDTIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 15:08:11 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11950C061A0F
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 12:08:11 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id u6so10831493ljl.6
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 12:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nA7BSbA4+dgWv2HHt/a9kOkMcvHTSjNmFgnO5JssieQ=;
        b=sfO9NULVivFgkR/GkcHTA+eGU6K3JdLPDjottL6+OHHtPcVfZVX0Sy7ylvnJdjJWq5
         iGJrKk7/+jSseAsbFq6jtsz7jo3RBDCUuwHcZsSI2s3VWX7FMhb66KUzfaKIUT3xqELD
         mPNavysrb6cme6+0A1ITYoUn/yZyLoUMslnUGSzwsDXJD8AjCyqaILchHIQF0mv8MVS7
         0xYhIcoKnu7wf7EIJ+DdFTn+CyuX0/UgarVZKIBKDYNry2CWLNLB4oXvUEzE9yNrfOLc
         H5XkgHNvs8O9Iwqr7qO3Kp/hVZhcfQbUF0yXh1niJN0XdvW2iBJa4kGMm+EqhCPGXaH9
         unNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nA7BSbA4+dgWv2HHt/a9kOkMcvHTSjNmFgnO5JssieQ=;
        b=Ujaqs54Ikk6ATeKRCBUiTvd80a/UyftRLMKP25dyGUNQylfnp64lhCCH0XSSa+2bzL
         B0rNzYYNxRmHwhNDtovg3/xOHjTg5uOACBuJeIOINeWQGFo39N/Bc7hkvc2UjzfwKIA+
         I6Tk0jaCbT3HsGMgkhAMyADONze+FA9144TTzMhN0YxtlZZHUPWbV7fQqF3u2A7QPIqR
         g0269aI/G14BHDGKXabi218669HE3qCzqzaPGK1IVGn5yaN1sQRA2hMgv7//tPmsglNK
         MwN1AqMrAtR1CXWYjFgyWdC9DS6RR622XkcooPDgb69UwlW5qEzrnDKZa7KlC5tOxmER
         f8Aw==
X-Gm-Message-State: AGi0PuY48Lf2ZQbe1HADrfcwIAqLQAx3zGEo8icNWoFCt1IoLiyAG/RN
        zL8DC4xqiAthuK5MF6Et3u5nkDEEP63wOJgkRjK8Nw==
X-Google-Smtp-Source: APiQypL6eRslPw+EBeAcDupV6Ro4Jx7U9WtD7rUCEBlSywksd5PdfQKMoje2doqtaKDJbPkzPEglmIWbgfyiyU9GJ6A=
X-Received: by 2002:a2e:9e45:: with SMTP id g5mr11658504ljk.180.1588619288729;
 Mon, 04 May 2020 12:08:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200420115316.18781-1-acme@kernel.org> <20200422120943.GA110748@gmail.com>
 <CAEUSe7_wmKS361mKLTB1eYbzYXcKkXdU26BX5BojdKRz8MfPCw@mail.gmail.com>
 <20200424130722.GK19437@kernel.org> <0f6403ec-36cd-f43f-b3a6-b87e628f3789@redhat.com>
In-Reply-To: <0f6403ec-36cd-f43f-b3a6-b87e628f3789@redhat.com>
From:   =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Date:   Mon, 4 May 2020 14:07:56 -0500
Message-ID: <CAEUSe7_Ybp=7XC-2xMSEGYmCHvEMff0YbZq1f6akvxLVcS_ePA@mail.gmail.com>
Subject: Re: [GIT PULL] perf/core improvements and fixes
To:     Andreas Gerstmayr <agerstmayr@redhat.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        He Zhe <zhe.he@windriver.com>, Ian Rogers <irogers@google.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Konstantin Kharlamov <hi-angel@yandex.ru>,
        Stephane Eranian <eranian@google.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Fri, 24 Apr 2020 at 09:10, Andreas Gerstmayr <agerstmayr@redhat.com> wro=
te:
>
> On 24.04.20 15:07, Arnaldo Carvalho de Melo wrote:
> > Em Thu, Apr 23, 2020 at 04:28:46PM -0500, Daniel D=C3=ADaz escreveu:
> >> On Wed, 22 Apr 2020 at 07:09, Ingo Molnar <mingo@kernel.org> wrote:
> >>>>   85 files changed, 1851 insertions(+), 513 deletions(-)
> >
> >>> Pulled, thanks a lot Arnaldo!
> >
> >> Our OpenEmbedded builds detected an issue with 5287f9269206 ("perf
> >> script: Add flamegraph.py script"):
> >>    ERROR: perf-1.0-r9 do_package_qa: QA Issue:
> >> /usr/libexec/perf-core/scripts/python/bin/flamegraph-report contained
> >> in package perf-python requires /usr/bin/sh, but no providers found in
> >> RDEPENDS_perf-python? [file-rdeps]
> >
> >
> > yeah, the flamegraph scripts are the outliers, there, everything else i=
s
> > using /bin/bash, so I'll switch to that, ok Andreas?
>
> Sure, no problem. Thanks!

Just a gentle reminder that this can still be fixed in today's
linux-next tree (next-20200504).

Greetings!

Daniel D=C3=ADaz
daniel.diaz@linaro.org
