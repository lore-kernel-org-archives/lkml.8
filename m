Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C5EEC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40F4A20746
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbgEFPAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:00:40 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:57032 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728428AbgEFPAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:00:40 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jWLXI-0000qZ-6w; Wed, 06 May 2020 09:00:36 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jWLXH-0006vv-HW; Wed, 06 May 2020 09:00:36 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
        <87ftcei2si.fsf@x220.int.ebiederm.org>
        <202005051354.C7E2278688@keescook>
Date:   Wed, 06 May 2020 09:57:10 -0500
In-Reply-To: <202005051354.C7E2278688@keescook> (Kees Cook's message of "Tue,
        5 May 2020 14:29:21 -0700")
Message-ID: <87368ddsc9.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jWLXH-0006vv-HW;;;mid=<87368ddsc9.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18x9VVQhJyecxxOZFaE4ZN6/7+8evDmFrk=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 6/7] exec: Move most of setup_new_exec into flush_old_exec
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> On Tue, May 05, 2020 at 02:45:33PM -0500, Eric W. Biederman wrote:
>> 
>> The current idiom for the callers is:
>> 
>> flush_old_exec(bprm);
>> set_personality(...);
>> setup_new_exec(bprm);
>> 
>> In 2010 Linus split flush_old_exec into flush_old_exec and
>> setup_new_exec.  With the intention that setup_new_exec be what is
>> called after the processes new personality is set.
>> 
>> Move the code that doesn't depend upon the personality from
>> setup_new_exec into flush_old_exec.  This is to facilitate future
>> changes by having as much code together in one function as possible.
>
> Er, I *think* this is okay, but I have some questions below which
> maybe you already investigated (and should perhaps get called out in
> the changelog).

I will see if I can expand more on the review that I have done.

I saw this as moving thre lines and the personality setting later in the
code, rather than moving a bunch of lines up

AKA these lines:
>> +	arch_pick_mmap_layout(me->mm, &bprm->rlim_stack);
>> +
>> +	arch_setup_new_exec();
>> +
>> +	/* Set the new mm task size. We have to do that late because it may
>> +	 * depend on TIF_32BIT which is only updated in flush_thread() on
>> +	 * some architectures like powerpc
>> +	 */
>> +	me->mm->task_size = TASK_SIZE;


I verified carefully that only those three lines can depend upon the
personality changes.

Your concern if anything depends on those moved lines I haven't looked
at so closely so I will go back through and do that.  I don't actually
expect anything depends upon those three lines because they should only
be changing architecture specific state.  But that is general handwaving
not actually careful review which tends to turn up suprises in exec.

Speaking of while I was looking through the lsm hooks again I just
realized that 613cc2b6f272 ("fs: exec: apply CLOEXEC before changing
dumpable task flags") only fixed half the problem.  So I am going to
take a quick detour fix that then come back to this.  As that directly
affects this code motion.

Eric
