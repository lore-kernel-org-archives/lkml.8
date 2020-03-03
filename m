Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CADC4C3F2D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 15:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DF4E20828
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 15:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pB5jYaHq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730039AbgCCPgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 10:36:31 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:39104 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgCCPga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 10:36:30 -0500
Received: by mail-qv1-f68.google.com with SMTP id fc12so1844983qvb.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 07:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KtX6PVs2ux7EM3PUzlpnr7mxocSNdXtdq//SFYl7/7o=;
        b=pB5jYaHq9oivPLg4f3b/WQiwiVzQlFIDDzmE3Dp7ydvOAU15lwd3jHkJhMAavK50i0
         EXpbCDtxneMEqXWYJfA9jaD4vjPKItcPBuuOkjE/4wHs3NEfGm9rYLK+oGurw5b/Uqu1
         //FC9Z5xU97Ri7MqOu2IhLU4SxWwS4t41YOk4PjWntRF/p4NKAmJkN4zhrham31L6hM6
         TgPpSegNmQDaOOvb8Y6YB4cLzpXZuXIuxa4YOkMVZBdknzbZle45YmMcKXn12CwuaCnN
         GOQtHxtjQA/91p7jj6UhAFfGCXrDHHgXdeUYJTTohVUzFr0TIA+h1gOv4UQJ8MkpYinj
         Np/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KtX6PVs2ux7EM3PUzlpnr7mxocSNdXtdq//SFYl7/7o=;
        b=FiR1W749F4/UU6b6U8cyT+UTXsr62cvO/xEFzdvluMsEoCqUUL7QNn8rYLpTxJpdxE
         OlC6uH9E0PIDzvsOU8sZVeOPmmius4G2jS+X5FrXZ50ec04VPi+ruO6KSQozQJ9sYMqN
         8ugzztwGz9uJiLd6RhqvMlNbHG++W8/F6799Y3DEn5qE/59hMVQ3i/Wf3u3DStSaeMGk
         UXHOrB5lX0MVOggMovYy5vgjQeyeEitdAEoh7Nc8qh0qJXC2nNcjlHgFx4nf9ep5cF/c
         EnDmD77TiU0QytkRh9fHFUJOvKGEemCw9cfmEQ+Zb5RKfaP3X4xWIYa5x9LSThqa5afY
         2n8w==
X-Gm-Message-State: ANhLgQ2ZNh9L830CNAbBjABn3FDLBRzmmwNr2Ag/71UaNdfJx83+B1cS
        0D6IED/pepo31NR26XFS/UB2RHM/2TU=
X-Google-Smtp-Source: ADFU+vtTKeqCpxsTBr0cUm+ZsBxPLCGW64o79x/4ls2E6/i5sIycR4oQYJ8jUXOJJ1BVxBeUkh2rHg==
X-Received: by 2002:a0c:db05:: with SMTP id d5mr4393720qvk.226.1583249789930;
        Tue, 03 Mar 2020 07:36:29 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id l6sm12421459qti.10.2020.03.03.07.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 07:36:29 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 28018403AD; Tue,  3 Mar 2020 12:36:27 -0300 (-03)
Date:   Tue, 3 Mar 2020 12:36:27 -0300
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf bench: Share 'start', 'end', 'runtime' global vars
Message-ID: <20200303153627.GC13702@kernel.org>
References: <20200302150914.GB28183@kernel.org>
 <87tv35cv9u.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tv35cv9u.fsf@nanos.tec.linutronix.de>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Mar 03, 2020 at 04:28:45PM +0100, Thomas Gleixner escreveu:
> Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> writes:
> 
> > Hi,
> >
> > 	Noticed with gcc 10 (fedora rawhide) that those variables were
> > not being declared as static, so end up with:
> >
> > ld: /tmp/build/perf/bench/epoll-wait.o:/git/perf/tools/perf/bench/epoll-wait.c:93: multiple definition of `end'; /tmp/build/perf/bench/futex-hash.o:/git/perf/tools/perf/bench/futex-hash.c:40: first defined here
> > ld: /tmp/build/perf/bench/epoll-wait.o:/git/perf/tools/perf/bench/epoll-wait.c:93: multiple definition of `start'; /tmp/build/perf/bench/futex-hash.o:/git/perf/tools/perf/bench/futex-hash.c:40: first defined here
> > ld: /tmp/build/perf/bench/epoll-wait.o:/git/perf/tools/perf/bench/epoll-wait.c:93: multiple definition of `runtime'; /tmp/build/perf/bench/futex-hash.o:/git/perf/tools/perf/bench/futex-hash.c:40: first defined here
> > ld: /tmp/build/perf/bench/epoll-ctl.o:/git/perf/tools/perf/bench/epoll-ctl.c:38: multiple definition of `end'; /tmp/build/perf/bench/futex-hash.o:/git/perf/tools/perf/bench/futex-hash.c:40: first defined here
> > ld: /tmp/build/perf/bench/epoll-ctl.o:/git/perf/tools/perf/bench/epoll-ctl.c:38: multiple definition of `start'; /tmp/build/perf/bench/futex-hash.o:/git/perf/tools/perf/bench/futex-hash.c:40: first defined here
> > ld: /tmp/build/perf/bench/epoll-ctl.o:/git/perf/tools/perf/bench/epoll-ctl.c:38: multiple definition of `runtime'; /tmp/build/perf/bench/futex-hash.o:/git/perf/tools/perf/bench/futex-hash.c:40: first defined here
> > make[4]: *** [/git/perf/tools/build/Makefile.build:145: /tmp/build/perf/bench/perf-in.o] Error 1
> >
> > 	Just prefixing them with 'extern' in all but one (futex-hash.c)
> > seems to be enough, ok?
> 
> Don't we have header files for that?

Sure, that was the laziest/quickest way to "fix" that, the other was to
stick a 'static' in front of it.

I'll go see if pushing them to a header file will not clash with other
stuff.

- Arnaldo
