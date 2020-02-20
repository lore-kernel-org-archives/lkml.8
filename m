Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5282EC11D20
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 21:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 240EB208CD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 21:30:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RTq29u2k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbgBTVap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 16:30:45 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46837 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729090AbgBTVao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 16:30:44 -0500
Received: by mail-oi1-f193.google.com with SMTP id a22so29065895oid.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 13:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oVh5juQDAX3nFGzy3Em/g1lgubn+lOWmnU3guSEX++0=;
        b=RTq29u2kxUZ7TuTu6/Ym0lqftSpWXlPAcHM21XJLsjrek3IdKOMW1tUscmr9452uqf
         cGtzhOfod2s8BNgdoNUHNqlTmpj2oxBLo1LdTfYsHIWkeseMR0rChQMxttyc7fdm6cXC
         pO9BmV28ZaJ89N5Fq1Eubp7A4zTMZrB75cXtgJAQVcueryBUov+4bRLQlb34GG/IdwFc
         YfQf9+JtF3CVJZqfmHUy67G/rbSicvG9o/gBDbefYCzOakJTk9VZxO1dv+LkkO+cV9HO
         m1vGuFvnqWEo2KQxB/GYkTR88H5P63KWA3QnXYcOiOvvlC7nB743GVb5/Z84CSrsYJ6q
         fIWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=oVh5juQDAX3nFGzy3Em/g1lgubn+lOWmnU3guSEX++0=;
        b=FimVTSewRX1rPs7rIMFha3aF50fbBL5rBMC6fEM5vQYzXv2cyhQF8XKBF+m79cjFyX
         UeZ5zDYbHBjtg+mO7b2BTo5xU50gW1AO2rOLFboigi5jyvm9CZP1sg64iGkivX/xveVB
         3oVpFwPHfSeio1k71Cam0DVXSqe4gStRnNrPLzWev6iBzHbbWsbu8OzhxIcJF+VkQ3fI
         QgUPkbb3oro8rxG6N03Hw5ZKSM/VwZXYjcT03nMqFwFWLxbbRCjJrYWXj4J6cvoRD612
         hBUvrAvIsOglamSYD9mkx6eB7lEeKmeBZiJtrs0P5YUCIbvPMnf8n72RYSI7koVRsYoT
         VTcw==
X-Gm-Message-State: APjAAAWc1Mj8UWAcJ5PD1p+NOPYn4gRYZed7Y/1NyG14vZqQTIqChwaM
        QKXaInegF0y6F7L/Q82q+g==
X-Google-Smtp-Source: APXvYqwTz7qzppb6KsFhdjw6YO9WvuQdahmdP5SBO9OchLZxzJJasv8cqW4Kx5WO93GyGuS3sgeZEw==
X-Received: by 2002:a05:6808:b1c:: with SMTP id s28mr3654588oij.2.1582234243664;
        Thu, 20 Feb 2020 13:30:43 -0800 (PST)
Received: from serve.minyard.net ([47.184.136.59])
        by smtp.gmail.com with ESMTPSA id 60sm252865otu.45.2020.02.20.13.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 13:30:43 -0800 (PST)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:cce4:a148:5f1:8fb6])
        by serve.minyard.net (Postfix) with ESMTPSA id 4C00718004F;
        Thu, 20 Feb 2020 21:30:42 +0000 (UTC)
Date:   Thu, 20 Feb 2020 15:30:40 -0600
From:   Corey Minyard <minyard@acm.org>
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Corey Minyard <cminyard@mvista.com>
Subject: Re: [PATCH v2] arm64:kgdb: Fix kernel single-stepping
Message-ID: <20200220213040.GA2919@minyard.net>
Reply-To: minyard@acm.org
References: <20200219152403.3495-1-minyard@acm.org>
 <20200220142214.GC14459@willie-the-truck>
 <20200220163038.GJ3704@minyard.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220163038.GJ3704@minyard.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 10:30:38AM -0600, Corey Minyard wrote:
> On Thu, Feb 20, 2020 at 02:22:14PM +0000, Will Deacon wrote:
> > On Wed, Feb 19, 2020 at 09:24:03AM -0600, minyard@acm.org wrote:

snip...

> > > After fixing this and doing some more testing, I ran into another issue:
> > > 
> > > * Kernel enables the pt_regs single step
> > > * Kernel returns from the exception with ERET.
> > > * An interrupt or page fault happens on the instruction, causing the
> > >   instruction to not be run, but the exception handler runs.
> > 
> > This sounds like you've broken debug; we should take the step exception
> > in the exception handler. That's the way this is supposed to work.
> 
> Ok, here is the disconnect, I think.  If that is the case, then what I'm
> seeing is working like it should.  That doesn't work with gdb, though,
> gdb expects to be able to single-step and get to the next instruction.
> The scenario I mentioned at the top of this email.
> 
> Let me look at this a bit more.  I'll look at this on qemu and maybe a
> pi.
> 

Ok, this is the disconnect.  I was assuming that single step would stop
at the next instruction after returning from an exception.  qemu works
the same way the hardware I have does.  So I'm assuming arm64 doesn't
clear PTRACE.SS on an exception, even though that seems to be what the
manual says.

You can reproduce this by setting up kgdb on the kernel and hooking up
gdb, setting a breakpoint somewhere that has interrupts enabled, then
doing a "continue".  It will hit the same breakpoint again and again
because the PC doesn't get advanced by the single step and the timer
interrupt is always going to be pending.  I can do a more detailed set
of instructions with qemu, if you like.

I looked at kprobes a bit.  I don't think kprobes will have a problem
with this particular issue, it disables interrupts while single
stepping and doesn't allow a probe on any instruction that would modify
the interrupt settings.  I didn't look at page faults, but I assume that
it also won't allow a probe where there can be a page fault.

If a single-step is enabled and an exception occurs before the
instruction is executed, the single step is happening in the exception
handler when debug is re-enabled.  This what you are saying is how it is
supposed to work.

That's not what gdb is expecting, and that's not how x86 works, at
least.  I looked at ARM and MIPS and they don't even do single steps in
the kernel debugger.  PPC seems to work like x86 from code examination
and since our testers haven't reported this bug on that architecture.

I can do a patch that works sort of like kprobes, disabling interrupts
and simulating a single-step if the instruction modifies the daif bits.
Then you couldn't single step across an instruction that did a page
fault, but that's probably not a huge restriction.

I could modify the patch I have now to ifdef it out unless kgdb is
enabled.

I can do a patch that just pulls single step support out of the kgdb
interface for ARM64, since it doesn't work as gdb expects, anyway.  And
that's what ARM does.

It doesn't really matter to me.  I'm just trying to fix a bug that was
reported to me, and trying to get it upstream as a good citizen.  I don't
use kgdb.

-corey
