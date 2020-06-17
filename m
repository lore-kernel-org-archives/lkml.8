Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51559C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 14:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D33D206D8
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 14:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="lxdjEtyN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgFQOU6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 10:20:58 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:56691 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726495AbgFQOU5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 10:20:57 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49n6g82rTMz9sRR;
        Thu, 18 Jun 2020 00:20:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1592403652;
        bh=nT3jSQ10DdCeaRDuIzvG9LLp2BdupDQ+BbxCSWTl9i0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=lxdjEtyNE10rEnpgqyn+zSVpLONzbnqx1pRDsdksAsyo2Rx8gEhf0XljLdpg6KjCO
         +66bPAJTtxOkdxUa6KHgOgYEiDz+W93amRTMOIk5Sm67SJxLod5dgevLZOLPbf5XSJ
         e/Hk1VYT4oU0+OQ+lFZJt0LSHDtmI/xVxmuDULhX6ODWj+ii7ShLU0HHyBLi9LX8iW
         gwnyPJMMX8T6aJYR0K4BFis9I3V7o+IY1ZPI7whFiGBp30gRFOROr4G/Jdu40VJoGi
         UG5lUCwblNTFME+U+kFaZiBO8Ke8jwShBK3SUywjpEKRpe8tCiKqjD3CjcgrbWvCjz
         sxAKyguruOPKw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Peter Zijlstra <peterz@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 3/3] powerpc/8xx: Provide ptep_get() with 16k pages
In-Reply-To: <20200615132244.GR2531@hirez.programming.kicks-ass.net>
References: <cover.1592225557.git.christophe.leroy@csgroup.eu> <341688399c1b102756046d19ea6ce39db1ae4742.1592225558.git.christophe.leroy@csgroup.eu> <20200615132244.GR2531@hirez.programming.kicks-ass.net>
Date:   Thu, 18 Jun 2020 00:21:22 +1000
Message-ID: <87wo45db8d.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:
> On Mon, Jun 15, 2020 at 12:57:59PM +0000, Christophe Leroy wrote:
>> READ_ONCE() now enforces atomic read, which leads to:
>
>> Fixes: 2ab3a0a02905 ("READ_ONCE: Enforce atomicity for {READ,WRITE}_ONCE() memory accesses")
>> Cc: Will Deacon <will@kernel.org>
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> ---
>>  arch/powerpc/include/asm/nohash/32/pgtable.h | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>> 
>> diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
>> index b56f14160ae5..77addb599ce7 100644
>> --- a/arch/powerpc/include/asm/nohash/32/pgtable.h
>> +++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
>> @@ -286,6 +286,16 @@ static inline pte_t ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
>>  	return __pte(pte_update(mm, addr, ptep, ~0, 0, 0));
>>  }
>>  
>> +#if defined(CONFIG_PPC_8xx) && defined(CONFIG_PPC_16K_PAGES)
>> +#define __HAVE_ARCH_PTEP_GET
>> +static inline pte_t ptep_get(pte_t *ptep)
>> +{
>> +	pte_t pte = {READ_ONCE(ptep->pte), 0, 0, 0};
>> +
>> +	return pte;
>> +}
>> +#endif
>
> Would it make sense to have a comment with this magic? The casual reader
> might wonder WTH just happened when he stumbles on this :-)

I tried writing a helpful comment but it's too late for my brain to form
sensible sentences.

Christophe can you send a follow-up with a comment explaining it? In
particular the zero entries stand out, it's kind of subtle that those
entries are only populated with the right value when we write to the
page table.

cheers
