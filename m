Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C178DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 10:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DFFD20781
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 10:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wM2UU7TQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SRitxauO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbgHMKrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 06:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbgHMKrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 06:47:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED95C061757
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 03:47:11 -0700 (PDT)
Date:   Thu, 13 Aug 2020 12:47:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597315629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iPnKb6ykt3lbBozkoOhiaH4Rw5GGiygCvzNCOPY8nxs=;
        b=wM2UU7TQD0Fympa+ZvPZyVCn/sgTOZn9FXejFXSulPpwNZUDPYL4/YPXqT/3YtZtj1AO9Y
        J3nu/K69TYqMXI+dtV9Xo0/R1TPw1nZbsFWzxmSnaxQabH4rqpN9Yn/vnlHrBtFrnJaVAZ
        OmwpnYlBvPg+BWzM2xyDxEkopBqQD91cP8t7/i1+s1FP70cUROP8XZDIeR6XnqM53ey+ZK
        2YwjqU4EryLFhJSed8Hs27mLFeDdlYji6o3gUOnnEfftz1OlWr39tiW+86Ac8r5S1ESoAo
        g8c84YufnLPqLRYtHRpDEW3w6t7TVXmkvkbXXJ6Al0x7UIuod6P4tDRUI6OrBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597315629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iPnKb6ykt3lbBozkoOhiaH4Rw5GGiygCvzNCOPY8nxs=;
        b=SRitxauOk1DMbQi7+1ZivyhVFy7ufb6QFcwDkfMbS6gsrqQDB45QU28XrJrIKG2HYxB3iL
        FHG1vJJWVeBpnaAQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86/alternatives: Let __text_poke() acquire the pte lock
 with enabled interrupts
Message-ID: <20200813104707.fxydmk6ctiwjql75@linutronix.de>
References: <20200706164215.2502730-1-bigeasy@linutronix.de>
 <87eeoc53o2.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87eeoc53o2.fsf@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-12 16:39:41 [+0200], Thomas Gleixner wrote:
> Sebastian,
Hi tglx,

> Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:
> 
> > The pte lock is never acquired from an IRQ-off region so it does not
> > require the interrupts to be disabled.
> 
> I doubt that this is true. It surely is acquired within other locks
> which might be taken with spin_lock_irq(). Which is completely fine on
> RT.
> 
> But that's not the point. The point is that pte_lock() does not require
> to be taken with interrupts disabled.

The IRQ-off vs in-IRQ working was chosen poorly.

> Please be precise about these kind of things. Handwavy descriptions
> cause more problems than they solve.
> 
> > RT complains here because the spinlock_t must not be acquired with
> > disabled interrupts.
> >
> > use_temporary_mm() expects interrupts to be off because it invokes
> > switch_mm_irqs_off() and uses per-CPU (current active mm) data.
> >
> > Move local_irq_save() after the the pte lock has been acquired. Move
> > local_irq_restore() after the pte lock has been released.
> 
> While part 1 is correct, part 2 is the exact opposite of what the patch
> does.
> 
>   Move the PTE lock handling outside the interrupt disabled region.
> 
> describes precisely what this is about without any gory details which
> can be seen in the patch itself. Hmm?

Oki reworded.

> Thanks,
> 
>         tglx

Sebastian
