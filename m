Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DECBC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 13:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 164AC2074F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 13:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gae2fyGY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2636309AbgDONyV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 09:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2633539AbgDONyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 09:54:11 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22785C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 06:54:11 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id m21so1517860pff.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 06:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VoVfmxYHYrGT8FRKsSsoJto7pKs3GSxuLHxpm5XKHFU=;
        b=gae2fyGYNKNIW6QFLLg6S/zYaJs+SzKeTKP5xOkozklzZ3AacLhlprRumbF3uiWLOc
         yUQkg4FmVVeVhuUbqu79kQh9OtJvjE/Fd3w+TdqFUsxnzwMRH9Exo1pCvrkgXr7XW99F
         2x9DRcTEZA2GXaKRhbId0b0tAZGBzwuWABJvDy/zpblHoAIsoLXpvOzXBGrpNE3Yqw/M
         JqkSP7+zYeHUx4Q/ujWfpbKCvtEoZsaAyeMM77SZb0mJTL6dOIwGFIWfqFz98yRL2BcF
         +N6SU7lWhfDX9Pq0/xtro15w0XIR1+no/ycot5SnPrRM0yiky3BiwJV9q3gxlgVHUwbe
         9Xyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VoVfmxYHYrGT8FRKsSsoJto7pKs3GSxuLHxpm5XKHFU=;
        b=f9iluRxh3wzTv/x29lgF1HpJLvx2SKkPrTeoYbED1b1jJPDzlIPhDlhDDSYjrxk1nx
         rzpYXYB1VJrOeANDP4hU7ebol4LNijmsfRBn/o8xZcXDvA9NNT3flfE5s1e/LKs8gumq
         O3CoE/I9WWpl4lRcv+4JbCpdOniwwZxWGRscjhCcV2tiuhDrbUyFSuNdzjR6I/fSKkLp
         N7+KrEfaYqWUUV7P+8i74a99HrPMV7k1F4w8dYtwEKoYM10oH0qMtacXM0b7gAC/R6HU
         vO6kFRMECu2y4LlL6SpM+5k+4+5YL9eoaZJQQm4J3ZZoHB7Nmg6v81u6mpt7NzpH3Wwy
         JZMg==
X-Gm-Message-State: AGi0PuaINmRj6u2vvibTA3LK4oA81xIQLe2dhRrGXmuu73iZC+ltPbfO
        N/litilY8SHg4VzUyq9dYq4=
X-Google-Smtp-Source: APiQypJJO6A+zBPcFPvcxTlmZZcVYNubuxvGmj5zln/Mu5X8Wu0ZpS04NGAtD+yWF80GmuT7E+I8dA==
X-Received: by 2002:a63:c20:: with SMTP id b32mr10710890pgl.75.1586958850568;
        Wed, 15 Apr 2020 06:54:10 -0700 (PDT)
Received: from localhost ([49.207.49.194])
        by smtp.gmail.com with ESMTPSA id u18sm14109144pfl.40.2020.04.15.06.54.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Apr 2020 06:54:09 -0700 (PDT)
Date:   Wed, 15 Apr 2020 19:24:07 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>
Cc:     Alan Kao <alankao@andestech.com>, Eric Lin <tesheng@andestech.com>,
        Gary Guo <gary@garyguo.net>, alex@ghiti.fr,
        David Abdurachmanov <david.abdurachmanov@gmail.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Price <steven.price@arm.com>, atish.patra@wdc.com,
        yash.shah@sifive.com, Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Greentime Hu <green.hu@gmail.com>, zong.li@sifive.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 0/3] Highmem support for 32-bit RISC-V
Message-ID: <20200415135407.GA6553@afzalpc>
References: <20200331093241.3728-1-tesheng@andestech.com>
 <CAK8P3a3LokurC0n9XiwtPQh9ZgQcswMKY4b+TEsQh1VgYDNeWA@mail.gmail.com>
 <20200408035118.GA1451@andestech.com>
 <CAK8P3a1JS3_2fWrhNTZx0eTWjJa-GTb4AscTPqydpSP5EB15Yw@mail.gmail.com>
 <20200414151748.GA5624@afzalpc>
 <CAK8P3a0JW9x-Wk9Ec3+zLjPHbWAvPQx8MF-xe-PnWUgEjRAuTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0JW9x-Wk9Ec3+zLjPHbWAvPQx8MF-xe-PnWUgEjRAuTg@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Apr 14, 2020 at 09:29:46PM +0200, Arnd Bergmann wrote:
> On Tue, Apr 14, 2020 at 5:17 PM afzal mohammed <afzal.mohd.ma@gmail.com> wrote:

> > + rmk

[ Forgot to provide context to Russell - this is about implementing
  VMSPLIT_4G_4G support for 32-bit ARM as a possible replacement of
  highmem ]

> > If no one have yet taken it up, i am interested in doing the work, i
> > will sponsor myself :). i will proceed at a slow pace without derailing
> > my other things normal.

> Thanks for offering to help, it's very much appreciated. Let me know how
> it goes and if you have any more detailed questions.

Okay, i will proceed initially w/ things that can be done using qemu &
available ARM boards. Right now no questions, i will probably be coming
up with questions later.

Regards
afzal

> I would recommend starting in a qemu emulated system on a PC host,
> you can just set it to emulate a Cortex-A15 or A7, and you can attach
> gdb to the qemu instance to see where it crashes (which it inevitably
> will).
> 
> You can also start by changing the functions in asm/uaccess.h to
> use the linear kernel mapping and memcpy(), like the version in
> arch/um/kernel/skas/uaccess.c does. This is slow, but will work on
> regardless of whether user space is mapped, and you can do a
> generic implementation that works on any architecture and put that
> into include/asm-generic/uaccess.h.
> 
> A second step after that could be to unmap user space when entering
> the kernel, without any change in the memory layout, this is still
> mostly hardware independent and could easily be done in qemu
> or any 32-bit ARM CPU.
> 
> Another thing to try early is to move the vmlinux virtual address
> from the linear mapping into vmalloc space. This does not require
> LPAE either, but it only works on relatively modern platforms that
> don't have conflicting fixed mappings there.
> 
> If you get that far, I'll happily buy you a Raspberry Pi 4 with 4GB
> for further experiments ;-)
> That one can run both 64-bit and 32-bit kernels (with LPAE),
> so you'd be able to test the limits and not rely on qemu to find
> all bugs such as missing TLB flushes or barriers.
