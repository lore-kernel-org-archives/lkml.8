Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0664C35242
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 02:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89C4B20842
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 02:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbgBLCuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 21:50:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:32978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727565AbgBLCuB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 21:50:01 -0500
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4449420724;
        Wed, 12 Feb 2020 02:50:00 +0000 (UTC)
Date:   Tue, 11 Feb 2020 21:49:58 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Subject: Re: [PATCH] kernel/watchdog: flush all printk nmi buffers when
 hardlockup detected
Message-ID: <20200211214958.5d8f4004@rorschach.local.home>
In-Reply-To: <20200212011551.GA13208@google.com>
References: <158132813726.1980.17382047082627699898.stgit@buzz>
        <20200212011551.GA13208@google.com>
X-Mailer: Claws Mail 3.17.4git76 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Feb 2020 10:15:51 +0900
Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:

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

Could it be because its from ftrace_dump() which can spit out millions
of lines from NMI context?

-- Steve
