Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50CC8C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 19:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2230C206C3
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 19:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QIDHeZQ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgFKTZl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 15:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbgFKTZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 15:25:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C80C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 12:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=koVl8W/ZBRTJJgK/g8lrQxTLHfCfIJ27kfDv+tOpgVE=; b=QIDHeZQ/xKqc7U9s+vRcXVNU5a
        7fh0qcCT/L7twhTGgMVTgMbuHY0ZM66gT7q9swOjm9KEOdxozG2uKPk1tsUoIin8vU2jTIi/wBDhd
        lxmFPYE+4vCiU0Prcmjpxfu5hxHkiFItYwJBSJ2U1baBGx58os/s2qy0bCRiDiDxHb/cNUdwXIMr6
        HfESkbm3A8KrdUouXGXnhmP6aGk9bkxp5LzmcIqdnN/xhxnVZ2dz/s+hep8v0alTV/TLVDsQuJUhI
        PXgpb6Q0UHti89OD2+dnAvHYMXYm/kavAaySc4F6sZ802Akfd78qyWRoNoC3CPCpR8LAYt3DtWyEf
        t3qdaKTw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jjSpF-0003sg-FW; Thu, 11 Jun 2020 19:25:21 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 54FA89841E9; Thu, 11 Jun 2020 21:25:18 +0200 (CEST)
Date:   Thu, 11 Jun 2020 21:25:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, cj.chengjian@huawei.com,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michel Lespinasse <walken@google.com>,
        lkft-triage@lists.linaro.org,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: Perf: WARNING: arch/x86/entry/common.c:624
 idtentry_exit_cond_rcu+0x92/0xc0
Message-ID: <20200611192518.GA2483@worktop.programming.kicks-ass.net>
References: <CA+G9fYvF3cyrY+-iw_SZtpN-i2qA2BruHg4M=QYECU2-dNdsMw@mail.gmail.com>
 <CALCETrXqhwJzhsAoM72tskso5aDELgfGLnHdGYHiAFmgCPforQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrXqhwJzhsAoM72tskso5aDELgfGLnHdGYHiAFmgCPforQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 11, 2020 at 12:10:50PM -0700, Andy Lutomirski wrote:
> On Thu, Jun 11, 2020 at 11:56 AM Naresh Kamboju
> <naresh.kamboju@linaro.org> wrote:
> >
> > While running perf test and selftest x86 single_step_syscall_32 on
> > i386 kernel linux
> > next 5.7.0-next-20200610 kernel warning noticed.
> >
> > steps to reproduce:
> > --------------------------
> > perf test
> > and
> > cd /opt/kselftests/default-in-kernel/x86
> > ./single_step_syscall_32
> >
> > perf warning log:
> > ----------------------
> > [   57.260865] ------------[ cut here ]------------
> > [   57.266576] IRQs not disabled as expected
> > [   57.270583] WARNING: CPU: 1 PID: 500 at
> > /usr/src/kernel/arch/x86/entry/common.c:624
> > idtentry_exit_cond_rcu+0x92/0xc0
> > [   57.281092] Modules linked in: x86_pkg_temp_thermal fuse
> > [   57.286406] CPU: 1 PID: 500 Comm: perf Not tainted 5.7.0-next-20200610 #1
> > [   57.293190] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
> > 2.2 05/23/2018
> > [   57.300577] EIP: idtentry_exit_cond_rcu+0x92/0xc0
> > [   57.305280] Code: 8b 89 d8 05 00 00 85 c9 74 ae 80 3d b1 64 2c d4
> > 00 75 a5 68 94 2d fb d3 89 55 f8 89 45 fc c6 05 b1 64 2c d4 01 e8 8e
> > f5 2b ff <0f> 0b 58 8b 55 f8 8b 45 fc eb 83 8d 76 00 e8 5b fd ff ff c9
> > c3 89
> > [   57.324017] EAX: 0000001d EBX: 0d00022a ECX: 00000027 EDX: f5b9e14c
> > [   57.330274] ESI: f2a2ffb4 EDI: ffff0ff4 EBP: f2a2ff8c ESP: f2a2ff80
> > [   57.336531] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00010096
> > [   57.343345] CR0: 80050033 CR2: 08700a58 CR3: 14ad7000 CR4: 003406d0
> > [   57.349608] DR0: 080dfb80 DR1: 080dfc00 DR2: 08700a58 DR3: 00000000
> > [   57.355866] DR6: fffe0ff0 DR7: 0d00062a
> > [   57.359697] Call Trace:
> > [   57.362143]  exc_debug+0x84/0x1b0
> > [   57.365487]  ? exc_int3+0x1d0/0x1d0
> > [   57.368981]  handle_exception+0x145/0x145
> > [   57.372991] EIP: 0x80dfbcd
> > [   57.375694] Code: Bad RIP value.
> > [   57.378918] EAX: 00000000 EBX: 00000005 ECX: 00002400 EDX: 00000000
> > [   57.385175] ESI: 00000003 EDI: 00000004 EBP: bfd59798 ESP: bfd59770
> > [   57.391431] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000246
> > [   57.398215] irq event stamp: 1896
> 
> A regrettable property of the current entry code structure is that we
> lose any real indication of the vector.  Presumably this is #DB, hence
> exc_debug.  I don't know what perf has to do with it.
> 
> I'll bang on this after lunch if no one beats me to it.

Puzzling, CR3 seems to suggest this is !user_mode(), but either way #DB
has either idtentry_enter_user() or nmi_enter().

