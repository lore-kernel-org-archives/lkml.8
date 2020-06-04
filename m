Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8338DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 13:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 634C120772
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 13:11:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbgFDNLw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 09:11:52 -0400
Received: from freki.datenkhaos.de ([81.7.17.101]:60592 "EHLO
        freki.datenkhaos.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbgFDNLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 09:11:51 -0400
Received: from localhost (localhost [127.0.0.1])
        by freki.datenkhaos.de (Postfix) with ESMTP id 619B62BBC375;
        Thu,  4 Jun 2020 15:11:50 +0200 (CEST)
Received: from freki.datenkhaos.de ([127.0.0.1])
        by localhost (freki.datenkhaos.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8PHAwIxS7RRD; Thu,  4 Jun 2020 15:11:46 +0200 (CEST)
Received: from latitude (vpn137.rz.tu-ilmenau.de [141.24.172.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by freki.datenkhaos.de (Postfix) with ESMTPSA;
        Thu,  4 Jun 2020 15:11:46 +0200 (CEST)
Date:   Thu, 4 Jun 2020 15:11:41 +0200
From:   Johannes Hirte <johannes.hirte@datenkhaos.de>
To:     Stephane Eranian <eranian@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, mingo@elte.hu,
        Ian Rogers <irogers@google.com>,
        "Phillips, Kim" <kim.phillips@amd.com>,
        Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v2 1/5] perf/x86/rapl: move RAPL support to common x86
 code
Message-ID: <20200604131141.GA678989@latitude>
References: <20200527224659.206129-1-eranian@google.com>
 <20200527224659.206129-2-eranian@google.com>
 <20200601123850.GA213137@latitude>
 <CABPqkBSKF_4BpXxT=LDb786cW5euuOk7oUbnem5=P6BpMtk0ZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPqkBSKF_4BpXxT=LDb786cW5euuOk7oUbnem5=P6BpMtk0ZA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020 Jun 01, Stephane Eranian wrote:
> On Mon, Jun 1, 2020 at 5:39 AM Johannes Hirte
> <johannes.hirte@datenkhaos.de> wrote:
> >
> > On 2020 Mai 27, Stephane Eranian wrote:
> >
> > ...
> > > diff --git a/arch/x86/events/Makefile b/arch/x86/events/Makefile
> > > index 6f1d1fde8b2de..12c42eba77ec3 100644
> > > --- a/arch/x86/events/Makefile
> > > +++ b/arch/x86/events/Makefile
> > > @@ -1,5 +1,6 @@
> > >  # SPDX-License-Identifier: GPL-2.0-only
> > >  obj-y                                        += core.o probe.o
> > > +obj-$(PERF_EVENTS_INTEL_RAPL)                += rapl.o
> > >  obj-y                                        += amd/
> > >  obj-$(CONFIG_X86_LOCAL_APIC)            += msr.o
> > >  obj-$(CONFIG_CPU_SUP_INTEL)          += intel/
> >
> > With this change, rapl won't be build. Must be:
> >
> > obj-$(CONFIG_PERF_EVENTS_INTEL_RAPL)                += rapl.o
> >
> Correct. I posted a patch last week to fix that.
> Thanks.

Yes, it just wasn't in tip when I've tested. Sorry for the noise.

-- 
Regards,
  Johannes Hirte

