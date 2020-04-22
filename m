Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B751FC55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 14:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F5092076E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 14:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgDVOtN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 10:49:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:51414 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726819AbgDVOtM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 10:49:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9ED44AA55;
        Wed, 22 Apr 2020 14:49:10 +0000 (UTC)
Message-ID: <1587566950.9537.107.camel@suse.cz>
Subject: Re: [BISECTED]: Kernel panic (was: Linux 5.7-rc2)
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     Dave Kleikamp <dave.kleikamp@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Harald Arnesen <harald@skogtun.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Wed, 22 Apr 2020 16:49:10 +0200
In-Reply-To: <5b9531e1-e0ae-cf5d-84f2-6bbb5c2cd089@oracle.com>
References: <CAHk-=wiQsJu-ZFjt7+c9FVD5R40khtZiihrT+7O3UaVvHYz=HQ@mail.gmail.com>
         <428bac87-b6dd-0867-c8f8-622cd606de3e@skogtun.org>
         <CAHk-=wiX+NT2yxtdPszH9U_S96MCNQA56GJFXY45mZc47yG5KQ@mail.gmail.com>
         <20200421212347.GV2483@worktop.programming.kicks-ass.net>
         <1587546150.9537.84.camel@suse.cz>
         <5b9531e1-e0ae-cf5d-84f2-6bbb5c2cd089@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-04-22 at 09:12 -0500, Dave Kleikamp wrote:
> On 4/22/20 4:02 AM, Giovanni Gherdovich wrote:
> > Linus, Peter:
> > 
> > the panic seen by Harald Arnesen (and Dave Kleikamp) is unrelated to
> > virtualization, and happens on all machines that have a CPU with less than 4
> > physical cores. It's a very serious (and very stupid) bug in the original
> > version of my code and is fixed by patch 2/4 "x86, sched: Account for CPUs
> > with less than 4 cores in freq. invariance" in the series 
> > 
> > https://lore.kernel.org/lkml/20200416054745.740-1-ggherdovich@suse.cz
> > 
> > Harald, Dave:
> > 
> > for peace of mind, can you please share the output of
> > 
> >   turbostat --interval 1 sleep 0
> 
> This is a Lenovo T410.
> 
> turbostat version 20.03.20 - Len Brown <lenb@kernel.org>
> CPUID(0): GenuineIntel 0xb CPUID levels; 0x80000008 xlevels; family:model:stepping 0x6:25:5 (6:37:5)
> [...]
> cpu0: MSR_TURBO_RATIO_LIMIT: 0x00001416
> 20 * 133.3 = 2666.6 MHz max turbo 2 active cores
> 22 * 133.3 = 2933.3 MHz max turbo 1 active cores


2 cores/ 4 threads, reported 4C turbo frequency of zero (i.e. bits 31:24
in MSR_TURBO_RATIO_LIMIT). This is consistent with all other occurrences
of this bug that have been reported.

Thanks Dave for your reply.


Giovanni
