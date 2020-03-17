Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A22BC10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 10:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 429A220714
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 10:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="Y0+ClKkA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbgCQKQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 06:16:40 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:43087 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbgCQKQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 06:16:39 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48hTbn465tz9txmZ;
        Tue, 17 Mar 2020 11:16:37 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=Y0+ClKkA; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Aklas_zFK9XK; Tue, 17 Mar 2020 11:16:37 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48hTbn2wrlz9txmY;
        Tue, 17 Mar 2020 11:16:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1584440197; bh=gHfeGuNMX9DiSTA3t8ffi2E0nIxwRTV7SW2fZ5cXtlo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Y0+ClKkAHkAbXdn90tqR12mVHVp0XeMaovQfiDBqjooBwzvtHjR0rMk0mG+IzuOS0
         8bPRYV+6KK9qTLUHnyCKT+YERwRt3+TfAVBqEXOnsHFb7IIPuczSnCxRxINs9o51s9
         o/u94T8qb60NVbDyIXCJigBoqFkPXg06UqIDHD+E=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 48BD48B787;
        Tue, 17 Mar 2020 11:16:38 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Ui0mrgBY-Bua; Tue, 17 Mar 2020 11:16:38 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7F50A8B785;
        Tue, 17 Mar 2020 11:16:36 +0100 (CET)
Subject: Re: [PATCH 02/15] powerpc/watchpoint: Add SPRN macros for second DAWR
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>, mpe@ellerman.id.au,
        mikey@neuling.org
Cc:     apopple@linux.ibm.com, paulus@samba.org, npiggin@gmail.com,
        naveen.n.rao@linux.vnet.ibm.com, peterz@infradead.org,
        jolsa@kernel.org, oleg@redhat.com, fweisbec@gmail.com,
        mingo@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20200309085806.155823-1-ravi.bangoria@linux.ibm.com>
 <20200309085806.155823-3-ravi.bangoria@linux.ibm.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <0a45786d-f44b-8717-3aed-dfcfcb1856bb@c-s.fr>
Date:   Tue, 17 Mar 2020 11:16:34 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200309085806.155823-3-ravi.bangoria@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 09/03/2020 à 09:57, Ravi Bangoria a écrit :
> Future Power architecture is introducing second DAWR. Add SPRN_ macros
> for the same.

I'm not sure this is called 'macros'. For me a macro is something more 
complex.

For me those are 'constants'.

Christophe

> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> ---
>   arch/powerpc/include/asm/reg.h | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
> index 156ee89fa9be..062e74cf41fd 100644
> --- a/arch/powerpc/include/asm/reg.h
> +++ b/arch/powerpc/include/asm/reg.h
> @@ -284,6 +284,7 @@
>   #define   CTRL_TE	0x00c00000	/* thread enable */
>   #define   CTRL_RUNLATCH	0x1
>   #define SPRN_DAWR0	0xB4
> +#define SPRN_DAWR1	0xB5
>   #define SPRN_RPR	0xBA	/* Relative Priority Register */
>   #define SPRN_CIABR	0xBB
>   #define   CIABR_PRIV		0x3
> @@ -291,6 +292,7 @@
>   #define   CIABR_PRIV_SUPER	2
>   #define   CIABR_PRIV_HYPER	3
>   #define SPRN_DAWRX0	0xBC
> +#define SPRN_DAWRX1	0xBD
>   #define   DAWRX_USER	__MASK(0)
>   #define   DAWRX_KERNEL	__MASK(1)
>   #define   DAWRX_HYP	__MASK(2)
> 
