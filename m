Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04ADC18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 15:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB23320663
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 15:31:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731600AbgCPPbW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 11:31:22 -0400
Received: from smtprelay0023.hostedemail.com ([216.40.44.23]:35616 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731483AbgCPPbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 11:31:22 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave08.hostedemail.com (Postfix) with ESMTP id F29A81802DEF8;
        Mon, 16 Mar 2020 15:31:20 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id E5402181D304D;
        Mon, 16 Mar 2020 15:31:19 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: route18_624da6916fc3d
X-Filterd-Recvd-Size: 2711
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Mon, 16 Mar 2020 15:31:15 +0000 (UTC)
Message-ID: <97ea305c0d336f3c36a804b37e6bbb4b1bbf24fd.camel@perches.com>
Subject: Re: [PATCHv2 01/50] kallsyms/printk: Add loglvl to print_ip_sym()
From:   Joe Perches <joe@perches.com>
To:     Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Greentime Hu <green.hu@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Hogan <jhogan@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Michal Simek <monstr@monstr.eu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Burton <paulburton@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Chen <deanbo422@gmail.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Will Deacon <will@kernel.org>, linux-mips@vger.kernel.org,
        linux-riscv@lists.infradead.org
Date:   Mon, 16 Mar 2020 08:29:28 -0700
In-Reply-To: <20200316143916.195608-2-dima@arista.com>
References: <20200316143916.195608-1-dima@arista.com>
         <20200316143916.195608-2-dima@arista.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-03-16 at 14:38 +0000, Dmitry Safonov wrote:
> print_ip_sym() needs to have a log level parameter to comply with other
> parts being printed. Otherwise, half of the expected backtrace would be
> printed and other may be missing with some logging level.

There are 15 instances of print_ip_sym.

Perhaps it'd be better to get rid of print_ip_sym
altogether by expanding it in-place instead.

>  arch/microblaze/kernel/unwind.c | 2 +-
>  arch/mips/kernel/traps.c        | 4 ++--
>  arch/nds32/kernel/traps.c       | 4 ++--
>  arch/riscv/kernel/stacktrace.c  | 2 +-
>  include/linux/kallsyms.h        | 4 ++--
>  kernel/locking/lockdep.c        | 4 ++--
>  kernel/sched/core.c             | 6 ++----
>  kernel/trace/ftrace.c           | 8 ++++----
>  tools/include/linux/kallsyms.h  | 2 +-


