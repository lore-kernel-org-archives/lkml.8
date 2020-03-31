Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9000AC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 13:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E6F520784
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 13:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730981AbgCaNm4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 09:42:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33017 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730216AbgCaNm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 09:42:56 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jJHAH-00038x-K6; Tue, 31 Mar 2020 15:42:49 +0200
Date:   Tue, 31 Mar 2020 15:42:49 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 6/9] lockdep: Introduce wait-type checks
Message-ID: <20200331134249.kf3zyf27xtspmlif@linutronix.de>
References: <20200313174701.148376-1-bigeasy@linutronix.de>
 <20200313174701.148376-7-bigeasy@linutronix.de>
 <CAMuHMdU6s1F=DnaguZXrV4sWzEO-EqTaGQ=N7zyhgGq1M+Q1Ug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CAMuHMdU6s1F=DnaguZXrV4sWzEO-EqTaGQ=N7zyhgGq1M+Q1Ug@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-03-31 15:25:21 [+0200], Geert Uytterhoeven wrote:
> Hi all,
Hi Geert,

> On arm64 (e.g. R-Car H3 ES2.0):
> 
> +=============================
> +[ BUG: Invalid wait context ]
> +5.6.0-salvator-x-09423-gb29514ba13a9c459-dirty #679 Not tainted
> +-----------------------------
> +swapper/5/0 is trying to lock:
> +ffffff86ff76f398 (&pool->lock){..-.}-{3:3}, at: __queue_work+0x134/0x430

The pool->lock is not yet converted.
…
> On arm32 (e.g SH-Mobile AG5, using Cortex-A9 TWD):
> 
> +=============================
> +[ BUG: Invalid wait context ]
> +5.6.0-kzm9g-09424-g2698719b4c4f35db-dirty #253 Not tainted
> +-----------------------------
> +swapper/0/0 is trying to lock:
> +dfbc5250 (&pool->lock){..-.}-{3:3}, at: __queue_work+0x14c/0x4d0

same issue.

> I also see it on other arm32 platforms using Renesas-specific timers,
> but I'll ignore those until the issues with "standard" ARM timers have
> been resolved ;-)

There are some known culprits, like the work infrastructure. The printk
is another one. From Kconfig:

|   NOTE: There are known nesting problems. So if you enable this
|   option expect lockdep splats until these problems have been fully
|   addressed which is work in progress. This config switch allows to
|   identify and analyze these problems. It will be removed and the
|   check permanentely enabled once the main issues have been fixed.


> Thanks!
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> 

Sebastian
