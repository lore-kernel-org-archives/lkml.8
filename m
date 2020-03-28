Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D05C7C2D0EC
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 10:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A678020716
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 10:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="pzeBx3E1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbgC1KUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 06:20:08 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:36986 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725937AbgC1KUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 06:20:08 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48qF8j331szB09ZZ;
        Sat, 28 Mar 2020 11:20:05 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=pzeBx3E1; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id WhdGRgIvWAGP; Sat, 28 Mar 2020 11:20:05 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48qF8j1h2rzB09ZY;
        Sat, 28 Mar 2020 11:20:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1585390805; bh=VxACPXV9Gk3PymTU0gGYQHtOnnL8iszZZtDxu9OZ0d0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=pzeBx3E1l4DxzUlqcR7ySE/cgizPmWuiUQIqjWW1w+yk3T8JBL7PtAs33jhcZDPl6
         f5Vjk7Nh8jaQ55EQV5espmk+CG9w7kDXQ7Rn3BPZ/w1S8VMPe9IknH41sTZR11XDNg
         0Wfj7lY+WzhQUYIAeG7NM6zRaLfQgfVg0Cow0Lf8=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 56DCA8B76B;
        Sat, 28 Mar 2020 11:20:06 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 7Hr0kWPiW8Oy; Sat, 28 Mar 2020 11:20:06 +0100 (CET)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4F6668B75B;
        Sat, 28 Mar 2020 11:20:05 +0100 (CET)
Subject: Re: [PATCH 1/1] ppc/crash: Skip spinlocks during crash
To:     Leonardo Bras <leonardo@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Enrico Weigelt <info@metux.net>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20200326222836.501404-1-leonardo@linux.ibm.com>
 <af505ef0-e0df-e0aa-bb83-3ed99841f151@c-s.fr>
 <56965ad674071181548d5ed4fb7c8fa08061b591.camel@linux.ibm.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <4759f5e9-24a6-7710-86a0-c8e45f5decb7@c-s.fr>
Date:   Sat, 28 Mar 2020 10:19:52 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <56965ad674071181548d5ed4fb7c8fa08061b591.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leonardo,

On 03/27/2020 03:51 PM, Leonardo Bras wrote:
> Hello Christophe, thanks for the feedback.
> 
> I noticed an error in this patch and sent a v2, that can be seen here:
> http://patchwork.ozlabs.org/patch/1262468/
> 
> Comments inline::
> 
> On Fri, 2020-03-27 at 07:50 +0100, Christophe Leroy wrote:
>>> @@ -142,6 +144,8 @@ static inline void arch_spin_lock(arch_spinlock_t *lock)
>>>    		if (likely(__arch_spin_trylock(lock) == 0))
>>>    			break;
>>>    		do {
>>> +			if (unlikely(crash_skip_spinlock))
>>> +				return;
> 
> Complete function for reference:
> static inline void arch_spin_lock(arch_spinlock_t *lock)
> {
> 	while (1) {
> 		if (likely(__arch_spin_trylock(lock) == 0))
> 			break;
> 		do {
> 			if (unlikely(crash_skip_spinlock))
> 				return;
> 			HMT_low();
> 			if (is_shared_processor())
> 				splpar_spin_yield(lock);
> 		} while (unlikely(lock->slock != 0));
> 		HMT_medium();
> 	}
> }
> 
>> You are adding a test that reads a global var in the middle of a so hot
>> path ? That must kill performance.
> 
> I thought it would, in worst case scenario, increase a maximum delay of
> an arch_spin_lock() call 1 spin cycle. Here is what I thought:
> 
> - If the lock is already free, it would change nothing,
> - Otherwise, the lock will wait.
> - Waiting cycle just got bigger.
> - Worst case scenario: running one more cycle, given lock->slock can
> turn to 0 just after checking.
> 
> Could you please point where I failed to see the performance penalty?
> (I need to get better at this :) )

