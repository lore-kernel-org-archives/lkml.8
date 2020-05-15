Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB78DC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 17:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FB3F206D8
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 17:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B2srkRIA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgEORuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 13:50:21 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55417 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726023AbgEORuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 13:50:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589565019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zwQ5ltGt83PqgYhj9uQQrPj4wuimjwIpIpSjO1pjtKQ=;
        b=B2srkRIA3ZNcxXrxfTrbZNPEnqOyfhPCab0zJWcFEfj2GP3ntSLiVrDxhc+0/bwLosZr/p
        Ak3kpxW8M1Y+jMFgHLslLr27muUcDLV8L1BzYYQVi4B/aglPYWpMRGUdxAtu3B2sbKYDjB
        bu4PMb9LqgsskIIFggayyYgolNuM+Xc=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-Hs4JGxStPSCdREjbgJLOSA-1; Fri, 15 May 2020 13:50:18 -0400
X-MC-Unique: Hs4JGxStPSCdREjbgJLOSA-1
Received: by mail-qk1-f200.google.com with SMTP id i21so3065773qki.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 10:50:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=zwQ5ltGt83PqgYhj9uQQrPj4wuimjwIpIpSjO1pjtKQ=;
        b=FBjl++qBsDcTpoppwx2JpYVIJBeAZ3nALk+cZBHwVjsNTHfE3k7hlRWvxboHsy38mh
         WWrp15SGvmI4iG0RAc9c9UZQlQ8M0yCoh0UGAFR/Gv11/O0159E6fY51EE9MmQQpQSos
         QtuktCs/Drm5O7M/+Ml+Z+a+4gLQAc3wmyhIXHDQht/xpXFrmf5eNnBR8IIFk63CjeCY
         zDroCxc+8L8EQ7tQqPEHBWQj4mUzgPhfM7GGEAMI/OEJMNTargaudmGkq2h8G7RCaT1w
         foMst7xesWbU+0lZtuiTA1CC8d3nyAoJ8+C4VHbGYOeqiDuKTZZQOL0QGahxgIOvtOOv
         34lQ==
X-Gm-Message-State: AOAM5331S77XUWLqN5ODiHsSqYT97KdvUYXwxljmXbBb0M1V1HEWdsXw
        1LDbOtzyXOjZlF2VFzYWm/3Hkbw1h9tiS9Dw7FM/f9AOUAriXdjCKBE7Mq8tD49INOOuFiLSTIl
        3+xS4NRpEPLg6XuQyN2PEe/Jc
X-Received: by 2002:ac8:714c:: with SMTP id h12mr4756283qtp.372.1589565017234;
        Fri, 15 May 2020 10:50:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxt4GvKY1IPSC9+yaLvlKyNwTubxF6olkd9m/7jRcVRlAeG7PlvKpIFSHS1j81tO5BUwDOM8Q==
X-Received: by 2002:ac8:714c:: with SMTP id h12mr4756264qtp.372.1589565016959;
        Fri, 15 May 2020 10:50:16 -0700 (PDT)
Received: from [192.168.1.4] (198-84-170-103.cpe.teksavvy.com. [198.84.170.103])
        by smtp.gmail.com with ESMTPSA id 88sm2549291qth.9.2020.05.15.10.50.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2020 10:50:16 -0700 (PDT)
Subject: Re: [PATCH] futex: send SIGBUS if argument is not aligned on a
 four-byte boundary
To:     Peter Zijlstra <peterz@infradead.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Maxim Samoylov <max7255@yandex-team.ru>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-api@vger.kernel.org
References: <158955700764.647498.18025770126733698386.stgit@buzz>
 <20200515162707.GI2978@hirez.programming.kicks-ass.net>
From:   Carlos O'Donell <carlos@redhat.com>
Organization: Red Hat
Message-ID: <403cc691-4ec5-8b3f-382c-4820736da41d@redhat.com>
Date:   Fri, 15 May 2020 13:50:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200515162707.GI2978@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/15/20 12:27 PM, Peter Zijlstra wrote:
> On Fri, May 15, 2020 at 06:36:47PM +0300, Konstantin Khlebnikov wrote:
>> Userspace implementations of mutexes (including glibc) in some cases
>> retries operation without checking error code from syscall futex.
>> This is good for performance because most errors are impossible when
>> locking code trusts itself.

In newer versions of glibc, which won't solve this problem for older
distributions (or newer glibc on older kernels), we've refactored all
of this code into futex-internal.h and do things like this (example
from one of the generic internal interfaces for futex use):

149     case -ETIMEDOUT: /* Cannot have happened as we provided no timeout.  */
150     case -EFAULT: /* Must have been caused by a glibc or application bug.  */
151     case -EINVAL: /* Either due to wrong alignment or due to the timeout not
152                      being normalized.  Must have been caused by a glibc or
153                      application bug.  */
154     case -ENOSYS: /* Must have been caused by a glibc bug.  */
155     /* No other errors are documented at this time.  */
156     default:
157       futex_fatal_error ();
158     }

Several of the pthread interfaces are using this code so they won't suffer
from "stuck EINVAL loops" like below.

We worked with all the interested parties to get `man 2 futex` updated
with the expected semantics and error return codes.

We don't want to ignore what the kernel is returning and we terminate
the process without propagating that error upwards for the simple 
API cases.

Likewise note the "default:" which means if we get new futex error that
is not documented we also terminate the process.

