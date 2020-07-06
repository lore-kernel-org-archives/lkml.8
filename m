Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28EDCC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 08:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 015CF206E9
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 08:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NAUrJJLo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbgGFIjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 04:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728188AbgGFIjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 04:39:09 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103C0C061794
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 01:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hQtxiKLfzE/x9Sg6QTa2n1RkY6u3HrYEtMHaJwO31ZI=; b=NAUrJJLoSJovF0sBrKzhye0fWI
        U2oiLykG4uyH6CzOQgoKWxa4xeHWzaul6dG2cRVdbxpePsvAAGZhl7GI7ZHt9VEY1rVZ7Q4Spki88
        8SUYFU+545f0WZEllcMNKoDPDuEj+aQryGRhrN5SKIJqPk99T7h8JKCE85qDIXNztsPFo52oZ/EAV
        kMm1Ctc23i4nAyq11HV1yAjLVSVdCJsqVDkDOsFhtcMN163orWzLIiifxOycFvxCyA26uYXdKYqln
        Rsnh7w6Hwvf+GJ68nyUTT8PSWsWp0bx0Rt48yd9Q+Ki13MY7JDw+vMegTSsobNZzfec1dpWZgZHi4
        kyfXPjFg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jsMeV-0007ks-RK; Mon, 06 Jul 2020 08:39:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 998103028C8;
        Mon,  6 Jul 2020 10:39:00 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 824F82025890A; Mon,  6 Jul 2020 10:39:00 +0200 (CEST)
Date:   Mon, 6 Jul 2020 10:39:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, mbenes@suse.cz
Subject: Re: [Linux v5.8-rc4] objtool warnings with gcc-10
Message-ID: <20200706083900.GC4800@hirez.programming.kicks-ass.net>
References: <CA+icZUVgJFXJ3C_iYK8HrsuhAy3R9U1RDB6mPkOS52JcnU4mDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUVgJFXJ3C_iYK8HrsuhAy3R9U1RDB6mPkOS52JcnU4mDQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 06, 2020 at 09:09:55AM +0200, Sedat Dilek wrote:
> [ Please CC me I am not subscribed to this mailing-list ]
> 
> Hi Josh and Peter,
> 
> today I switched over from Linux v5.7.y to Linux v5.8-rc4 and built
> the first time with GCC version 10 on Debian/testing AMD64.
> 
> $ cat /proc/version
> Linux version 5.8.0-rc4-1-amd64-gcc10 (sedat.dilek@gmail.com@iniza)
> (gcc-10 (Debian 10.1.0-4) 10.1.0, GNU ld (GNU Binutils for Debian)
> 2.34) #1~bullseye+dileks1 SMP 2020-07-06
> 
> I see these objtool warnings (which are new to me):
> 
> $ grep warning: build-log_5.8.0-rc4-1-amd64-gcc10.txt | sort
> arch/x86/kernel/cpu/mce/core.o: warning: objtool: mce_panic()+0x118: unreachable instruction
> drivers/atm/horizon.o: warning: objtool: interrupt_handler()+0x19f: unreachable instruction
> drivers/message/fusion/mptbase.o: warning: objtool: mpt_Soft_Hard_ResetHandler()+0x33a: unreachable instruction
> drivers/scsi/aic7xxx/aic79xx_core.o: warning: objtool: ahd_intr.part.0()+0x10f: unreachable instruction
> drivers/scsi/pcmcia/aha152x_core.o: warning: objtool: run()+0x4c0: unreachable instruction
> fs/btrfs/backref.o: warning: objtool: btrfs_backref_finish_upper_links()+0x309: unreachable instruction
> fs/btrfs/extent_io.o: warning: objtool: __set_extent_bit.cold()+0xc: unreachable instruction
> fs/btrfs/relocation.o: warning: objtool: update_backref_cache.part.0()+0x1de: unreachable instruction
> kernel/exit.o: warning: objtool: __x64_sys_exit_group()+0x14: unreachable instruction
> net/core/skbuff.o: warning: objtool: skb_push.cold()+0x15: unreachable instruction

That's more CONFIG_LIVEPATCH=y wreckage I expect. The problem is that
GCC -flive-patching= thing wreck the propagation of the noreturn.

This really is a compiler issue and we've not managed a sensible
work-around in objtool.
