Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0500C3F2D7
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 04:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76B4E2084E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 04:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="e/Ei7Y5I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgCFEuy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 23:50:54 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37270 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbgCFEuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 23:50:54 -0500
Received: by mail-qk1-f196.google.com with SMTP id y126so1188895qke.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 20:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0wipnWw1cldWf5kaoeA+yDqtsFNc3E5tyyjbRgywYFs=;
        b=e/Ei7Y5Ik8WM1Taux+DExv+Jv/Fqylv3LWaQkFS1tZS+VrdFV5zge1M+oSCL4N6nh1
         kqFutv0Jhd1kKJrkscv0XC4U8PWfWKvyp3UwW0tl0lYe99dOzId8l7/YWA1Xv+08VLY7
         hDJuO8ZOTI4vrG1s7V8krX9kJIqrXheC0YSn2thFWrdtdf55B18kKm6SouQ/651zKGQe
         w6qrjn9AzZRZiIJD/tYfimUsaWF6T2SnV5KzAUzqTJ6hVwCwgw3BQORlcmjO/INQpYpH
         /OGE6z0l6tphlsbCSsGA6ecMIRTXWlG6RPo9hVW3aJY8iZn1Laz5XEu2ALoMD9XX1pJD
         Lltg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0wipnWw1cldWf5kaoeA+yDqtsFNc3E5tyyjbRgywYFs=;
        b=OYH4mzsBjtCd9oDPLJxLDkn/EGtUJwo/p1NKbkP8WNbHibuVutcdHcgG6PZxhIiygL
         +XzioQcUqO2CrRBJZs9yB/zbM1WPEk8r7h97/Pl89zhisXbKiNII2EGCrsFIGriX8n70
         /T4QawN1dODurTCTGRnJ041P5GgQZt1cFK3bhM+GSjqAdS9StZeVXDTBU4Wkt1BzRoqC
         cFXr39tVuNeJkqrq5TZRqHnP0ibHcfPJE5xmEQj8z8zNWcpgdelQvvQsYBqWwssHHr90
         44TdysiHioVMcL3AMsEGf9LZebIAcxZMUCFyn+FaUD8iRJMO9wHwB+Ej4CPgS0KgOZ1q
         X9Gw==
X-Gm-Message-State: ANhLgQ08rp283SA2pMZoOVuUOTlAQvKi586PTTnDQBo944v/puJo5eyE
        nge/viyP+NC5IZolwkepQs6g4Q==
X-Google-Smtp-Source: ADFU+vtic/BvcsQbXvszV0ThZDIcumBI/9MYEWzwIe8iZkHUwmR0NoS2w+h/h8sIk6M2DubtQ4nVmA==
X-Received: by 2002:a37:a08b:: with SMTP id j133mr1326092qke.265.1583470253067;
        Thu, 05 Mar 2020 20:50:53 -0800 (PST)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id b5sm7520197qkk.16.2020.03.05.20.50.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Mar 2020 20:50:52 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH -next v2] powerpc/64s/pgtable: fix an undefined behaviour
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <a082f4c3-db68-6ca3-c832-b1abb5363e3a@c-s.fr>
Date:   Thu, 5 Mar 2020 23:50:51 -0500
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>, rashmicy@gmail.com,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A40C59F0-B4E2-4A6B-B3AF-0173C93DEB9C@lca.pw>
References: <1583418759-16105-1-git-send-email-cai@lca.pw>
 <a082f4c3-db68-6ca3-c832-b1abb5363e3a@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 5, 2020, at 2:22 PM, Christophe Leroy <christophe.leroy@c-s.fr> =
wrote:
>=20
>=20
>=20
> Le 05/03/2020 =C3=A0 15:32, Qian Cai a =C3=A9crit :
>> Booting a power9 server with hash MMU could trigger an undefined
>> behaviour because pud_offset(p4d, 0) will do,
>> 0 >> (PAGE_SHIFT:16 + PTE_INDEX_SIZE:8 + H_PMD_INDEX_SIZE:10)
>> Fix it by converting pud_offset() and friends to static inline
>> functions.
>=20
> I was suggesting to convert pud_index() to static inline, because =
that's where the shift sits. Is it not possible ?
>=20
> Here you seems to fix the problem for now, but if someone reuses =
pud_index() in another macro one day, the same problem may happen again.
>=20

Sounds reasonable. I send out a v3,

https://lore.kernel.org/lkml/20200306044852.3236-1-cai@lca.pw/T/#u

> Christophe
>=20
>>  UBSAN: shift-out-of-bounds in arch/powerpc/mm/ptdump/ptdump.c:282:15
>>  shift exponent 34 is too large for 32-bit type 'int'
>>  CPU: 6 PID: 1 Comm: swapper/0 Not tainted 5.6.0-rc4-next-20200303+ =
#13
>>  Call Trace:
>>  dump_stack+0xf4/0x164 (unreliable)
>>  ubsan_epilogue+0x18/0x78
>>  __ubsan_handle_shift_out_of_bounds+0x160/0x21c
>>  walk_pagetables+0x2cc/0x700
>>  walk_pud at arch/powerpc/mm/ptdump/ptdump.c:282
>>  (inlined by) walk_pagetables at arch/powerpc/mm/ptdump/ptdump.c:311
>>  ptdump_check_wx+0x8c/0xf0
>>  mark_rodata_ro+0x48/0x80
>>  kernel_init+0x74/0x194
>>  ret_from_kernel_thread+0x5c/0x74
>> Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> Signed-off-by: Qian Cai <cai@lca.pw>
>> ---
>>  arch/powerpc/include/asm/book3s/64/pgtable.h | 20 =
++++++++++++++------
>>  1 file changed, 14 insertions(+), 6 deletions(-)
>> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h =
b/arch/powerpc/include/asm/book3s/64/pgtable.h
>> index fa60e8594b9f..4967bc9e25e2 100644
>> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
>> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
>> @@ -1016,12 +1016,20 @@ static inline bool p4d_access_permitted(p4d_t =
p4d, bool write)
>>    #define pgd_offset(mm, address)	 ((mm)->pgd + =
pgd_index(address))
>>  -#define pud_offset(p4dp, addr)	\
>> -	(((pud_t *) p4d_page_vaddr(*(p4dp))) + pud_index(addr))
>> -#define pmd_offset(pudp,addr) \
>> -	(((pmd_t *) pud_page_vaddr(*(pudp))) + pmd_index(addr))
>> -#define pte_offset_kernel(dir,addr) \
>> -	(((pte_t *) pmd_page_vaddr(*(dir))) + pte_index(addr))
>> +static inline pud_t *pud_offset(p4d_t *p4d, unsigned long address)
>> +{
>> +	return (pud_t *)p4d_page_vaddr(*p4d) + pud_index(address);
>> +}
>> +
>> +static inline pmd_t *pmd_offset(pud_t *pud, unsigned long address)
>> +{
>> +	return (pmd_t *)pud_page_vaddr(*pud) + pmd_index(address);
>> +}
>> +
>> +static inline pte_t *pte_offset_kernel(pmd_t *pmd, unsigned long =
address)
>> +{
>> +	return (pte_t *)pmd_page_vaddr(*pmd) + pte_index(address);
>> +}
>>    #define pte_offset_map(dir,addr)	pte_offset_kernel((dir), (addr))
>> =20

