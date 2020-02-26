Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 369FEC4BA0E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 11:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 002D424685
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 11:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="d4tmsZnw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbgBZLSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 06:18:34 -0500
Received: from mail.skyhub.de ([5.9.137.197]:51638 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726555AbgBZLSe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 06:18:34 -0500
Received: from zn.tnic (p200300EC2F08E300B4442D161B607307.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:e300:b444:2d16:1b60:7307])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3C8441EC0CE8;
        Wed, 26 Feb 2020 12:18:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1582715913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=A6vGW6WUZ5u5dkVwvmxhlqIwrUUQElMkiVyfzpmoYNE=;
        b=d4tmsZnwpqQRbWbXWbISqx/ToV3X/lDxjhdVx25tGVKzjZ6pF8Ga0vbGPlnafNAcqQPs/v
        vUpXL/JJr6kqLKoZtMRTzjy1ku7xqROLqmGS3++KsmpjO4ZwQr8oUPCMW49baleRd0f6Nk
        muU+bgepnGz0RQAIOefZOitsE2uN1aw=
Date:   Wed, 26 Feb 2020 12:18:27 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [patch 02/10] x86/mce: Disable tracing and kprobes on
 do_machine_check()
Message-ID: <20200226111827.GA16756@zn.tnic>
References: <20200225213636.689276920@linutronix.de>
 <20200225220216.315548935@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200225220216.315548935@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 10:36:38PM +0100, Thomas Gleixner wrote:
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -1213,8 +1213,14 @@ static void __mc_scan_banks(struct mce *
>   * On Intel systems this is entered on all CPUs in parallel through
>   * MCE broadcast. However some CPUs might be broken beyond repair,
>   * so be always careful when synchronizing with others.
> + *
> + * Tracing and kprobes are disabled: if we interrupted a kernel context
> + * with IF=1, we need to minimize stack usage.  There are also recursion
> + * issues: if the machine check was due to a failure of the memory
> + * backing the user stack, tracing that reads the user stack will cause
			      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Had to read this a couple of times to parse that formulation properly.
Make that

"... backing the user stack, tracing code which accesses same user stack
will potentially cause an infinite recursion."

With that:

Reviewed-by: Borislav Petkov <bp@suse.de>

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
