Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D66FC35249
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 06:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E80520659
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 06:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="Hmjs+NJp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgBEG0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 01:26:02 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:64192 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbgBEG0C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 01:26:02 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48CBQb2lTQz9v9Cl;
        Wed,  5 Feb 2020 07:25:59 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=Hmjs+NJp; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id djzf2NcZP0j6; Wed,  5 Feb 2020 07:25:59 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48CBQb1TnSz9v9Ck;
        Wed,  5 Feb 2020 07:25:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1580883959; bh=arjyGSAsMm0Nw/MEg/HGvPVCQztAhca2h8pfvGO7wGE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Hmjs+NJpMGkA+Ee2fGqfMl3SCjZu9+GCPa3wGWJc7wxoIgzYVeN2jhvL23n25B30d
         NHCWMIWfW4VHsOQF3Bt0rJ7ofbK+qot1ySSNV99RkUGa4V9dHmKbRYXe2q3H9WFX0n
         V0YLQ+h2/2Yekf2izKm81liQC22q9kqACXqDWOAM=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0273C8B820;
        Wed,  5 Feb 2020 07:26:00 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Ue-_DaLfAi1p; Wed,  5 Feb 2020 07:25:59 +0100 (CET)
Received: from [172.25.230.107] (unknown [172.25.230.107])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B9A9A8B778;
        Wed,  5 Feb 2020 07:25:59 +0100 (CET)
Subject: Re: [PATCH] powerpc/vdso32: mark __kernel_datapage_offset as
 STV_PROTECTED
To:     Fangrui Song <maskray@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
References: <20200205005054.k72fuikf6rwrgfe4@google.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <10e3d362-ec29-3816-88ff-8415d5c78e3b@c-s.fr>
Date:   Wed, 5 Feb 2020 07:25:59 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200205005054.k72fuikf6rwrgfe4@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 05/02/2020 à 01:50, Fangrui Song a écrit :
> A PC-relative relocation (R_PPC_REL16_LO in this case) referencing a
> preemptible symbol in a -shared link is not allowed.  GNU ld's powerpc
> port is permissive and allows it [1], but lld will report an error after
> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/commit/?id=ec0895f08f99515194e9fcfe1338becf6f759d38

Note that there is a series whose first two patches aim at dropping 
__kernel_datapage_offset . See 
https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=156045 
and especially patches https://patchwork.ozlabs.org/patch/1231467/ and 
https://patchwork.ozlabs.org/patch/1231461/

Those patches can be applied independentely of the rest.

Christophe

> 
> Make the symbol protected so that it is non-preemptible but still
> exported.
> 
> [1]: https://sourceware.org/bugzilla/show_bug.cgi?id=25500
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/851
> Signed-off-by: Fangrui Song <maskray@google.com>
> ---
>   arch/powerpc/kernel/vdso32/datapage.S | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/vdso32/datapage.S b/arch/powerpc/kernel/vdso32/datapage.S
> index 217bb630f8f9..2831a8676365 100644
> --- a/arch/powerpc/kernel/vdso32/datapage.S
> +++ b/arch/powerpc/kernel/vdso32/datapage.S
> @@ -13,7 +13,8 @@
>   #include <asm/vdso_datapage.h>
>   
>   	.text
> -	.global	__kernel_datapage_offset;
> +	.global	__kernel_datapage_offset
> +	.protected	__kernel_datapage_offset
>   __kernel_datapage_offset:
>   	.long	0
>   
> 
