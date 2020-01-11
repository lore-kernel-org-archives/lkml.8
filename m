Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C63E9C33CA4
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 15:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99A212072E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 15:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="AhT1+njd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730132AbgAKPyA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 10:54:00 -0500
Received: from mout.gmx.net ([212.227.15.15]:33229 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730094AbgAKPyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 10:54:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1578758004;
        bh=0kBdLR9wkohCtOta6IygwqGSte/SYe8ZDcZ4u9MqqKM=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=AhT1+njdEmzkt3WAtJ5CcE7f1eOg/C/CxDJUlT8IzhuIThkmgFk6g77LRbmakeUIc
         /syOmARz4To8rpFIjsgmSJCDZ7n1JRYBjs1M76wCuh1TVizsyX4AsgHRGMuVem5ORU
         QJh5xG0+fF/pqKYixvLZkBu/8O3qotRGuYHmncY8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.148.185]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MDQiS-1j0iOY29ry-00AXUL; Sat, 11
 Jan 2020 16:53:24 +0100
Subject: Re: [PATCH] parisc: fix map_pages() to actually populate upper
 directory
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Mike Rapoport <rppt@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Meelis Roos <mroos@linux.ee>, Jeroen Roovers <jer@gentoo.org>,
        Mikulas Patocka <mpatocka@redhat.com>
References: <20200108125852.19823-1-rppt@kernel.org>
 <20200109065055.GA13038@ls3530.fritz.box>
 <20200109084513.GA11067@linux.ibm.com>
From:   Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
 c2TFWAS8k6RLkk41ZUU8ENX8+qZx/Q==
Message-ID: <56969e89-2f86-a50d-1e6f-7360527da54b@gmx.de>
Date:   Sat, 11 Jan 2020 16:53:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200109084513.GA11067@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Q+nCy/TnFGzuFJyAklFQ4CuyGVMmwR/MeKvIxNC+XJ1FlFM2kl7
 KS90feEzXABJ0KUD8DeUFcI19geJCxiZZpP8ccRRIfe/lmdeaY0BX4eQPRK70Fu+13pT2Q9
 OXcXhqJdV0H2YNTH1jBtzsIYfcKHm/CQnX5RORGcd1B7F7t9G1+RiGWi57qTuJ6yBKz+D7C
 H99fllu3nSN/BFivIMhQA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1fXNigJvbno=:Po/g0+M3aRDX9CiLvkXhMk
 PhokdSRzrxm4sicrdZnXMsBMjOICIeiKPdfP9sorcjyzh5WUq9Ys4QCJc4AnbJv2pzqrUPk2x
 jHK43PTKBEeQR5n2jSnfCuidcUL49PlzQjKR0feuaCNLV7a3Z/FdjKSGLMSBrSGVOtD/Iz/Sy
 Rebv8JR4ev4WvGQdx3ObONm3VGql3HUDuIdARYkl+KUqvy22jbTeNgyiDtRk/z8nY1QkOSTCo
 7ZtMKJonQC2P192LmEeI7lEmvjNL4ky2MzL78m7sZ3cRXxtT1CzM5jYthnYMWRVwOiSC2pNat
 x7+HkaZBnykrWLJLkDpGce/G79xV16aUecPQ2WIBCjErsIJxaYlJnzBeYn1X6EKgWLC0tzHuc
 4h+U0aobc7MThESqaQBNYBXzjl+wnHjAplacxktF45fOAuUtetaCv1tXm93tloKxLkgxZSKJs
 21TO8l7K4NN7dlL+5tNHiWH29ASIXVjpl0Jhc2exAZEllo8Zgpe/jyK7Wa7J49ydwvioDVPqy
 wGKoWL5JBOpZH8DdaLlojXr9cKrkL6zzg1N6/3G6fRZ3pVJCzT9eaiHNFPwXLNyymEzAeYQZH
 opJLJ5932Bm67UNdz2xg55KHC58vDbsVwWJJyGlIywC3NI34DSTRPdkKHRxpc4mx6GGwBjWIs
 c2zD6Qf6lGTA8vHxQTpo+UNbIfG7OBzXjFYxvl8wtutQW1rDmMxxDrHurcbjno852JCvrMckS
 j66DSRB94rHSVsoEyj8Di6fyyV7S0s10fFXojbLea5SaVkKwrSHc74QZtVyfD+SD0Clr2FFyS
 2wyx/qoIEzKKQKRKyTcxOKgwbT+noDi4rAf9Lyf4xZowqCLy7fNc3VnKdfaAqjJBcIg14oOJS
 gFMcsyZz2ukfSWfcJHsCuJPRY2FT/rBZIJECyYs/qJhYERgZGNE1B3dBPnn2wyxrCBB7vlNE+
 A5TUu7KggV0c7oY3b56b6uhc43W591WNfTubSeHDrCILmB2/4BjyX+toa3oBySh0/d4AVA7Xy
 IisUEhp6H+kx+yLIsrukPYurnk9ticNAkVS7HtzquPlVOmDO4QlnTQdTdGHhQT31TZkurbC2W
 AaeSCSoCAE60b5y8qGBqnDR6kAkKuWoELwRdTRNfq6ax6wT4zk3Bv0Tjy3EFNIg7uQTkhP12r
 nnJ3tYuVSQbfupDhkQohuLa9DcNwd+Zh4Ma0yJU4DNnlCYZxZYOSCqI9ZcpbSBQklf7pZeJyP
 n8kbUCfREMEjxuL8iYJjfHvtYYMsFPbhCvOdzdw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.01.20 09:45, Mike Rapoport wrote:
