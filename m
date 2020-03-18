Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8575C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 14:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82CD020752
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 14:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cg+tSaG3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgCROqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 10:46:55 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45119 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbgCROqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 10:46:55 -0400
Received: by mail-qt1-f193.google.com with SMTP id z8so17453304qto.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 07:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eh/Ib4EsyafdGPI0DMwjZV/QaVZ3bLQMWRWBWNBBqHk=;
        b=Cg+tSaG3i752Nqi49qTaSi53c1mrgc5pDqUcioClwMg0R0IQ5TMF62UtdONDArXJEb
         83114Ra1HPHiVxPfn+XXIiyhNlfo+9fx4r+Jq8m/X8VZONbMoCEsyYXiqWbIRtmZALPb
         +VNb5w1nfwNHdeocO7z5XYy7UKRZh1qTdXI3eTnMzO25cFfLQDbJbpoO/NDShf7a2Llj
         H1KVqdxoQJLkxoSbwt8k7bZqDdRV0nfAkJWKdX+k3cYJ5+6vaJSBQM+943+AGzZVbkt1
         XFY4PlXjRe0fge7kbP6TIhMd/hqUDEQthsanhRi2L0J6YZC4/pvEMFOSv6LvPmCXf+wY
         F1fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eh/Ib4EsyafdGPI0DMwjZV/QaVZ3bLQMWRWBWNBBqHk=;
        b=OXp8ht84XiAWepluVOQRk1ie6POpeNJj0lN2WowpPCDKvckXCyBBNK2v0oCoCXFKQu
         mk1cDpPIDqs30ifoBro5jISDpdL6D+K8fPo2Zi4/AgNY0nsua+J2LXN4UhcRiUiBnmnT
         XaWvu4+nbq26hVZj7uB9iYRP9lky1jhRHFdW/2ikukocx+cUbgkvN7gm3fmaCHyCYL3c
         Dm/ZvFoQuL2yxrtpBbYIK3dAGx1NmlcGn2+OqOitGy/q0FGcYiAlXkj92e8CMfPqO7sK
         xYJob5rLhGsq2XwISmsmiv1IyeirNmW04+lRoioj/WN67TAfvN6A7aIPq/sX9uOaDqCg
         3dmg==
X-Gm-Message-State: ANhLgQ02d/NxIHQzLagQ1tutcGPJXHKRaO1Z4VQqWDLl0BfYtb/NrPjy
        UYBcOcWR0Z3L5YcI0wKe2WQ=
X-Google-Smtp-Source: ADFU+vvJlT6ur/t6sxwglZqpVQ1AUbmmJHS2fsz6+YJoliw66FGjJ1hkSqwF11aADg7uQFZSxbW0Xw==
X-Received: by 2002:ac8:6c6:: with SMTP id j6mr4748317qth.231.1584542813294;
        Wed, 18 Mar 2020 07:46:53 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id w132sm4161807qkb.96.2020.03.18.07.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 07:46:52 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B9C39404E4; Wed, 18 Mar 2020 11:46:49 -0300 (-03)
Date:   Wed, 18 Mar 2020 11:46:49 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        John Garry <john.garry@huawei.com>,
        Enrico Weigelt <info@metux.net>, linux-kernel@vger.kernel.org,
        Mike Leach <mike.leach@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>
Subject: Re: [PATCH v3] perf symbols: Consolidate symbol fixup issue
Message-ID: <20200318144649.GE11531@kernel.org>
References: <20200306015759.10084-1-leo.yan@linaro.org>
 <20200318110659.GA845874@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318110659.GA845874@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 18, 2020 at 12:06:59PM +0100, Jiri Olsa escreveu:
