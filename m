Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D00C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 20:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43C1F2054F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 20:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="iogvTZzs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbgEMUzg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 16:55:36 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:58917 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726015AbgEMUzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 16:55:35 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589403335; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=soxLFGcusBrU6Ui7EMNphc3/4GGGrCTLXGXwJr1QcwI=;
 b=iogvTZzsoBVQ8yomeTZeL0ShzP3qsArRja8egCiQR2vEj/uVeFpV2do1KJlfOy41L2SqBlk6
 KcjjZflp0+xk4SD6GkDZt/3ecFHCIxk6BwHuWLqoPqe4LkbFFCzp8eNZB79yLauDRK4e5lge
 IPKOYN4B1xJMQicYI47UAbQ5kIA=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ebc5ec5.7f453b5d4298-smtp-out-n05;
 Wed, 13 May 2020 20:55:33 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8F963C43636; Wed, 13 May 2020 20:55:32 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: psodagud)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F0E27C433F2;
        Wed, 13 May 2020 20:55:31 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 13 May 2020 13:55:31 -0700
From:   psodagud@codeaurora.org
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     john.stultz@linaro.org, sboyd@kernel.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, saravanak@google.com,
        pkondeti@codeaurora.org, Joonwoo Park <joonwoop@codeaurora.org>
Subject: Re: [PATCH v3 1/2] timer: make deferrable cpu unbound timers really
 not bound to a cpu
In-Reply-To: <87d0771swr.fsf@nanos.tec.linutronix.de>
References: <1588444137-18651-1-git-send-email-psodagud@codeaurora.org>
 <1588444137-18651-2-git-send-email-psodagud@codeaurora.org>
 <87a72lkx9t.fsf@nanos.tec.linutronix.de>
 <dbc01cd27346bb465744b93ece2b6362@codeaurora.org>
 <87d0771swr.fsf@nanos.tec.linutronix.de>
Message-ID: <ba1e3e84f0a77d550898222e94844ca7@codeaurora.org>
X-Sender: psodagud@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-13 13:28, Thomas Gleixner wrote:
> psodagud@codeaurora.org writes:
>> On 2020-05-06 06:28, Thomas Gleixner wrote:
>>>>  #ifdef CONFIG_SMP
>>>> +struct timer_base timer_base_deferrable;
>>>>  unsigned int sysctl_timer_migration = 1;
>>>> 
>>>>  DEFINE_STATIC_KEY_FALSE(timers_migration_enabled);
>>>> @@ -841,8 +842,14 @@ static inline struct timer_base
>>>> *get_timer_cpu_base(u32 tflags, u32 cpu)
>>>>  	 * If the timer is deferrable and NO_HZ_COMMON is set then we need
>>>>  	 * to use the deferrable base.
>>>>  	 */
>>>> -	if (IS_ENABLED(CONFIG_NO_HZ_COMMON) && (tflags & 
>>>> TIMER_DEFERRABLE))
>>>> -		base = per_cpu_ptr(&timer_bases[BASE_DEF], cpu);
>>>> +	if (IS_ENABLED(CONFIG_NO_HZ_COMMON) && (tflags & 
>>>> TIMER_DEFERRABLE))
>>>> {
>>>> +#ifdef CONFIG_SMP
>>>> +		base = &timer_base_deferrable;
>>>> +#endif
>>> 
>>> There are definitely smarter ways of solving this than sprinkling
>>> #ifdef's around the code.
>> 
>> I am able to understand all other comments and I will address all 
>> those
>> comments in the next patch set.
>> It is not clear to me how to avoid #ifdef's in this case. Could you
>> please share an example here?
> 
> The answer is further down already:

Thanks Tglx for quick response.

I think, you are referring stub functions. Yes. I can reduce some of the 
#ifdefs with stub functions as you mentioned and not all the cases 
right?
I have introduced two variables timer_base_deferrable and 
deferrable_pending and I can put stub function where ever is possible. 
But it may not be appropriate to have stub function for all the 
references of these variables right? Correct me if my understanding is 
wrong.

-Thanks, Prasad

> 
>>> Stub functions exist to avoid this unreadable #ifdef garbage.
