Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EDF3C3F2CF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 07:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FE90246A0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 07:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgB1HFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 02:05:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:36400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726407AbgB1HFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 02:05:43 -0500
Received: from [10.44.0.22] (unknown [103.48.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE03D246A3;
        Fri, 28 Feb 2020 07:05:39 +0000 (UTC)
Subject: Re: [PATCH v2 06/18] m68k: Replace setup_irq() by request_irq()
To:     afzal mohammed <afzal.mohd.ma@gmail.com>,
        Finn Thain <fthain@telegraphics.com.au>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <20200227081805.GA5746@afzalpc>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <2c8b836e-36f7-e479-db7a-6bb3c072116a@linux-m68k.org>
Date:   Fri, 28 Feb 2020 17:05:36 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200227081805.GA5746@afzalpc>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Afzal,

On 27/2/20 6:18 pm, afzal mohammed wrote:
> On Wed, Feb 26, 2020 at 10:42:00AM +1000, Greg Ungerer wrote:
> 
>>> -	setup_irq(TMR_IRQ_NUM, &m68328_timer_irq);
>>> +	if (request_irq(TMR_IRQ_NUM, hw_tick, IRQF_TIMER, "timer", NULL))
>>> +		pr_err("%s: request_irq() failed\n", "timer");
>>
>> Why not just:
>>
>>                  pr_err("timer: request_irq() failed\n");
> 
> The reason to use %s was that it could be automated by cocci script &
> the o/p didn't look bad. Second arg to pr_err is what cocci
> presents me & there is wide variation in the name across the tree as
> Finn noted.
> 
> Excerpts from v1 cover letter [1],
> 
> - setup_irq(E1,&act);
> + if (request_irq(E1,f_handler,f_flags,f_name,f_dev_id))
> + 	pr_err("request_irq() on %s failed\n", f_name);
> 
> [ don't get mislead by string contents used, this was for v1, just to
>   show how the result was obtained. To take care of Finn's suggesstion,
>   instead of modifying cocci & then making changes other changes over
>   that (i could not fully automate w/ cocci, and Julia said my script
>   is fine as is), it was easier to run sed over the v1  patches ]
> 
>> And maybe would it be useful to print out the error return code from a
>> failed request_irq()?
> 
> Since most of the existing setup_irq() didn't even check & handle
> error return, my first thought was just s/setup_irq/request_irq, it
> was easier from scripting pointing of view. i felt uncomfortable doing
> nothing in case of error. Also noted that request_irq() definition has
> a "__much_check", so decided to add it.
> 
> And there is a wide variation in the way return value is handled by
> the caller, some already have a local variable, some don't. Moreover
> in many cases caller cannot return any value, i.e. void, so what
> to be done with return value was another issue, in some cases in
> addition to printing error value, the error value can't be returned,
> while some others it can.
>
>> What about displaying the requested IRQ number as well?
>> Just a thought.
> 
> i initially did the cocci to display IRQ number as the 3rd arg to
> pr_err, but then it was observed that most of the those lines were
> exceeding 80 chars, though cocci could align args properly in next
> line, it could not put flower braces to the preceeding
> 'if request_irq()' & in next line (though it is a single C statement
> inside 'if', per kernel coding style, flower brace had to be put for a
> single statement that spans multiple lines ], else it had to be
> manually added treewide.
> 
> On Wed, Feb 26, 2020 at 12:11:55PM +1100, Finn Thain wrote:
> 
>> Moreover, compare this change,
>>
>> -	setup_irq(TMR_IRQ_NUM, &m68328_timer_irq);
>> +	request_irq(TMR_IRQ_NUM, hw_tick, IRQF_TIMER, "timer", NULL);
>>
>> with this change,
>>
>> +	int err;
>>
>> -	setup_irq(TMR_IRQ_NUM, &m68328_timer_irq);
>> +	err = request_irq(TMR_IRQ_NUM, hw_tick, IRQF_TIMER, "timer", NULL);
>> +	if (err)
>> +		return err;
>>
>> Isn't the latter change the more common pattern? It prints nothing.
>>
>> And arguably, the former example is actually the change that's described
>> in the commit description.
>>
>> This patch seems to be making two orthogonal changes but I'll leave that
>> question to the maintainer. (I'm not really trying to NAK this patch.)
> 
> Instead of not checking the error value as in the existing cases &
> mechanically replace w/ request_irq(), thought of at least giving user
> the indication by way of pr_err (but i think most of the use is for
> tick timer, if it fails, in most cases, system would not even boot)
> due to the reasons mentioned above.
> 
> On Wed, Feb 26, 2020 at 12:11:38PM +1000, Greg Ungerer wrote:
> 
>> Hmm, in my experience the much more common pattern is:
>>
>>> +	int err;
>>>
>>> -	setup_irq(TMR_IRQ_NUM, &m68328_timer_irq);
>>> +	err = request_irq(TMR_IRQ_NUM, hw_tick, IRQF_TIMER, "timer", NULL);
>>> +	if (err) {
>>> +             pr_err("timer: request_irq() failed with err=%d\n", err);
>>> +		return err;
>>> +     }
> 
> This is my preferred style, but note that returning error is not
> possible in many of these cases as callers are void return type.
> 
> On Wed, Feb 26, 2020 at 05:39:57PM +1100, Finn Thain wrote:
> 
>> Besides, introducing local variables and altering control flow seems well
>> out-of-scope for this kind of refactoring, right?
> 
> To make changes perfect, it would be required to get into context of
> each case (>150), and do it manually as there is wide variation like
> whether caller can return error code, whether already a local integer
> is defined to catch the error, whether it returns error after a goto,
> whether we should allow it to proceed if it fails and so on.
> 
> And handling manually all the cases tree wide would be more error
> prone & time consuming. i was relieved that there was only one build
> error reported by test robot (i had done build & boot test only on ARM
> & x86_64), given the amount of manual changes i had to do on top of
> cocci generated ones.
> 
> At the same time, i didn't want to just mechanically replace & wanted
> to add some value to the existing setup, which resulted in this patch.
> 
> My thought process was to do treewide removal of setup_irq() and
> possibly low hanging cleanup's at the places where setup_irq() lives
> to make sure that surrounding situation will be better than or at
> least equal to the current.

Ok, makes sense. Given the very large tree-wide change I can see
why you wanted to completely automate it.


> But if the consensus is that all these situations have to be taken
> care, let me know.
> 
> On Wed, Feb 26, 2020 at 10:26:55PM +1000, Greg Ungerer wrote:
> 
>> A quick grep shows
>> that "%s: request_irq() failed\n" has no other exact matches in the current
>> kernel source.
> 
> git grep -n '%s: request_irq' gives a few somewhat similar ones, i
> remember it because searching this string after my changes to verify
> gave more than that i added :)

Unfortunately similar strings won't be coalesced...

Regards
Greg

