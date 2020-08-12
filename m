Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F311DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 09:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D91232076B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 09:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgHLJaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 05:30:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:33812 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726595AbgHLJaz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 05:30:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 99660AEAC;
        Wed, 12 Aug 2020 09:31:15 +0000 (UTC)
Date:   Wed, 12 Aug 2020 11:31:14 +0200
From:   Cyril Hrubis <chrubis@suse.cz>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        kernel test robot <rong.a.chen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Thomas Gleixner <tglx@linutronix.de>, ltp@lists.linux.it
Subject: Re: [LTP] [x86/entry] 2bbc68f837: ltp.ptrace08.fail
Message-ID: <20200812093114.GA13676@yuki.lan>
References: <87y2onbdtb.fsf@nanos.tec.linutronix.de>
 <8E41B15F-D567-4C52-94E9-367015480345@amacapital.net>
 <20200616132705.GW2531@hirez.programming.kicks-ass.net>
 <20200617131742.GD8389@yuki.lan>
 <CALCETrVX=wxRrv0qw-Enbyg5CEQsy5TigbNt7sSs=MDO6uAnMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrVX=wxRrv0qw-Enbyg5CEQsy5TigbNt7sSs=MDO6uAnMw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
> do_debug is a bit of a red herring here.  ptrace should not be able to
> put a breakpoint on a kernel address, period.  I would just pick a
> fixed address that's in the kernel text range or even just in the
> pre-KASLR text range and make sure it gets rejected.  Maybe try a few
> different addresses for good measure.

I've looked at the code and it seems like this would be a bit more
complicated since the breakpoint is set by an accident in a race and the
call still fails. Which is why the test triggers the breakpoint and
causes infinite loop in the kernel...

I guess that we could instead read back the address with
PTRACE_PEEKUSER, so something as:


break_addr = ptrace(PTRACE_PEEKUSER, child_pid,
                    (void *)offsetof(struct user, u_debugreg[0]),
                    NULL);

if (break_addr == kernel_addr)
	tst_res(TFAIL, "ptrace() set break on a kernel address");

-- 
Cyril Hrubis
chrubis@suse.cz
