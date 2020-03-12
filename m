Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25146C1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 20:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1654205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 20:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Pshp6KqL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbgCLUIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 16:08:01 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54858 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727161AbgCLUH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 16:07:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=2PpORpJTPrNcGriWZwtPff3V9dem0kgKDLcFiL16NcQ=; b=Pshp6KqLv/j9DBZvV6G2uN3dq+
        S5NflfEkjwmGOSuodljk/490Yns3N1V9aUc1hO+fPyRPBmHZLmFq7iqID15Zw25Q05hiuhHd4Gzmy
        u+T5ECoQ3zvS7Hy/ek3uXsOpNv11ZYqvkRYmrAj1rd6v+6RQ/sfrtfQ34cs2V8bQLvBIhtU08uZ/J
        6hSsbgKCqthU1l99/QW7lnY6YW+28lYe495cUf6WyJkqpMgV7DpvKs1nfZ85Ho4I07Fe5+oTsoLDp
        kO8F0UFDiYZL3hkGeSAC0WH7bINyPSCZ5qci9BTG3iQ8lsGp6VQMutFY1XnOYBOFpgGpBcLulKRbH
        8VRL6c2A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCU7J-0002Ww-P5; Thu, 12 Mar 2020 20:07:42 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id CDA4998114E; Thu, 12 Mar 2020 21:07:38 +0100 (CET)
Date:   Thu, 12 Mar 2020 21:07:38 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Andy Lutomirski <luto@amacapital.net>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Vince Weaver <vincent.weaver@maine.edu>,
        Dave Jones <dsj@fb.com>, Jann Horn <jannh@google.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 03/14] x86/entry/64: Fix unwind hints in register
 clearing code
Message-ID: <20200312200738.GB5086@worktop.programming.kicks-ass.net>
References: <cb9b03b2a391b064573c152696d99017f76e8603.1584033751.git.jpoimboe@redhat.com>
 <DECA668C-B7EA-4663-8ABB-5B9E0495F498@amacapital.net>
 <20200312195714.gc5jalix2dp57dyb@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200312195714.gc5jalix2dp57dyb@treble>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 02:57:14PM -0500, Josh Poimboeuf wrote:
> On Thu, Mar 12, 2020 at 12:29:29PM -0700, Andy Lutomirski wrote:
> > > On Mar 12, 2020, at 10:31 AM, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > > 
> > > ﻿The PUSH_AND_CLEAR_REGS macro zeroes each register immediately after
> > > pushing it.  If an NMI or exception hits after a register is cleared,
> > > but before the UNWIND_HINT_REGS annotation, the ORC unwinder will
> > > wrongly think the previous value of the register was zero.  This can
> > > confuse the unwinding process and cause it to exit early.
> > > 
> > > Because ORC is simpler than DWARF, there are a limited number of unwind
> > > annotation states, so it's not possible to add an individual unwind hint
> > > after each push/clear combination.  Instead, the register clearing
> > > instructions need to be consolidated and moved to after the
> > > UNWIND_HINT_REGS annotation.
> > 
> > I don’t suppose you know how bad t he performance hit is on a non-PTI machine?
> 
> Hm, what does it have to do with PTI?  Should I run a syscall
> microbenchmark?

Mostly that performance with PTI on is abysmal so we don't care about a
few cycles.
