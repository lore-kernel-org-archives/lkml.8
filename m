Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7316FC11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 19:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40C1024699
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 19:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="mH+7UFzC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730715AbgB0T5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 14:57:11 -0500
Received: from mail.skyhub.de ([5.9.137.197]:57702 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730359AbgB0T5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 14:57:10 -0500
Received: from zn.tnic (p200300EC2F0E0F0080237097B4C234BF.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:f00:8023:7097:b4c2:34bf])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8FDA31EC0A0E;
        Thu, 27 Feb 2020 20:57:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1582833428;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=cco6Llf7gZKT60wjg7MEvwtwaNV3LxviMFNzL2SHpB0=;
        b=mH+7UFzCHAprZqVnOxnx6lEDIQ8Q+c9mG/KG19MDvqoKxdw6HbJIQKxDfOkPl7Su5uX3XG
        Ag7Erw8ecn0lDt4B6TIZGF8xRg0r8DukPj48ga+19JHxsEa1YEsnei6t1ccMsd987OJkvh
        sfwtgUAXE/tWYpZ/PX537VY/SywQEDo=
Date:   Thu, 27 Feb 2020 20:57:08 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 2/8] x86/entry/common: Consolidate syscall entry code
Message-ID: <20200227195708.GD18629@zn.tnic>
References: <20200225220801.571835584@linutronix.de>
 <20200225221305.390667997@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200225221305.390667997@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 11:08:03PM +0100, Thomas Gleixner wrote:
> All syscall entry points call enter_from_user_mode() and
> local_irq_enable(). Move that into an inline helper so the interrupt
> tracing can be moved into that helper later instead of sprinkling
> it all over the place.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/entry/common.c |   48 +++++++++++++++++++++++++++++++++---------------
>  1 file changed, 33 insertions(+), 15 deletions(-)
> 
> --- a/arch/x86/entry/common.c
> +++ b/arch/x86/entry/common.c
> @@ -49,6 +49,18 @@
>  static inline void enter_from_user_mode(void) {}
>  #endif
>  
> +/*
> + * All syscall entry variants call with interrupts disabled.
> + *
> + * Invoke context tracking if enabled and enable interrupts for further
> + * processing.
> + */
> +static __always_inline void syscall_entry_fixups(void)

Function name needs a verb. "do_syscall_entry_fixups()" seems to fit well
with where it is called or "apply_..." or so.

Rest looks ok.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
