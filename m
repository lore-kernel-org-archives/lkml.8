Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40CC7C7619B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 06:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18D94206F4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 06:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="h0XXEdLk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgBQGt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 01:49:56 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:47518 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726314AbgBQGt4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 01:49:56 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48LZNY685Jz9tyTR;
        Mon, 17 Feb 2020 07:49:49 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=h0XXEdLk; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id AtQbmnOzfIpS; Mon, 17 Feb 2020 07:49:49 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48LZNY4V8Gz9tyTL;
        Mon, 17 Feb 2020 07:49:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1581922189; bh=gkxNRKBqNEJM66/gtBwTFE5U/ypR6IcgTcqQArGKtAE=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=h0XXEdLkKH2E0dt22yIYOuvOaegk3eCLCP+4W3SWfv5PJ2Jp2YQltB8O1P7FlUiwh
         nfrwNORHWBhqMQDmUK0JJnsT7QyadXDatnxKlXRbIN3vCkSgq4qg7RF74QEOcDgc92
         MB6HJATyptC98Vgbp+4+Fa3M6tW+Vb6bwZ0wPZLo=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2D3AB8B79C;
        Mon, 17 Feb 2020 07:49:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id TfHkxj9zhBIY; Mon, 17 Feb 2020 07:49:54 +0100 (CET)
Received: from [172.25.230.102] (unknown [172.25.230.102])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0127C8B755;
        Mon, 17 Feb 2020 07:49:53 +0100 (CET)
Subject: Re: [RFC PATCH v2 00/12] Reduce ifdef mess in ptrace
From:   Christophe Leroy <christophe.leroy@c-s.fr>
To:     mikey@neuling.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <cover.1561735587.git.christophe.leroy@c-s.fr>
Message-ID: <f62b0f67-c418-3734-0b07-65aea7537a78@c-s.fr>
Date:   Mon, 17 Feb 2020 07:49:53 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <cover.1561735587.git.christophe.leroy@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mikey,

Le 28/06/2019 à 17:47, Christophe Leroy a écrit :
> The purpose of this series is to reduce the amount of #ifdefs
> in ptrace.c
> 

Any feedback on this series which aims at fixing the issue you opened at 
https://github.com/linuxppc/issues/issues/128 ?

Thanks
Christophe

> This is a first try. Most of it is done, there are still some #ifdefs that
> could go away.
> 
> Please comment and tell whether it is worth continuing in that direction.
> 
> v2:
> - Fixed several build failures. Now builts cleanly on kisskb, see http://kisskb.ellerman.id.au/kisskb/head/840e53cf913d6096dd60181a085f102c85d6e526/
> - Droped last patch which is not related to ptrace and can be applies independently.
> 
> Christophe Leroy (12):
>    powerpc: move ptrace into a subdirectory.
>    powerpc/ptrace: drop unnecessary #ifdefs CONFIG_PPC64
>    powerpc/ptrace: drop PARAMETER_SAVE_AREA_OFFSET
>    powerpc/ptrace: split out VSX related functions.
>    powerpc/ptrace: split out ALTIVEC related functions.
>    powerpc/ptrace: split out SPE related functions.
>    powerpc/ptrace: split out TRANSACTIONAL_MEM related functions.
>    powerpc/ptrace: move register viewing functions out of ptrace.c
>    powerpc/ptrace: split out ADV_DEBUG_REGS related functions.
>    powerpc/ptrace: create ptrace_get_debugreg()
>    powerpc/ptrace: create ppc_gethwdinfo()
>    powerpc/ptrace: move ptrace_triggered() into hw_breakpoint.c
> 
>   arch/powerpc/include/asm/ptrace.h           |    9 +-
>   arch/powerpc/include/uapi/asm/ptrace.h      |   12 +-
>   arch/powerpc/kernel/Makefile                |    7 +-
>   arch/powerpc/kernel/hw_breakpoint.c         |   16 +
>   arch/powerpc/kernel/ptrace.c                | 3402 ---------------------------
>   arch/powerpc/kernel/ptrace/Makefile         |   20 +
>   arch/powerpc/kernel/ptrace/ptrace-adv.c     |  511 ++++
>   arch/powerpc/kernel/ptrace/ptrace-altivec.c |  151 ++
>   arch/powerpc/kernel/ptrace/ptrace-decl.h    |  184 ++
>   arch/powerpc/kernel/ptrace/ptrace-noadv.c   |  291 +++
>   arch/powerpc/kernel/ptrace/ptrace-novsx.c   |   83 +
>   arch/powerpc/kernel/ptrace/ptrace-spe.c     |   92 +
>   arch/powerpc/kernel/ptrace/ptrace-tm.c      |  879 +++++++
>   arch/powerpc/kernel/ptrace/ptrace-view.c    |  953 ++++++++
>   arch/powerpc/kernel/ptrace/ptrace-vsx.c     |  177 ++
>   arch/powerpc/kernel/ptrace/ptrace.c         |  430 ++++
>   arch/powerpc/kernel/{ => ptrace}/ptrace32.c |    0
>   17 files changed, 3798 insertions(+), 3419 deletions(-)
>   delete mode 100644 arch/powerpc/kernel/ptrace.c
>   create mode 100644 arch/powerpc/kernel/ptrace/Makefile
>   create mode 100644 arch/powerpc/kernel/ptrace/ptrace-adv.c
>   create mode 100644 arch/powerpc/kernel/ptrace/ptrace-altivec.c
>   create mode 100644 arch/powerpc/kernel/ptrace/ptrace-decl.h
>   create mode 100644 arch/powerpc/kernel/ptrace/ptrace-noadv.c
>   create mode 100644 arch/powerpc/kernel/ptrace/ptrace-novsx.c
>   create mode 100644 arch/powerpc/kernel/ptrace/ptrace-spe.c
>   create mode 100644 arch/powerpc/kernel/ptrace/ptrace-tm.c
>   create mode 100644 arch/powerpc/kernel/ptrace/ptrace-view.c
>   create mode 100644 arch/powerpc/kernel/ptrace/ptrace-vsx.c
>   create mode 100644 arch/powerpc/kernel/ptrace/ptrace.c
>   rename arch/powerpc/kernel/{ => ptrace}/ptrace32.c (100%)
> 
