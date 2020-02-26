Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FB4C4BA0B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 05:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A5B824653
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 05:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582694944;
	bh=7EZlyJmfitwu9cl72s933JiTNqw/gi+6NG4TRgo4WRE=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=kWeMeSGhZh4yGPQczNm8ECYv3WN+cokGF52k/cGO33G/I3JlHc0nQ4T4XGPKahPu9
	 dJgvHC7/qiT7ffeOA3wMd7rkSG9d3+jq8sVatSHxseJKJQjiCX/ds6aggPU130DzLA
	 rER6DI5UdlAZxBibcqq1EhWyMcQYck32nT+m2HbA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbgBZF3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 00:29:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:33542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbgBZF3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 00:29:02 -0500
Received: from [192.168.0.217] (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25C4C21927;
        Wed, 26 Feb 2020 05:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582694941;
        bh=7EZlyJmfitwu9cl72s933JiTNqw/gi+6NG4TRgo4WRE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mFeHjgEfkA7pOt7jfFCg5L8mtHjs+k/GwAC0YTe/YMbPlM6xs8nk5DwfglUYqtaBX
         DGKrhZbXoBF5M3sOjnsPaapdshJIQsDRgIMQs2GSp/YZAvr+1DfsEehDWrZIjlYjEN
         xQxZ2xvc/FUDtccjB03rf+4xH0yDfV5bGvG9Db3s=
Subject: Re: [patch 02/10] x86/mce: Disable tracing and kprobes on
 do_machine_check()
To:     Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
References: <20200225213636.689276920@linutronix.de>
 <20200225220216.315548935@linutronix.de> <20200226011349.GH9599@lenoir>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <d9bde3a6-1e19-1340-1fda-bc6de2eb4f7c@kernel.org>
Date:   Tue, 25 Feb 2020 21:29:00 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200226011349.GH9599@lenoir>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/25/20 5:13 PM, Frederic Weisbecker wrote:
> On Tue, Feb 25, 2020 at 10:36:38PM +0100, Thomas Gleixner wrote:
>> From: Andy Lutomirski <luto@kernel.org>
>>
>> do_machine_check() can be raised in almost any context including the most
>> fragile ones. Prevent kprobes and tracing.
>>
>> Signed-off-by: Andy Lutomirski <luto@kernel.org>
>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>> ---
>>  arch/x86/include/asm/traps.h   |    3 ---
>>  arch/x86/kernel/cpu/mce/core.c |   12 ++++++++++--
>>  2 files changed, 10 insertions(+), 5 deletions(-)
>>
>> --- a/arch/x86/include/asm/traps.h
>> +++ b/arch/x86/include/asm/traps.h
>> @@ -88,9 +88,6 @@ dotraplinkage void do_page_fault(struct
>>  dotraplinkage void do_spurious_interrupt_bug(struct pt_regs *regs, long error_code);
>>  dotraplinkage void do_coprocessor_error(struct pt_regs *regs, long error_code);
>>  dotraplinkage void do_alignment_check(struct pt_regs *regs, long error_code);
>> -#ifdef CONFIG_X86_MCE
>> -dotraplinkage void do_machine_check(struct pt_regs *regs, long error_code);
>> -#endif
>>  dotraplinkage void do_simd_coprocessor_error(struct pt_regs *regs, long error_code);
>>  #ifdef CONFIG_X86_32
>>  dotraplinkage void do_iret_error(struct pt_regs *regs, long error_code);
>> --- a/arch/x86/kernel/cpu/mce/core.c
>> +++ b/arch/x86/kernel/cpu/mce/core.c
>> @@ -1213,8 +1213,14 @@ static void __mc_scan_banks(struct mce *
>>   * On Intel systems this is entered on all CPUs in parallel through
>>   * MCE broadcast. However some CPUs might be broken beyond repair,
>>   * so be always careful when synchronizing with others.
>> + *
>> + * Tracing and kprobes are disabled: if we interrupted a kernel context
>> + * with IF=1, we need to minimize stack usage.  There are also recursion
>> + * issues: if the machine check was due to a failure of the memory
>> + * backing the user stack, tracing that reads the user stack will cause
>> + * potentially infinite recursion.
>>   */
>> -void do_machine_check(struct pt_regs *regs, long error_code)
>> +void notrace do_machine_check(struct pt_regs *regs, long error_code)
>>  {
>>  	DECLARE_BITMAP(valid_banks, MAX_NR_BANKS);
>>  	DECLARE_BITMAP(toclear, MAX_NR_BANKS);
>> @@ -1360,6 +1366,7 @@ void do_machine_check(struct pt_regs *re
>>  	ist_exit(regs);
>>  }
>>  EXPORT_SYMBOL_GPL(do_machine_check);
>> +NOKPROBE_SYMBOL(do_machine_check);
> 
> That won't protect all the function called by do_machine_check(), right?
> There are lots of them.
> 

It at least means we can survive to run actual C code in
do_machine_check(), which lets us try to mitigate this issue further.
PeterZ has patches for that, and maybe this series fixes it later on.
(I'm reading in order!)
