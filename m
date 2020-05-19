Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB4EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CFB7207E8
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589919308;
	bh=My6svUo2kNhHd0PeK985QXponpPvUA8f6n4aRh+On+U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ScdLp0U+ZMkG+c0RS/ysGHdnA6gC2yEDq0XjZa8Cu1SKFshwyFOhl42pLC6zCvNm1
	 p4e1RoOf2UMNt23wQJkScj1cWm/hsnQyt1JObsD1sylfxfz5A6VANmcGtKHeOmZtce
	 EfV5YTw54GgC4GTCuFmOzMZdtIvpth71VgHQg/lY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbgESUPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 16:15:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:56940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726333AbgESUPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 16:15:07 -0400
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6E1920885
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 20:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589919307;
        bh=My6svUo2kNhHd0PeK985QXponpPvUA8f6n4aRh+On+U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CrNMGi/tQoXg8/dbvKj/8/Y+l3/GOWJilF6d5vatNbme/D3NotSvdM5XHeG0iV5sg
         tv1/Ml3ZuH4rQbfPEmNYkwe7K63NQgkul+5Fo5aMZtAoWqI2lk6fyf2PMDMwjiHRNX
         rKYkO8z1BjfrWnlr/gUYDIxyCUKp+Fs5opjaO41I=
Received: by mail-wr1-f42.google.com with SMTP id e1so813715wrt.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 13:15:06 -0700 (PDT)
X-Gm-Message-State: AOAM533GfcHijptQ2JgSMKp38AJaQmg1mifa0aqsxD4l0M4au6PKMr3+
        +ig7XZk3IXP42IVyvzLnwjPjPAr4FU2WdC5/6yIfWA==
X-Google-Smtp-Source: ABdhPJxdJ3S07frZMUz3YtceATmXgjQNeRAf2fNN82ryR4V4QXF93CyCGpNS7enh/bnRrjC2cbTzkaopnfg1N126C4k=
X-Received: by 2002:adf:eccf:: with SMTP id s15mr632076wro.70.1589919305380;
 Tue, 19 May 2020 13:15:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200515234547.710474468@linutronix.de> <20200515235126.128592439@linutronix.de>
In-Reply-To: <20200515235126.128592439@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 19 May 2020 13:14:54 -0700
X-Gmail-Original-Message-ID: <CALCETrX7G2MSLgPjkvC2Ybc+UMBAb_G6T5Or0mvEetGM14xpnQ@mail.gmail.com>
Message-ID: <CALCETrX7G2MSLgPjkvC2Ybc+UMBAb_G6T5Or0mvEetGM14xpnQ@mail.gmail.com>
Subject: Re: [patch V6 17/37] x86/entry/32: Remove common_exception
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Zhao Yakui <yakui.zhao@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 5:10 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
>
> No more users.

Acked-by: Andy Lutomirski <luto@kernel.org>
