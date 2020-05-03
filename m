Return-Path: <SRS0=5Fkd=6R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862F4C28CBC
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 17:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56F952068E
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 17:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GYaWtaJF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728929AbgECRbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 May 2020 13:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728831AbgECRbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 13:31:50 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A03C061A0F
        for <linux-kernel@vger.kernel.org>; Sun,  3 May 2020 10:31:50 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id e16so5725874ybn.7
        for <linux-kernel@vger.kernel.org>; Sun, 03 May 2020 10:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KH08NvE4HhhbynEpLq4c2wHhLG6hjJ/tAPnzoWQyZUU=;
        b=GYaWtaJFqqe4DTbChDekN9wLtXvsFqkVL2B/Gk7OJlgB5vg6OJcWsgCTXs33/7cqwv
         qLek8Xg4ObFv8j8SDLm4MFySZixfxwSuKOPTLMAArK3y6NCEgTpFIiJpUU+GYyONtHhZ
         qG8hxhFMRUABiLganCxqvfTX7ABnAPkDlg3tN9FsBsSghaLPO7ZqxQo1sKDCVxDW+l/j
         DblasEWJJSFK6bcbfvnoGg4tvK3JzDNlsoz3/VJZsy6AeOD9ABYGxJZ7cy92+t0mZEzG
         Yc4U3qQ9w24uomai/ZGdzfPYr3mN3PdNP15ZdxeQhwapU6o5z5P7pae3WEB3ThNww+qg
         vYgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KH08NvE4HhhbynEpLq4c2wHhLG6hjJ/tAPnzoWQyZUU=;
        b=NbCv/084iANE+v4al/hPuwBYPyRQ3oVlwdDf7Z4AL451g43iFMmESPaSz1TYDrA29o
         +XEEuuxgj8VlFKVTsMst6oAvNEmMZExRm4gindOx/zAdQ/K87zjLP9WL0o/MgrXltLYq
         nD3rYKjMUaZatJnlSJiXkZeAgAzXFI875r1euejZBQGq1gFhZi5M66rf9oSWUP+tFAoA
         lTy6NuhdtskLM4X6n7j7pzCAufi4wEWdgJ5N3fQ1qyHyanANMuHTjD/sbpQMFk6d1Uq5
         1R7IEHVbFF1tgagrLCvI4pFItWx9CgLxjvcUn+MHhLUVrHpNzUht+e3trMuWhRWV829t
         eptg==
X-Gm-Message-State: AGi0PuZLwLJrakpKgkZ4YrIdakZ/bfXZqRnbcpZmgC+RymRzqPdMwwZr
        iuUdo8S1muWyzOCCH5RhLnf3bd1n3Mvldci+NAsD5g==
X-Google-Smtp-Source: APiQypKnnIUC2GqfJIc2KRZH9M9N9tR3rqq5iQSGw9IJzrUSSqDrYocJA2uP72+iU0HF//UkjSEScLPsexqjJrriv5U=
X-Received: by 2002:a25:c08b:: with SMTP id c133mr10218465ybf.286.1588527108775;
 Sun, 03 May 2020 10:31:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200501173333.227162-1-irogers@google.com> <20200501173333.227162-13-irogers@google.com>
 <20200503145553.GA1865281@krava> <CAP-5=fXrwcz+MMF0Dqd_UnoXoTo1iO7T3-ENX0fzytPmJWmtoA@mail.gmail.com>
 <20200503170608.GA1915271@krava>
In-Reply-To: <20200503170608.GA1915271@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Sun, 3 May 2020 10:31:37 -0700
Message-ID: <CAP-5=fVaLWVyxweesWYCj1=FFubM3t6OsF1Jd46d=FtsQUQVmQ@mail.gmail.com>
Subject: Re: [PATCH v4 12/12] perf test: improve pmu event metric testing
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Haiyan Song <haiyanx.song@intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Paul Clarke <pc@us.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kajoljain <kjain@linux.ibm.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: multipart/mixed; boundary="0000000000000a441305a4c1ca85"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000000a441305a4c1ca85
Content-Type: text/plain; charset="UTF-8"