> Hi,
>
> On Thu, Jan 09, 2020 at 07:50:55AM +0100, Helge Deller wrote:
>>> The commit d96885e277b5 ("parisc: use pgtable-nopXd instead of
>>> 4level-fixup") converted PA-RISC to use folded page tables, but it mis=
sed
>>> the conversion of pgd_populate() to pud_populate() in maps_pages()
>>> function. This caused the upper page table directory to remain empty a=
nd
>>> the system would crash as a result.
>>>
>>> Using pud_populate() that actually populates the page table instead of
>>> dummy pgd_populate() fixes the issue.
>>> ...
>>> diff --git a/arch/parisc/mm/init.c b/arch/parisc/mm/init.c
>>> index ddca8287d43b..354cf060b67f 100644
>>> --- a/arch/parisc/mm/init.c
>>> +++ b/arch/parisc/mm/init.c
>>> @@ -401,7 +401,7 @@ static void __init map_pages(unsigned long start_v=
addr,
>>>  			pmd =3D (pmd_t *) __pa(pmd);
>>>  		}
>>>
>>> -		pgd_populate(NULL, pg_dir, __va(pmd));
>>> +		pud_populate(NULL, (pud_t *)pg_dir, __va(pmd));
>>>  #endif
>>
>> Wouldn't the untested patch below be more clean?
>>
>> Helge
>>
>> diff --git a/arch/parisc/mm/init.c b/arch/parisc/mm/init.c
>> index ddca8287d43b..73de58f31f5f 100644
>> --- a/arch/parisc/mm/init.c
>> +++ b/arch/parisc/mm/init.c
>> @@ -387,6 +387,8 @@ static void __init map_pages(unsigned long start_va=
ddr,
>>  #if PTRS_PER_PMD =3D=3D 1
>>  		pmd =3D (pmd_t *)__pa(pg_dir);
>>  #else
>> +		p4d_t *p4d;
>> +		pud_t *pud;
>>  		pmd =3D (pmd_t *)pgd_address(*pg_dir);
>>
>>  		/*
>> @@ -401,7 +403,9 @@ static void __init map_pages(unsigned long start_va=
ddr,
>>  			pmd =3D (pmd_t *) __pa(pmd);
>>  		}
>>
>> -		pgd_populate(NULL, pg_dir, __va(pmd));
>> +		p4d =3D p4d_offset(pg_dir, vaddr);
>> +		pud =3D pud_offset(p4d, vaddr);
>> +		pud_populate(NULL, pud, __va(pmd));
>>  #endif
>>  		pg_dir++;
>
> I've tried to keep the changes to minimum :)
> Otherwise I'd go with something even more surgical:


Ok, then let's use the small fix for v5.5, and the bigger one for v5.6.
I'll push the small fixup to Linux through the parisc tree shortly.

Would you mind resending the full cleanup patch for v5.6 later again ?

Thanks!!
Helge

>
> diff --git a/arch/parisc/mm/init.c b/arch/parisc/mm/init.c
> index 354cf060b67f..94baa4382c29 100644
> --- a/arch/parisc/mm/init.c
> +++ b/arch/parisc/mm/init.c
> @@ -351,7 +351,6 @@ static void __init map_pages(unsigned long start_vad=
dr,
>  			     unsigned long start_paddr, unsigned long size,
>  			     pgprot_t pgprot, int force)
>  {
> -	pgd_t *pg_dir;
>  	pmd_t *pmd;
>  	pte_t *pg_table;
>  	unsigned long end_paddr;
> @@ -372,8 +371,6 @@ static void __init map_pages(unsigned long start_vad=
dr,
>
>  	end_paddr =3D start_paddr + size;
>
> -	pg_dir =3D pgd_offset_k(start_vaddr);
> -
>  #if PTRS_PER_PMD =3D=3D 1
>  	start_pmd =3D 0;
>  #else
> @@ -384,50 +381,30 @@ static void __init map_pages(unsigned long start_v=
addr,
>  	address =3D start_paddr;
>  	vaddr =3D start_vaddr;
>  	while (address < end_paddr) {
> -#if PTRS_PER_PMD =3D=3D 1
> -		pmd =3D (pmd_t *)__pa(pg_dir);
> -#else
> -		pmd =3D (pmd_t *)pgd_address(*pg_dir);
> +		pgd_t *pgd =3D pgd_offset_k(vaddr);
> +		p4d_t *p4d =3D p4d_offset(pgd, vaddr);
> +		pud_t *pud =3D pud_offset(p4d, vaddr);
>
> -		/*
> -		 * pmd is physical at this point
> -		 */
> -
> -		if (!pmd) {
> +#if CONFIG_PGTABLE_LEVELS =3D=3D 3
> +		if (pud_none(*pud)) {
>  			pmd =3D memblock_alloc(PAGE_SIZE << PMD_ORDER,
>  					     PAGE_SIZE << PMD_ORDER);
>  			if (!pmd)
>  				panic("pmd allocation failed.\n");
> -			pmd =3D (pmd_t *) __pa(pmd);
> +			pud_populate(NULL, pud, pmd);
>  		}
> -
> -		pud_populate(NULL, (pud_t *)pg_dir, __va(pmd));
>  #endif
> -		pg_dir++;
>
> -		/* now change pmd to kernel virtual addresses */
> -
> -		pmd =3D (pmd_t *)__va(pmd) + start_pmd;
> +		pmd =3D pmd_offset(pud, vaddr);
>  		for (tmp1 =3D start_pmd; tmp1 < PTRS_PER_PMD; tmp1++, pmd++) {
> -
> -			/*
> -			 * pg_table is physical at this point
> -			 */
> -
> -			pg_table =3D (pte_t *)pmd_address(*pmd);
> -			if (!pg_table) {
> -				pg_table =3D memblock_alloc(PAGE_SIZE,
> -							  PAGE_SIZE);
> +			if (pmd_none(*pmd)) {
> +				pg_table =3D memblock_alloc(PAGE_SIZE, PAGE_SIZE);
>  				if (!pg_table)
>  					panic("page table allocation failed\n");
> -				pg_table =3D (pte_t *) __pa(pg_table);
> +				pmd_populate_kernel(NULL, pmd, pg_table);
>  			}
>
> -			pmd_populate_kernel(NULL, pmd, __va(pg_table));
> -
> -			/* now change pg_table to kernel virtual addresses */
> -
> -			pg_table =3D (pte_t *) __va(pg_table) + start_pte;
> +			pg_table =3D pte_offset_kernel(pmd, vaddr);
>  			for (tmp2 =3D start_pte; tmp2 < PTRS_PER_PTE; tmp2++, pg_table++) {
>  				pte_t pte;
>  				pgprot_t prot;
>
>

