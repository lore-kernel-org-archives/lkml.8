Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B221DC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 09:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EC7A2075E
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 09:15:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725813AbgIKJPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 05:15:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:42696 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbgIKJPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 05:15:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2EE61ABEA;
        Fri, 11 Sep 2020 09:15:59 +0000 (UTC)
Date:   Fri, 11 Sep 2020 11:15:42 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/traps: fix recoverability of machine check
 handling on book3s/32
Message-ID: <20200911091542.GE29521@kitsune.suse.cz>
References: <1c804764d38fb084b420b12ca13e8c1b2dea075e.1548166189.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c804764d38fb084b420b12ca13e8c1b2dea075e.1548166189.git.christophe.leroy@c-s.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

does this logic apply to "Unrecoverable System Reset" as well?

Thanks

Michal

On Tue, Jan 22, 2019 at 02:11:24PM +0000, Christophe Leroy wrote:
> Looks like book3s/32 doesn't set RI on machine check, so
> checking RI before calling die() will always be fatal
> allthought this is not an issue in most cases.
> 
> Fixes: b96672dd840f ("powerpc: Machine check interrupt is a non-maskable interrupt")
> Fixes: daf00ae71dad ("powerpc/traps: restore recoverability of machine_check interrupts")
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Cc: stable@vger.kernel.org
> ---
>  arch/powerpc/kernel/traps.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index 64936b60d521..c740f8bfccc9 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -763,15 +763,15 @@ void machine_check_exception(struct pt_regs *regs)
>  	if (check_io_access(regs))
>  		goto bail;
>  
> -	/* Must die if the interrupt is not recoverable */
> -	if (!(regs->msr & MSR_RI))
> -		nmi_panic(regs, "Unrecoverable Machine check");
> -
>  	if (!nested)
>  		nmi_exit();
>  
>  	die("Machine check", regs, SIGBUS);
>  
> +	/* Must die if the interrupt is not recoverable */
> +	if (!(regs->msr & MSR_RI))
> +		nmi_panic(regs, "Unrecoverable Machine check");
> +
>  	return;
>  
>  bail:
> -- 
> 2.13.3
> 
