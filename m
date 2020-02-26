Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43BDC4BA0B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 12:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5B6120838
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 12:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbgBZM1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 07:27:03 -0500
Received: from icp-osb-irony-out7.external.iinet.net.au ([203.59.1.107]:28279
        "EHLO icp-osb-irony-out7.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727267AbgBZM1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 07:27:02 -0500
X-SMTP-MATCH: 0
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2AUAAAXY1Ze/zXSMGcNWRsBAQEBAQE?=
 =?us-ascii?q?BBQEBAREBAQMDAQEBgWoDAQEBCwGDZIR1j1KBN4lxkUwJAQEBAQEBAQEBNwQ?=
 =?us-ascii?q?BAYRAAoIkNwYOAhABAQEFAQEBAQEFAwGFWIY7AQEBAQIBIxVBBQsLDQEKAgI?=
 =?us-ascii?q?mAgJXBg0IAQGDIoJXBa1ndYEyGoUwgzeBPoEOKgGBZIpZeYEHgREngmw+gQQ?=
 =?us-ascii?q?BhleCXgSNYol3gUOWegiCPpZfIo8fA4wMLawagXszGggoCIMoT50ckkEBAQ?=
X-IPAS-Result: =?us-ascii?q?A2AUAAAXY1Ze/zXSMGcNWRsBAQEBAQEBBQEBAREBAQMDA?=
 =?us-ascii?q?QEBgWoDAQEBCwGDZIR1j1KBN4lxkUwJAQEBAQEBAQEBNwQBAYRAAoIkNwYOA?=
 =?us-ascii?q?hABAQEFAQEBAQEFAwGFWIY7AQEBAQIBIxVBBQsLDQEKAgImAgJXBg0IAQGDI?=
 =?us-ascii?q?oJXBa1ndYEyGoUwgzeBPoEOKgGBZIpZeYEHgREngmw+gQQBhleCXgSNYol3g?=
 =?us-ascii?q?UOWegiCPpZfIo8fA4wMLawagXszGggoCIMoT50ckkEBAQ?=
X-IronPort-AV: E=Sophos;i="5.70,488,1574092800"; 
   d="scan'208";a="241459339"
Received: from unknown (HELO [10.44.0.192]) ([103.48.210.53])
  by icp-osb-irony-out7.iinet.net.au with ESMTP; 26 Feb 2020 20:26:58 +0800
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
 <caa5686a-5be3-5848-fdee-36f54237ccb6@linux-m68k.org>
 <alpine.LNX.2.22.394.2002261637400.8@nippy.intranet>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <a682c89d-baf2-3d3c-647f-a07b2a146c9f@linux-m68k.org>
Date:   Wed, 26 Feb 2020 22:26:55 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.22.394.2002261637400.8@nippy.intranet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 26/2/20 4:39 pm, Finn Thain wrote:
> On Wed, 26 Feb 2020, Greg Ungerer wrote:
> 
>>> That error would almost always be -EBUSY, right?
>>
>> I expect it will never fail this early in boot.
> 
> If so, it suggests to me that tweaking the error message string is just
> bikeshedding and that adding these error messages across the tree is just
> bloat.
> 
>> But how will you know if it really is EBUSY if you don't print it out?
>>
>>> Moreover, compare this change,
>>>
>>> -	setup_irq(TMR_IRQ_NUM, &m68328_timer_irq);
>>> +	request_irq(TMR_IRQ_NUM, hw_tick, IRQF_TIMER, "timer", NULL);
>>>
>>> with this change,
>>>
>>> +	int err;
>>>
>>> -	setup_irq(TMR_IRQ_NUM, &m68328_timer_irq);
>>> +	err = request_irq(TMR_IRQ_NUM, hw_tick, IRQF_TIMER, "timer", NULL);
>>> +	if (err)
>>> +		return err;
>>>
>>> Isn't the latter change the more common pattern? It prints nothing.
>>
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
>>
>> Where the pr_err() could be one of pr_err, printk, dev_err, ...
>>
> 
> A rough poll using 'git grep' seems to agree with your assessment.
> 
> If -EBUSY means the end user has misconfigured something, printing
> "request_irq failed" would be helpful. But does that still happen?

I have seen it many times. Its not at all difficult to get interrupt
assignments wrong, duplicated, or otherwise mistaken when creating
device trees. Not so much m68k/coldfire platforms where they are
most commonly hard coded.


> Printing any error message for -ENOMEM is frowned upon, and printing -12
> is really unhelpful. So the most popular pattern isn't that great, though
> it is usually less verbose than the example you've given.
> 
> Besides, introducing local variables and altering control flow seems well
> out-of-scope for this kind of refactoring, right?

I don't agree with the local variable part. Adding a local variable to
keep track of the error return code doesn't seem out of scope for this change.
The patch as Afzal sent it doesn't change the control flow - and
that is the right thing to do here.


> Anyway, if you're going to add an error message,
> pr_err("%s: request_irq failed", foo) is unavoidable whenever foo isn't a
> string constant, so one can't expect to grep the source code for the
> literal error message from the log.
> 
> BTW, one of the benefits of "%s: request_irq failed" is that a compilation
> unit with multiple request_irq calls permits the compiler to coalesce all
> duplicated format strings. Whereas, that's not possible with
> "foo: request_irq failed" and "bar: request_irq failed".

Given the wide variety of message text used with failed request_irq() calls
it would be shear luck that this matched anything else. A quick grep shows
that "%s: request_irq() failed\n" has no other exact matches in the current
kernel source.

Regards
Greg


