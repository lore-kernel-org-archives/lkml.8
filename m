Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A0AC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 18:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DA9D2077D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 18:54:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgE2SyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 14:54:02 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:45292 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725795AbgE2SyB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 14:54:01 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 49YYd03GNpz9v2TY;
        Fri, 29 May 2020 20:53:56 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id hFV3bymvO7BL; Fri, 29 May 2020 20:53:56 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 49YYd02TMyz9v2TX;
        Fri, 29 May 2020 20:53:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 607B98B88A;
        Fri, 29 May 2020 20:53:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 7nz_JfvzlUQf; Fri, 29 May 2020 20:53:56 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D57F98B886;
        Fri, 29 May 2020 20:53:55 +0200 (CEST)
Subject: Re: [PATCH] powerpc/32s: Fix another build failure with
 CONFIG_PPC_KUAP_DEBUG
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <5ce7982c72424eb3e7abf78063d454c38c42b343.1590778219.git.christophe.leroy@csgroup.eu>
Message-ID: <0bd1be94-5e1c-b276-c2fa-9fdb3ac07a02@csgroup.eu>
Date:   Fri, 29 May 2020 20:53:45 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <5ce7982c72424eb3e7abf78063d454c38c42b343.1590778219.git.christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 29/05/2020 à 20:50, Christophe Leroy a écrit :
> From: Christophe Leroy <christophe.leroy@c-s.fr>
> 
> 'thread' doesn't exist in kuap_check() macro.
> 
> Use 'current' instead.
> 
> Fixes: a68c31fc01ef ("powerpc/32s: Implement Kernel Userspace Access Protection")
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Argh, can you drop this line ?

> Cc: stable@vger.kernel.org
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Reported-by: kbuild test robot <lkp@intel.com>

> ---
>   arch/powerpc/include/asm/book3s/32/kup.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/book3s/32/kup.h b/arch/powerpc/include/asm/book3s/32/kup.h
> index db0a1c281587..668508c8a1b5 100644
> --- a/arch/powerpc/include/asm/book3s/32/kup.h
> +++ b/arch/powerpc/include/asm/book3s/32/kup.h
> @@ -75,7 +75,7 @@
>   
>   .macro kuap_check	current, gpr
>   #ifdef CONFIG_PPC_KUAP_DEBUG
> -	lwz	\gpr, KUAP(thread)
> +	lwz	\gpr, THREAD + KUAP(\current)
>   999:	twnei	\gpr, 0
>   	EMIT_BUG_ENTRY 999b, __FILE__, __LINE__, (BUGFLAG_WARNING | BUGFLAG_ONCE)
>   #endif
> 