You are right that when the lock is free, it changes nothing. However 
when it is not, it is not just one cycle.

Here is arch_spin_lock() without your patch:

00000440 <my_lock>:
  440:	39 40 00 01 	li      r10,1
  444:	7d 20 18 28 	lwarx   r9,0,r3
  448:	2c 09 00 00 	cmpwi   r9,0
  44c:	40 82 00 10 	bne     45c <my_lock+0x1c>
  450:	7d 40 19 2d 	stwcx.  r10,0,r3
  454:	40 a2 ff f0 	bne     444 <my_lock+0x4>
  458:	4c 00 01 2c 	isync
  45c:	2f 89 00 00 	cmpwi   cr7,r9,0
  460:	4d be 00 20 	bclr+   12,4*cr7+eq
  464:	7c 21 0b 78 	mr      r1,r1
  468:	81 23 00 00 	lwz     r9,0(r3)
  46c:	2f 89 00 00 	cmpwi   cr7,r9,0
  470:	40 be ff f4 	bne     cr7,464 <my_lock+0x24>
  474:	7c 42 13 78 	mr      r2,r2
  478:	7d 20 18 28 	lwarx   r9,0,r3
  47c:	2c 09 00 00 	cmpwi   r9,0
  480:	40 82 00 10 	bne     490 <my_lock+0x50>
  484:	7d 40 19 2d 	stwcx.  r10,0,r3
  488:	40 a2 ff f0 	bne     478 <my_lock+0x38>
  48c:	4c 00 01 2c 	isync
  490:	2f 89 00 00 	cmpwi   cr7,r9,0
  494:	40 be ff d0 	bne     cr7,464 <my_lock+0x24>
  498:	4e 80 00 20 	blr

Here is arch_spin_lock() with your patch. I enclose with === what comes 
in addition:

00000440 <my_lock>:
  440:	39 40 00 01 	li      r10,1
  444:	7d 20 18 28 	lwarx   r9,0,r3
  448:	2c 09 00 00 	cmpwi   r9,0
  44c:	40 82 00 10 	bne     45c <my_lock+0x1c>
  450:	7d 40 19 2d 	stwcx.  r10,0,r3
  454:	40 a2 ff f0 	bne     444 <my_lock+0x4>
  458:	4c 00 01 2c 	isync
  45c:	2f 89 00 00 	cmpwi   cr7,r9,0
  460:	4d be 00 20 	bclr+   12,4*cr7+eq
=====================================================
  464:	3d 40 00 00 	lis     r10,0
			466: R_PPC_ADDR16_HA	crash_skip_spinlock
  468:	39 4a 00 00 	addi    r10,r10,0
			46a: R_PPC_ADDR16_LO	crash_skip_spinlock
  46c:	39 00 00 01 	li      r8,1
  470:	89 2a 00 00 	lbz     r9,0(r10)
  474:	2f 89 00 00 	cmpwi   cr7,r9,0
  478:	4c 9e 00 20 	bnelr   cr7
=====================================================
  47c:	7c 21 0b 78 	mr      r1,r1
  480:	81 23 00 00 	lwz     r9,0(r3)
  484:	2f 89 00 00 	cmpwi   cr7,r9,0
  488:	40 be ff f4 	bne     cr7,47c <my_lock+0x3c>
  48c:	7c 42 13 78 	mr      r2,r2
  490:	7d 20 18 28 	lwarx   r9,0,r3
  494:	2c 09 00 00 	cmpwi   r9,0
  498:	40 82 00 10 	bne     4a8 <my_lock+0x68>
  49c:	7d 00 19 2d 	stwcx.  r8,0,r3
  4a0:	40 a2 ff f0 	bne     490 <my_lock+0x50>
  4a4:	4c 00 01 2c 	isync
  4a8:	2f 89 00 00 	cmpwi   cr7,r9,0
  4ac:	40 be ff c4 	bne     cr7,470 <my_lock+0x30>
  4b0:	4e 80 00 20 	blr


Christophe
