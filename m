Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AACAC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 12:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F28EE20772
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 12:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uFjYLcy3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J83+q3jn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbgGBMzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 08:55:00 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49426 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728917AbgGBMzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 08:55:00 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1593694497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hNvxqRrDBbz/jOt3So+sU7T7gZSGCFNrBBBNp3CZ8ak=;
        b=uFjYLcy3ORbpRJ1mNlx3oLoa/xhPpbmog/Rzoeck+yzRlpR+1qwqbSbNRNkICxTp+NeiZ4
        1/5ZodefKs3pCG7Dr1zT1PtRHOmyPIarZKu5JrBCFec29TFCTKV4lBvvX1zyGqDxQVdNtl
        7wZqz88O8OsL8c2ovz5KpEjSb9EmltKRcWqqYLCOA8Jx3IFGtHz5Xm9YkjG4K/yAPIpbFL
        nOuvXvfvXPZc2nVgqCg03DT4kNoEgAUypGBlx0yupqVkaseT4QedEj3mFGCU+u6uFTNjwQ
        QVhMC61GkmeCe60cHGtCwBAgYeCWmooqDxCAB9PFpGNbfZm6wHtyKqtva+msPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1593694497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hNvxqRrDBbz/jOt3So+sU7T7gZSGCFNrBBBNp3CZ8ak=;
        b=J83+q3jnPFCHhvohg6pU47S27J9wegJwqnwUYOrKe1OOWO7wE7bVIoC8hRvQ+vI0ktFeHt
        GchKFMnOfP9AxrCw==
To:     Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH 3/6] x86/entry/64/compat: Fix Xen PV SYSENTER frame setup
In-Reply-To: <CALCETrVy-Q4K04wmEPe5VeU=at2BL4b-bSFkoSU-BPbTaTB2Yg@mail.gmail.com>
References: <cover.1593191971.git.luto@kernel.org> <947880c41ade688ff4836f665d0c9fcaa9bd1201.1593191971.git.luto@kernel.org> <CAMzpN2iW4XD1Gsgq0ZeeH2eewLO+9Mk6eyk0LnbF-kP3v=smLg@mail.gmail.com> <CALCETrVy-Q4K04wmEPe5VeU=at2BL4b-bSFkoSU-BPbTaTB2Yg@mail.gmail.com>
Date:   Thu, 02 Jul 2020 14:54:57 +0200
Message-ID: <87k0zm9ivy.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Lutomirski <luto@kernel.org> writes:
> On Wed, Jul 1, 2020 at 8:42 AM Brian Gerst <brgerst@gmail.com> wrote:
> > On Fri, Jun 26, 2020 at 1:30 PM Andy Lutomirski <luto@kernel.org> wrote:
>> >
>> > The SYSENTER frame setup was nonsense.  It worked by accident
>> > because the normal code into which the Xen asm jumped
>> > (entry_SYSENTER_32/compat) threw away SP without touching the stack.
>> > entry_SYSENTER_compat was recently modified such that it relied on
>> > having a valid stack pointer, so now the Xen asm needs to invoke it
>> > with a valid stack.
>> >
>> > Fix it up like SYSCALL: use the Xen-provided frame and skip the bare
>> > metal prologue.
>> >
>> > Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
>> > Cc: Juergen Gross <jgross@suse.com>
>> > Cc: Stefano Stabellini <sstabellini@kernel.org>
>> > Cc: xen-devel@lists.xenproject.org
>> > Fixes: 1c3e5d3f60e2 ("x86/entry: Make entry_64_compat.S objtool clean")
>> > Signed-off-by: Andy Lutomirski <luto@kernel.org>
>> > ---
>> >  arch/x86/entry/entry_64_compat.S |  1 +
>> >  arch/x86/xen/xen-asm_64.S        | 20 ++++++++++++++++----
>> >  2 files changed, 17 insertions(+), 4 deletions(-)
>> >
>> > diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
>> > index 7b9d8150f652..381a6de7de9c 100644
>> > --- a/arch/x86/entry/entry_64_compat.S
>> > +++ b/arch/x86/entry/entry_64_compat.S
>> > @@ -79,6 +79,7 @@ SYM_CODE_START(entry_SYSENTER_compat)
>> >         pushfq                          /* pt_regs->flags (except IF = 0) */
>> >         pushq   $__USER32_CS            /* pt_regs->cs */
>> >         pushq   $0                      /* pt_regs->ip = 0 (placeholder) */
>> > +SYM_INNER_LABEL(entry_SYSENTER_compat_after_hwframe, SYM_L_GLOBAL)
>>
>> This skips over the section that truncates the syscall number to
>> 32-bits.  The comments present some doubt that it is actually
>> necessary, but the Xen path shouldn't differ from native.  That code
>> should be moved after this new label.
>
> Whoops.  I thought I caught that myself, but apparently not.  I'll fix it.

Darn. I already applied that lot. Can you please send a delta fix?

Thanks,

        tglx
