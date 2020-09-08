Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA16C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 05:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECCE621897
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 05:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jv-coder.de header.i=@jv-coder.de header.b="q8PkaB+W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbgIHFsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 01:48:32 -0400
Received: from mail.jv-coder.de ([5.9.79.73]:45364 "EHLO mail.jv-coder.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728531AbgIHFsa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 01:48:30 -0400
Received: from [10.61.40.7] (unknown [37.156.92.209])
        by mail.jv-coder.de (Postfix) with ESMTPSA id A265CA3403;
        Tue,  8 Sep 2020 05:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jv-coder.de; s=dkim;
        t=1599544102; bh=5olWPIBIDOBpJ/u/jO0SIMS2OiTZyBP0n7I5ctG990A=;
        h=Subject:To:From:Message-ID:Date:MIME-Version;
        b=q8PkaB+W/1AgQd4h5AFDos1ediFHia+Q8K6R1z4Q0EXzSxWsugUbhITGKcFFJtxqA
         akjCeaN7nVe6p+vEWQ10Ic4zx7ypWrA9P3Gpa6npVwOILrHEDp5sASZhVrRMhjeonR
         QNqI+T7d52Qgifs4/kzT106aUO1Hy858zwAyMMzE=
Subject: Re: [BUG RT] dump-capture kernel not executed for panic in interrupt
 context
To:     peterz@infradead.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Huang Ying <ying.huang@intel.com>,
        linux-kernel@vger.kernel.org,
        Joerg Vehlow <joerg.vehlow@aox-tech.de>
References: <20200528084614.0c949e8d@gandalf.local.home>
 <cbbf7926-148e-7acb-dc03-3f055d73364b@jv-coder.de>
 <20200727163655.8c94c8e245637b62311f5053@linux-foundation.org>
 <c6b095af-fc92-420f-303f-d2efd9f28873@jv-coder.de>
 <20200821110848.6c3183d1@oasis.local.home>
 <20200821134753.9547695c9b782275be3c95b5@linux-foundation.org>
 <20200821170334.73b52fdd@oasis.local.home>
 <95d7a489-a295-1c11-ac62-83e941ed3a87@jv-coder.de>
 <20200907114618.GR2674@hirez.programming.kicks-ass.net>
 <5c3a502f-2255-5aae-3599-5220aa4b8328@jv-coder.de>
 <20200907162338.GN1362448@hirez.programming.kicks-ass.net>
From:   Joerg Vehlow <lkml@jv-coder.de>
Message-ID: <5600c9f8-2c9d-7776-161a-5f5c1be62c10@jv-coder.de>
Date:   Tue, 8 Sep 2020 07:48:22 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200907162338.GN1362448@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter

On 9/7/2020 6:23 PM, peterz@infradead.org wrote:
>> According to the original comment in __crash_kexec, the mutex was used to
>> prevent a sys_kexec_load, while crash_kexec is executed. Your proposed patch
>> does not lock the mutex in crash_kexec.
> Sure, but any mutex taker will (spin) wait for panic_cpu==CPU_INVALID.
> And if the mutex is already held, we'll not run __crash_kexec() just
> like the trylock() would do today.
Yes you are right, it should work.
>> This does not cover the original use
>> case anymore. The only thing that is protected now are two panicing cores at
>> the same time.
> I'm not following. AFAICT it does exactly what the old code did.
> Although maybe I didn't replace all kexec_mutex users, I now see that
> thing isn't static.
Same thing here.
>
>> Actually, this implementation feels even more hacky to me....
> It's more minimal ;-) It's simpler in that it only provides the required
> semantics (as I understand them) and does not attempt to implement a
> more general trylock() like primitive that isn't needed.
Here I cannot agree with you. There is a second trylock in kernel_kexec, 
that cannot
be protected using the panic_cpu, but it actually could still use 
mutex_trylock and check
the panic_cpu. This should work I guess:

int kexec_trylock(void) {
     if (!mutex_trylock(&kexec_mutex)) {
         return 0;
     }
     smp_mb();
     if (panic_cpu != PANIC_CPU_INVALID) {
          mutex_unlock(&kexec_mutex);
          return 0;
     }
     return 1;
}

Or do I miss something now? All functions protected by mutex_lock cannot 
be executed, after
kexec_trylock resturned 1. kexec_crash will execute up to 
mutex_is_locked and then roll back.
The only thing that can go wrong now is: kexec_trylock executes up to 
smb_mb. At the same time
kexec_crash executes mutex_is_locked, which returns false now and then 
before panic_cpu is reset,
kexec_trylock executes the panic_cpu check, and returns. Now both 
functions did not get the lock and
nothing is executed.

Does that sound right to you? If you have no further objections I will 
post it here

Jörg
