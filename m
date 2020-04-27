Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE46C54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 14:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80DA420661
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 14:44:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbgD0Oov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 10:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727077AbgD0Oot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 10:44:49 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27D4C0610D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 07:44:49 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jT501-0005LI-NJ; Mon, 27 Apr 2020 16:44:45 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id E65B0100606; Mon, 27 Apr 2020 16:44:44 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Brian Gerst <brgerst@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH] tracing/x86: fix trace event registration for syscalls without arguments
In-Reply-To: <158636958997.7900.16485049455470033557.stgit@buzz>
References: <158636958997.7900.16485049455470033557.stgit@buzz>
Date:   Mon, 27 Apr 2020 16:44:44 +0200
Message-ID: <87368pq97n.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Konstantin Khlebnikov <khlebnikov@yandex-team.ru> writes:

> Syscalls without arguments now has no ABI subs, instead of that macro

What is 'ABI subs'? 

> SYSCALL_DEFINE0() defines __abi_sys_name as aliase to __do_sys_name.
>
> As a result in find_syscall_meta() kallsyms_lookup() returns
> "__do_sys_name" which does not match with declared trace event.
>
> Also see commit 1c758a2202a6 ("tracing/x86: Update syscall trace events
> to handle new prefixed syscall func names")
>
> Fixes: d2b5de495ee9 ("x86/entry: Refactor SYSCALL_DEFINE0 macros")
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> ---
>  arch/x86/include/asm/ftrace.h |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
> index 85be2f506272..70b96cae5b42 100644
> --- a/arch/x86/include/asm/ftrace.h
> +++ b/arch/x86/include/asm/ftrace.h
> @@ -61,11 +61,12 @@ static inline bool arch_syscall_match_sym_name(const char *sym, const char *name
>  {
>  	/*
>  	 * Compare the symbol name with the system call name. Skip the
> -	 * "__x64_sys", "__ia32_sys" or simple "sys" prefix.
> +	 * "__x64_sys", "__ia32_sys", "__do_sys" or simple "sys" prefix.
>  	 */
>  	return !strcmp(sym + 3, name + 3) ||
>  		(!strncmp(sym, "__x64_", 6) && !strcmp(sym + 9, name + 3)) ||
> -		(!strncmp(sym, "__ia32_", 7) && !strcmp(sym + 10, name + 3));
> +		(!strncmp(sym, "__ia32_", 7) && !strcmp(sym + 10, name + 3)) ||
> +		(!strncmp(sym, "__do_sys", 8) && !strcmp(sym + 8, name + 3));
>  }
>  
>  #ifndef COMPILE_OFFSETS
