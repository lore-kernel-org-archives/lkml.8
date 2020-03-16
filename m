Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B87C18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 13:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 434CF205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 13:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J1gGejFz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731140AbgCPNEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 09:04:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58246 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730974AbgCPNEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 09:04:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XYP4eLWlmurw/yjHmjNfN5IFqsjDCm9io3qRKcZbPcU=; b=J1gGejFzBgU3ABPLGZfeahlXVA
        zICDn6wUZjBvXMTn1D5zLCm4wnGBns+fC2OyK+s03CmqmOcPjuqkRd/DqyhgqYCDT69VMy6dcdnP3
        0ajKpBhHRv7s6v+9kodIxjs51HfoX/KmdkO6orXQB6UIGtELw8rsXgyJZea2el3rAH0m8TiJy5s2x
        SwZNZPlwcVr7RWlf6fmw7XXWmPNfph2iiLl38jtf9OjD9Y5WCXDpGVmjjEb49nQTfZ5flsuzGl9B8
        wNUbZTVWCTXRFPeaRY1rNGPfbbNRsQJzVParhzZqWoJfUV5kv2qstm3qB7aY4E7AgA63UgOZ6Eudz
        gjrvHiVA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jDpPk-0001Zo-Ro; Mon, 16 Mar 2020 13:04:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6CE3D30138D;
        Mon, 16 Mar 2020 14:04:14 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 570E220B151F4; Mon, 16 Mar 2020 14:04:14 +0100 (CET)
Date:   Mon, 16 Mar 2020 14:04:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sergei Trofimovich <slyfox@gentoo.org>
Cc:     linux-kernel@vger.kernel.org, Jakub Jelinek <jakub@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org
Subject: Re: [PATCH] x86: fix early boot crash on gcc-10
Message-ID: <20200316130414.GC12561@hirez.programming.kicks-ass.net>
References: <20200314164451.346497-1-slyfox@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200314164451.346497-1-slyfox@gentoo.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 14, 2020 at 04:44:51PM +0000, Sergei Trofimovich wrote:
> The change fixes boot failure on physical machine where kernel
> is built with gcc-10 with stack-protector enabled by default:

> This happens because `start_secondary()` is responsible for setting
> up initial stack canary value in `smpboot.c`, but nothing prevents
> gcc from inserting stack canary into `start_secondary()` itself
> before `boot_init_stack_canary()` call.

> diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
> index 9b294c13809a..da9f4ea9bf4c 100644
> --- a/arch/x86/kernel/Makefile
> +++ b/arch/x86/kernel/Makefile
> @@ -11,6 +11,12 @@ extra-y	+= vmlinux.lds
>  
>  CPPFLAGS_vmlinux.lds += -U$(UTS_MACHINE)
>  
> +# smpboot's init_secondary initializes stack canary.
> +# Make sure we don't emit stack checks before it's
> +# initialized.
> +nostackp := $(call cc-option, -fno-stack-protector)
> +CFLAGS_smpboot.o := $(nostackp)

What makes GCC10 insert this while GCC9 does not. Also, I would much
rather GCC10 add a function attrbute to kill this:

  __attribute__((no_stack_protect))

Then we can explicitly clear this one function and keep it on for the
rest of the file.