On Sun, May 3, 2020 at 10:06 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Sun, May 03, 2020 at 08:26:22AM -0700, Ian Rogers wrote:
> > On Sun, May 3, 2020 at 7:56 AM Jiri Olsa <jolsa@redhat.com> wrote:
> > >
> > > On Fri, May 01, 2020 at 10:33:33AM -0700, Ian Rogers wrote:
> > > > Add a basic floating point number test to expr.
> > > > Break pmu-events test into 2 and add a test to verify that all pmu metric
> > > > expressions simply parse. Try to parse all metric ids/events, failing if
> > > > metrics for the current architecture fail to parse.
> > > >
> > > > Tested on skylakex with the patch set in place. May fail on other
> > > > architectures if metrics are invalid.
> > >
> > > yep, failing for me (-vvv output below).. could you plz
> > > detect that and skip the test ?
> >
> > Thanks, filtering the verbose output we have just 1 parse event failure:
> >
> > Parse event failed: id 'arb/event=0x80,umask=0x2,thresh=1/' metric
> > 'DRAM_Parallel_Reads' expr 'arb@event\=0x80\,umask\=0x2@ /
> > arb@event\=0x80\,umask\=0x2\,thresh\=1@'
> > Error string 'unknown term 'thresh' for pmu 'uncore_arb'' help 'valid
> > terms: event,edge,inv,umask,cmask,config,config1,config2,name,period,freq,branch_type,time,call-graph,stack-size,no-inherit,inherit,max-stack,nr,no-overwrite,overwrite,driver-config,percore,aux-output,aux-sample-size'
> >
> > This looks like a bug in skl-metrics.json:
> >
> >    {
> >         "BriefDescription": "Average number of parallel data read
> > requests to external memory. Accounts for demand loads and L1/L2
> > prefetches",
> >         "MetricExpr": "arb@event\\=0x80\\,umask\\=0x2@ /
> > arb@event\\=0x80\\,umask\\=0x2\\,thresh\\=1@",
> >         "MetricGroup": "Memory_BW",
> >         "MetricName": "DRAM_Parallel_Reads"
> >     },
> >
> > which can be fixed by removing "\\,thresh\\=1" but looking at the
> > expression this will just make the expression yield a value of 1. As
> > this is an Intel json file could they comment? Jiri, could you be
> > missing a patch on the kernel side? We could lower this failure to
> > just a diagnostic message to land this set of patches, let me know
> > what you'd like me to do.
>
> I applied this on current Arnaldo's perf/core.. not sure there's
> more pending changes out there
>
> I'd like not to delay this patchset too long.. could we push the
> first 10 patches and solve the rest in separate change?

Thanks, I've attached a patch that can be squashed into 12 to make the
error non-fatal. Patch 11 is trying to make the diagnostics around
adding a PMU event clearer and aside warning messages, and removal of,
has no functional effect. I don't mind the first 10 being merged and
these coming later. I don't mind just patch 11 coming later as it'd be
nice to have the test so metrics can get fixed.

Thanks,
Ian

> thanks,
> jirka
>

--0000000000000a441305a4c1ca85
Content-Type: text/x-patch; charset="US-ASCII"; name="jiri.patch"
Content-Disposition: attachment; filename="jiri.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_k9rbtbov0>
X-Attachment-Id: f_k9rbtbov0

