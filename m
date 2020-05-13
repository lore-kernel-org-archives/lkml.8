Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A1AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 20:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B1C920575
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 20:28:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbgEMU20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 16:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbgEMU20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 16:28:26 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 476D2C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 13:28:26 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jYxzJ-0003vJ-1H; Wed, 13 May 2020 22:28:21 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 2E545100605; Wed, 13 May 2020 22:28:20 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     psodagud@codeaurora.org
Cc:     john.stultz@linaro.org, sboyd@kernel.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, saravanak@google.com,
        pkondeti@codeaurora.org, Joonwoo Park <joonwoop@codeaurora.org>
Subject: Re: [PATCH v3 1/2] timer: make deferrable cpu unbound timers really not bound to a cpu
In-Reply-To: <dbc01cd27346bb465744b93ece2b6362@codeaurora.org>
References: <1588444137-18651-1-git-send-email-psodagud@codeaurora.org> <1588444137-18651-2-git-send-email-psodagud@codeaurora.org> <87a72lkx9t.fsf@nanos.tec.linutronix.de> <dbc01cd27346bb465744b93ece2b6362@codeaurora.org>
Date:   Wed, 13 May 2020 22:28:20 +0200
Message-ID: <87d0771swr.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

psodagud@codeaurora.org writes:
> On 2020-05-06 06:28, Thomas Gleixner wrote:
>>>  #ifdef CONFIG_SMP
>>> +struct timer_base timer_base_deferrable;
>>>  unsigned int sysctl_timer_migration = 1;
>>> 
>>>  DEFINE_STATIC_KEY_FALSE(timers_migration_enabled);
>>> @@ -841,8 +842,14 @@ static inline struct timer_base 
>>> *get_timer_cpu_base(u32 tflags, u32 cpu)
>>>  	 * If the timer is deferrable and NO_HZ_COMMON is set then we need
>>>  	 * to use the deferrable base.
>>>  	 */
>>> -	if (IS_ENABLED(CONFIG_NO_HZ_COMMON) && (tflags & TIMER_DEFERRABLE))
>>> -		base = per_cpu_ptr(&timer_bases[BASE_DEF], cpu);
>>> +	if (IS_ENABLED(CONFIG_NO_HZ_COMMON) && (tflags & TIMER_DEFERRABLE)) 
>>> {
>>> +#ifdef CONFIG_SMP
>>> +		base = &timer_base_deferrable;
>>> +#endif
>> 
>> There are definitely smarter ways of solving this than sprinkling
>> #ifdef's around the code.
>
> I am able to understand all other comments and I will address all those 
> comments in the next patch set.
> It is not clear to me how to avoid #ifdef's in this case. Could you 
> please share an example here?

The answer is further down already:
 
>> Stub functions exist to avoid this unreadable #ifdef garbage.

