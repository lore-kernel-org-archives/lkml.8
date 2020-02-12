Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8364DC2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 14:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6037B20714
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 14:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbgBLOyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 09:54:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:35302 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727231AbgBLOyo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 09:54:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 85253AFC6;
        Wed, 12 Feb 2020 14:54:42 +0000 (UTC)
Date:   Wed, 12 Feb 2020 15:54:41 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Subject: Re: [PATCH] kernel/watchdog: flush all printk nmi buffers when
 hardlockup detected
Message-ID: <20200212145441.ukhvil6tpljsivvl@pathway.suse.cz>
References: <158132813726.1980.17382047082627699898.stgit@buzz>
 <e80b3a66-35a3-1386-b35a-94837937956b@virtuozzo.com>
 <c3ce3cee-c757-f76e-8d43-33e9b9ae80ba@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3ce3cee-c757-f76e-8d43-33e9b9ae80ba@yandex-team.ru>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2020-02-11 15:36:02, Konstantin Khlebnikov wrote:
> On 11/02/2020 11.14, Kirill Tkhai wrote:
> > Hi, Konstantin,
> > 
> > On 10.02.2020 12:48, Konstantin Khlebnikov wrote:
> > > In NMI context printk() could save messages into per-cpu buffers and
> > > schedule flush by irq_work when IRQ are unblocked. This means message
> > > about hardlockup appears in kernel log only when/if lockup is gone.
> > > 
> > > Comment in irq_work_queue_on() states that remote IPI aren't NMI safe
> > > thus printk() cannot schedule flush work to another cpu.
> > > 
> > > This patch adds simple atomic counter of detected hardlockups and
> > > flushes all per-cpu printk buffers in context softlockup watchdog
> > > at any other cpu when it sees changes of this counter.
> > > 
> > > Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> > > ---
> > >   include/linux/nmi.h   |    1 +
> > >   kernel/watchdog.c     |   22 ++++++++++++++++++++++
> > >   kernel/watchdog_hld.c |    1 +
> > >   3 files changed, 24 insertions(+)
> > > 
> > > diff --git a/include/linux/nmi.h b/include/linux/nmi.h
> > > index 9003e29cde46..8406df72ae5a 100644
> > > --- a/include/linux/nmi.h
> > > +++ b/include/linux/nmi.h
> > > @@ -84,6 +84,7 @@ static inline void reset_hung_task_detector(void) { }
> > >   #if defined(CONFIG_HARDLOCKUP_DETECTOR)
> > >   extern void hardlockup_detector_disable(void);
> > >   extern unsigned int hardlockup_panic;
> > > +extern atomic_t hardlockup_detected;
> > >   #else
> > >   static inline void hardlockup_detector_disable(void) {}
> > >   #endif
> > > diff --git a/kernel/watchdog.c b/kernel/watchdog.c
> > > index b6b1f54a7837..9f5c68fababe 100644
> > > --- a/kernel/watchdog.c
> > > +++ b/kernel/watchdog.c
> > > @@ -92,6 +92,26 @@ static int __init hardlockup_all_cpu_backtrace_setup(char *str)
> > >   }
> > >   __setup("hardlockup_all_cpu_backtrace=", hardlockup_all_cpu_backtrace_setup);
> > >   # endif /* CONFIG_SMP */
> > > +
> > > +atomic_t hardlockup_detected = ATOMIC_INIT(0);
> > > +
> > > +static inline void flush_hardlockup_messages(void)
> > > +{
> > > +	static atomic_t flushed = ATOMIC_INIT(0);
> > > +
> > > +	/* flush messages from hard lockup detector */
> > > +	if (atomic_read(&hardlockup_detected) != atomic_read(&flushed)) {
> > > +		atomic_set(&flushed, atomic_read(&hardlockup_detected));
> > > +		printk_safe_flush();
> > > +	}
> > > +}
> > 
> > Do we really need two variables here? They may come into two different
> > cache lines, and there will be double cache pollution just because of
> > this simple check. Why not the below?
> 
> I don't think anybody could notice read-only access to second variable.
> This executes once in several seconds.
> 
> Watchdogs already use same pattern (monotonic counter + snapshot) in
> couple places. So code looks more clean in this way.

It is not only about speed. It is also about code complexity
and correctness. Using two variables is more complex.
Calling atomic_read(&hardlockup_detected) twice does
not look like a correct pattern.

The single variable patter is used for similar things there
as well, for example, see hard_watchdog_warn,
hardlockup_allcpu_dumped.

I would call the variable "hardlockup_dump_flush" and
use the same logic as for hardlockup_allcpu_dumped.

Note that simple READ_ONCE(), WRITE_ONCE() are not enough
because they do not provide smp barriers.

Best Regards,
Petr
