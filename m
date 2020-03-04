Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C55C3F2C6
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 01:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8807620836
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 01:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387515AbgCDBjt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 20:39:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:35974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387476AbgCDBjr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 20:39:47 -0500
Received: from [10.44.0.22] (unknown [103.48.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46D6B2073D;
        Wed,  4 Mar 2020 01:39:44 +0000 (UTC)
Subject: Re: [PATCH v5] m68k: Replace setup_irq() by request_irq()
To:     afzal mohammed <afzal.mohd.ma@gmail.com>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Finn Thain <fthain@telegraphics.com.au>
References: <20200229153406.GA32479@afzalpc> <20200301012655.GA6035@afzalpc>
 <c2c04a29-4fc8-7cb5-6cc6-5bc3b125d047@linux-m68k.org>
 <20200304013711.GA5470@afzalpc>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <3c721380-2348-dccd-8de8-5ee60a1d5240@linux-m68k.org>
Date:   Wed, 4 Mar 2020 11:39:41 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200304013711.GA5470@afzalpc>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Afzal,

On 4/3/20 11:37 am, afzal mohammed wrote:
> Hi Greg,
> 
> On Mon, Mar 02, 2020 at 11:32:53AM +1000, Greg Ungerer wrote:
> 
>> I have retested and everything works as expected, so:
>>
>>    Tested-by: Greg Ungerer <gerg@linux-m68k.org>
>>
>> I have applied this to the m68knommu git tree, for next branch.
> 
> Thanks
> 
>>>    void hw_timer_init(irq_handler_t handler)
>>>    {
>>> +	int r;
>>
>> You used 'r' here as the error return value holder.
>> But in the previous cases you used 'ret'.
>> I would have used the same name everywhere ('ret' probably being the
>> most commonly used in the kernel).
> 
> That was a circus to dodge 80 char limit, i did think about it while
> making the changes whether to do or not. If 'ret' is used request_irq()
> line had to be split to two, slightly affecting the readability and
> since 'r' was a local variable (though conventionally 'ret' or 'err'
> is used) went ahead that way. Even if 're' is used as the local
> variable, it would be 81 chars ;)
> 
> Let me know if you want to change it.

Understand. No, no need to change it.

Regards
Greg


> Regards
> afzal
> 
>>> -	setup_irq(MCF_IRQ_TIMER, &mcfslt_timer_irq);
>>> +	r = request_irq(MCF_IRQ_TIMER, mcfslt_tick, IRQF_TIMER, "timer", NULL);
>>> +	if (r) {
>>> +		pr_err("Failed to request irq %d (timer): %pe\n", MCF_IRQ_TIMER,
>>> +		       ERR_PTR(r));
>>> +	}
