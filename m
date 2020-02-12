Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF21C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 14:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA07E20714
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 14:18:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbgBLOSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 09:18:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:50402 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727732AbgBLOSe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 09:18:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D3759AF27;
        Wed, 12 Feb 2020 14:18:32 +0000 (UTC)
Date:   Wed, 12 Feb 2020 15:18:32 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Subject: Re: [PATCH] kernel/watchdog: flush all printk nmi buffers when
 hardlockup detected
Message-ID: <20200212141832.lqmzzdi77hb6yrhu@pathway.suse.cz>
References: <158132813726.1980.17382047082627699898.stgit@buzz>
 <20200212011551.GA13208@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212011551.GA13208@google.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2020-02-12 10:15:51, Sergey Senozhatsky wrote:
> On (20/02/10 12:48), Konstantin Khlebnikov wrote:
> > 
> > In NMI context printk() could save messages into per-cpu buffers and
> > schedule flush by irq_work when IRQ are unblocked. This means message
> > about hardlockup appears in kernel log only when/if lockup is gone.
> > 
> > Comment in irq_work_queue_on() states that remote IPI aren't NMI safe
> > thus printk() cannot schedule flush work to another cpu.
> > 
> > This patch adds simple atomic counter of detected hardlockups and
> > flushes all per-cpu printk buffers in context softlockup watchdog
> > at any other cpu when it sees changes of this counter.
> 
> Petr, could you remind me, why do we do PRINTK_NMI_DIRECT_CONTEXT_MASK
> only from ftrace?

There was a possible deadlock when printing backtraces from all CPUs.
The CPUs were serialized via a lock in nmi_cpu_backtrace(). One of
them might have been interrupted under logbuf_lock.

ftrace was needed because it printed too many messages. And it was
safe because the ftrace log was read from a single CPU without
any lock.

Best Regards,
Petr
