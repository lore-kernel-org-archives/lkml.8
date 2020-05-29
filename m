Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B36C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 16:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8405E207F9
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 16:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0Potvx4h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbgE2QJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 12:09:34 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58140 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbgE2QJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 12:09:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=brDBe8zkbDnfUIboOBhhAsaCy9eR3qJV3apR8YziRMA=; b=0Potvx4hwZE8LtSKCfp3SU+iB1
        jSfJMba8qYbLrwdCSCtT/hshW7/pF16GR9UnuqjQQWo6SxTW6nwKEDOWOEWb7/jd2+XbJ0gHDNuRC
        9cdX1Q+aBxFV74T8NpdVYzuxjpRG604D0AeS0a0rLO46cCTMkKfp0t7xmzX/+wqrm2gUiVQ/F2UrW
        qq3S7LEjxrKFMjdiHTf+/RyK8MiIrWxMqPXHVnnx/dtft2ao65MFvU6arF8pPn4WHNURePKNvzgAA
        5V4qG6wk+PW7hzJmeZfrpkHiD6VMfwZo6mU1Uk5G5eyW33trrz5GjZ8GBIHLj2Vqop9v1CLdMkK7J
        WV4kwzmA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jehXN-0000nz-PB; Fri, 29 May 2020 16:07:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 52A9230280F;
        Fri, 29 May 2020 18:07:11 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3F823286F9818; Fri, 29 May 2020 18:07:11 +0200 (CEST)
Date:   Fri, 29 May 2020 18:07:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+dc1fa714cb070b184db5@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: PANIC: double fault in fixup_bad_iret
Message-ID: <20200529160711.GC706460@hirez.programming.kicks-ass.net>
References: <000000000000d2474c05a6c938fe@google.com>
 <CACT4Y+ajjB8RmG3_H_9r-kaRAZ05ejW02-Py47o7wkkBjwup3Q@mail.gmail.com>
 <87o8q6n38p.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o8q6n38p.fsf@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 05:57:10PM +0200, Thomas Gleixner wrote:
> Dmitry,
> 
> Dmitry Vyukov <dvyukov@google.com> writes:
> > On Fri, May 29, 2020 at 3:14 PM syzbot
> > <syzbot+dc1fa714cb070b184db5@syzkaller.appspotmail.com> wrote:
> >>
> >> Hello,
> >>
> >> syzbot found the following crash on:
> >>
> >> HEAD commit:    7b4cb0a4 Add linux-next specific files for 20200525
> >> git tree:       linux-next
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=15dc34ba100000
> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=47b0740d89299c10
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=dc1fa714cb070b184db5
> >> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> >> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14678626100000
> >> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1017ef06100000
> >>
> >> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> >> Reported-by: syzbot+dc1fa714cb070b184db5@syzkaller.appspotmail.com
> >
> > From the reproducer it seems to be either x86 related or ptrace
> > related.
> >
> >> RIP: 0010:fixup_bad_iret+0x24/0x170 arch/x86/kernel/traps.c:665
> 
> as a quick assumption that's related to KASAN in fixup_bad_iret() which
> is a frightenly bad idea. I'm about to verify.

Like with KCSAN, we should blanket kill KASAN/UBSAN and friends (at the
very least in arch/x86/) until they get that function attribute stuff
sorted.
