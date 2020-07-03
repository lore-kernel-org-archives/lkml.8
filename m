Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B36C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 05:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81BED20772
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 05:15:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbgGCFPb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 01:15:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:57886 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbgGCFPb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 01:15:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 33B3FB03E;
        Fri,  3 Jul 2020 05:15:29 +0000 (UTC)
Subject: Re: [PATCH v2 1/4] x86/xen: remove 32-bit Xen PV guest support
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Stefano Stabellini <sstabellini@kernel.org>
References: <20200701110650.16172-1-jgross@suse.com>
 <20200701110650.16172-2-jgross@suse.com>
 <6d0b517a-6c53-61d3-117b-40e33e013037@oracle.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <96159aed-9fdb-9fcb-a1b1-7c6c2c47e6a1@suse.com>
Date:   Fri, 3 Jul 2020 07:15:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <6d0b517a-6c53-61d3-117b-40e33e013037@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.07.20 00:59, Boris Ostrovsky wrote:
> On 7/1/20 7:06 AM, Juergen Gross wrote:
>> Xen is requiring 64-bit machines today and since Xen 4.14 it can be
>> built without 32-bit PV guest support. There is no need to carry the
>> burden of 32-bit PV guest support in the kernel any longer, as new
>> guests can be either HVM or PVH, or they can use a 64 bit kernel.
>>
>> Remove the 32-bit Xen PV support from the kernel.
>>
>> Signed-off-by: Juergen Gross <jgross@suse.com>
>> ---
>>   arch/x86/entry/entry_32.S      | 109 +----------
>>   arch/x86/include/asm/proto.h   |   2 +-
>>   arch/x86/include/asm/segment.h |   2 +-
>>   arch/x86/kernel/head_32.S      |  31 ---
>>   arch/x86/xen/Kconfig           |   3 +-
>>   arch/x86/xen/Makefile          |   3 +-
>>   arch/x86/xen/apic.c            |  17 --
>>   arch/x86/xen/enlighten_pv.c    |  48 +----
> 
> 
> Should we drop PageHighMem() test in set_aliased_prot()?
> 
> 
> (And there are few other places where is is used, in mmu_pv.c)

Yes, will drop those.

> 
> 
> 
>> @@ -555,13 +547,8 @@ static void xen_load_tls(struct thread_struct *t, unsigned int cpu)
>>   	 * exception between the new %fs descriptor being loaded and
>>   	 * %fs being effectively cleared at __switch_to().
>>   	 */
>> -	if (paravirt_get_lazy_mode() == PARAVIRT_LAZY_CPU) {
>> -#ifdef CONFIG_X86_32
>> -		lazy_load_gs(0);
>> -#else
> 
> 
> I think this also needs an adjustment to the preceding comment.

Yes.

> 
> 
>>   
>> -#ifdef CONFIG_X86_PAE
>> -static void xen_set_pte_atomic(pte_t *ptep, pte_t pte)
>> -{
>> -	trace_xen_mmu_set_pte_atomic(ptep, pte);
>> -	__xen_set_pte(ptep, pte);
> 
> 
> Probably not for this series but I wonder whether __xen_set_pte() should
> continue to use hypercall now that we are 64-bit only.

As Andrew wrote already the hypercall will be cheaper.

I'll adjust the comment, though.

> 
> 
>> @@ -654,14 +621,12 @@ static int __xen_pgd_walk(struct mm_struct *mm, pgd_t *pgd,
> 
> 
> Comment above should be updated.

Yes.


Juergen
