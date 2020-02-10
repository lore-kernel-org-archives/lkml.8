Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FCF1C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E891E2070A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:13:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBeV3rRe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730459AbgBJNNk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:13:40 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44545 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729195AbgBJNNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 08:13:38 -0500
Received: by mail-qk1-f195.google.com with SMTP id v195so6349289qkb.11;
        Mon, 10 Feb 2020 05:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ELueoEBRkgTl4B40PNsdNYDb0SBaJjBLOAUumLTiqbY=;
        b=MBeV3rRewhJ8Z2qz4yOAmR2cWhPbcyZKmrSvWF15ozDZE1h81jcU9LY2Pn6IbvL5I9
         pNWo9o+969vGIuz7+NkmwV6QtVvaucOiQsVtwLlla4OOhhxVXjLXeRGFtrKa2M2SdQ9m
         bhchhU+FqFra2W3Z8z04qnOsXi5Bi3GvUX1B6tQ8uw2x8J2HzS6wnASao6T5lYCbWCX2
         DvNNht/FONbVZ8tagNaH8yEX9mzX3ds9q2cL3ssTdk/MT5uLqvUcb3nA3kg73lo8o8og
         HfZMxba6OZMXnlw3up4ocgi/kOzbGWY3o6PtZslz2+Zqg7Sh5GXLJsDxLWfip5jWC40R
         MjLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ELueoEBRkgTl4B40PNsdNYDb0SBaJjBLOAUumLTiqbY=;
        b=lfyBj1KjVG1zt09tR425XT0dQe+VSVBMPUgsxl8/PuCxwf7sCk+stoEkJBm0VqWaNB
         qy7etA2nAVE7SqKouRRJfPg+88427AETkIRRxD7O4p8E7HLlaCbtSynIa8f0ETXnfeBN
         gxkWSG3QcfLAekUEOaMWrRDIrOx3a/QUQQ5Qzb9w9i2OkLRFCiLu1nVY9ACvasIE5ler
         tUK54dvgU0jwZ2z0MrCNLERIu9q2wHBXlBdgEaO1gGbxrxIuQ8HbzdVaVPObfWkjW1Ug
         3/mnjgyB25B9ev4yjaokRayznAhaT6hsQCnclIvFIfC4bgWcDroV2bjjmvkYyyloOXDQ
         wF0A==
X-Gm-Message-State: APjAAAXA+PUxKzUPUYRAQWbb+6uVRG4aJJhex6ngLv1zjYrFJgXKNr20
        iZvrPujfdg5r4d8BHAs/Ono=
X-Google-Smtp-Source: APXvYqxCw4A7soOdnOjruGJgVoLWi5AiQxVeCMMpgBwVZoZJPeI4B7eBJrBjF8xNDhGYBoBTQLwSvw==
X-Received: by 2002:a37:2e43:: with SMTP id u64mr1116241qkh.387.1581340415783;
        Mon, 10 Feb 2020 05:13:35 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id j196sm107192qke.102.2020.02.10.05.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 05:13:35 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 09B6640A7D; Mon, 10 Feb 2020 10:13:33 -0300 (-03)
Date:   Mon, 10 Feb 2020 10:13:32 -0300
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 3/4] perf map: Set kmap->kmaps backpointer for main
 kernel map chunks
Message-ID: <20200210131332.GB3416@kernel.org>
References: <20191223133241.8578-1-acme@kernel.org>
 <20191223133241.8578-4-acme@kernel.org>
 <2617ead1-60e2-3da6-cde6-9efd68412139@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2617ead1-60e2-3da6-cde6-9efd68412139@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Feb 06, 2020 at 03:10:38PM +0530, Ravi Bangoria escreveu:
> Hi Arnaldo,
> 
> On 12/23/19 7:02 PM, Arnaldo Carvalho de Melo wrote:
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > 
> > When a map is create to represent the main kernel area (vmlinux) with
> > map__new2() we allocate an extra area to store a pointer to the 'struct
> > maps' for the kernel maps, so that we can access that struct when
> > loading ELF files or kallsyms, as we will need to split it in multiple
> > maps, one per kernel module or ELF section (such as ".init.text").
> > 
> > So when map->dso->kernel is non-zero, it is expected that
> > map__kmap(map)->kmaps to be set to the tree of kernel maps (modules,
> > chunks of the main kernel, bpf progs put in place via
> > PERF_RECORD_KSYMBOL, the main kernel).
> > 
> > This was not the case when we were splitting the main kernel into chunks
> > for its ELF sections, which ended up making 'perf report --children'
> > processing a perf.data file with callchains to trip on
> > __map__is_kernel(), when we press ENTER to see the popup menu for main
> > histogram entries that starts at a symbol in the ".init.text" ELF
> > section, e.g.:
> > 
> > -    8.83%     0.00%  swapper     [kernel.vmlinux].init.text  [k] start_kernel
> >       start_kernel
> >       cpu_startup_entry
> >       do_idle
> >       cpuidle_enter
> >       cpuidle_enter_state
> >       intel_idle
> > 
> > Fix it.
> 
> perf top from perf/core has started crashing at __map__is_kernel():
> 
>   (gdb) bt
>   #0  __map__is_kernel (map=<optimized out>) at util/map.c:935
>   #1  0x000000000045551d in perf_event__process_sample (machine=0xbab8f8,
>       sample=0x7fffe5ffa6d0, evsel=0xba7570, event=0xbcac50, tool=0x7fffffff84e0)
>       at builtin-top.c:833
>   #2  deliver_event (qe=<optimized out>, qevent=<optimized out>) at builtin-top.c:1192
>   #3  0x000000000050b9fb in do_flush (show_progress=false, oe=0x7fffffff87e0)
>       at util/ordered-events.c:244
>   #4  __ordered_events__flush (oe=oe@entry=0x7fffffff87e0, how=how@entry=OE_FLUSH__TOP,
>       timestamp=timestamp@entry=0) at util/ordered-events.c:323
>   #5  0x000000000050c1b5 in __ordered_events__flush (timestamp=<optimized out>,
>       how=<optimized out>, oe=<optimized out>) at util/ordered-events.c:339
>   #6  ordered_events__flush (how=OE_FLUSH__TOP, oe=0x7fffffff87e0) at util/ordered-events.c:341
>   #7  ordered_events__flush (oe=oe@entry=0x7fffffff87e0, how=how@entry=OE_FLUSH__TOP)
>       at util/ordered-events.c:339
>   #8  0x0000000000454e21 in process_thread (arg=0x7fffffff84e0) at builtin-top.c:1104
>   #9  0x00007ffff7f2c4e2 in start_thread () from /lib64/libpthread.so.0
>   #10 0x00007ffff76086d3 in clone () from /lib64/libc.so.6
> 
> I haven't debugged it much but seems like the actual patch that's causing the
> crash is de90d513b246 ("perf map: Use map->dso->kernel + map__kmaps() in
> map__kmaps()").
> 
> Did you face this / aware of it?

No, I wasn't aware of this, will check, getting back from vacations
today, so may take some time,

- Arnaldo
