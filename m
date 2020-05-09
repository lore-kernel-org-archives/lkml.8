Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D81C47255
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 13:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EAB421655
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 13:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbgEINmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 09:42:51 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:36594 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726782AbgEINmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 09:42:50 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jXPkb-0004NO-Kb; Sat, 09 May 2020 07:42:45 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jXPka-0008Hp-Me; Sat, 09 May 2020 07:42:45 -0600
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
        <87sgga6ze4.fsf@x220.int.ebiederm.org>
        <87y2q25knl.fsf_-_@x220.int.ebiederm.org>
        <202005082228.5C0E44CC6@keescook>
Date:   Sat, 09 May 2020 08:39:16 -0500
In-Reply-To: <202005082228.5C0E44CC6@keescook> (Kees Cook's message of "Fri, 8
        May 2020 22:31:06 -0700")
Message-ID: <874ksp448r.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jXPka-0008Hp-Me;;;mid=<874ksp448r.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/hO8wcopX1eKURjVw/cKNalrZ0rz8JKN0=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 5/6] exec: Move handling of the point of no return to the top level
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> On Fri, May 08, 2020 at 01:47:10PM -0500, Eric W. Biederman wrote:
>> 
>> Move the handing of the point of no return from search_binary_handler
>> into __do_execve_file so that it is easier to find, and to keep
>> things robust in the face of change.
>> 
>> Make it clear that an existing fatal signal will take precedence over
>> a forced SIGSEGV by not forcing SIGSEGV if a fatal signal is already
>> pending.  This does not change the behavior but it saves a reader
>> of the code the tedium of reading and understanding force_sig
>> and the signal delivery code.
>> 
>> Update the comment in begin_new_exec about where SIGSEGV is forced.
>> 
>> Keep point_of_no_return from being a mystery by documenting
>> what the code is doing where it forces SIGSEGV if the
>> code is past the point of no return.
>> 
>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>
> I had to read the code around these changes a bit carefully, but yeah,
> this looks like a safe cleanup. It is a behavioral change, though (in
> that in unmasks non-SEGV fatal signals), so I do wonder if something
> somewhere might notice this, but I'd agree that it's the more robust
> behavior.

So the only behavioral change that I can see is that for non-SIGSEGV
fatal signals the signal handler for SIGSEGV will not be set to SIG_DFL
and SIGSEGV will not be removed from tasks local blocked signal set.

I think there is a good case that behavior change is a bug.

If you think that it was SIGSEGV that was being delivered and
it was masking an other existing fatal you would be incorrect.

If you look at:

fatal_signal_pending - you will see that it tests for SIGKILL on the
current's tasks queue.

complete_signal() - you will see that when a fatal (non-coredumpable)
signal is delvered it sets SIGKILL in every threads local queue.  As
well as setting SIGNAL_GROUP_EXIT

get_signal - It special cases SIGNAL_GROUP_EXIT and fast forwards
to the end.  So that a signal that has been delivered can not be
overriden by another signal.

__send_signal - It tests SIGNAL_GROUP_EXIT and if it is set
gets out early (which applies to force_sigsegv amoung others)

So unless it is de_thread or coredumping that sets the task
local SIGKILL there is no chance for a force SIGSEGV to do antyhing,
and the code has already tested for those to in de_thread and
exit_mmap before point_of_no_return is set.

So except for the SIGSEGV handler and blocked state there are no
behavior changes.


That does takes some reading through all of that code to see what is
going on, and just saying !fatal_signal_pending makes it all so much
clearer.


In the next patch when I move setting point_of_no_return earlier that
fatal_signal_pending check ensures that we don't stomp on de_thread or
coredump state with force_sigsegv(SIGSEGV).  But again that also won't
be a change in behavior, as we aren't performing the force_sigsegv test
when it could be either of those things until that patch.  So
force_sigsegv never gets a chance to stomp on those cases.

Eric
