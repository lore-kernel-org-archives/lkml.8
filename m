Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1294C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 06:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F4C6206D9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 06:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="COI23NhG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbgD1GNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 02:13:00 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:55710 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726258AbgD1GNA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 02:13:00 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 49BBCF0Xcfz9tyF2;
        Tue, 28 Apr 2020 08:12:57 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=COI23NhG; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 4r37Lc1vIQHO; Tue, 28 Apr 2020 08:12:57 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 49BBCD5PjBz9tyF4;
        Tue, 28 Apr 2020 08:12:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1588054376; bh=+ZMvexP9svzyr579SUVlBPFWwl34Ct5wXGNoazNmR9o=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=COI23NhGwCF/YQ1hVnxHFehdbXTfVgF+9IMqnFRwHbTKNg89yheUHYWiE5bHfeR8Y
         QNkH8xUxOSoNI6VghNO/uOjspN/Kjxy4op9Xp++mM93Wx/UR/sB4G24b0Y9mE5sYqJ
         rdKZ5HnUVbv+Yu8AHr4k3x/HVFKbGP6c7I5KrBLc=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A7D808B7ED;
        Tue, 28 Apr 2020 08:12:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id gL1unGRV9f8Z; Tue, 28 Apr 2020 08:12:57 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 19AF18B75F;
        Tue, 28 Apr 2020 08:12:56 +0200 (CEST)
Subject: Re: [mm/debug] fa6726c1e7: kernel_BUG_at_include/linux/mm.h
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Qian Cai <cai@lca.pw>
Cc:     kernel test robot <lkp@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
References: <096a07fc-4525-feb6-5658-40bcffbd0a58@arm.com>
 <D30E4C88-408A-438B-803B-D9F8F82D87A7@lca.pw>
 <b3e5d138-9e14-826c-82c9-2cec9bd41ca5@c-s.fr>
 <9e9091b9-6918-d0af-dd92-3bdc0e29a4d5@arm.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <018a6f32-5cf6-b38c-7b8c-78b6e5c2d98d@c-s.fr>
Date:   Tue, 28 Apr 2020 08:12:48 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <9e9091b9-6918-d0af-dd92-3bdc0e29a4d5@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 28/04/2020 à 07:53, Anshuman Khandual a écrit :
> 
> 
> On 04/28/2020 10:54 AM, Christophe Leroy wrote:
>>
>>
>> Le 28/04/2020 à 04:51, Qian Cai a écrit :
>>>
>>>
>>>> On Apr 27, 2020, at 10:35 PM, Anshuman Khandual <Anshuman.Khandual@arm.com> wrote:
>>>>
>>>> Letting CONFIG_DEBUG_VM_PGTABLE enabled via CONFIG_EXPERT for unsupported
>>>> platforms i.e without ARCH_HAS_DEBUG_VM_PGTABLE, was a conscious decision
>>>> meant to expand it's adaptability and coverage without requiring any code
>>>> (i.e Kconfig) change. The easier it is to enable the test on unsupported
>>>> platforms right now, more folks are likely to try it out thus increasing
>>>> it's probability to get fixed on those platforms. That is a valid enough
>>>> reason to have CONFIG_EXPERT based enablement method, IMHO. Also even with
>>>> CONFIG_EXPERT set, CONFIG_DEBUG_VM_PGTABLE does not get enabled by default
>>>> automatically.
>>>
>>> No, I am talking about PAE. There is a distinction between known broken that nobody cares (like arm32) and in-progress/unknown status (like s390).
>>>
>>> Also, it is not very nice to introduce regressions for robots when testing PAE because they always select CONFIG__EXPERT and CONFIG_DEBUG_VM.
>>>
>>
>> Having CONFIG_EXPERT and CONFIG_DEBUG_VM is not enough to get CONFIG_DEBUG_VM_PGTABLE set to yes.
> 
> Not automatically, that is right. But it can be set if required. Seems like
> the testing robots can and will test with each and every config whether they
> are enabled by default or not. So if we really need to prevent all possible
> testing robot regressions, X86_PAE needs to be disabled completely.
> 
>>
>> By default, CONFIG_DEBUG_VM_PGTABLE is set to no when ARCH_HAS_DEBUG_VM_PGTABLE is not set.
> 
> That is true. There is a slight change in the rules, making it explicit yes
> only when both ARCH_HAS_DEBUG_VM_PGTABLE and DEBUG_VM are enabled.
> 
> +config DEBUG_VM_PGTABLE
> +	bool "Debug arch page table for semantics compliance"
> +	depends on MMU
> +	depends on !IA64 && !ARM
> +	depends on ARCH_HAS_DEBUG_VM_PGTABLE || EXPERT
> +	default y if ARCH_HAS_DEBUG_VM_PGTABLE && DEBUG_VM
> +	help
> 
> The default is really irrelevant as the config option can be set explicitly.
> 

Yes but Qian was saying: "Also, it is not very nice to introduce 
regressions for robots when testing PAE because they always select 
CONFIG__EXPERT and CONFIG_DEBUG_VM"

Here we see that the said regression is not introduced because they 
select CONFIG__EXPERT and CONFIG_DEBUG_VM. This is because the robots 
explicitely select DEBUG_VM_PGTABLE.

Christophe
