Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA049C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 14:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FD8B246A0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 14:18:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgB1OSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 09:18:18 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36836 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgB1OSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 09:18:18 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j7gSo-0000Ne-V5; Fri, 28 Feb 2020 15:18:03 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 911D0104097; Fri, 28 Feb 2020 15:18:02 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Alexandre Chartre <alexandre.chartre@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 07/24] x86/traps: Prepare for using DEFINE_IDTENTRY
In-Reply-To: <af1808f4-93a3-d015-753f-168c742f89f7@oracle.com>
References: <20200225221606.511535280@linutronix.de> <20200225222648.880108780@linutronix.de> <af1808f4-93a3-d015-753f-168c742f89f7@oracle.com>
Date:   Fri, 28 Feb 2020 15:18:02 +0100
Message-ID: <8736auhk2t.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexandre Chartre <alexandre.chartre@oracle.com> writes:
> On 2/25/20 11:16 PM, Thomas Gleixner wrote:
>> Prepare for using IDTENTRY to define the C exception/trap entry points. It
>> would be possible to glue this into the existing macro maze, but it's
>> simpler and better to read at the end to just make them distinct. Provide
>> a trivial inline helper to read the trap address.
>> 
>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>> ---
>>   arch/x86/kernel/traps.c |    5 +++++
>>   1 file changed, 5 insertions(+)
>> 
>> --- a/arch/x86/kernel/traps.c
>> +++ b/arch/x86/kernel/traps.c
>> @@ -274,6 +274,11 @@ static void do_error_trap(struct pt_regs
>>   	}
>>   }
>>   
>> +static inline void __user *error_get_trap_addr(struct pt_regs *regs)
>> +{
>> +	return (void __user *)uprobe_get_trap_addr(regs);
>> +}
>> +
>>   #define IP ((void __user *)uprobe_get_trap_addr(regs))
>
> And you will eventually get rid of this IP macro, right?

The whole macro maze will be gone at the end.