> On Fri, Mar 06, 2020 at 09:57:58AM +0800, Leo Yan wrote:
> > After copying Arm64's perf archive with object files and perf.data file
> > to x86 laptop, the x86's perf kernel symbol resolution fails.  It
> > outputs 'unknown' for all symbols parsing.
> > 
> > This issue is root caused by the function elf__needs_adjust_symbols(),
> > x86 perf tool uses one weak version, Arm64 (and powerpc) has rewritten
> > their own version.  elf__needs_adjust_symbols() decides if need to parse
> > symbols with the relative offset address; but x86 building uses the weak
> > function which misses to check for the elf type 'ET_DYN', so that it
> > cannot parse symbols in Arm DSOs due to the wrong result from
> > elf__needs_adjust_symbols().
> > 
> > The DSO parsing should not depend on any specific architecture perf
> > building; e.g. x86 perf tool can parse Arm and Arm64 DSOs, vice versa.
> > And confirmed by Naveen N. Rao that powerpc64 kernels are not being
> > built as ET_DYN anymore and change to ET_EXEC.
> > 
> > This patch removes the arch specific functions for Arm64 and powerpc and
> > changes elf__needs_adjust_symbols() as a common function.
> > 
> > In the common elf__needs_adjust_symbols(), it checks an extra condition
> > 'ET_DYN' for elf header type.  With this fixing, the Arm64 DSO can be
> > parsed properly with x86's perf tool.
> > 
> > Before:
> > 
> >   # perf script
> >   main  3258          1          branches:                 0 [unknown] ([unknown]) => ffff800010c4665c [unknown] ([kernel.kallsyms])
> >   main  3258          1          branches:  ffff800010c46670 [unknown] ([kernel.kallsyms]) => ffff800010c4eaec [unknown] ([kernel.kallsyms])
> >   main  3258          1          branches:  ffff800010c4eaec [unknown] ([kernel.kallsyms]) => ffff800010c4eb00 [unknown] ([kernel.kallsyms])
> >   main  3258          1          branches:  ffff800010c4eb08 [unknown] ([kernel.kallsyms]) => ffff800010c4e780 [unknown] ([kernel.kallsyms])
> >   main  3258          1          branches:  ffff800010c4e7a0 [unknown] ([kernel.kallsyms]) => ffff800010c4eeac [unknown] ([kernel.kallsyms])
> >   main  3258          1          branches:  ffff800010c4eebc [unknown] ([kernel.kallsyms]) => ffff800010c4ed80 [unknown] ([kernel.kallsyms])
> > 
> > After:
> > 
> >   # perf script
> >   main  3258          1          branches:                 0 [unknown] ([unknown]) => ffff800010c4665c coresight_timeout+0x54 ([kernel.kallsyms])
> >   main  3258          1          branches:  ffff800010c46670 coresight_timeout+0x68 ([kernel.kallsyms]) => ffff800010c4eaec etm4_enable_hw+0x3cc ([kernel.kallsyms])
> >   main  3258          1          branches:  ffff800010c4eaec etm4_enable_hw+0x3cc ([kernel.kallsyms]) => ffff800010c4eb00 etm4_enable_hw+0x3e0 ([kernel.kallsyms])
> >   main  3258          1          branches:  ffff800010c4eb08 etm4_enable_hw+0x3e8 ([kernel.kallsyms]) => ffff800010c4e780 etm4_enable_hw+0x60 ([kernel.kallsyms])
> >   main  3258          1          branches:  ffff800010c4e7a0 etm4_enable_hw+0x80 ([kernel.kallsyms]) => ffff800010c4eeac etm4_enable+0x2d4 ([kernel.kallsyms])
> >   main  3258          1          branches:  ffff800010c4eebc etm4_enable+0x2e4 ([kernel.kallsyms]) => ffff800010c4ed80 etm4_enable+0x1a8 ([kernel.kallsyms])
> > 
> > v3: Changed to check for ET_DYN across all architectures.
> > 
> > v2: Fixed Arm64 and powerpc native building.
> > 
> > Reported-by: Mike Leach <mike.leach@linaro.org>
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > Reviewed-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks, applied.

- Arnaldo
