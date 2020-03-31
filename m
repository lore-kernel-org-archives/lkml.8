Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9159C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 18:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F5E0212CC
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 18:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbgCaSLb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 14:11:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:58604 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbgCaSLb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 14:11:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E9855AC52;
        Tue, 31 Mar 2020 18:11:26 +0000 (UTC)
Message-ID: <1585678285.30493.27.camel@suse.cz>
Subject: Re: [tip: sched/core] x86, sched: Add support for frequency
 invariance
From:   Giovanni Gherdovich <ggherdovich@suse.cz>
To:     Chris Wilson <chris@chris-wilson.co.uk>,
        linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        tip-bot2 for Giovanni Gherdovich <tip-bot2@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Doug Smythies <dsmythies@telus.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        x86 <x86@kernel.org>
Date:   Tue, 31 Mar 2020 20:11:25 +0200
In-Reply-To: <158556634294.3228.4889951961483021094@build.alporthouse.com>
References: <20200122151617.531-2-ggherdovich@suse.cz>
         <158029757853.396.10568128383380430250.tip-bot2@tip-bot2>
         <158556634294.3228.4889951961483021094@build.alporthouse.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-03-30 at 12:05 +0100, Chris Wilson wrote:
> Quoting tip-bot2 for Giovanni Gherdovich (2020-01-29 11:32:58)
> > The following commit has been merged into the sched/core branch of tip:
> > 
> > Commit-ID:     1567c3e3467cddeb019a7b53ec632f834b6a9239
> > Gitweb:        https://git.kernel.org/tip/1567c3e3467cddeb019a7b53ec632f834b6a9239
> > Author:        Giovanni Gherdovich <ggherdovich@suse.cz>
> > AuthorDate:    Wed, 22 Jan 2020 16:16:12 +01:00
> > Committer:     Ingo Molnar <mingo@kernel.org>
> > CommitterDate: Tue, 28 Jan 2020 21:36:59 +01:00
> > [...]
>
> Since this has become visible via linux-next [20200326?], we have been
> deluged by oops during cpu-hotplug.
> 
> <6> [184.949219] [IGT] perf_pmu: starting subtest cpu-hotplug
> <4> [185.092279] IRQ 24: no longer affine to CPU0
> <4> [185.092285] IRQ 25: no longer affine to CPU0
> <6> [185.093709] smpboot: CPU 0 is now offline
> <6> [186.107062] smpboot: Booting Node 0 Processor 0 APIC 0x0
> <3> [186.107643] BUG: sleeping function called from invalid context at ./include/linux/percpu-rwsem.h:49
> <3> [186.107648] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 0, name: swapper/0
> [...]
> 
> repeating ad nauseam, e.g.
> https://intel-gfx-ci.01.org/tree/linux-next/next-20200327/shard-hsw4/dmesg9.txt
> 
> Across all our test boxen.
> -Chris

Hello Chris,

thank you for catching this problem and sorry for the mess.

Until your message I wasn't aware that CPU0 can be hotplugged, but now that I
check the feature is been there since v3.8 :/

The code assumes cpu0 is always there and I need to fix that.

It seems your report comes from executing an automated test suite, can you
give me a link to the test sources and a hint on how to run it? I'd like to
reproduce locally so that I make sure I correctly address this problem.

Thanks,
Giovanni