ZGlmZiAtLWdpdCBhL3Rvb2xzL3BlcmYvdGVzdHMvcG11LWV2ZW50cy5jIGIvdG9vbHMvcGVyZi90
ZXN0cy9wbXUtZXZlbnRzLmMKaW5kZXggNWFiMTgwOWI3NDFiLi5jMThiOWNlOGNhY2UgMTAwNjQ0
Ci0tLSBhL3Rvb2xzL3BlcmYvdGVzdHMvcG11LWV2ZW50cy5jCisrKyBiL3Rvb2xzL3BlcmYvdGVz
dHMvcG11LWV2ZW50cy5jCkBAIC00MDQsMTIgKzQwNCwxMyBAQCBzdGF0aWMgaW50IGNoZWNrX3Bh
cnNlX2lkKGNvbnN0IGNoYXIgKmlkLCBib29sIHNhbWVfY3B1LCBzdHJ1Y3QgcG11X2V2ZW50ICpw
ZSkKIAltZW1zZXQoJmVycm9yLCAwLCBzaXplb2YoZXJyb3IpKTsKIAlyZXQgPSBwYXJzZV9ldmVu
dHMoZXZsaXN0LCBpZCwgJmVycm9yKTsKIAlpZiAocmV0ICYmIHNhbWVfY3B1KSB7Ci0JCXByX2Rl
YnVnKCJQYXJzZSBldmVudCBmYWlsZWQ6IGlkICclcycgbWV0cmljICclcycgZXhwciAnJXMnXG4i
LAotCQkJaWQsIHBlLT5tZXRyaWNfbmFtZSwgcGUtPm1ldHJpY19leHByKTsKLQkJcHJfZGVidWco
IkVycm9yIHN0cmluZyAnJXMnIGhlbHAgJyVzJ1xuIiwKKwkJZnByaW50ZihzdGRlcnIsCisJCQki
XG5XQVJOSU5HOiBQYXJzZSBldmVudCBmYWlsZWQgbWV0cmljICclcycgaWQgJyVzJyBleHByICcl
cydcbiIsCisJCQlwZS0+bWV0cmljX25hbWUsIGlkLCBwZS0+bWV0cmljX2V4cHIpOworCQlmcHJp
bnRmKHN0ZGVyciwgIkVycm9yIHN0cmluZyAnJXMnIGhlbHAgJyVzJ1xuIiwKIAkJCWVycm9yLnN0
ciwgZXJyb3IuaGVscCk7CiAJfSBlbHNlIGlmIChyZXQpIHsKLQkJcHJfZGVidWcoIlBhcnNlIGV2
ZW50IGZhaWxlZCwgYnV0IGZvciBhbiBldmVudCB0aGF0IG1heSBub3QgYmUgc3VwcG9ydGVkIGJ5
IHRoaXMgQ1BVLlxuaWQgJyVzJyBtZXRyaWMgJyVzJyBleHByICclcydcbiIsCisJCXByX2RlYnVn
MygiUGFyc2UgZXZlbnQgZmFpbGVkLCBidXQgZm9yIGFuIGV2ZW50IHRoYXQgbWF5IG5vdCBiZSBz
dXBwb3J0ZWQgYnkgdGhpcyBDUFUuXG5pZCAnJXMnIG1ldHJpYyAnJXMnIGV4cHIgJyVzJ1xuIiwK
IAkJCWlkLCBwZS0+bWV0cmljX25hbWUsIHBlLT5tZXRyaWNfZXhwcik7CiAJfQogCWV2bGlzdF9f
ZGVsZXRlKGV2bGlzdCk7CkBAIC00MTcsNyArNDE4LDggQEAgc3RhdGljIGludCBjaGVja19wYXJz
ZV9pZChjb25zdCBjaGFyICppZCwgYm9vbCBzYW1lX2NwdSwgc3RydWN0IHBtdV9ldmVudCAqcGUp
CiAJZnJlZShlcnJvci5oZWxwKTsKIAlmcmVlKGVycm9yLmZpcnN0X3N0cik7CiAJZnJlZShlcnJv
ci5maXJzdF9oZWxwKTsKLQlyZXR1cm4gc2FtZV9jcHUgPyByZXQgOiAwOworCS8qIFRPRE86IHRv
byBtYW55IG1ldHJpY3MgYXJlIGJyb2tlbiB0byBmYWlsIG9uIHRoaXMgdGVzdCBjdXJyZW50bHku
ICovCisJcmV0dXJuIDA7CiB9CiAKIHN0YXRpYyBpbnQgdGVzdF9wYXJzaW5nKHZvaWQpCg==
--0000000000000a441305a4c1ca85--
