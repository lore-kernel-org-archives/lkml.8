Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FCFBC43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 04:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FED5206F2
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 04:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ObODFOh6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgC0Efy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 00:35:54 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:24724 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726027AbgC0Efx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 00:35:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585283752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8KShwIj7VxFkZqXsnC3iGTxrLingzKsRq2JUiDdy+tk=;
        b=ObODFOh6MHJbp+E00VcqXSaXEJMS/NF3zxxoBA5+0x4Ff9eBd976O61DPgz1uZT2ktCtdg
        x/FHwZvscY42OP23L1nxB4wA4UXhVGVe0Kq1JXksbT0YOKb6WvxRp6Pr78rPsimKe7vGMS
        CiPoAvkCbgz3gf7wxtK3YDqnfGoztsU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-2HQH6e4KMua9AnrPPzNI-Q-1; Fri, 27 Mar 2020 00:35:46 -0400
X-MC-Unique: 2HQH6e4KMua9AnrPPzNI-Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 872B318A6EC0;
        Fri, 27 Mar 2020 04:35:45 +0000 (UTC)
Received: from treble (unknown [10.10.110.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 945BECDBC9;
        Fri, 27 Mar 2020 04:35:44 +0000 (UTC)
Date:   Thu, 26 Mar 2020 23:35:42 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH 5/7] x86: convert arch_futex_atomic_op_inuser() to
 user_access_begin/user_access_end()
Message-ID: <20200327043542.nuvxllamanwigtzo@treble>
References: <20200323185127.252501-5-viro@ZenIV.linux.org.uk>
 <CAHk-=wgMmmnQTFT7U9+q2BsyV6Ge+LAnnhPmv0SUtFBV1D4tVw@mail.gmail.com>
 <20200324020846.GG23230@ZenIV.linux.org.uk>
 <CAHk-=whTwaUZZ5Aj_Viapf2tdvcd65WdM4jjXJ3tdOTDmgkW0g@mail.gmail.com>
 <20200324204246.GH23230@ZenIV.linux.org.uk>
 <CAHk-=whnTRF5yA2MrPGcmMm=hXaGHfC2HEDtNzA=_1=szhJ4-w@mail.gmail.com>
 <20200327024227.GT23230@ZenIV.linux.org.uk>
 <CAHk-=wjn9Ohb7TW3OxaS0MTURi=boXzk=0Lo0WT-pN2CPE9PzA@mail.gmail.com>
 <CAHk-=wjk+GjHu-P_KNW3zw2uDsz6yz=U2CUT2hT4jKgyxLEfPQ@mail.gmail.com>
 <CAHk-=wix8-FHSpR2gebAxubQnzpgH3_HSOahh=o9TbgrPO6u0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wix8-FHSpR2gebAxubQnzpgH3_HSOahh=o9TbgrPO6u0w@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 09:03:41PM -0700, Linus Torvalds wrote:
> On Thu, Mar 26, 2020 at 8:49 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Seems to work for me.
> >
> > That's with the futex bug fixed. Not that it looks like it would have
> > mattered except for the (unlikely) exception case, so my testing is
> > meaningless.
> 
> Hmm. Doing a "perf" run, I only noticed after-the-fact that I got this:
> 
>   WARNING: stack recursion on stack type 4
>   WARNING: can't dereference registers at 0000000079a3d9c5 for ip
> swapgs_restore_regs_and_return_to_usermode+0x25/0x80
> 
> that may not be due to any of the uaccess or futex changes, though, it
> smells like just bad luck.
> 
> Josh?
> 
> This may also be related to the fact that I've been building my
> test-boot kernels with clang for the last couple of months,
> 
> That "swapgs_restore_regs_and_return_to_usermode+0x25" location is the
> 
>         pushq  0x28(%rdi)
> 
> instruction. That's this:
> 
>         movq    %rsp, %rdi
>         movq    PER_CPU_VAR(cpu_tss_rw + TSS_sp0), %rsp
> 
>         /* Copy the IRET frame to the trampoline stack. */
>         pushq   6*8(%rdi)       /* SS */
> --->    pushq   5*8(%rdi)       /* RSP */
>         pushq   4*8(%rdi)       /* EFLAGS */
>         pushq   3*8(%rdi)       /* CS */
>         pushq   2*8(%rdi)       /* RIP */
> 
> and yeah, at this point the stack is obviously a mess, so I'm not
> surprised that it might cause confusion for unwinding..

You did indeed get unlucky, and that's the correct diagnosis.  It's
pretty harmless.

  https://lkml.kernel.org/r/58c05bf0a9f06ac7f2ed6df5e369d3276ccec33c.1584033751.git.jpoimboe@redhat.com

Working on a v2, I'll add you to the already excessive Reported-by list
:-)

-- 
Josh

