Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E1E4C18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 18:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50F9B20679
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 18:35:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732355AbgCPSfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 14:35:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:33180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731967AbgCPSfV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 14:35:21 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C38620674;
        Mon, 16 Mar 2020 18:35:19 +0000 (UTC)
Date:   Mon, 16 Mar 2020 14:35:17 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Eugeniu Rosca <roscaeugeniu@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>,
        Dirk Behme <dirk.behme@de.bosch.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: Re: [RFC PATCH 0/3] Fix quiet console in pre-panic scenarios
Message-ID: <20200316143517.651abbeb@gandalf.local.home>
In-Reply-To: <20200315170903.17393-1-erosca@de.adit-jv.com>
References: <20200315170903.17393-1-erosca@de.adit-jv.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Mar 2020 18:09:00 +0100
Eugeniu Rosca <roscaeugeniu@gmail.com> wrote:

> Dear community,
> 
> The motivation behind this seris is to save days/weeks, if not months,
> of debugging efforts for users who:
> 
>  * experience an issue like softlockup/hardlockup/hung task/oom, whose
>    reproduction is not clear and whose occurrence rate is very low
>  * are constrained to use a low loglevel value (1,2,3) in production
>  * mostly rely on console logs to debug the issue post-mortem
>    (e.g. saved to persistent storage via e.g. pstore)
> 
> As pointed out in the last patch from this series, under the above
> circumstances, users might simply lack any relevant logs during
> post-mortem analysis.
> 
> Why this series is marked as RFC is because:
>  * There are several possible approaches to turn console verbosity on
>    and off. Current series employs the 'ignore_loglevel' functionality,
>    but an alternative way is to use the 'console_loglevel' variable. The
>    latter is more intrusive, hence the former has been chosen as v1.
>  * Manipulating 'ignore_loglevel' might be seen as an abuse, especially
>    because it breaks the expectation of users who assume the system to
>    be dead silent after passing loglevel=0 on kernel command line.
> 
> Thank you for your comments!

I don't see any issues with this patch set. What do others think?

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

[ Note, I only acked, and did not give a deep review of it ]

-- Steve

> 
> Eugeniu Rosca (3):
>   printk: convert ignore_loglevel to atomic_t
>   printk: add console_verbose_{start,end}
>   watchdog: Turn console verbosity on when reporting softlockup
> 
>  include/linux/printk.h | 10 ++++++++++
>  kernel/printk/printk.c | 30 ++++++++++++++++++++++++++----
>  kernel/watchdog.c      |  4 ++++
>  3 files changed, 40 insertions(+), 4 deletions(-)
> 

