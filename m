Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE179C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 12:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D4182073E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 12:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qAOOULAM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fFq432rM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733019AbgF3MJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 08:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731654AbgF3MJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 08:09:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14D0C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 05:09:03 -0700 (PDT)
Date:   Tue, 30 Jun 2020 14:09:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1593518942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7C8vxekFFai8VGaBkEmkcfmiQqHJvnUGAhrxpnQgoNg=;
        b=qAOOULAM2ZyG/eDbyaBMr9HS0/V4Xa2Lhp7C2fyiXjoAQzhW0qQ+AZ4NShrYc7lGFJcD+5
        modMY7GB0SiXpSBX6KQAYwAFkbo0zMrrIpE38IWQlmIVpvG3RCi/NXurkOP5fy+tdvsSd9
        0yN5z0bOnJAH1RRvZ2QyKkJJZWl2SO4MdcK6B0RO9OFpfvH2vfSGLAoRkhcq5jQFYQk9Xg
        uAZVPXMrGExJE5gkHWKJ6I9GmkYWrOObDbPBRJu6h3FmUxLgmNviOse6mtuyzyZ2hf+dpP
        /onNwr90DFgJ1bqc+3dBzvGmfmkYI+N6FWbFQaxi4Ti4ZhLahN9xb5vkZDscYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1593518942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7C8vxekFFai8VGaBkEmkcfmiQqHJvnUGAhrxpnQgoNg=;
        b=fFq432rMzp+GY0v4mZ4si0eGYamIVsIxDDC8Rk1gNmpB6aypBe7p9nYRG6e8rSUX831BYm
        AClDF9m5ySORVvAg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin " <hpa@zytor.com>
Subject: Re: [PATCH 2/2] x86/entry: Remove `regs' parameter from
 idtentry_exit_cond_resched()
Message-ID: <20200630120900.crhrbdqcqn7illie@linutronix.de>
References: <20200630102209.1143072-1-bigeasy@linutronix.de>
 <20200630102209.1143072-3-bigeasy@linutronix.de>
 <20200630111430.GN4800@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200630111430.GN4800@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-30 13:14:30 [+0200], Peter Zijlstra wrote:
> > -static void idtentry_exit_cond_resched(struct pt_regs *regs, bool may_sched)
> > +static void idtentry_exit_cond_resched(bool may_sched)
> 
> This is a style question; so far all idtentry_*() functions have regs
> passed. In the lockdep-vs-nmi series I introduce
> idtentry_{enter,exit}_nmi() both having an unused regs argument.
> 
> Not sure which way around I feel on this.

Do as you are pleased. I was more attached to the previous patch that to
this one :)

Sebastian
