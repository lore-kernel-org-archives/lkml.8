Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37379C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 13:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03BD020656
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 13:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728749AbgFZNs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 09:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728489AbgFZNs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 09:48:56 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46CBC03E979
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 06:48:55 -0700 (PDT)
Received: from p508752b4.dip0.t-ipconnect.de ([80.135.82.180] helo=vostro)
        by Galois.linutronix.de with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1jooin-00048z-Aa; Fri, 26 Jun 2020 15:48:49 +0200
From:   John Ogness <john.ogness@linutronix.de>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@kernel.org>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: truncate dict: was: Re: [PATCH v3 3/3] printk: use the lockless ringbuffer
References: <20200618144919.9806-1-john.ogness@linutronix.de>
        <20200618144919.9806-4-john.ogness@linutronix.de>
        <20200625081650.GE6156@alley>
Date:   Fri, 26 Jun 2020 15:48:42 +0200
In-Reply-To: <20200625081650.GE6156@alley> (Petr Mladek's message of "Thu, 25
        Jun 2020 10:16:50 +0200")
Message-ID: <87wo3u2b0l.fsf@jogness.linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-25, Petr Mladek <pmladek@suse.com> wrote:
>> --- a/kernel/printk/printk.c
>> +++ b/kernel/printk/printk.c
>> @@ -594,22 +473,26 @@ static u32 msg_used_size(u16 text_len, u16 dict_len, u32 *pad_len)
>>  #define MAX_LOG_TAKE_PART 4
>>  static const char trunc_msg[] = "<truncated>";
>>  
>> -static u32 truncate_msg(u16 *text_len, u16 *trunc_msg_len,
>> -			u16 *dict_len, u32 *pad_len)
>> +static void truncate_msg(u16 *text_len, u16 *trunc_msg_len, u16 *dict_len)
>>  {
>>  	/*
>>  	 * The message should not take the whole buffer. Otherwise, it might
>>  	 * get removed too soon.
>>  	 */
>>  	u32 max_text_len = log_buf_len / MAX_LOG_TAKE_PART;
>> +
>>  	if (*text_len > max_text_len)
>>  		*text_len = max_text_len;
>> -	/* enable the warning message */
>> +
>> +	/* enable the warning message (if there is room) */
>>  	*trunc_msg_len = strlen(trunc_msg);
>> +	if (*text_len >= *trunc_msg_len)
>> +		*text_len -= *trunc_msg_len;
>> +	else
>> +		*trunc_msg_len = 0;
>> +
>>  	/* disable the "dict" completely */
>>  	*dict_len = 0;
>
> The dictionary does not longer need to be removed at this point.
> It is stored in a separate buffer. It is ignored by prb_reserve()
> when there is not enough space for it.

Agreed. @dict_len argument will also be dropped from the function.

John Ogness
