Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13091C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 13:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2EC2222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 13:50:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729320AbgBNNuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 08:50:07 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:54654 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728405AbgBNNuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 08:50:07 -0500
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1j2bM3-0006JK-SH; Fri, 14 Feb 2020 14:50:04 +0100
From:   John Ogness <john.ogness@linutronix.de>
To:     lijiang <lijiang@redhat.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] printk: use the lockless ringbuffer
References: <20200128161948.8524-1-john.ogness@linutronix.de>
        <20200128161948.8524-3-john.ogness@linutronix.de>
        <ccbe1383-a4a4-41f8-3330-972f03c97429@redhat.com>
Date:   Fri, 14 Feb 2020 14:50:02 +0100
In-Reply-To: <ccbe1383-a4a4-41f8-3330-972f03c97429@redhat.com>
        (lijiang@redhat.com's message of "Fri, 14 Feb 2020 21:29:23 +0800")
Message-ID: <87zhdle0s5.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lianbo,

On 2020-02-14, lijiang <lijiang@redhat.com> wrote:
>> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
>> index 1ef6f75d92f1..d0d24ee1d1f4 100644
>> --- a/kernel/printk/printk.c
>> +++ b/kernel/printk/printk.c
>> @@ -1062,21 +928,16 @@ void log_buf_vmcoreinfo_setup(void)
>>  {
>>  	VMCOREINFO_SYMBOL(log_buf);
>>  	VMCOREINFO_SYMBOL(log_buf_len);
>
> I notice that the "prb"(printk tb static) symbol is not exported into
> vmcoreinfo as follows:
>
> +	VMCOREINFO_SYMBOL(prb);
>
> Should the "prb"(printk tb static) symbol be exported into vmcoreinfo?
> Otherwise, do you happen to know how to walk through the log_buf and
> get all kernel logs from vmcore?

You are correct. This will need to be exported as well so that the
descriptors can be accessed. (log_buf is only the pure human-readable
text.) I am currently hacking the crash tool to see exactly what needs
to be made available in order to access all the data of the ringbuffer.

John Ogness
