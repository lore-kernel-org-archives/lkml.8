Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E57AC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 13:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D92E206DB
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 13:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbgEFNA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 09:00:27 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:39120 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727964AbgEFNA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 09:00:27 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jWJey-0007Bg-TN; Wed, 06 May 2020 07:00:24 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jWJey-00061w-1F; Wed, 06 May 2020 07:00:24 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
        <87bln2jhki.fsf@x220.int.ebiederm.org>
        <ce5f0c22-675b-cdc8-cd95-976c0e0babee@linux-m68k.org>
Date:   Wed, 06 May 2020 07:56:59 -0500
In-Reply-To: <ce5f0c22-675b-cdc8-cd95-976c0e0babee@linux-m68k.org> (Greg
        Ungerer's message of "Wed, 6 May 2020 22:42:42 +1000")
Message-ID: <87v9l9dxwk.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jWJey-00061w-1F;;;mid=<87v9l9dxwk.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19W5a9a8zm+g2O6M8Y98Fe+NXQMQUxKUZo=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 1/7] binfmt: Move install_exec_creds after setup_new_exec to match binfmt_elf
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Ungerer <gerg@linux-m68k.org> writes:

> One small nit:

Good point.

> On 6/5/20 5:41 am, Eric W. Biederman wrote:
>> In 2016 Linus moved install_exec_creds immediately after
>> setup_new_exec, in binfmt_elf as a cleanup and as part of closing a
>> potential information leak.
>>
>> Perform the same cleanup for the other binary formats.
>>
>> Different binary formats doing the same things the same way makes exec
>> easier to reason about and easier to maintain.
>>
>> The binfmt_flagt bits were tested by Greg Ungerer <gerg@linux-m68k.org>
>              ^^^^^
>              flat
>
> Regards
> Greg
>
>
>> Ref: 9f834ec18def ("binfmt_elf: switch to new creds when switching to new mm")
>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>> ---
>>   arch/x86/ia32/ia32_aout.c | 3 +--
>>   fs/binfmt_aout.c          | 2 +-
>>   fs/binfmt_elf_fdpic.c     | 2 +-
>>   fs/binfmt_flat.c          | 3 +--
>>   4 files changed, 4 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/x86/ia32/ia32_aout.c b/arch/x86/ia32/ia32_aout.c
>> index 9bb71abd66bd..37b36a8ce5fa 100644
>> --- a/arch/x86/ia32/ia32_aout.c
>> +++ b/arch/x86/ia32/ia32_aout.c
>> @@ -140,6 +140,7 @@ static int load_aout_binary(struct linux_binprm *bprm)
>>   	set_personality_ia32(false);
>>     	setup_new_exec(bprm);
>> +	install_exec_creds(bprm);
>>     	regs->cs = __USER32_CS;
>>   	regs->r8 = regs->r9 = regs->r10 = regs->r11 = regs->r12 =
>> @@ -156,8 +157,6 @@ static int load_aout_binary(struct linux_binprm *bprm)
>>   	if (retval < 0)
>>   		return retval;
>>   -	install_exec_creds(bprm);
>> -
>>   	if (N_MAGIC(ex) == OMAGIC) {
>>   		unsigned long text_addr, map_size;
>>   diff --git a/fs/binfmt_aout.c b/fs/binfmt_aout.c
>> index 8e8346a81723..ace587b66904 100644
>> --- a/fs/binfmt_aout.c
>> +++ b/fs/binfmt_aout.c
>> @@ -162,6 +162,7 @@ static int load_aout_binary(struct linux_binprm * bprm)
>>   	set_personality(PER_LINUX);
>>   #endif
>>   	setup_new_exec(bprm);
>> +	install_exec_creds(bprm);
>>     	current->mm->end_code = ex.a_text +
>>   		(current->mm->start_code = N_TXTADDR(ex));
>> @@ -174,7 +175,6 @@ static int load_aout_binary(struct linux_binprm * bprm)
>>   	if (retval < 0)
>>   		return retval;
>>   -	install_exec_creds(bprm);
>>     	if (N_MAGIC(ex) == OMAGIC) {
>>   		unsigned long text_addr, map_size;
>> diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
>> index 240f66663543..6c94c6d53d97 100644
>> --- a/fs/binfmt_elf_fdpic.c
>> +++ b/fs/binfmt_elf_fdpic.c
>> @@ -353,6 +353,7 @@ static int load_elf_fdpic_binary(struct linux_binprm *bprm)
>>   		current->personality |= READ_IMPLIES_EXEC;
>>     	setup_new_exec(bprm);
>> +	install_exec_creds(bprm);
>>     	set_binfmt(&elf_fdpic_format);
>>   @@ -434,7 +435,6 @@ static int load_elf_fdpic_binary(struct linux_binprm
>> *bprm)
>>   	current->mm->start_stack = current->mm->start_brk + stack_size;
>>   #endif
>>   -	install_exec_creds(bprm);
>>   	if (create_elf_fdpic_tables(bprm, current->mm,
>>   				    &exec_params, &interp_params) < 0)
>>   		goto error;
>> diff --git a/fs/binfmt_flat.c b/fs/binfmt_flat.c
>> index 831a2b25ba79..1a1d1fcb893f 100644
>> --- a/fs/binfmt_flat.c
>> +++ b/fs/binfmt_flat.c
>> @@ -541,6 +541,7 @@ static int load_flat_file(struct linux_binprm *bprm,
>>   		/* OK, This is the point of no return */
>>   		set_personality(PER_LINUX_32BIT);
>>   		setup_new_exec(bprm);
>> +		install_exec_creds(bprm);
>>   	}
>>     	/*
>> @@ -963,8 +964,6 @@ static int load_flat_binary(struct linux_binprm *bprm)
>>   		}
>>   	}
>>   -	install_exec_creds(bprm);
>> -
>>   	set_binfmt(&flat_format);
>>     #ifdef CONFIG_MMU
>>
