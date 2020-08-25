Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4AEC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 10:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9CA52068E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 10:12:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729628AbgHYKM1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 06:12:27 -0400
Received: from foss.arm.com ([217.140.110.172]:55360 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728117AbgHYKMZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 06:12:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0124030E;
        Tue, 25 Aug 2020 03:12:24 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1958E3F66B;
        Tue, 25 Aug 2020 03:12:23 -0700 (PDT)
References: <20200824153902.57875-1-andriy.shevchenko@linux.intel.com> <jhjeenwdl7u.mognet@arm.com> <20200825082636.GQ1891694@smile.fi.intel.com> <jhjd03fdrn3.mognet@arm.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH v1] sched/topology: Make compiler happy about unused constant definitions
In-reply-to: <jhjd03fdrn3.mognet@arm.com>
Date:   Tue, 25 Aug 2020 11:12:21 +0100
Message-ID: <jhjblizdofu.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 25/08/20 10:03, Valentin Schneider wrote:
> On 25/08/20 09:26, Andy Shevchenko wrote:
>> On Mon, Aug 24, 2020 at 06:09:41PM +0100, Valentin Schneider wrote:
>>> On 24/08/20 16:39, Andy Shevchenko wrote:
>>> > Compilation of almost each file ends up with
>>> >
>>> >  In file included from .../include/linux/energy_model.h:10,
>>> >                 from .../include/linux/device.h:16,
>>> >                 from .../drivers/spi/spi.c:8:
>>> >  .../include/linux/sched/topology.h:30:27: warning: ‘SD_DEGENERATE_GROUPS_MASK’ defined but not used [-Wunused-const-variable=]
>>> >     30 | static const unsigned int SD_DEGENERATE_GROUPS_MASK =
>>> >        |                           ^~~~~~~~~~~~~~~~~~~~~~~~~
>>> >  ...
>>> >
>>> > Make compiler happy by annotating the static constants with __maybwe_unused.

> Sorry, that's what I get for trying to be too succinct; what I tried to say
> was that SD_DEGENERATE_GROUPS_MASK should very much be used for SMP. If the
> build is !SMP, it shouldn't even be defined, IOW I'm perplexed as to where
> this is coming from.

So I see how having this as a constvar rather than a constexpr is somewhat
daft (we get an instance per compilation unit), but none of my compilers
seem to complain (even with W=1). AFAIA the kernelbot didn't catch any of
it either.

Out of curiosity, what's your compiler & compiler version?

Alternatively we can make this a "proper" constant expression with the
below.
---

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 2d59ca77103e..b1331c4c48e9 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -27,9 +27,11 @@ enum {

 /* Generate a mask of SD flags with the SDF_NEEDS_GROUPS metaflag */
 #define SD_FLAG(name, mflags) (name * !!((mflags) & SDF_NEEDS_GROUPS)) |
-static const unsigned int SD_DEGENERATE_GROUPS_MASK =
+enum {
+	SD_DEGENERATE_GROUPS_MASK =
 #include <linux/sched/sd_flags.h>
-0;
+0
+};
 #undef SD_FLAG

 #ifdef CONFIG_SCHED_DEBUG
