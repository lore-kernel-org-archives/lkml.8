Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95206C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 22:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F4BE2053B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 22:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="GX02xB3H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731978AbgEMW7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 18:59:00 -0400
Received: from mail.efficios.com ([167.114.26.124]:50980 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731815AbgEMW7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 18:59:00 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id C61132BF350;
        Wed, 13 May 2020 18:58:58 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 23sC-RYK1Vet; Wed, 13 May 2020 18:58:58 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 899FE2BF60C;
        Wed, 13 May 2020 18:58:58 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 899FE2BF60C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1589410738;
        bh=lYnUYdKASWttmtbCjT9VqHa4gyix8hxv8nRsU5Wu5gE=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=GX02xB3HxyKSXRhKWa2s/3qQBKhKzieJNA2FH26dITNc4QL925cjsWjjUw8ykfxSF
         dlWt8uUDyeYg0aAJDzbf82K95bt+BYFlQkGmK1Y2oxmoThBk682wQnxIFAy7xcvdw8
         FurKQFlaG4Jfw/VSbEaw3g48+9RilGJxz0f0X08fQEwxnQwUHjz4LVozBF0r/cypEx
         eRnXCKuvz1ze21Kb/dcLI+702mHeBRZ4J7y9qQeZEOb5PbfgrbEQeR1BO1SvtTHfbJ
         HPrEIxPj24IjoBcfVaLBe2fSNMfn0C+0EU1lQtucdDRaa5ESJHcKPEEbqxD+z8J6/k
         BkZP/i7QuVh1g==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id iZCEUSHzl246; Wed, 13 May 2020 18:58:58 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 78FB62BF34D;
        Wed, 13 May 2020 18:58:58 -0400 (EDT)
Date:   Wed, 13 May 2020 18:58:58 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Alexandre Chartre <alexandre.chartre@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        paulmck <paulmck@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>, rostedt <rostedt@goodmis.org>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Message-ID: <1733222250.20139.1589410738477.JavaMail.zimbra@efficios.com>
In-Reply-To: <a5d3866a-af7f-bf0a-4864-16db9965e39f@oracle.com>
References: <20200505131602.633487962@linutronix.de> <20200505134059.970057117@linutronix.de> <a5d3866a-af7f-bf0a-4864-16db9965e39f@oracle.com>
Subject: Re: [patch V4 part 1 19/36] x86/entry: Exclude low level entry code
 from sanitizing
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3928 (ZimbraWebClient - FF76 (Linux)/8.8.15_GA_3928)
Thread-Topic: x86/entry: Exclude low level entry code from sanitizing
Thread-Index: YtHVr8cJ2M9gb3Xiem2xs44SVIpxLQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On May 6, 2020, at 12:03 PM, Alexandre Chartre alexandre.chartre@oracle.com wrote:

> On 5/5/20 3:16 PM, Thomas Gleixner wrote:
>> The sanitizers are not really applicable to the fragile low level entry
>> code. code. Entry code needs to carefully setup a normal 'runtime'
> 
> typo: code. code.

Looking at updated tree, the reviewed-by is there, but there is still
way too much "code". ;)

Thanks,

Mathieu

> 
> Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
> 
> alex.
> 
> 
>> environment.
>> 
>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>> ---
>>   arch/x86/entry/Makefile |    8 ++++++++
>>   1 file changed, 8 insertions(+)
>> 
>> --- a/arch/x86/entry/Makefile
>> +++ b/arch/x86/entry/Makefile
>> @@ -3,6 +3,14 @@
>>   # Makefile for the x86 low level entry code
>>   #
>>   
>> +KASAN_SANITIZE := n
>> +UBSAN_SANITIZE := n
>> +KCOV_INSTRUMENT := n
>> +
>> +CFLAGS_REMOVE_common.o = $(CC_FLAGS_FTRACE) -fstack-protector
>> -fstack-protector-strong
>> +CFLAGS_REMOVE_syscall_32.o = $(CC_FLAGS_FTRACE) -fstack-protector
>> -fstack-protector-strong
>> +CFLAGS_REMOVE_syscall_64.o = $(CC_FLAGS_FTRACE) -fstack-protector
>> -fstack-protector-strong
>> +
>>   OBJECT_FILES_NON_STANDARD_entry_64_compat.o := y
>>   
>>   CFLAGS_syscall_64.o		+= $(call cc-option,-Wno-override-init,)

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
