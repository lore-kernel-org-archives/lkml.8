Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A30C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 04:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7192B20714
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 04:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585281843;
	bh=4QOps3qW34M1PbsdVZN7fn1JR2uHIhbSTq8mCsghhGo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Vj/jX4/fCrXskq3FHXHFUqR7i9S2cK5OgF2lAlxjCbTJaifMXHFHRHzwB/pjBuC9d
	 rXZdXOpY5Gt7ME3pKhydFoEexaxsDzz4AXNkTP5unDomJl4itd/mwx7i/YtXEdoJjc
	 wMVFJeP0YeKpBuedhzXzWIIJfIHIk08CeA67xL+8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbgC0EEC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 00:04:02 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46543 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbgC0EEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 00:04:01 -0400
Received: by mail-lj1-f196.google.com with SMTP id r7so1157595ljg.13
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 21:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3BXn62xXJw/t/Bz7IJQThBrlQvnVRvxsEConyEt9HUQ=;
        b=TVm7MxmWAJQW6pRgk/zjVz+9EODkYQXe5bckeBAvdtsCOqa6g1gD9samFpXH5VAgUz
         pSuEjGaewh7dprbK4GPc2JC5Amek2NNoi+jkgWh6w7byJZoQt86YgiMXpJ2qI2qYxdCq
         UlM4v5SPMl/bF0lnwk+K0U0H1iXhvLJolT2k4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3BXn62xXJw/t/Bz7IJQThBrlQvnVRvxsEConyEt9HUQ=;
        b=XGzGXFURQDtFOU37oMUbyEnz0NYan6+DFtBC8/A0n0QQsFnQye//86njNohC/dlDFI
         95VjxFY5nifWy77almfx1j808rAq5JVI6THaNRBI5P8b6tfxNS0hP3MxcEVnUaY+d3It
         Z62c/f48bYHF4rTjHRs7qwdCnliEsP9H3ACznN/UyQDqsb9mD185lFYdyS9oR7QT9B12
         qwFO+0tkli6UnrIzmeWT4vc0Uc84vScWrKTRD0Ux9xdheEeKSEuR4sdyB9x+H4X0/j7t
         cf8rJiWQ8uN7xVlg+HylI4uICnwx3AmdMYU9xSC9Vk/zGFfJQo7VvOHBg8cEm/z3kRNX
         IpKA==
X-Gm-Message-State: AGi0PuaAvKXtJmHfVTWqhX66wfPNcDm+g2M+dfpxVERVpCXkCzGEdCud
        mpqXFVTeoG4U/mxAEEGwAutB9lODTko=
X-Google-Smtp-Source: APiQypI/mltyZlYexYvGOEfTqjINye7VkCpqbNcKcU5jGru/xJ7boaUMjBbPuK1c/LHMTEch1rgeqA==
X-Received: by 2002:a2e:b0ee:: with SMTP id h14mr5875168ljl.35.1585281838939;
        Thu, 26 Mar 2020 21:03:58 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id b21sm2487390ljo.54.2020.03.26.21.03.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2020 21:03:57 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id h6so971586lfp.6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 21:03:57 -0700 (PDT)
X-Received: by 2002:ac2:4a72:: with SMTP id q18mr3611230lfp.10.1585281837374;
 Thu, 26 Mar 2020 21:03:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200323185057.GE23230@ZenIV.linux.org.uk> <20200323185127.252501-1-viro@ZenIV.linux.org.uk>
 <20200323185127.252501-5-viro@ZenIV.linux.org.uk> <CAHk-=wgMmmnQTFT7U9+q2BsyV6Ge+LAnnhPmv0SUtFBV1D4tVw@mail.gmail.com>
 <20200324020846.GG23230@ZenIV.linux.org.uk> <CAHk-=whTwaUZZ5Aj_Viapf2tdvcd65WdM4jjXJ3tdOTDmgkW0g@mail.gmail.com>
 <20200324204246.GH23230@ZenIV.linux.org.uk> <CAHk-=whnTRF5yA2MrPGcmMm=hXaGHfC2HEDtNzA=_1=szhJ4-w@mail.gmail.com>
 <20200327024227.GT23230@ZenIV.linux.org.uk> <CAHk-=wjn9Ohb7TW3OxaS0MTURi=boXzk=0Lo0WT-pN2CPE9PzA@mail.gmail.com>
 <CAHk-=wjk+GjHu-P_KNW3zw2uDsz6yz=U2CUT2hT4jKgyxLEfPQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjk+GjHu-P_KNW3zw2uDsz6yz=U2CUT2hT4jKgyxLEfPQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 26 Mar 2020 21:03:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wix8-FHSpR2gebAxubQnzpgH3_HSOahh=o9TbgrPO6u0w@mail.gmail.com>
Message-ID: <CAHk-=wix8-FHSpR2gebAxubQnzpgH3_HSOahh=o9TbgrPO6u0w@mail.gmail.com>
Subject: Re: [RFC][PATCH 5/7] x86: convert arch_futex_atomic_op_inuser() to user_access_begin/user_access_end()
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 8:49 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Seems to work for me.
>
> That's with the futex bug fixed. Not that it looks like it would have
> mattered except for the (unlikely) exception case, so my testing is
> meaningless.

Hmm. Doing a "perf" run, I only noticed after-the-fact that I got this:

  WARNING: stack recursion on stack type 4
  WARNING: can't dereference registers at 0000000079a3d9c5 for ip
swapgs_restore_regs_and_return_to_usermode+0x25/0x80

that may not be due to any of the uaccess or futex changes, though, it
smells like just bad luck.

Josh?

This may also be related to the fact that I've been building my
test-boot kernels with clang for the last couple of months,

That "swapgs_restore_regs_and_return_to_usermode+0x25" location is the

        pushq  0x28(%rdi)

instruction. That's this:

        movq    %rsp, %rdi
        movq    PER_CPU_VAR(cpu_tss_rw + TSS_sp0), %rsp

        /* Copy the IRET frame to the trampoline stack. */
        pushq   6*8(%rdi)       /* SS */
--->    pushq   5*8(%rdi)       /* RSP */
        pushq   4*8(%rdi)       /* EFLAGS */
        pushq   3*8(%rdi)       /* CS */
        pushq   2*8(%rdi)       /* RIP */

and yeah, at this point the stack is obviously a mess, so I'm not
surprised that it might cause confusion for unwinding..

              Linus
