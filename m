Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B01C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 11:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94D752072A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 11:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8Ruf4x/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgCFLjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 06:39:01 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45053 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbgCFLjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 06:39:01 -0500
Received: by mail-qt1-f196.google.com with SMTP id h16so1424268qtr.11
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 03:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Gjl63qb0MfrCTq5Qlm7evD5crVkGu65xKPi7JWOt5/M=;
        b=Z8Ruf4x/eUDCPpsEBPghS9SJSEUYV6KhHbvbDbg9cRtDhATalOf66UuJ3Pf4Q/P6Rs
         DnRfRq5LoTGcWRe4KMO+y11jrVrfLvlkwPrePMV1j8JkQdww2jW0sKe6CvB50NAGIaHe
         gW2g246ZAl2YhMlEnNXLGzk88XHIdYHQfsuVSejhvnbbIAzE6qIMb+Ay4sqU49jvMuE/
         ZoaL1JiEoAXp/CABXyOYsQdII2GmNBrsePwYCOi5et5/r8pAHlrit6Bf+pbBZQ2NCSVc
         e1DqeFPtr2jliI6WXr/OxISbemOQqpv4bgun074K+RXpnExeUJfVkt2ucZdj14soW1U9
         BfVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Gjl63qb0MfrCTq5Qlm7evD5crVkGu65xKPi7JWOt5/M=;
        b=VrdE+ihFpy9QAydC5ZL8pVx45EMPGIgOJoT2L0noyxyeJYro4dZmr4KbHIf9A68I+A
         aIMx3D+/HWCBD7fBpNi5a/387g56FYs3hFVE/UBo+yIdGSnjU5KGd32xFgvroNrAreN9
         +yX7BZD1ptYRazIv2cHGKARyz1wTaHbIScz9awItQ3O5eWlecMb/BJ5rChFS3RiYGz53
         DZCdte28GSKuf8LKGWydrq6wT/6IBppTkBoLFekPfBRAqjpRNr+nIUTG4z3rsQ7NbiDS
         RKOX+2posIkECXtN/W9usyHqD8z99kkmk0hGse3pV1guULNre06nEYW6P1+wr0tT/alv
         fzFw==
X-Gm-Message-State: ANhLgQ0b9gL/Rfko+HpXsIUOjTAtbY7APf1FzsrCwSkeYUPjqfy2qxOG
        QNbk0SIqxvUvi1YOxZljrgI=
X-Google-Smtp-Source: ADFU+vtFVeo/6V1oCrTaKRcvDvJ7Nz2ZtcSxP7uvrHz7CqTaXo6NNzZfNzEZhYXpWHg68WPowkJFUQ==
X-Received: by 2002:ac8:3ae6:: with SMTP id x93mr2507316qte.69.1583494738693;
        Fri, 06 Mar 2020 03:38:58 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id k202sm4490605qke.134.2020.03.06.03.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 03:38:57 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 28155403AD; Fri,  6 Mar 2020 08:38:55 -0300 (-03)
Date:   Fri, 6 Mar 2020 08:38:55 -0300
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Igor Lubashev <ilubashe@akamai.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wei Li <liwei391@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 2/3] libperf: avoid redefining _GNU_SOURCE in test
Message-ID: <20200306113855.GA27494@kernel.org>
References: <20200306071110.130202-1-irogers@google.com>
 <20200306071110.130202-3-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306071110.130202-3-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Mar 05, 2020 at 11:11:09PM -0800, Ian Rogers escreveu:
> _GNU_SOURCE needs to be globally defined to pick up features like
> asprintf. Add a guard against redefinition in this test.

Humm, so you're completely sure that the Makefiles that drive the build
of this file don't set _GNU_SOURCE? I.e. some explanation in the cset
log message about that would help in processing the patch,

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/lib/perf/tests/test-evlist.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/lib/perf/tests/test-evlist.c b/tools/lib/perf/tests/test-evlist.c
> index 6d8ebe0c2504..5a5ff104b668 100644
> --- a/tools/lib/perf/tests/test-evlist.c
> +++ b/tools/lib/perf/tests/test-evlist.c
> @@ -1,5 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
> +#ifndef _GNU_SOURCE
>  #define _GNU_SOURCE // needed for sched.h to get sched_[gs]etaffinity and CPU_(ZERO,SET)
> +#endif
>  #include <sched.h>
>  #include <stdio.h>
>  #include <stdarg.h>
> -- 
> 2.25.1.481.gfbce0eb801-goog
> 

-- 

- Arnaldo
