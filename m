Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01299C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DED1D2065E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387783AbgGTQLT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733093AbgGTQLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:11:17 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99302C0619D2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 09:11:16 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 9012C344; Mon, 20 Jul 2020 18:11:13 +0200 (CEST)
Date:   Mon, 20 Jul 2020 18:11:12 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>, hpa@zytor.com,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/idt: Make sure idt_table takes a whole page
Message-ID: <20200720161112.GB620@8bytes.org>
References: <0CEC6A66-FD50-4B6B-9521-A40E5B9DA10F@zytor.com>
 <7FB389D0-77D4-482E-8A21-8662DDB00268@amacapital.net>
 <0B7CF270-EC04-4907-821A-A01F24BEF156@zytor.com>
 <20200719023405.GA564835@rani.riverdale.lan>
 <87pn8rokjz.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pn8rokjz.fsf@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 19, 2020 at 12:39:44PM +0200, Thomas Gleixner wrote:
> The right fix is trivial. See below.
> 
> Thanks,
> 
>         tglx
> ----
>  arch/x86/kernel/vmlinux.lds.S     |    1 +
>  include/asm-generic/vmlinux.lds.h |    1 +
>  2 files changed, 2 insertions(+)
> 
> --- a/arch/x86/kernel/vmlinux.lds.S
> +++ b/arch/x86/kernel/vmlinux.lds.S
> @@ -358,6 +358,7 @@ SECTIONS
>  	.bss : AT(ADDR(.bss) - LOAD_OFFSET) {
>  		__bss_start = .;
>  		*(.bss..page_aligned)
> +		. = ALIGN(PAGE_SIZE);
>  		*(BSS_MAIN)
>  		BSS_DECRYPTED
>  		. = ALIGN(PAGE_SIZE);
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -738,6 +738,7 @@
>  	.bss : AT(ADDR(.bss) - LOAD_OFFSET) {				\
>  		BSS_FIRST_SECTIONS					\
>  		*(.bss..page_aligned)					\
> +		. = ALIGN(PAGE_SIZE);					\
>  		*(.dynbss)						\
>  		*(BSS_MAIN)						\
>  		*(COMMON)						\

I thougt about that too (and doing the same for .data..page_aligned),
but decided that 'page_aligned' does not imply 'page_sized', so that
putting other variables on the same page is fine in general and saves
some memory. The problem why it breaks here is only because x86 maps a
variabe which is not page-sized RO, so my thinking was that it should be
fixed right there, at the variable.

But if the above is fine too I prepare a patch which also aligns the end
of .data..page_aligned.

Thanks,

	Joerg

