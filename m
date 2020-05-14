Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C879C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 10:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 439392053B
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 10:37:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbgENKhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 06:37:10 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:35686 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbgENKhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 06:37:10 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 49N7Jd6WD1z1qsbw;
        Thu, 14 May 2020 12:37:05 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 49N7Jd58Fnz1shf0;
        Thu, 14 May 2020 12:37:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id ko2jpSuwhhpd; Thu, 14 May 2020 12:37:04 +0200 (CEST)
X-Auth-Info: WUTlnI9/QyTBJ+uRTi09dhHMGWk5XT8U8LZ6vzd/qvdVFwDdans5FzcgBT3sZp+y
Received: from igel.home (ppp-46-244-180-168.dynamic.mnet-online.de [46.244.180.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu, 14 May 2020 12:37:04 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id C03992C1E36; Thu, 14 May 2020 12:37:03 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Qais Yousef <qais.yousef@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ia64: enable HAVE_COPY_THREAD_TLS, switch to
 kernel_clone_args
References: <20200513204848.1208864-1-christian.brauner@ubuntu.com>
        <3908561D78D1C84285E8C5FCA982C28F7F6266E0@ORSMSX115.amr.corp.intel.com>
        <79e58d9b-5a39-390c-2f0c-0d87b63442b4@physik.fu-berlin.de>
        <20200514074606.vkc35syhdep23rzh@wittgenstein>
        <6b298416-1e64-eee7-0bb4-3b1f7f67adc6@physik.fu-berlin.de>
        <d6c94d4f-a431-9de5-7a0f-661894dbec01@physik.fu-berlin.de>
        <20200514100459.pt7dxq2faghdds2c@wittgenstein>
        <2e22b0d2-b9ce-420d-48a0-0d9134108a5c@physik.fu-berlin.de>
        <20200514101540.25hvle74w63t66fs@wittgenstein>
        <20200514101914.fu7xhgaxtb5fy2ky@wittgenstein>
X-Yow:  I'm having an emotional outburst!!
Date:   Thu, 14 May 2020 12:37:03 +0200
In-Reply-To: <20200514101914.fu7xhgaxtb5fy2ky@wittgenstein> (Christian
        Brauner's message of "Thu, 14 May 2020 12:19:14 +0200")
Message-ID: <87blmq6bw0.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mai 14 2020, Christian Brauner wrote:

>> static inline pid_t raw_clone(unsigned long flags) {
>>         pid_t ret;
>> 
>>         assert((flags & (CLONE_VM|CLONE_PARENT_SETTID|CLONE_CHILD_SETTID|
>>                          CLONE_CHILD_CLEARTID|CLONE_SETTLS)) == 0);
>> #if defined(__s390x__) || defined(__s390__) || defined(__CRIS__)
>>         /* On s390/s390x and cris the order of the first and second arguments
>>          * of the raw clone() system call is reversed. */
>>         ret = (pid_t) syscall(__NR_clone, NULL, flags);
>> #elif defined(__sparc__)
>>         {
>>                 /**
>>                  * sparc always returns the other process id in %o0, and
>>                  * a boolean flag whether this is the child or the parent in
>>                  * %o1. Inline assembly is needed to get the flag returned
>>                  * in %o1.
>>                  */
>>                 int in_child, child_pid, error;
>> 
>>                 asm volatile("mov %3, %%g1\n\t"
>>                              "mov %4, %%o0\n\t"
>>                              "mov 0 , %%o1\n\t"
>> #if defined(__arch64__)
>>                              "t 0x6d\n\t"
>> #else
>>                              "t 0x10\n\t"
>> #endif
>>                              "addx %%g0, 0, %2\n\t"
>>                              "mov %%o1, %0\n\t"
>>                              "mov %%o0, %1" :
>>                              "=r"(in_child), "=r"(child_pid), "=r"(error) :
>>                              "i"(__NR_clone), "r"(flags) :
>>                              "%o1", "%o0", "%g1", "cc" );
>> 
>>                 if (error) {
>>                         errno = child_pid;
>>                         ret = -1;
>>                 } else
>>                         ret = in_child ? 0 : child_pid;
>>         }
>> +#elif defined(__ia64__)
>> +	/* On ia64 the stack and stack size are passed as separate arguments. */
>> +	return (pid_t)syscall(__NR_clone, flags, NULL, 0);
>> +#else
>> +	return (pid_t)syscall(__NR_clone, flags, NULL);
>> +#endif
>
> Scratch that. It's even worse. On ia64 it is _invalid_ to pass a NULL
> stack.

Only if you want CLONE_VM.  But this raw_clone does not allow CLONE_VM,
thus it is actually a true fork.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
