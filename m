Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB3DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C1E3207E8
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730741AbgFROWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 10:22:15 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:29808 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728033AbgFROWO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 10:22:14 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 49nkf96Dz2z9v22D;
        Thu, 18 Jun 2020 16:22:09 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id fKTzY7i6T9qx; Thu, 18 Jun 2020 16:22:09 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 49nkf95BPcz9v22C;
        Thu, 18 Jun 2020 16:22:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B04C78B84F;
        Thu, 18 Jun 2020 16:22:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ibpuocsAlwuq; Thu, 18 Jun 2020 16:22:11 +0200 (CEST)
Received: from [10.25.210.22] (po15451.idsi0.si.c-s.fr [10.25.210.22])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5B6938B849;
        Thu, 18 Jun 2020 16:22:11 +0200 (CEST)
Subject: Re: [PATCH 3/3] powerpc/8xx: Provide ptep_get() with 16k pages
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org
References: <cover.1592225557.git.christophe.leroy@csgroup.eu>
 <341688399c1b102756046d19ea6ce39db1ae4742.1592225558.git.christophe.leroy@csgroup.eu>
 <20200615132244.GR2531@hirez.programming.kicks-ass.net>
 <87wo45db8d.fsf@mpe.ellerman.id.au>
 <20200617143826.GJ2531@hirez.programming.kicks-ass.net>
 <87pn9xchql.fsf@mpe.ellerman.id.au>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <baa6c8bc-1d2e-d714-8dee-5d97a643f5ee@csgroup.eu>
Date:   Thu, 18 Jun 2020 16:21:16 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <87pn9xchql.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 18/06/2020 à 02:58, Michael Ellerman a écrit :
> Peter Zijlstra <peterz@infradead.org> writes:
>> On Thu, Jun 18, 2020 at 12:21:22AM +1000, Michael Ellerman wrote:
>>> Peter Zijlstra <peterz@infradead.org> writes:
>>>> On Mon, Jun 15, 2020 at 12:57:59PM +0000, Christophe Leroy wrote:
>>
>>>>> +#if defined(CONFIG_PPC_8xx) && defined(CONFIG_PPC_16K_PAGES)
>>>>> +#define __HAVE_ARCH_PTEP_GET
>>>>> +static inline pte_t ptep_get(pte_t *ptep)
>>>>> +{
>>>>> +	pte_t pte = {READ_ONCE(ptep->pte), 0, 0, 0};
>>>>> +
>>>>> +	return pte;
>>>>> +}
>>>>> +#endif
>>>>
>>>> Would it make sense to have a comment with this magic? The casual reader
>>>> might wonder WTH just happened when he stumbles on this :-)
>>>
>>> I tried writing a helpful comment but it's too late for my brain to form
>>> sensible sentences.
>>>
>>> Christophe can you send a follow-up with a comment explaining it? In
>>> particular the zero entries stand out, it's kind of subtle that those
>>> entries are only populated with the right value when we write to the
>>> page table.
>>
>> static inline pte_t ptep_get(pte_t *ptep)
>> {
>> 	unsigned long val = READ_ONCE(ptep->pte);
>> 	/* 16K pages have 4 identical value 4K entries */
>> 	pte_t pte = {val, val, val, val);
>> 	return pte;
>> }
>>
>> Maybe something like that?
> 
> I think val wants to be pte_basic_t, but otherwise yeah I like that much
> better.
> 

I sent a patch for that.

I'll also send one to fix mm/debug_vm_pgtable.c which also uses 
READ_ONCE() to access page table entries.

Christophe
