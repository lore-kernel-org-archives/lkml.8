Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD98C35254
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 11:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A12D20801
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 11:13:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbgBQLNc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 06:13:32 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59372 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728191AbgBQLNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 06:13:31 -0500
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1j3eL9-0001PU-Ar; Mon, 17 Feb 2020 12:13:27 +0100
From:   John Ogness <john.ogness@linutronix.de>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        lijiang <lijiang@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] printk: replace ringbuffer
References: <20200128161948.8524-1-john.ogness@linutronix.de>
        <dc4ca9b5-d2a2-03af-c186-204a3aad2399@redhat.com>
        <20200205044848.GH41358@google.com>
        <20200205050204.GI41358@google.com>
        <88827ae2-7af5-347b-29fb-cffb94350f8f@redhat.com>
        <20200205063640.GJ41358@google.com> <877e11h0ir.fsf@linutronix.de>
        <20200205110522.GA456@jagdpanzerIV.localdomain>
        <87wo919grz.fsf@linutronix.de>
        <20200214155639.m5yp3rd2t3vdzfj7@pathway.suse.cz>
Date:   Mon, 17 Feb 2020 12:13:25 +0100
In-Reply-To: <20200214155639.m5yp3rd2t3vdzfj7@pathway.suse.cz> (Petr Mladek's
        message of "Fri, 14 Feb 2020 16:56:39 +0100")
Message-ID: <87blpxbh62.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-02-14, Petr Mladek <pmladek@suse.com> wrote:
>> I oversaw that devkmsg_open() setup a printk_record and so I did not
>> see to add the extra NULL initialization of text_line_count. There
>> should be be an initializer function/macro to avoid this danger.
>> 
>> John Ogness
>> 
>> The quick fixup:
>> 
>> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
>> index d0d24ee1d1f4..5ad67ff60cd9 100644
>> --- a/kernel/printk/printk.c
>> +++ b/kernel/printk/printk.c
>> @@ -883,6 +883,7 @@ static int devkmsg_open(struct inode *inode, struct file *file)
>>  	user->record.text_buf_size = sizeof(user->text_buf);
>>  	user->record.dict_buf = &user->dict_buf[0];
>>  	user->record.dict_buf_size = sizeof(user->dict_buf);
>> +	user->record.text_line_count = NULL;
>
> The NULL pointer hidden in the structure also complicates the code
> reading. It is less obvious when the same function is called
> only to get the size/count and when real data.

OK.

> I played with it and created extra function to get this information.
>
> In addition, I had problems to follow the code in
> record_print_text_inline(). So I tried to reuse the new function
> and the existing record_printk_text() there.
>
> Please, find below a patch that I ended with. I booted a system
> with this patch. But I guess that I actually did not use the
> record_print_text_inline(). So, it might be buggy.

Yes, there are several bugs. But I see where you want to go with this:

- introduce prb_count_lines() to handle line counting

- introduce prb_read_valid_info() for only reading meta-data and getting
  the line count

- also use prb_count_lines() internally

I will include these changes in v2. I will still introduce the static
inlines to initialize records because readers and writers do it
differently.

Thanks.

John Ogness
