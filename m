Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C9BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 06:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87B3D2072E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 06:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389504AbgFXGvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 02:51:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:57428 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389400AbgFXGvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 02:51:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9307BAD11;
        Wed, 24 Jun 2020 06:50:58 +0000 (UTC)
Date:   Wed, 24 Jun 2020 08:50:54 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Subject: Re: [PATCH 0/3] x86/dumpstack: Print registers with the same log
 level as the backtrace
Message-ID: <20200624065054.GC8444@alley>
References: <20200623162958.331051-1-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623162958.331051-1-dima@arista.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2020-06-23 17:29:55, Dmitry Safonov wrote:
> show_trace_log_lvl() provides x86 platform-specific way to unwind
> backtrace with a given log level. Unfortunately, registers dump(s) are
> not printed with the same log level - instead, KERN_DEFAULT is always
> used.
> 
> Arista's switches uses quite common setup with rsyslog, where only
> urgent messages goes to console (console_log_level=KERN_ERR), everything
> else goes into /var/log/ as the console baud-rate often is indecently
> slow (9600 bps).
> 
> Backtrace dumps without registers printed have proven to be as useful as
> morning standups. Furthermore, in order to introduce KERN_UNSUPPRESSED
> (which I believe is still the most elegant way to fix raciness of sysrq[1])
> the log level should be passed down the stack to register dumping
> functions. Besides, I have a potential use-case for printing traces
> with KERN_DEBUG level [2] (where registers dump shouldn't appear with
> higher log level than the backtrace).
> 
> Dmitry Safonov (3):
>   x86/dumpstack: Add log_lvl to show_iret_regs()
>   x86/dumpstack: Add log_lvl to __show_regs()
>   x86/dumpstack: Show registers dump with trace's log level

The change makes sense. It is natural next step after adding log_lvl
parameter for printing stack traces. For the entire patchset:

Acked-by: Petr Mladek <pmladek@suse.com>

Are there any plans to add this also for other architectures, please?

Best Regards,
Petr
