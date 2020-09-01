Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 813A9C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 09:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CBFD2071B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 09:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598951172;
	bh=x7UgaVEtn7LcKQh+v7eI7xv4Z3XN3zYAoRRb1ZIt3uk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=fkxAe4uGSgkRUSpWqiNWm1q+q8toj9QjqjNAKc/kFhMVps9PUDkH11qauRhEPSJth
	 IG5MzQTghiHrArBqZ+y7AtIN9fn58ul1j60GmrOI14/xFpjv1dEmAYp84Ww5qY/z0P
	 QojWeUx79yO7qobdVKwSSRg4GuhYf70nEdQGcAWk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgIAJGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 05:06:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:37616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbgIAJGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 05:06:09 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89BE520866;
        Tue,  1 Sep 2020 09:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598951168;
        bh=x7UgaVEtn7LcKQh+v7eI7xv4Z3XN3zYAoRRb1ZIt3uk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ECI3sIDzwemAFk1AF06m2yM8vxOrxCc0wX4+yaqfW0m7s4wKm4xYZUYJNJ4bhaCi5
         P/4glFhj1AZZSuCkPx/xcr13uAYsZuHWalLEHjfngPgeSAz2ei2Z9Kv1GZ2BGXp/xi
         NuHuZJ566H9WFVOq3wQXgO5LqBnH0RQ4Hj+BuLcI=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kD2Ew-008E6T-RI; Tue, 01 Sep 2020 10:06:06 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 01 Sep 2020 10:06:06 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Dongjiu Geng <gengdongjiu@huawei.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Adjust interrupt Priority for ARM64 GIC
In-Reply-To: <003822ee-c43b-9572-7a64-fda049ecb05f@huawei.com>
References: <5a6e65cf-d2fe-0107-2318-0e3c81d57000@huawei.com>
 <51146530616bb8fdf23c637ff5bee44e@kernel.org>
 <003822ee-c43b-9572-7a64-fda049ecb05f@huawei.com>
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <a769b2bef12342004d8c457313629f4a@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: gengdongjiu@huawei.com, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-01 09:48, Dongjiu Geng wrote:
> On 2020/9/1 15:48, Marc Zyngier wrote:
>> Hi Dongjiu,
>> 
>> In the future, please use my kernel.org address, as I don't work
>> for ARM anymore, and would have missed this email if I wasn't pointed
>> to it.
>> 
>> On 2020-08-14 18:10, Dongjiu Geng wrote:
>>> Hi Marc,
>>>    In the Linux kernel, we can not adjust the  interrupt Priority, 
>>> For
>>> all the interrupts, the interrupt Priority are fixed to 0xa0.
>>> In some scenarios, it needs to change the Priority. so I want to
>>> upstream a serie patch to support to change the Priority through
>>> procfs. do you agree I upstream this feature? thanks~
>> 
>> No, that's not something I would ever consider, and for multiple
>> reasons:
>> 
>> - Linux only supports a single priority, meaning that interrupts are
>>   themselves aren't preemptable. Dealing with things like (pseudo) NMI
>>   is invasive enough, and I can't see a good reason to relax the
>>   single priority requirement.
>> 
>> - Building on top of the above, the whole scheduler and locking model
>>   relies on the non-preemptable property of an interrupt.
>> 
>> - I cannot see a good reason to leave the priority control to 
>> userspace.
>>   That's a sure recipe for userspace-controlled livelocks.
>> 
>> Now, I'm sure you want to introduce this for a reason, and you are not
>> explaining it ("some scenarios" doesn't quite cut it). If you care to
>> explain these "scenarios", maybe there is something we can do.
> Marc，
>     Thanks for answer.
>     In the real-time system(RTOS), we want the timer tick irq is 
> responded as
> soon as possible to trigger kernel do task schedule. Non-preemptable
> IRQ decreases the Real-Time Performance of Real-Time Operating System

Giving the timer a higher priority doesn't solve anything, really.
It just papers over the fact that you are not using threaded interrupts.
You also don't explain how you plan to change the scheduler and the
whole locking infrastructure to cope with nesting interrupts in the
general case.

I would suggest you use PREEMPT-RT, where all interrupts are threaded
and thus preemptable.

         M.
-- 
Jazz is not dead. It just smells funny...
