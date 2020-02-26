Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA00C4BA09
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 02:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8845321D7E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 02:11:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730184AbgBZCL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 21:11:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:40970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730008AbgBZCL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 21:11:56 -0500
Received: from [10.44.0.22] (unknown [103.48.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 030E521744;
        Wed, 26 Feb 2020 02:11:50 +0000 (UTC)
Subject: Re: [PATCH v2 06/18] m68k: Replace setup_irq() by request_irq()
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     afzal mohammed <afzal.mohd.ma@gmail.com>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <cover.1582471508.git.afzal.mohd.ma@gmail.com>
 <00b0bf964278dd0bb3e093283994399ff796cca5.1582471508.git.afzal.mohd.ma@gmail.com>
 <73c3ad08-963d-fea2-91d7-b06e4ef8d3ef@linux-m68k.org>
 <alpine.LNX.2.22.394.2002261151220.9@nippy.intranet>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <caa5686a-5be3-5848-fdee-36f54237ccb6@linux-m68k.org>
Date:   Wed, 26 Feb 2020 12:11:38 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.22.394.2002261151220.9@nippy.intranet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 26/2/20 11:11 am, Finn Thain wrote:
> On Wed, 26 Feb 2020, Greg Ungerer wrote:
>> On 24/2/20 10:50 am, afzal mohammed wrote:
>>> request_irq() is preferred over setup_irq(). The early boot setup_irq()
>>> invocations happen either via 'init_IRQ()' or 'time_init()', while
>>> memory allocators are ready by 'mm_init()'.
>>>
>>> Per tglx[1], setup_irq() existed in olden days when allocators were not
>>> ready by the time early interrupts were initialized.
>>>
>>> Hence replace setup_irq() by request_irq().
>>>
>>> Seldom remove_irq() usage has been observed coupled with setup_irq(),
>>> wherever that has been found, it too has been replaced by free_irq().
>>>
>>> [1] https://lkml.kernel.org/r/alpine.DEB.2.20.1710191609480.1971@nanos
>>>
>>> Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>
>>> Tested-by: Greg Ungerer <gerg@linux-m68k.org> # ColdFire
>>> ---
>>>
>>> v2:
>>>    * Replace pr_err("request_irq() on %s failed" by
>>>              pr_err("%s: request_irq() failed"
>>>    * Commit message massage
>>>    * remove now irrelevant comment lines at 3 places
>>>
>>>    arch/m68k/68000/timers.c      | 11 ++---------
>>>    arch/m68k/coldfire/pit.c      | 11 ++---------
>>>    arch/m68k/coldfire/sltimers.c | 19 +++++--------------
>>>    arch/m68k/coldfire/timers.c   | 21 +++++----------------
>>>    4 files changed, 14 insertions(+), 48 deletions(-)
>>>
>>> diff --git a/arch/m68k/68000/timers.c b/arch/m68k/68000/timers.c
>>> index 71ddb4c98726..55a76a2d3d58 100644
>>> --- a/arch/m68k/68000/timers.c
>>> +++ b/arch/m68k/68000/timers.c
>>> @@ -68,14 +68,6 @@ static irqreturn_t hw_tick(int irq, void *dummy)
>>>      /***************************************************************************/
>>>    -static struct irqaction m68328_timer_irq = {
>>> -	.name	 = "timer",
>>> -	.flags	 = IRQF_TIMER,
>>> -	.handler = hw_tick,
>>> -};
>>> -
>>>
>>> -/***************************************************************************/
>>> -
>>>    static u64 m68328_read_clk(struct clocksource *cs)
>>>    {
>>>    	unsigned long flags;
>>> @@ -106,7 +98,8 @@ void hw_timer_init(irq_handler_t handler)
>>>    	TCTL = 0;
>>>      	/* set ISR */
>>> -	setup_irq(TMR_IRQ_NUM, &m68328_timer_irq);
>>> +	if (request_irq(TMR_IRQ_NUM, hw_tick, IRQF_TIMER, "timer", NULL))
>>> +		pr_err("%s: request_irq() failed\n", "timer");
>>
>> Why not just:
>>
>>                  pr_err("timer: request_irq() failed\n");
>>
> 
> I believe that the compiler would coalesce the two "timer" string
> constants in the patch from Afzal (as per my suggestion).>
> I suspect that your version costs a few extra bytes everywhere it appears
> (but I didn't check).

Maybe. It costs some extra code for another argument push and a bunch
of cycles to process the %s at run time though (if triggered).

The profile timer setup is not commonly used, so in most typical
builds there is no scope for coalescing the same string. So in the end
most builds will be a few bytes larger with the separated strings.

But really that is not the point. It just seems simpler and clearer to
me to put the string in place - all in one.


>> And maybe would it be useful to print out the error return code from a
>> failed request_irq()?  What about displaying the requested IRQ number as
>> well? Just a thought.
>>
> 
> That error would almost always be -EBUSY, right?

I expect it will never fail this early in boot.
But how will you know if it really is EBUSY if you don't print it out?


> Moreover, compare this change,
> 
> -	setup_irq(TMR_IRQ_NUM, &m68328_timer_irq);
> +	request_irq(TMR_IRQ_NUM, hw_tick, IRQF_TIMER, "timer", NULL);
> 
> with this change,
> 
> +	int err;
> 
> -	setup_irq(TMR_IRQ_NUM, &m68328_timer_irq);
> +	err = request_irq(TMR_IRQ_NUM, hw_tick, IRQF_TIMER, "timer", NULL);
> +	if (err)
> +		return err;
> 
> Isn't the latter change the more common pattern? It prints nothing.

Hmm, in my experience the much more common pattern is:

> +	int err;
> 
> -	setup_irq(TMR_IRQ_NUM, &m68328_timer_irq);
> +	err = request_irq(TMR_IRQ_NUM, hw_tick, IRQF_TIMER, "timer", NULL);
> +	if (err) {
> +             pr_err("timer: request_irq() failed with err=%d\n", err);
> +		return err;
> +     }

Where the pr_err() could be one of pr_err, printk, dev_err, ...

Regards
Greg
