Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC806C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 17:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5D4B2083B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 17:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Du2GXZKc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgEGRC3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 13:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726518AbgEGRC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 13:02:28 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73195C05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 10:02:28 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id b188so6857533qkd.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 10:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yAHhylpwtOslrc/dOUKgfB3SOwKO6Omu8a9EnpJ1Fhc=;
        b=Du2GXZKcBr3UQ2ZVdisEy2jQtSYaJPXnxqv3b4UJoX49dZG/SwbUbnI3tLEIbs3iFW
         IDe1t4N9V8dsqJPAYg5R5aT6jvPXuXjlseJ0Suvk/FPBH5za0Rb0nIQ3u0cjo6cdpthG
         vRdjPKq10gaRIX2r0EfFFRVShWHUrjzatSQsEOplvhy9N2h9fimSDZqWh9/wAzkLL44v
         fiLiF1deMlmHbR5PBC1fJ20wb/x3oEY1DEgf+7wMNPUKkXXG3smwPmVwpCFAx8n7K3Lr
         JGErrUt7zG8gdRY3+DbhIeC6LWWiog1PY03vSl1D5tRO9cXPcExIxV8czMd19nzXhG4i
         SZ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yAHhylpwtOslrc/dOUKgfB3SOwKO6Omu8a9EnpJ1Fhc=;
        b=kv/EjYh3tmm2PIbYYbMHFdT6/d/D46dysWOu3iHlmO1BmYqsZny6S7oZ2D8e3BIjmG
         kl671oZ0CnPLiHz8TyLZUq4N6vvVd2TlzlKPa+sC9CaNWp1ieSVHnk6oxwKVNo1AVTLa
         wavzPrF1KxUTnoahhBsDMr7LTM8jqX4URxP9vNkaWM4EGPCH9dfpdmNf1ylFf+O9uc+Q
         YL54zVjDEzzux+poJDbFcPZoKhl0Mct6vuKAGCHTEqLWAdoN1B1pCaGwOx4QN62Dlr7s
         hSj64nRRvCig2glXGjrXH6irUcG+mHNv9wU6VsQcS+bLOTfuWrDhylZOzV8VeuPfJlzW
         8A8w==
X-Gm-Message-State: AGi0Pub6XSTFxMLvuWibb3bso7qEBdSGaH6sqk9iJgJmttp7QhExvRo9
        XbefTekq+VpkSMpUC07nhPw=
X-Google-Smtp-Source: APiQypKLUJQFnAfO0rtfdnHGXTlbvckVtlzUYOyGdxnnnFWLakJUU+d6Jw7WE2vp1oZDaRuymVSeGA==
X-Received: by 2002:a37:49c6:: with SMTP id w189mr14602032qka.444.1588870947613;
        Thu, 07 May 2020 10:02:27 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id y185sm4649121qkd.29.2020.05.07.10.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 10:02:26 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 92B4340AFD; Thu,  7 May 2020 14:02:24 -0300 (-03)
Date:   Thu, 7 May 2020 14:02:24 -0300
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 09/11] perf record: implement control commands handling
Message-ID: <20200507170224.GH31109@kernel.org>
References: <d582cc3d-2302-c7e2-70d3-bc7ab6f628c3@linux.intel.com>
 <db9bb4c3-14d2-aa9f-c281-f81ca698913d@linux.intel.com>
 <20200506202339.GH9893@kernel.org>
 <4971d2b6-a95a-d53d-515d-7f0ba95fb2f8@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4971d2b6-a95a-d53d-515d-7f0ba95fb2f8@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, May 07, 2020 at 11:58:45AM +0300, Alexey Budankov escreveu:
> 
> On 06.05.2020 23:23, Arnaldo Carvalho de Melo wrote:
> > Em Wed, May 06, 2020 at 09:29:05PM +0300, Alexey Budankov escreveu:
> >>
> >> Implement handling of 'enable' and 'disable' control commands
> >> coming from control file descriptor.
> >>
> >> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> >> ---
> >>  tools/perf/builtin-record.c | 18 +++++++++++++++++-
> >>  1 file changed, 17 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> >> index 8a14e68b86ad..2278a3efc747 100644
> >> --- a/tools/perf/builtin-record.c
> >> +++ b/tools/perf/builtin-record.c
> >> @@ -1496,6 +1496,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
> >>  	bool disabled = false, draining = false;
> >>  	int fd;
> >>  	float ratio = 0;
> >> +	enum evlist_ctl_cmd cmd = CTL_CMD_UNSUPPORTED;
> >>  
> >>  	atexit(record__sig_exit);
> >>  	signal(SIGCHLD, sig_handler);
> >> @@ -1793,8 +1794,23 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
> >>  			 * Propagate error, only if there's any. Ignore positive
> >>  			 * number of returned events and interrupt error.
> >>  			 */
> >> -			if (err > 0 || (err < 0 && errno == EINTR))
> >> +			if (err > 0 || (err < 0 && errno == EINTR)) {
> >>  				err = 0;
> >> +				if (perf_evlist__ctlfd_process(rec->evlist, &cmd) > 0) {
> >> +					switch (cmd) {
> >> +					case CTL_CMD_ENABLE:
> >> +						pr_info(PERF_EVLIST__ENABLED_MSG);
> >> +						break;
> >> +					case CTL_CMD_DISABLE:
> >> +						pr_info(PERF_EVLIST__DISABLED_MSG);
> >> +						break;
> >> +					case CTL_CMD_ACK:
> >> +					case CTL_CMD_UNSUPPORTED:
> > 
> > Shouldn't we have a pr_debug() or even pr_err() for the unsupported one?
> 
> It already exists on lower level, at perf_evlist__ctlfd_process() (see patch 02/11).

oic
 
> ~Alexey

-- 

- Arnaldo
