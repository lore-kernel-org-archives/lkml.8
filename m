Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2667CC3F2CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 15:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDCA22070E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 15:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKdntnCh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgCEPQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 10:16:13 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:42588 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbgCEPQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 10:16:12 -0500
Received: by mail-qv1-f68.google.com with SMTP id e7so2562169qvy.9;
        Thu, 05 Mar 2020 07:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Qr9T4/HfHNjKQEoGnPMpOHpy/Tgp3MiA/ssiXAaRBcU=;
        b=TKdntnCh9T9OceR6r5KJMZbWwbtVWrwUMfrde9/uPEKUCsO1IxxVBguSbk3Zfefyw/
         O/sPEidM4LDyiCPa+QwlRiVfg5kxK04BfWsxp1MF+gngNX23T415jUPyxvkMBq4aykoO
         iUEgOPPPaAuVpLpvTnselNkPnAoanY1mryl18l/QU9h4fNgCqXypbNNa2STqelFWiou/
         pAmh6SH2mTPaRFaLH2fAQu2ExSr1z3xnzXN/o/rJa/eLT2ISp6QNJR2C720qbEKth3Q2
         JLCG4XNjiF2XA038mO51V9ZVXy8ZT0lOKeTafx3WO/kSPIAPBliZ0Gtqt5qTNikgIDFO
         aR4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Qr9T4/HfHNjKQEoGnPMpOHpy/Tgp3MiA/ssiXAaRBcU=;
        b=FQCe6KdWGi8bAKBgie8sSC8A535vM+FMEl7Kp+E0KQ76xj/Tr8CQRJGX38Yt69517I
         5LOZ33wSmipQnqhwgdcg5c1NEL9UFisxXm3lJRN5hZdtGiMGeoh9cjopHEs2Ak+A+F2p
         Pa4H7NpeMY0SKFCj+n4MMVkY5297YEJbeI1fvoW0bdKiM8sdrsSy0e7y2N1FI3YnUqPH
         jsTi5pGOuQUpqQjUZnck4jdRgUKotyT5HAWe0WfIYjk4kS/YaWGAl/PL/WIH68AKXHZv
         6+jo9RWX3iv5HeMGDT6CzpqKrW58r9Ih5wcMJRV7up7tDLm0NBVIcWqJGce1aQUyruDt
         23Yw==
X-Gm-Message-State: ANhLgQ0KWRipUgKwOsQEHmIbS/+m3tJnO31pwFc/PgbYXNBmrpUSbgyn
        FNZVT5UzSgLloPvp/UG45FCBsRGYZ0E=
X-Google-Smtp-Source: ADFU+vtDD5SoolymY435I3JgIVSFCVZwLKyiD32jrBVXmOt78Q17Y06DePByKUYqLmqiUvIFnWdzoQ==
X-Received: by 2002:a0c:fdc5:: with SMTP id g5mr7055887qvs.194.1583421371779;
        Thu, 05 Mar 2020 07:16:11 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id u18sm1537531qtv.96.2020.03.05.07.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 07:16:11 -0800 (PST)
From:   Arnaldo Carvalho de MElo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de MElo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1A32C403AD; Thu,  5 Mar 2020 12:16:09 -0300 (-03)
Date:   Thu, 5 Mar 2020 12:16:09 -0300
To:     "Rantala, Tommi T. (Nokia - FI/Espoo)" <tommi.t.rantala@nokia.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 4/5] perf bench: Share some global variables to fix build
 with gcc 10
Message-ID: <20200305151609.GE7895@kernel.org>
References: <20200303194827.6461-1-acme@kernel.org>
 <20200303194827.6461-5-acme@kernel.org>
 <bb1a3048a0f75d1fdf497c67d16a022cdd15c437.camel@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb1a3048a0f75d1fdf497c67d16a022cdd15c437.camel@nokia.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Mar 05, 2020 at 08:43:32AM +0000, Rantala, Tommi T. (Nokia - FI/Espoo) escreveu:
> On Tue, 2020-03-03 at 16:48 -0300, Arnaldo Carvalho de Melo wrote:
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> BTW there's also some div-by-zero bugs here if runtime is zero:
> 
> $ perf bench epoll wait --runtime=0
> # Running 'epoll/wait' benchmark:
> Run summary [PID 30859]: 7 threads monitoring on 64 file-descriptors for 0
> secs.
> 
> Floating point exception (core dumped)

Can you please submit a patch for that? 

I've applied the other 3 fixes you submitted, thanks for that!

- Arnaldo
 
> > diff --git a/tools/perf/bench/epoll-wait.c b/tools/perf/bench/epoll-
> > wait.c
> > index 7af694437f4e..d1c5cb526b9f 100644
> > --- a/tools/perf/bench/epoll-wait.c
> > +++ b/tools/perf/bench/epoll-wait.c
> > 
> > @@ -519,7 +518,7 @@ int bench_epoll_wait(int argc, const char **argv)
> >  		qsort(worker, nthreads, sizeof(struct worker), cmpworker);
> >  
> >  	for (i = 0; i < nthreads; i++) {
> > -		unsigned long t = worker[i].ops/runtime.tv_sec;
> > +		unsigned long t = worker[i].ops / bench__runtime.tv_sec;
> >  
> >  		update_stats(&throughput_stats, t);
> >  
> > diff --git a/tools/perf/bench/futex-hash.c b/tools/perf/bench/futex-
> > hash.c
> > index 8ba0c3330a9a..21776862e940 100644
> > --- a/tools/perf/bench/futex-hash.c
> > +++ b/tools/perf/bench/futex-hash.c
> > 
> > @@ -204,7 +204,7 @@ int bench_futex_hash(int argc, const char **argv)
> >  	pthread_mutex_destroy(&thread_lock);
> >  
> >  	for (i = 0; i < nthreads; i++) {
> > -		unsigned long t = worker[i].ops/runtime.tv_sec;
> > +		unsigned long t = worker[i].ops / bench__runtime.tv_sec;
> >  		update_stats(&throughput_stats, t);
> >  		if (!silent) {
> >  			if (nfutexes == 1)
> > diff --git a/tools/perf/bench/futex-lock-pi.c b/tools/perf/bench/futex-
> > lock-pi.c
> > index d0cae8125423..30d97121dc4f 100644
> > --- a/tools/perf/bench/futex-lock-pi.c
> > +++ b/tools/perf/bench/futex-lock-pi.c
> > 
> > @@ -211,7 +210,7 @@ int bench_futex_lock_pi(int argc, const char **argv)
> >  	pthread_mutex_destroy(&thread_lock);
> >  
> >  	for (i = 0; i < nthreads; i++) {
> > -		unsigned long t = worker[i].ops/runtime.tv_sec;
> > +		unsigned long t = worker[i].ops / bench__runtime.tv_sec;
> >  
> >  		update_stats(&throughput_stats, t);
> >  		if (!silent)
> 

-- 

- Arnaldo
