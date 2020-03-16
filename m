Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65478C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 22:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4309E205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 22:12:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732762AbgCPWM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 18:12:57 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:37232 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732652AbgCPWM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 18:12:56 -0400
Received: from sf (tunnel547699-pt.tunnel.tserv1.lon2.ipv6.he.net [IPv6:2001:470:1f1c:3e6::2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: slyfox)
        by smtp.gentoo.org (Postfix) with ESMTPSA id 4547834F19C;
        Mon, 16 Mar 2020 22:12:54 +0000 (UTC)
Date:   Mon, 16 Mar 2020 22:12:51 +0000
From:   Sergei Trofimovich <slyfox@gentoo.org>
To:     Jakub Jelinek <jakub@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org
Subject: Re: [PATCH] x86: fix early boot crash on gcc-10
Message-ID: <20200316221251.7b4f5801@sf>
In-Reply-To: <20200316132648.GM2156@tucnak>
References: <20200314164451.346497-1-slyfox@gentoo.org>
        <20200316130414.GC12561@hirez.programming.kicks-ass.net>
        <20200316132648.GM2156@tucnak>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Mar 2020 14:26:48 +0100
Jakub Jelinek <jakub@redhat.com> wrote:

> > > +# smpboot's init_secondary initializes stack canary.
> > > +# Make sure we don't emit stack checks before it's
> > > +# initialized.
> > > +nostackp := $(call cc-option, -fno-stack-protector)
> > > +CFLAGS_smpboot.o := $(nostackp)  
> > 
> > What makes GCC10 insert this while GCC9 does not. Also, I would much  
> 
> My bet is different inlining decisions.
> If somebody hands me over the preprocessed source + gcc command line, I can
> have a look in detail (which exact change and why).

In case you are still interested in preprocessed files and results I've collected
all the bits in a single tarball:
    https://dev.gentoo.org/~slyfox/bugs/linux-gcc-10-boot-2020-03-14.tar.gz
Same available in separate files in:
    https://dev.gentoo.org/~slyfox/bugs/linux-gcc-10-boot-2020-03-14/

Specifically:
- gcc-v.gcc-{9,10}: gcc-v output of both compilers. Note --enable-default-pie --enable-default-ssp.
- config.gcc-{9,10}: note, they are not identical as Kbuild does not recognize gcc-10's
  plugin support. I don't use it though.
- boot-crash-gcc-10.jpg: picture of a full boot crash
- command.gcc-{9,10} called to generate .s files (it's almost the same when building .o files)
- arch-x86-kernel-smpboot.s-gcc-{9,10}: asm files, gennerated with 'make arch/x86/kernel/smpboot.s V=1'
- arch-x86-kernel-smpboot.c.c-gcc-{9,10}: preprocessed files, generated from command by changing -S to -E.

Another observation: kernel built by gcc-10 boots as-is in qemu without patches.
I wonder if the following boot line right before the crash has something to do wit it:
    "random: get_random_bgtes called from start_secondary+0x105/0x1a0 with crng_init=0"
I hope it's not a race of async canary initialization and canary use.
Only one CPU is booted at that time, yes?

-- 

  Sergei
