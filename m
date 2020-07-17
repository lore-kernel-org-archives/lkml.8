Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B605C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6015C20704
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kkZ15Sln";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0Nt3KUrp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbgGQSiN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 14:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgGQSiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 14:38:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE3EC0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 11:38:12 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595011090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=epzCBXg5qGcUfz87P+4zTdQJlxn0UPwHoqC1rhawI+4=;
        b=kkZ15SlnVeAyM8KP28wI99EpmR25TiEo1o/GP3Z++FjeSUic/TRu8p3NAqkP5517rnE7lc
        LMvco4TaXym9Wt0fhT/Y4eDrqblfetORQ5jIPFurRDN0W2lblI9BDdxREKgbDbLzzS4Wfu
        q4AyPva3YdECri3KJT+KkDyG3dVANoKM4b8zjOv2F+qR16QDgymvIk9eZxbhPO3oqw2Avl
        48rfrrz2OA+zrPiyzoyAkNQ0+NIvi8vTl5y2PANGb87/YsoPQ3QyGFiBXu9m53b9pGtdz1
        KI0UW9hvl0ZRXZKXTIlrTXYV4iFp8YH1yjBS59gW4cR9FO46T9ggu+yoieHzfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595011090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=epzCBXg5qGcUfz87P+4zTdQJlxn0UPwHoqC1rhawI+4=;
        b=0Nt3KUrpCBd404neVuL9guOuxvCq5t65zxuM0w8h9hphTZfoh6vSm0wvNN91BIQyvm9VgH
        Rfe13kHJvvxoFlCw==
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [patch V2 3/5] posix-cpu-timers: Provide mechanisms to defer timer handling to task_work
In-Reply-To: <20200716225458.GL5523@worktop.programming.kicks-ass.net>
References: <20200716201923.228696399@linutronix.de> <20200716202044.734067877@linutronix.de> <20200716225458.GL5523@worktop.programming.kicks-ass.net>
Date:   Fri, 17 Jul 2020 20:38:10 +0200
Message-ID: <87tuy6q965.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:
> On Thu, Jul 16, 2020 at 10:19:26PM +0200, Thomas Gleixner wrote:
>> +static void __run_posix_cpu_timers(struct task_struct *tsk)
>> +{
>> +	struct posix_cputimers *pct = &tsk->posix_cputimers;
>> +
>> +	if (!test_and_set_bit(CPUTIMERS_WORK_SCHEDULED, &pct->flags))
>> +		task_work_add(tsk, &pct->task_work, true);
>
> s/true/TWA_RESUME/g
>
> see: e91b48162332 ("task_work: teach task_work_add() to do signal_wake_up()")

Duh, yes.
