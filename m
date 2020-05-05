Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 202A7C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 21:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE79A206B8
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 21:19:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729515AbgEEVTn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 17:19:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:52908 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729266AbgEEVTm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 17:19:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C8A8EAEA3;
        Tue,  5 May 2020 21:19:42 +0000 (UTC)
Date:   Tue, 5 May 2020 23:19:32 +0200
From:   Borislav Petkov <bp@suse.de>
To:     akpm@linux-foundation.org
Cc:     mm-commits@vger.kernel.org, ndesaulniers@google.com,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: + arch-x86-makefile-use-config_shell.patch added to -mm tree
Message-ID: <20200505211932.GE6880@zn.tnic>
References: <20200505211301.9_zLPwR3D%akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200505211301.9_zLPwR3D%akpm@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 05, 2020 at 02:13:01PM -0700, akpm@linux-foundation.org wrote:
> 
> The patch titled
>      Subject: arch/x86/Makefile: use $(CONFIG_SHELL)
> has been added to the -mm tree.  Its filename is
>      arch-x86-makefile-use-config_shell.patch
> 
> This patch should soon appear at
>     http://ozlabs.org/~akpm/mmots/broken-out/arch-x86-makefile-use-config_shell.patch
> and later at
>     http://ozlabs.org/~akpm/mmotm/broken-out/arch-x86-makefile-use-config_shell.patch
> 
> Before you just go and hit "reply", please:
>    a) Consider who else should be cc'ed
>    b) Prefer to cc a suitable mailing list as well
>    c) Ideally: find the original patch on the mailing list and do a
>       reply-to-all to that, adding suitable additional cc's
> 
> *** Remember to use Documentation/process/submit-checklist.rst when testing your code ***
> 
> The -mm tree is included into linux-next and is updated
> there every 3-4 working days
> 
> ------------------------------------------------------
> From: Andrew Morton <akpm@linux-foundation.org>
> Subject: arch/x86/Makefile: use $(CONFIG_SHELL)
> 
> When scripts/x86-check-compiler.sh doesn't have the x bit set:
> 
> q:/usr/src/25> make clean
> make: execvp: ./scripts/x86-check-compiler.sh: Permission denied
> 
> Fix this by using $(CONFIG_SHELL).
> 
> This will happen if the user downloads and applies patch-5.7.tar.gz, since
> patch(1) doesn't preserve the x bit.
> 
> Fixes: 73da86741e7f7 ("x86/build: Check whether the compiler is sane")
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  arch/x86/Makefile |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/arch/x86/Makefile~arch-x86-makefile-use-config_shell
> +++ a/arch/x86/Makefile
> @@ -2,7 +2,7 @@
>  # Unified Makefile for i386 and x86_64
>  
>  #  Check the compiler
> -sane_compiler := $(shell $(srctree)/scripts/x86-check-compiler.sh $(CC))
> +sane_compiler := $($(CONFIG_SHELL) $(srctree)/scripts/x86-check-compiler.sh $(CC))
>  $(if $(sane_compiler),$(error $(CC) check failed. Aborting),)
>  
>  # select defconfig based on actual architecture
> _

Ah, interesting.

Thanks Andrew, I'll queue it tomorrow through tip.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
