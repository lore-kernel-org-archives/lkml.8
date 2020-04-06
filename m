Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A70C2BA17
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 18:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23E5A206F5
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 18:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="Tnve/r/w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgDFSSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 14:18:36 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:55938 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbgDFSSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 14:18:36 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48wzLg3hsJz9v0BM;
        Mon,  6 Apr 2020 20:18:35 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=Tnve/r/w; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id sh5LVu4Zz_PJ; Mon,  6 Apr 2020 20:18:35 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48wzLg2H6kz9v0BL;
        Mon,  6 Apr 2020 20:18:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1586197115; bh=eo4TdLmuuA8DaXdbgpPkyf6SowdS8w6IgKKi5skgu/8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Tnve/r/wvjFnyXjUemjEM6sCiOY/gChrZ2rnjZnpLKOkXZMHxrUsLj7rBMpK/mZXt
         IN3fDuau70xMtUcXiYqaXpz5BbemKDAfRbLkkIHXZCqEg/mzhtZcIV0XX6MGMlM50D
         EQv4SBw7ESa1RtDn30ilTKkMjnIGRWwD12AoZBMo=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 415DA8B784;
        Mon,  6 Apr 2020 20:18:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id fDH1qkHOVEY2; Mon,  6 Apr 2020 20:18:35 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BF4838B775;
        Mon,  6 Apr 2020 20:18:34 +0200 (CEST)
Subject: Re: [RFC PATCH v2 12/13] powerpc/kernel: Do not inconditionally save
 non volatile registers on system call
To:     Nicholas Piggin <npiggin@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>, msuchanek@suse.de,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <029e1064b1ad738785718221ea468c9cfc282457.1586108649.git.christophe.leroy@c-s.fr>
 <4ef6d617cfd34e09e9bf5a456b2e0b6d2a8a3c96.1586108649.git.christophe.leroy@c-s.fr>
 <1586135554.pnqaj0giue.astroid@bobo.none>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <48d3e2e5-318f-011e-a59b-ec89bd7b76d2@c-s.fr>
Date:   Mon, 6 Apr 2020 20:18:29 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1586135554.pnqaj0giue.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 06/04/2020 à 03:25, Nicholas Piggin a écrit :
> Christophe Leroy's on April 6, 2020 3:44 am:
>> Before : 347 cycles on null_syscall
>> After  : 327 cycles on null_syscall
> 
> The problem I had doing this is that signal delivery wnats full regs,
> and you don't know if you have a signal pending ahead of time if you
> have interrupts enabled.
> 
> I began to try bailing out back to asm to save nvgprs and call again.
> I think that can be made to work, but it is more complication in asm,
> and I soon found that 64s CPUs don't care about NVGPRs too much so it's
> nice to get rid of the !fullregs state.

I tried a new way in v3, please have a look. I split 
syscall_exit_prepare() in 3 parts and the result is unexpected: it is 
better than before the series (307 cycles now versus 311 cycles with 
full ASM syscall entry/exit).

> 
> Possibly another approach would be to leave interrupts disabled for the
> case where you have no work to do. You could create a small
> syscall_exit_prepare_nowork fastpath for that case for 32-bit, perhaps?
> 
> Thanks,
> Nick
> 

Christophe
