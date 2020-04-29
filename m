Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 809C7C83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 18:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64B2F2072A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 18:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="f42xaq0v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgD2SfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 14:35:24 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:49245 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726456AbgD2SfY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 14:35:24 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 49C6dQ5PGTz9vBJp;
        Wed, 29 Apr 2020 20:35:22 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=f42xaq0v; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id TswvTeYISwmU; Wed, 29 Apr 2020 20:35:22 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 49C6dQ3hXCz9vBJn;
        Wed, 29 Apr 2020 20:35:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1588185322; bh=sIfYf0j48uBfXDJpyWR7ybHRDv0EMtWI1mQFSLuL7SY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=f42xaq0vAMNu/h83QvG9I3UBt+iWYECC+3YzXGi40/6Zjd5sSZkFykiYlkDA2TvP2
         7GA2RtEgtL745ipZxvu+L+mjRLLbsdkkVxZJBqhM/eT9oG363OZQB/R26v/Qjpl2aZ
         rBnYHjViNEuwRfBtrKqpEQgkZdPYQKo6uEWz0U/M=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7B7328B8D9;
        Wed, 29 Apr 2020 20:35:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ijXr73YsbsvL; Wed, 29 Apr 2020 20:35:22 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 580548B8CD;
        Wed, 29 Apr 2020 20:35:20 +0200 (CEST)
Subject: Re: [LKP] Re: [mm/debug] fa6726c1e7: kernel_BUG_at_include/linux/mm.h
To:     Catalin Marinas <catalin.marinas@arm.com>,
        "Chen, Rong A" <rong.a.chen@intel.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Qian Cai <cai@lca.pw>, kernel test robot <lkp@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
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
References: <9e9091b9-6918-d0af-dd92-3bdc0e29a4d5@arm.com>
 <813D7CD3-F31C-4056-92DF-D462633E9D69@lca.pw> <20200428092105.GB3868@gaia>
 <b62c66c8-1550-087f-f5d2-b33a18bb0edc@arm.com>
 <07ea0efd-0145-eaaf-c628-e48957154a2c@intel.com>
 <20200429181550.GF10651@gaia>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <410b5235-bbd0-6cff-c361-c25665a854ae@c-s.fr>
Date:   Wed, 29 Apr 2020 20:34:17 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200429181550.GF10651@gaia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 29/04/2020 à 20:15, Catalin Marinas a écrit :
> On Wed, Apr 29, 2020 at 08:52:25PM +0800, Chen, Rong A wrote:
>> On 4/29/2020 11:28 AM, Anshuman Khandual wrote:
>>> On 04/28/2020 02:51 PM, Catalin Marinas wrote:
>>>> On Tue, Apr 28, 2020 at 04:41:11AM -0400, Qian Cai wrote:
>>>>> On Apr 28, 2020, at 1:54 AM, Anshuman Khandual <Anshuman.Khandual@arm.com> wrote:
>>>>>> That is true. There is a slight change in the rules, making it explicit yes
>>>>>> only when both ARCH_HAS_DEBUG_VM_PGTABLE and DEBUG_VM are enabled.
>>>>>>
>>>>>> +config DEBUG_VM_PGTABLE
>>>>>> +    bool "Debug arch page table for semantics compliance"
>>>>>> +    depends on MMU
>>>>>> +    depends on !IA64 && !ARM
>>>>>> +    depends on ARCH_HAS_DEBUG_VM_PGTABLE || EXPERT
>>>>>> +    default y if ARCH_HAS_DEBUG_VM_PGTABLE && DEBUG_VM
>>>>>> +    help
>>>>>>
>>>>>> The default is really irrelevant as the config option can be set explicitly.
>>>>> That could also explain. Since not long time ago, it was only “default
>>>>> y if DEBUG_VM”, that caused the robot saved a .config with
>>>>> DEBUG_VM_PGTABLE=y by default.
>>>>>
>>>>> Even though you changed the rule recently, it has no effect as the
>>>>> robot could “make oldconfig” from the saved config for each linux-next
>>>>> tree execution and the breakage will go on.
>>>> I'm not entirely sure that's the case. This report still points at the
>>>> old commit fa6726c1e7 which has:
>>>>
>>>> +       depends on ARCH_HAS_DEBUG_VM_PGTABLE || EXPERT
>>>> +       default n if !ARCH_HAS_DEBUG_VM_PGTABLE
>>>> +       default y if DEBUG_VM
>>>>
>>>> In -next we now have commit 647d9a0de34c and subsequently modified by
>>>> commit 0a8646638865. So hopefully with the latest -next tree we won't
>>>> see this report.
>>> Could some one from LKP test framework, please confirm if this still causes
>>> above problem on the latest linux-next by default ?
>>
>> The .config is a rand config, the problem is still exist if run "make
>> oldconfig" for the config with commit 0a8646638865.
> 
> Is randconfig expected to boot? I don't think it is but I guess it
> should not trigger a BUG_ON during boot.
> 
>> $ grep -e CONFIG_MMU= -e CONFIG_EXPERT= -e CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=
>> -e CONFIG_DEBUG_VM= .config
>> CONFIG_EXPERT=y
>> CONFIG_MMU=y
>> CONFIG_DEBUG_VM=y
>>
>> should we disable DEBUG_VM_PGTABLE by default?
> 
> If that's the only case where this fails in LKP, I'd rather remove the
> EXPERT dependency so that it cannot be enabled. Architectures that want
> to experiment with this feature will have to select
> ARCH_HAS_DEBUG_VM_PGTABLE explicitly.
> 

But when something is not selectable, people won't even know it exists.

Why not try and fix the problems reported by the robots instead ?
