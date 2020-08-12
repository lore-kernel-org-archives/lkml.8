Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A70C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 12:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CF95208A9
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 12:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597234041;
	bh=r4EgSqulkD3kSTPtlPX5p1ifrsxQh2mU+WuoS0dKHwc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kt0gaYrDswJaXMRAkyOzV4cUtm11DS2xRIiIE4HKsscCTzrwcy9HIrGi8earYFSDk
	 psn4DLOFL0A6TMEvzqs3u3iw79eOTLGsa8a7VT4E286XZ2pVJHoz+ydtQqtlUKcimK
	 VfLkLeVrP/b1AOSy+e/5mSnbck81VCNawmH3GVlw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbgHLMHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 08:07:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:36544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728038AbgHLMHL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 08:07:11 -0400
Received: from quaco.ghostprotocols.net (179.176.8.134.dynamic.adsl.gvt.net.br [179.176.8.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9139D2080C;
        Wed, 12 Aug 2020 12:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597234030;
        bh=r4EgSqulkD3kSTPtlPX5p1ifrsxQh2mU+WuoS0dKHwc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C5aIkdYpCVMetaX/bJQ+WzdOtT9R7q0MTKzTAn/XAEp09UOmnlfs0dPsYK6YX9vAu
         xJ0/P6frWNUolCtS6dhofOVYagIzZ4FL7bo31Hr7wc+zkeUzyAFqBtKdGvbbgsWo2H
         za8b4c1+/0lmIKNTDgIzPV8cWwXDujZvhhH4fyHk=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D0A4C403C6; Wed, 12 Aug 2020 09:07:07 -0300 (-03)
Date:   Wed, 12 Aug 2020 09:07:07 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v2 2/3] perf bench numa: fix number of processes in
 "2x3-convergence" test
Message-ID: <20200812120707.GB13995@kernel.org>
References: <cover.1597004831.git.agordeev@linux.ibm.com>
 <d949f5f48e17fc816f3beecf8479f1b2480345e4.1597004831.git.agordeev@linux.ibm.com>
 <CAM9d7cijhLpaZWEn6=Gd-DQ08P0V0uEvFqzg_vD5kcNjPO9gBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cijhLpaZWEn6=Gd-DQ08P0V0uEvFqzg_vD5kcNjPO9gBg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Aug 11, 2020 at 04:27:35PM +0900, Namhyung Kim escreveu:
> On Mon, Aug 10, 2020 at 3:22 PM Alexander Gordeev
> <agordeev@linux.ibm.com> wrote:
> >
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > Cc: Jiri Olsa <jolsa@redhat.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied,

- Arnaldo
 
> Thanks
> Namhyung
> 
> > ---
> >  tools/perf/bench/numa.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
> > index 23e224e..90639c9 100644
> > --- a/tools/perf/bench/numa.c
> > +++ b/tools/perf/bench/numa.c
> > @@ -1754,7 +1754,7 @@ static int run_bench_numa(const char *name, const char **argv)
> >     { " 1x3-convergence,", "mem",  "-p",  "1", "-t",  "3", "-P",  "512", OPT_CONV },
> >     { " 1x4-convergence,", "mem",  "-p",  "1", "-t",  "4", "-P",  "512", OPT_CONV },
> >     { " 1x6-convergence,", "mem",  "-p",  "1", "-t",  "6", "-P", "1020", OPT_CONV },
> > -   { " 2x3-convergence,", "mem",  "-p",  "3", "-t",  "3", "-P", "1020", OPT_CONV },
> > +   { " 2x3-convergence,", "mem",  "-p",  "2", "-t",  "3", "-P", "1020", OPT_CONV },
> >     { " 3x3-convergence,", "mem",  "-p",  "3", "-t",  "3", "-P", "1020", OPT_CONV },
> >     { " 4x4-convergence,", "mem",  "-p",  "4", "-t",  "4", "-P",  "512", OPT_CONV },
> >     { " 4x4-convergence-NOTHP,",
> > --
> > 1.8.3.1
> >

-- 

- Arnaldo
