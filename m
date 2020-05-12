Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E055C54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D733C206F5
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZUEDTd9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730148AbgELOJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 10:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbgELOJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 10:09:07 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646EBC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 07:09:07 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id y22so1019711qki.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 07:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6/uIsxWQn8xUBY6PuZWN340e2D798d3iUe7b5tSjlu4=;
        b=jZUEDTd9Pbyxy86CFcIgLT3Xq+vWSzd+naUcc1wuiyzIb19DQ3oPCcriApygsVi/fK
         zrkvdQQXLd6B5ygxVuuhgIOblr764uGadJG12herxFL/OnZGWAxs3AvytnCp8AYjkLf9
         AqJY1azQlzlJSaWOHOh83tez8n8MOC1Lhlcr8pfzy4pFO+ZVJgEfNTTF7+NOEnnregS6
         peS9ohxm1hfKJkiszWpAM9KzYzMWIFOwR7vHD7sgXhvWOSJWTH2ozLigW6NH09vYbwLN
         SMFUzsAxlvufVKdXZJNvlCMtJBQZRNj+v8sT1B9SkK0Ex2ZfMMvilbOHJg2Xk4NBWnVB
         Huog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6/uIsxWQn8xUBY6PuZWN340e2D798d3iUe7b5tSjlu4=;
        b=lghNUfFVKfqkdHwudpcyLH3Yoj9Cj31jrDwfVp3zlCXo3KQQpfdyA8eWZ9f18er3/N
         mTjGMLhbR1+mxWi8TRtJio5oiKwwr39eMQVKpKSZO4ERP+3CbTvHV24T930evA9LH2Ia
         SO7D2+yaO+01wi1qJIgzxiOn7C/98zKBwdf+k1SVNDGrN4F9/NkqL/QwT9TYPR8foMGq
         yT0s1pn7diTNYFZYjCLYcbCMtAbmiX03nA3Y+E9zYTY1UOE9fgOF71ntGJV2zlR1RrAW
         isfDqFpgRxr1sxWIGTBKpQGVywmgvVn/sX6DXbzPipxVGPzj1Hg3+r2E4KGq1wJatIby
         pJJg==
X-Gm-Message-State: AGi0PuboAbUR2S8rSooEDtjkuM241+m4Te5NRLAEx9Q+N+ovtokVaa5d
        XaLKeWBkrTRyC2C2YOJ66PyfJtfHXJg=
X-Google-Smtp-Source: APiQypJ8FVdVJ3xWnl/Fd4UGJ/K3PE6MEveItln32QIJw4YM3ctMkuWaD2olNha5f8IyPkoIMDh1lQ==
X-Received: by 2002:a05:620a:816:: with SMTP id s22mr21389690qks.348.1589292546495;
        Tue, 12 May 2020 07:09:06 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id c25sm5880872qkm.119.2020.05.12.07.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 07:09:06 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D1EB740AFD; Tue, 12 May 2020 11:09:02 -0300 (-03)
Date:   Tue, 12 May 2020 11:09:02 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH perf/urgent] perf tools: Fix is_bpf_image function logic
Message-ID: <20200512140902.GK28888@kernel.org>
References: <20200512122310.3154754-1-jolsa@kernel.org>
 <20200512133223.GI28888@kernel.org>
 <20200512133609.GA3158213@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512133609.GA3158213@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, May 12, 2020 at 03:36:09PM +0200, Jiri Olsa escreveu:
> On Tue, May 12, 2020 at 10:32:23AM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Tue, May 12, 2020 at 02:23:10PM +0200, Jiri Olsa escreveu:
> > > Adrian reported that is_bpf_image is not working the way it was
> > > intended - passing on trampolines and dispatcher names. Instead
> > > it returned true for all the bpf names.
> > > 
> > > The reason even this logic worked properly is that all bpf objects,
> > > even trampolines and dispatcher, were assigned DSO_BINARY_TYPE__BPF_IMAGE
> > > binary_type.
> > > 
> > > The later for bpf_prog objects, the binary_type was fixed in bpf load event
> > > processing, which is executed after the ksymbol code.
> > > 
> > > Fixing the is_bpf_image logic, so it properly recognizes trampoline
> > > and dispatcher objects.
> > 
> > This is not applying on top of torvalds/master, not tip/perf/urgent, and
> 
> right.. it's on top of your's perf/core.. I can rebase on perf/urgent

You don't need to, this hasn't hit torvalds/master, it'll be in the next
merge window, the one for 5.8.
 
> > you forgot to add the Fixes: line, lemme try to find this...
> 
> oops, sorry
> 
>Fixes: 3c29d4483e85 ("perf annotate: Add basic support for bpf_image")

I did it already, and:

[acme@five perf]$ git tag --contains 3c29d4483e85
perf-core-for-mingo-5.8-20200420
perf-core-for-mingo-5.8-20200506
perf-for-bpf-2020-05-06
[acme@five perf]$

So can't go to perf/urgent at the moment.

- Arnaldo
 
> jirka
> 
> > 
> > - Arnaldo
> >  
> > > Reported-by: Adrian Hunter <adrian.hunter@intel.com>
> > > Signed-off-by: Jiri Olsa <jolsa@redhat.com>
> > > ---
> > >  tools/perf/util/machine.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> > > index 8ed2135893bb..d5384807372b 100644
> > > --- a/tools/perf/util/machine.c
> > > +++ b/tools/perf/util/machine.c
> > > @@ -738,8 +738,8 @@ int machine__process_switch_event(struct machine *machine __maybe_unused,
> > >  
> > >  static int is_bpf_image(const char *name)
> > >  {
> > > -	return strncmp(name, "bpf_trampoline_", sizeof("bpf_trampoline_") - 1) ||
> > > -	       strncmp(name, "bpf_dispatcher_", sizeof("bpf_dispatcher_") - 1);
> > > +	return strncmp(name, "bpf_trampoline_", sizeof("bpf_trampoline_") - 1) == 0 ||
> > > +	       strncmp(name, "bpf_dispatcher_", sizeof("bpf_dispatcher_") - 1) == 0;
> > >  }
> > >  
> > >  static int machine__process_ksymbol_register(struct machine *machine,
> > > -- 
> > > 2.25.4
> > > 
> > 
> > -- 
> > 
> > - Arnaldo
> > 
> 

-- 

- Arnaldo
