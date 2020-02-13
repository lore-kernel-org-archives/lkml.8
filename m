Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948B9C3F68F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 11:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66A5120848
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 11:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="bNiPg8Ec"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729931AbgBMLgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 06:36:31 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:35252 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729772AbgBMLga (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 06:36:30 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48JDx81Mdxz9vC0r;
        Thu, 13 Feb 2020 12:36:28 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=bNiPg8Ec; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id VwdZhkCoNCGT; Thu, 13 Feb 2020 12:36:28 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48JDx80GCPz9vC0q;
        Thu, 13 Feb 2020 12:36:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1581593788; bh=JI/l0B6oz142zI0BvEjYO3SlgbYPDoynj43XnCUS9yE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=bNiPg8EcysRQB4ODi9z7nh+YEqqtH1BrWwsAe/FKsSCltCYZgXx4GKUzvP60xSyto
         PKEktQpridUB5saxEPQVV2sh7RP5SSpiWNdwr+sDZMHXHQr2tuin1mILW61TzIkif0
         XHRKxeUKZsgVxvRBqzflGslRYSmi1eI5kILvJoxc=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3C8578B841;
        Thu, 13 Feb 2020 12:36:29 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id AepsZRA2KoQk; Thu, 13 Feb 2020 12:36:29 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6797F8B83F;
        Thu, 13 Feb 2020 12:36:28 +0100 (CET)
Subject: Re: [PATCH v7 4/4] powerpc: Book3S 64-bit "heavyweight" KASAN support
To:     Daniel Axtens <dja@axtens.net>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        kasan-dev@googlegroups.com, aneesh.kumar@linux.ibm.com,
        bsingharora@gmail.com
Cc:     Michael Ellerman <mpe@ellerman.id.au>
References: <20200213004752.11019-1-dja@axtens.net>
 <20200213004752.11019-5-dja@axtens.net>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <abcc9f7d-995d-e06e-ef04-1dbd144a38e0@c-s.fr>
Date:   Thu, 13 Feb 2020 12:36:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200213004752.11019-5-dja@axtens.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 13/02/2020 à 01:47, Daniel Axtens a écrit :
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 497b7d0b2d7e..f1c54c08a88e 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -169,7 +169,9 @@ config PPC
>   	select HAVE_ARCH_HUGE_VMAP		if PPC_BOOK3S_64 && PPC_RADIX_MMU
>   	select HAVE_ARCH_JUMP_LABEL
>   	select HAVE_ARCH_KASAN			if PPC32
> +	select HAVE_ARCH_KASAN			if PPC_BOOK3S_64 && PPC_RADIX_MMU

That's probably detail, but as it is necessary to deeply define the HW 
when selecting that (I mean giving the exact amount of memory and with 
restrictions like having a wholeblock memory), should it also depend of 
EXPERT ?

>   	select HAVE_ARCH_KASAN_VMALLOC		if PPC32
> +	select HAVE_ARCH_KASAN_VMALLOC		if PPC_BOOK3S_64 && PPC_RADIX_MMU

Maybe we could have

-  	select HAVE_ARCH_KASAN_VMALLOC		if PPC32
+	select HAVE_ARCH_KASAN_VMALLOC		if HAVE_ARCH_KASAN


>   	select HAVE_ARCH_KGDB
>   	select HAVE_ARCH_MMAP_RND_BITS
>   	select HAVE_ARCH_MMAP_RND_COMPAT_BITS	if COMPAT


Christophe
