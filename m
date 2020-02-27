Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B10EC3F34E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D715A24656
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XuBVxWyk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730133AbgB0NoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:44:05 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46598 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730082AbgB0Nn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:43:57 -0500
Received: by mail-qt1-f196.google.com with SMTP id i14so2231034qtv.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 05:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Jys7Gbail/zgLiwqIBiO/p0dxCFqFpihM2t+GeeAp1g=;
        b=XuBVxWyk5pATRPOLJKW8C0BAZtupQu6Cp5Uu375u1kh7JcL9ubmJQqIKWsPK+VcFzI
         OCZfMLf5c3Ca76chbIE7+t2TbqIPRpWD+tAH6dhM+4Z91uFHWA1tTCi1CfEJ/1fELDCL
         98gBOsoAGQUUKd1GCdp3nrzf3GQRdy5HLVN4X5Ll6XVAVrCRDrkQfXu/KuJcMzjeWgdq
         66hu6pPajMpxDEUiyIXXaplTFkaOecUJpVtOz86fhOtclANh4ESeY3mZKBCSz+lQTT3M
         ItJ/ZyMCS/xp4i/hwRjWJ7V7kJq5ZtGCMZ4pNvEt0YLNJSj/2gI1/5SYivQVGTtmbpBZ
         WtWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Jys7Gbail/zgLiwqIBiO/p0dxCFqFpihM2t+GeeAp1g=;
        b=q7kxUfSY72OFIpnLggfmH/+59ERHnJ/32qMcWX3nN5uwoyKf8n/V+KcsIKFr4iQJcw
         WxFp9kTupEIelAKwzukHuk3pF1rXPnxxEmJMy1AqFp7AbJrcomdUn6qxK9JNfecjZ8al
         elJcwH2Ps39ZOlyYrY0M+NE2q5csUVrpGbwk7YJ6nOWoVwXchvVeGWk3NQIed0q1INQH
         a01CRucJ0PXHGo4H3kWilFs70vy4bu+AHIlk47odt1v0LqwtZd5dzXr5tEZotGjfsVJl
         jrTnw3+KiT/U6OZesZRNXnOg2EzgJnVAEGJ0m6WeMj8q8v5u1o0MdY+TXj9ELdCbqyQ7
         UvTQ==
X-Gm-Message-State: APjAAAWaazpp0RxC+H6bYVMHzAsfM/teLPxOMWjD0CcJOzFUIRsD7UrI
        dTKXos2uVJtK3BLToKqmtSY=
X-Google-Smtp-Source: APXvYqzjeJpCG3nDwSfUL+wIfkaFeqy1WGsg3GMCO1vZKso83jGAejz9yEOnG+WNLMLINPOdF3Oy2w==
X-Received: by 2002:aed:29a4:: with SMTP id o33mr4749739qtd.316.1582811036068;
        Thu, 27 Feb 2020 05:43:56 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id 17sm464665qkc.81.2020.02.27.05.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 05:43:55 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9E9CA403AD; Thu, 27 Feb 2020 10:43:53 -0300 (-03)
Date:   Thu, 27 Feb 2020 10:43:53 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        xieyisheng1@huawei.com, alexey.budankov@linux.intel.com,
        treeze.taeung@gmail.com, adrian.hunter@intel.com,
        tmricht@linux.ibm.com, namhyung@kernel.org, irogers@google.com,
        songliubraving@fb.com, yao.jin@linux.intel.com,
        changbin.du@intel.com, leo.yan@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] perf annotate/config: More fixes
Message-ID: <20200227134353.GB10761@kernel.org>
References: <20200213064306.160480-1-ravi.bangoria@linux.ibm.com>
 <20200216211549.GA157041@krava>
 <20200227130846.GA9899@kernel.org>
 <20200227131648.GF34774@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227131648.GF34774@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Feb 27, 2020 at 02:16:48PM +0100, Jiri Olsa escreveu:
> On Thu, Feb 27, 2020 at 10:08:46AM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Sun, Feb 16, 2020 at 10:15:49PM +0100, Jiri Olsa escreveu:
> > > On Thu, Feb 13, 2020 at 12:12:58PM +0530, Ravi Bangoria wrote:
> > > > These are the additional set of fixes on top of previous series:
> > > > http://lore.kernel.org/r/20200204045233.474937-1-ravi.bangoria@linux.ibm.com
> > > > 
> > > > Note for the last patch:
> > > > I couldn't understand what intel-pt.cache-divisor is really used for.
> > > > Adrian, can you please help.
> > > > 
> > > > Ravi Bangoria (8):
> > > >   perf annotate/tui: Re-render title bar after switching back from
> > > >     script browser
> > > >   perf annotate: Fix --show-total-period for tui/stdio2
> > > >   perf annotate: Fix --show-nr-samples for tui/stdio2
> > > >   perf config: Introduce perf_config_u8()
> > > >   perf annotate: Make perf config effective
> > > >   perf annotate: Prefer cmdline option over default config
> > > >   perf annotate: Fix perf config option description
> > > >   perf config: Document missing config options
> > > 
> > > nice, I guess this all worked in the past but got broken because
> > > we don't have any tests for annotation code.. any chance you could
> > 
> > I'm going thru them, can I take that "nice" as an Acked-by? Have you
> > gone thru those patches?
> 
> nope, I just real fast checked on them.. I expected more discussion on tests ;-)

Ok, I tested all of the patches, and merged them, thanks,

- Arnaldo
 
> but as Ravi wrote, it could take some time
> 
> jirka
> 
> > 
> > - Arnaldo
> > 
> > > think of some way to test annotations?
> >  
> > > perhaps some shell script, or prepare all the needed data for annotation
> > > manualy.. sort of like we did in tests/hists_*.c
> > > 
> > > thanks,
> > > jirka
> > > 
> > > > 
> > > >  tools/perf/Documentation/perf-config.txt | 74 +++++++++++++++++++-
> > > >  tools/perf/builtin-annotate.c            |  4 +-
> > > >  tools/perf/builtin-report.c              |  2 +-
> > > >  tools/perf/builtin-top.c                 |  2 +-
> > > >  tools/perf/ui/browsers/annotate.c        | 19 +++--
> > > >  tools/perf/util/annotate.c               | 89 +++++++++---------------
> > > >  tools/perf/util/annotate.h               |  6 +-
> > > >  tools/perf/util/config.c                 | 12 ++++
> > > >  tools/perf/util/config.h                 |  1 +
> > > >  9 files changed, 134 insertions(+), 75 deletions(-)
> > > > 
> > > > -- 
> > > > 2.24.1
> > > > 
> > > 
> > 
> > -- 
> > 
> > - Arnaldo
> > 
> 

-- 

- Arnaldo