>> Some errors which could came from outer code are handled automatically,
>> for example invalid address triggers SIGSEGV on atomic fast path.
>>
>> But one case turns into nasty busy-loop: when address is unaligned.
>> futex(FUTEX_WAIT) returns EINVAL immediately and loop goes to retry.
>>
>> Example which loops inside second call rather than hung peacefully:
>>
>> #include <stdlib.h>
>> #include <pthread.h>
>>
>> int main(int argc, char **argv)
>> {
>> 	char buf[sizeof(pthread_mutex_t) + 1];
>> 	pthread_mutex_t *mutex = (pthread_mutex_t *)(buf + 1);
>>
>> 	pthread_mutex_init(mutex, NULL);
>> 	pthread_mutex_lock(mutex);
>> 	pthread_mutex_lock(mutex);
>> }

This isn't fixed because this is the older code in pthread_mutex_lock
which we haven't ported to futex-internal.h yet, otherwise we would abort
the process.

A quick change to use the newer interface (futex_wait_simple), and the
example above fails as expected:

./test
The futex facility returned an unexpected error code.
Aborted (core dumped)

And it does not loop. I'm open to bikeshed on the existing error message
(which has been there since 2014 / commit a2f0363f817).

coredumpctl debug loop-futex/test

Core was generated by `./test'.
Program terminated with signal SIGABRT, Aborted.
#0  __GI_raise (sig=sig@entry=6) at ../sysdeps/unix/sysv/linux/raise.c:49
49	  return ret;
(gdb) bt
#0  __GI_raise (sig=sig@entry=6) at ../sysdeps/unix/sysv/linux/raise.c:49
#1  0x00007f1cac0d2872 in __GI_abort () at abort.c:79
#2  0x00007f1cac12a248 in __libc_message (action=action@entry=do_abort, fmt=fmt@entry=0x7f1cac234a57 "%s")
    at ../sysdeps/posix/libc_fatal.c:155
#3  0x00007f1cac12a27a in __GI___libc_fatal (
    message=message@entry=0x7f1cac288000 "The futex facility returned an unexpected error code.\n")
    at ../sysdeps/posix/libc_fatal.c:164
#4  0x00007f1cac283fdc in futex_fatal_error () at ../sysdeps/nptl/futex-internal.h:157
#5  futex_wait (private=<optimized out>, expected=2, futex_word=0x7f1cac283fdc <__lll_lock_wait+92>)
    at ../sysdeps/nptl/futex-internal.h:157
#6  futex_wait_simple (private=<optimized out>, expected=2, futex_word=0x7f1cac283fdc <__lll_lock_wait+92>)
    at ../sysdeps/nptl/futex-internal.h:172
#7  __lll_lock_wait (futex=futex@entry=0x7ffdb1f0a2c1, private=<optimized out>) at lowlevellock.c:53
#8  0x00007f1cac27cbf3 in __GI___pthread_mutex_lock (mutex=0x7ffdb1f0a2c1) at ../nptl/pthread_mutex_lock.c:80
#9  0x000000000040117a in main (argc=1, argv=0x7ffdb1f0a3f8) at test.c:11

So semantically the kernel change makes sense, and will terminate the
process for glibc today, and matches what the refactored glibc code
will do in userspace for more of the interfaces in the future.

>> It seems there is no practical usage for calling syscall futex for
>> unaligned address. This may be only bug in user space. Let's help
>> and handle this gracefully without adding extra code on fast path.

The only use case I could see is retroactively adding a futex to the
existing ABI of a structure and wanting to avoid padding. That does
not seem like a common enough use case that we would want to support.
To get efficient cache-line usage you'll want to pack things by hand.

>> This patch sends SIGBUS signal to slay task and break busy-loop.
>>
>> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
>> Reported-by: Maxim Samoylov <max7255@yandex-team.ru>
> 
> Seems like a sensible idea to me.

Please do try to update the linux kernel man pages update to note
the change in behaviour and the version and commit of the released
kernel where this changed.

Please keep `man 2 futex` as accurate as possible for userspace
libc implementations.

Thanks.
 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
>> ---
>>  kernel/futex.c |   13 ++++++++++++-
>>  1 file changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/futex.c b/kernel/futex.c
>> index b59532862bc0..8a6d35fa56bc 100644
>> --- a/kernel/futex.c
>> +++ b/kernel/futex.c
>> @@ -508,10 +508,21 @@ get_futex_key(u32 __user *uaddr, int fshared, union futex_key *key, enum futex_a
>>  
>>  	/*
>>  	 * The futex address must be "naturally" aligned.
>> +	 * Also send signal to break busy-loop if user-space ignore error.
>> +	 * EFAULT case should trigger SIGSEGV at access from user-space.
>>  	 */
>>  	key->both.offset = address % PAGE_SIZE;
>> -	if (unlikely((address % sizeof(u32)) != 0))
>> +	if (unlikely((address % sizeof(u32)) != 0)) {
>> +		struct kernel_siginfo info;
>> +
>> +		clear_siginfo(&info);
>> +		info.si_signo = SIGBUS;
>> +		info.si_code  = BUS_ADRALN;
>> +		info.si_addr  = uaddr;
>> +		force_sig_info(&info);
>> +
>>  		return -EINVAL;
>> +	}
>>  	address -= key->both.offset;
>>  
>>  	if (unlikely(!access_ok(uaddr, sizeof(u32))))
>>
> 

-- 
Cheers,
Carlos.

