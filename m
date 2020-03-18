Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73758C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 15:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49F2120767
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 15:40:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgCRPkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 11:40:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57687 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbgCRPkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 11:40:49 -0400
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1jEao2-00077C-7y; Wed, 18 Mar 2020 16:40:30 +0100
From:   John Ogness <john.ogness@linutronix.de>
To:     Eugeniu Rosca <erosca@de.adit-jv.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>,
        Dirk Behme <dirk.behme@de.bosch.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [RFC PATCH 0/3] Fix quiet console in pre-panic scenarios
References: <20200315170903.17393-1-erosca@de.adit-jv.com>
        <20200316143517.651abbeb@gandalf.local.home>
        <20200316190948.7peesqnx6yhpzdpl@linutronix.de>
        <20200318145600.GA20301@lxhi-065.adit-jv.com>
Date:   Wed, 18 Mar 2020 16:40:27 +0100
In-Reply-To: <20200318145600.GA20301@lxhi-065.adit-jv.com> (Eugeniu Rosca's
        message of "Wed, 18 Mar 2020 15:56:00 +0100")
Message-ID: <87sgi5n02c.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-03-18, Eugeniu Rosca <erosca@de.adit-jv.com> wrote:
> On Mon, Mar 16, 2020 at 08:09:48PM +0100, Sebastian Andrzej Siewior wrote:
>> On 2020-03-16 14:35:17 [-0400], Steven Rostedt wrote:
>> > I don't see any issues with this patch set. What do others think?
>> > 
>> > Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
>> > 
>> > [ Note, I only acked, and did not give a deep review of it ]
>> 
>> What is the state of the other larger printk rework? If this does not
>> solve any -stable related issues then it will be replaced?
>
> Is this a question to John and his most recent series in
> https://lore.kernel.org/lkml/20200128161948.8524-1-john.ogness@linutronix.de/
> ?
>
> Is there any upstream agreement to already keep the current printk
> mechanism away from any updates?

No. Fixes are welcome!

The only thing we are trying to avoid at this stage is massive
refactoring/cleanup work. Your series does not fit into that category.

As to my opinion on this series, assuming it is acceptable for the
maintainers, I would like to see console_verbose() become an alias to
console_verbose_start(). Then @ignore_loglevel would be used for both
and CONSOLE_LOGLEVEL_MOTORMOUTH could be removed.

John Ogness
