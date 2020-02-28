Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3161DC3F2D0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 09:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E3F2246A2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 09:11:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbgB1JLm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 04:11:42 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36158 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbgB1JLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 04:11:42 -0500
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1j7bgC-00046G-U5; Fri, 28 Feb 2020 10:11:33 +0100
From:   John Ogness <john.ogness@linutronix.de>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Lech Perczak <l.perczak@camlintechnologies.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>, Arnd Bergmann <arnd@arndb.de>,
        Krzysztof =?utf-8?Q?Drobi=C5=84ski?= 
        <k.drobinski@camlintechnologies.com>,
        Pawel Lenkow <p.lenkow@camlintechnologies.com>
Subject: Re: Regression in v4.19.106 breaking waking up of readers of /proc/kmsg and /dev/kmsg
References: <aa0732c6-5c4e-8a8b-a1c1-75ebe3dca05b@camlintechnologies.com>
        <20200227123633.GB962932@kroah.com>
        <42d3ce5c-5ffe-8e17-32a3-5127a6c7c7d8@camlintechnologies.com>
        <e9358218-98c9-2866-8f40-5955d093dc1b@camlintechnologies.com>
        <20200228031306.GO122464@google.com>
Date:   Fri, 28 Feb 2020 10:11:30 +0100
In-Reply-To: <20200228031306.GO122464@google.com> (Sergey Senozhatsky's
        message of "Fri, 28 Feb 2020 12:13:06 +0900")
Message-ID: <87r1yfvzy5.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-02-28, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:
> Cc-ing Petr, Steven, John

Thanks.

> https://lore.kernel.org/lkml/e9358218-98c9-2866-8f40-5955d093dc1b@camlintechnologies.com
>
> On (20/02/27 14:08), Lech Perczak wrote:
>> >>> My test scenario for bisecting was:
>> >>> 1. run 'dmesg --follow' as root
>> >>> 2. run 'echo t > /proc/sysrq-trigger'
>> >>> 3. If trace appears in dmesg output -> good, otherwise, bad. If trace doesn't appear in output of 'dmesg --follow', re-running it will show the trace.
>> >>>
>> >>> I ran my tests on Debian 10.3 with configuration based directly on one from 4.19.0-8-amd64 (4.19.98-1) in Qemu.
>> >>> I could reproduce the same issue on several boards with x86 and ARMv7 CPUs alike, with 100% reproducibility.
>
> This is very-very odd... Hmm.
> Just out of curiosity, what happens if you comment out that
> printk() entirely?
>
> printk_deferred() should not affect the PRINTK_PENDING_WAKEUP path.

It is the printk_deferred() causing the issue. This is relatively early,
so perhaps something is not yet properly initialized.

> Either we never queue wakeup irq_work(), e.g. because
> waitqueue_active() never lets us to do so or because `(curr_log_seq !=
> log_next_seq)' is always zero

wake_up_klogd() is called and the waitqueue (@log_wait) is
active. irq_work_queue() is called, but the work function,
wake_up_klogd_work_func(), is never called.

Perhaps @wake_up_klogd_work gets broken somehow. I'm looking into it.

John Ogness
