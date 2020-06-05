Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DF8C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 18:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91B77206FA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 18:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbgFESgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 14:36:03 -0400
Received: from winnie.ispras.ru ([83.149.199.91]:22679 "EHLO smtp.ispras.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726448AbgFESgC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 14:36:02 -0400
Received: from monopod.intra.ispras.ru (monopod.intra.ispras.ru [10.10.3.121])
        by smtp.ispras.ru (Postfix) with ESMTP id D0453203BF;
        Fri,  5 Jun 2020 21:35:56 +0300 (MSK)
Date:   Fri, 5 Jun 2020 21:35:56 +0300 (MSK)
From:   Alexander Monakov <amonakov@ispras.ru>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
cc:     linux-kernel@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>, qperret@google.com,
        juri.lelli@redhat.com,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Doug Smythies <dsmythies@telus.net>
Subject: Re: schedutil issue with serial workloads
In-Reply-To: <c3145e26-56c8-4979-513c-cfac191e989b@intel.com>
Message-ID: <alpine.LNX.2.20.13.2006052058560.3984@monopod.intra.ispras.ru>
References: <alpine.LNX.2.20.13.2006042341160.3984@monopod.intra.ispras.ru> <c3145e26-56c8-4979-513c-cfac191e989b@intel.com>
User-Agent: Alpine 2.20.13 (LNX 116 2015-12-14)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Jun 2020, Rafael J. Wysocki wrote:

> > This sounds like it should be a known problem, but I couldn't find any
> > mention of it in the documentation.
> 
> Well, what would you expect to happen instead of what you see?

Not sure why you ask. Named workloads are pretty common for example on
"build-bot" machines. If you don't work exclusively on the kernel you
probably recognize that on, let's say, more "traditionally engineered"
packages ./configure can take 10x more wall-clock time than subsequent
'make -j $(nproc)', and if schedutil makes the problem worse by
consistently choosing the lowest possible frequency for the configure
phase, that's a huge pitfall that's worth fixing or documenting.

To answer your question, assuming schedutil is intended to become a good
choice for a wide range of use-cases, I'd expect it to choose a high
frequency, ideally the highest, and definitely not the lowest. I think I
was pretty transparent about that in my initial mail. I understand there
is no obvious fix and inventing one may prove difficult.

Short term, better Kconfig help text to help people make a suitable choice
for their workloads would be nice.

I'd also like to point out that current Kconfig is confusingly worded
where it says "If the utilization is frequency-invariant, ...". It can
be interpreted as "the workload is producing the same utilization
irrespective of frequency", but what it actually refers to is the
implementation detail of how the "utilization" metric is interpreted.
Does that sentence need to be in Kconfig help at all?

Thanks.
Alexander
