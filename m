Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC36C35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 07:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79B0220801
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 07:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbgBUHH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 02:07:26 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:34390 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727169AbgBUHH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 02:07:26 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.1.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 888172009A2;
        Fri, 21 Feb 2020 07:07:24 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id 5854420AED; Fri, 21 Feb 2020 08:07:04 +0100 (CET)
Date:   Fri, 21 Feb 2020 08:07:04 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Brian Gerst <brgerst@gmail.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 2/5] x86: Move 32-bit compat syscalls to common location
Message-ID: <20200221070704.GF3368@light.dominikbrodowski.net>
References: <20200221050934.719152-1-brgerst@gmail.com>
 <20200221050934.719152-3-brgerst@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221050934.719152-3-brgerst@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 12:09:31AM -0500, Brian Gerst wrote:
> --- a/arch/x86/kernel/Makefile
> +++ b/arch/x86/kernel/Makefile
> @@ -57,6 +57,8 @@ obj-y			+= setup.o x86_init.o i8259.o irqinit.o
>  obj-$(CONFIG_JUMP_LABEL)	+= jump_label.o
>  obj-$(CONFIG_IRQ_WORK)  += irq_work.o
>  obj-y			+= probe_roms.o
> +obj-$(CONFIG_X86_32)	+= sys_ia32.o
> +obj-$(CONFIG_IA32_EMULATION)	+= sys_ia32.o

That doesn't look nicely...

Other than that, the patch looks trivial enough.

Thanks,
	Dominik
