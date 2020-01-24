Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F22C8C2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 07:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DE9C2075D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 07:03:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="AmfhqxCL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730749AbgAXHDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 02:03:40 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:48814 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbgAXHDi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 02:03:38 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 483qqX1ywTz9tyWR;
        Fri, 24 Jan 2020 08:03:36 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=AmfhqxCL; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 1MTHMFIssLu8; Fri, 24 Jan 2020 08:03:36 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 483qqW6WN3z9tyWM;
        Fri, 24 Jan 2020 08:03:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1579849415; bh=ITaOlJ0/QZZrDkYtjFjngyVQpAL/zHUltBD1tC8H/AY=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=AmfhqxCLvYIIarRc5Sj6TqXdi78MZxs1FJIy8UehPMFzYNeRnkGrPgkHJmGwOZujp
         owUVkiZjvW4DtF3OJ28hx/nh5NlUgcag9iG4v4NCT7B8lTB0CRmNtoha0qps7OzE/o
         r00NWOLgPqUZvtDLxJJmjEqEg7OEz6W6rUUx14n8=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BBC498B83D;
        Fri, 24 Jan 2020 08:03:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id JdtNjI8kHPZZ; Fri, 24 Jan 2020 08:03:36 +0100 (CET)
Received: from po14934vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.111])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7AE098B768;
        Fri, 24 Jan 2020 08:03:36 +0100 (CET)
Subject: Re: [PATCH 1/2] powerpc/irq: don't use current_stack_pointer() in
 check_stack_overflow()
From:   Christophe Leroy <christophe.leroy@c-s.fr>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <bae3e75a0c7f9037e4012ee547842c04cd527931.1575871613.git.christophe.leroy@c-s.fr>
 <87d0b9iez3.fsf@mpe.ellerman.id.au>
 <f4196f83-82ac-4df0-8c15-267a2c6c07ba@c-s.fr>
Message-ID: <74cb4227-1a24-6fe1-2df4-3d4b069453c4@c-s.fr>
Date:   Fri, 24 Jan 2020 07:03:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <f4196f83-82ac-4df0-8c15-267a2c6c07ba@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/24/2020 06:19 AM, Christophe Leroy wrote:
> 
> 
> Le 24/01/2020 à 06:46, Michael Ellerman a écrit :
>>
>> If I do this it seems to work, but feels a little dicey:
>>
>>     asm ("" : "=r" (r1));
>>     sp = r1 & (THREAD_SIZE - 1);
> 
> 
> Or we could do add in asm/reg.h what we have in boot/reg.h:
> 
> register void *__stack_pointer asm("r1");
> #define get_sp()    (__stack_pointer)
> 
> And use get_sp()
> 

It works, and I guess doing it this way is acceptable as it's exactly 
what's done for current in asm/current.h with register r2.

Now I (still) get:

	sp = get_sp() & (THREAD_SIZE - 1);
  b9c:	54 24 04 fe 	clrlwi  r4,r1,19
	if (unlikely(sp < 2048)) {
  ba4:	2f 84 07 ff 	cmpwi   cr7,r4,2047





Allthough GCC 8.1 what doing exactly the same with the form CLANG don't 
like:

	register unsigned long r1 asm("r1");
	long sp = r1 & (THREAD_SIZE - 1);
  b84:	54 24 04 fe 	clrlwi  r4,r1,19
	if (unlikely(sp < 2048)) {
  b8c:	2f 84 07 ff 	cmpwi   cr7,r4,2047


Christophe
