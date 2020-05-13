Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B5DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 22:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B60ED2065C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 22:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="FrSzFsyX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731621AbgEMWsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 18:48:08 -0400
Received: from mail.efficios.com ([167.114.26.124]:45934 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbgEMWsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 18:48:08 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 4A48B2BF0F4;
        Wed, 13 May 2020 18:48:07 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 5m3aCmDaghkm; Wed, 13 May 2020 18:48:07 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id D88FD2BF50F;
        Wed, 13 May 2020 18:48:06 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com D88FD2BF50F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1589410086;
        bh=0j9hcwAiMKcXFOCzdbopvIrpb21QeIwUcZoNF4AAP3E=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=FrSzFsyXioF/oDqePxJ3WptEMVlP+diLIlpVw2QIm2xCttCTKAeFDRWQ+Y8LA9grA
         K8ANzDmV3kByWsChvrO2VyLrKPK8bGZQYNOXRmKCpWOe7ALnVw4KPx9A2bELphiE9y
         N/8+eS6baXlNwUrVRiuwe0TYsl1l9ZNCn8+0dn7CRniVlI8WEFAGlLV02v6CopFiQr
         WW0pvmK3kvErQdkX4RX7CBIpgppvtXD9aFOoUTXdDzwUJgEgvYIMBK0C2MS2dU1bWp
         Qlc6C6rbkBYdTLy/AcNjU5xiZARWD5W4janh26nOYA5gViCXVDzzoEq09r2zPRppDo
         Ld3DoL9pf4tDA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id L23gvuzIwzgh; Wed, 13 May 2020 18:48:06 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id C678B2BF493;
        Wed, 13 May 2020 18:48:06 -0400 (EDT)
Date:   Wed, 13 May 2020 18:48:06 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     rostedt <rostedt@goodmis.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, paulmck <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Message-ID: <1473818156.20126.1589410086731.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200513171047.04c2c10e@gandalf.local.home>
References: <20200505131602.633487962@linutronix.de> <20200505134058.560059744@linutronix.de> <1970736614.19996.1589403401588.JavaMail.zimbra@efficios.com> <20200513171047.04c2c10e@gandalf.local.home>
Subject: Re: [patch V4 part 1 05/36] x86/entry: Flip _TIF_SIGPENDING and
 _TIF_NOTIFY_RESUME handling
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3928 (ZimbraWebClient - FF76 (Linux)/8.8.15_GA_3928)
Thread-Topic: x86/entry: Flip _TIF_SIGPENDING and _TIF_NOTIFY_RESUME handling
Thread-Index: +oxW4+ld0+7v3FOGlyEwJV7EJeY6WQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On May 13, 2020, at 5:10 PM, rostedt rostedt@goodmis.org wrote:

> On Wed, 13 May 2020 16:56:41 -0400 (EDT)
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> ----- On May 5, 2020, at 9:16 AM, Thomas Gleixner tglx@linutronix.de wrote:
>> 
>> > Make sure task_work runs before any kind of userspace -- very much
>> > including signals -- is invoked.
>> 
>> What is missing from this patch description is: _why_ is this deemed
>> useful ?
>> 
>> Also, color me confused: is "do_signal()" actually running any user-space,
>> or just setting up the user-space stack for eventual return to signal handler ?
>> 
>> Also, it might be OK, but we're changing the order of two things which
>> have effects on each other: restartable sequences abort fixup for preemption
>> and do_signal(), which also have effects on rseq abort.
>> 
>> Because those two will cause the abort to trigger, I suspect changing
>> the order might be OK, but we really need to think this through.
>> 
>> Thanks,
>> 
>> Mathieu
>> 
>> > 
>> > Suggested-by: Andy Lutomirski <luto@kernel.org>
>> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>> > ---
>> > arch/x86/entry/common.c |    8 ++++----
>> > 1 file changed, 4 insertions(+), 4 deletions(-)
>> > 
>> > --- a/arch/x86/entry/common.c
>> > +++ b/arch/x86/entry/common.c
>> > @@ -156,16 +156,16 @@ static void exit_to_usermode_loop(struct
>> > 		if (cached_flags & _TIF_PATCH_PENDING)
>> > 			klp_update_patch_state(current);
>> > 
>> > -		/* deal with pending signal delivery */
>> > -		if (cached_flags & _TIF_SIGPENDING)
>> > -			do_signal(regs);
>> > -
>> > 		if (cached_flags & _TIF_NOTIFY_RESUME) {
>> > 			clear_thread_flag(TIF_NOTIFY_RESUME);
>> > 			tracehook_notify_resume(regs);
>> > 			rseq_handle_notify_resume(NULL, regs);
>> > 		}
>> > 
>> > +		/* deal with pending signal delivery */
>> > +		if (cached_flags & _TIF_SIGPENDING)
>> > +			do_signal(regs);
> 
> Looking deeper into this, it appears that do_signal() can freeze or kill the
> task.
> 
> That is, it wont go back to user space here, but simply schedule out (being
> traced) or even exit (killed).
> 
> Before the resume hooks would never be called in such cases, and now they
> are.

Regarding swapping order of tracehook vs do_signal: Is the task really resumed
if it gets frozen or killed ? What is this change trying to accomplish, why
is it needed in the first place ?

Regarding swapping order of rseq wrt do_signal: why is it needed, why, and has
this been tested ?

Thanks,

Mathieu

> 
> -- Steve
> 
> 
>> > +
>> > 		if (cached_flags & _TIF_USER_RETURN_NOTIFY)
>> >  			fire_user_return_notifiers();

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
