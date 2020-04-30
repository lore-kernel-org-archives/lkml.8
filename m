Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B0FC83003
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 02:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60EE62083B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 02:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgD3CjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 22:39:16 -0400
Received: from foss.arm.com ([217.140.110.172]:47894 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726180AbgD3CjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 22:39:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB4261063;
        Wed, 29 Apr 2020 19:39:14 -0700 (PDT)
Received: from [10.163.71.104] (unknown [10.163.71.104])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1F5413F68F;
        Wed, 29 Apr 2020 19:39:07 -0700 (PDT)
Subject: Re: [LKP] Re: [mm/debug] fa6726c1e7: kernel_BUG_at_include/linux/mm.h
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Chen, Rong A" <rong.a.chen@intel.com>
Cc:     Qian Cai <cai@lca.pw>, kernel test robot <lkp@intel.com>,
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
 <20200429181550.GF10651@gaia> <410b5235-bbd0-6cff-c361-c25665a854ae@c-s.fr>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <444b9424-f1e1-2587-6d46-9848478d51e2@arm.com>
Date:   Thu, 30 Apr 2020 08:08:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <410b5235-bbd0-6cff-c361-c25665a854ae@c-s.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/30/2020 12:04 AM, Christophe Leroy wrote:
> 
> 
> Le 29/04/2020 à 20:15, Catalin Marinas a écrit :
>> On Wed, Apr 29, 2020 at 08:52:25PM +0800, Chen, Rong A wrote:
>>> On 4/29/2020 11:28 AM, Anshuman Khandual wrote:
>>>> On 04/28/2020 02:51 PM, Catalin Marinas wrote:
>>>>> On Tue, Apr 28, 2020 at 04:41:11AM -0400, Qian Cai wrote:
>>>>>> On Apr 28, 2020, at 1:54 AM, Anshuman Khandual <Anshuman.Khandual@arm.com> wrote:
>>>>>>> That is true. There is a slight change in the rules, making it explicit yes
>>>>>>> only when both ARCH_HAS_DEBUG_VM_PGTABLE and DEBUG_VM are enabled.
>>>>>>>
>>>>>>> +config DEBUG_VM_PGTABLE
>>>>>>> +    bool "Debug arch page table for semantics compliance"
>>>>>>> +    depends on MMU
>>>>>>> +    depends on !IA64 && !ARM
>>>>>>> +    depends on ARCH_HAS_DEBUG_VM_PGTABLE || EXPERT
>>>>>>> +    default y if ARCH_HAS_DEBUG_VM_PGTABLE && DEBUG_VM
>>>>>>> +    help
>>>>>>>
>>>>>>> The default is really irrelevant as the config option can be set explicitly.
>>>>>> That could also explain. Since not long time ago, it was only “default
>>>>>> y if DEBUG_VM”, that caused the robot saved a .config with
>>>>>> DEBUG_VM_PGTABLE=y by default.
>>>>>>
>>>>>> Even though you changed the rule recently, it has no effect as the
>>>>>> robot could “make oldconfig” from the saved config for each linux-next
>>>>>> tree execution and the breakage will go on.
>>>>> I'm not entirely sure that's the case. This report still points at the
>>>>> old commit fa6726c1e7 which has:
>>>>>
>>>>> +       depends on ARCH_HAS_DEBUG_VM_PGTABLE || EXPERT
>>>>> +       default n if !ARCH_HAS_DEBUG_VM_PGTABLE
>>>>> +       default y if DEBUG_VM
>>>>>
>>>>> In -next we now have commit 647d9a0de34c and subsequently modified by
>>>>> commit 0a8646638865. So hopefully with the latest -next tree we won't
>>>>> see this report.
>>>> Could some one from LKP test framework, please confirm if this still causes
>>>> above problem on the latest linux-next by default ?
>>>
>>> The .config is a rand config, the problem is still exist if run "make
>>> oldconfig" for the config with commit 0a8646638865.
>>
>> Is randconfig expected to boot? I don't think it is but I guess it
>> should not trigger a BUG_ON during boot.
>>
>>> $ grep -e CONFIG_MMU= -e CONFIG_EXPERT= -e CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=
>>> -e CONFIG_DEBUG_VM= .config
>>> CONFIG_EXPERT=y
>>> CONFIG_MMU=y
>>> CONFIG_DEBUG_VM=y
>>>
>>> should we disable DEBUG_VM_PGTABLE by default?
>>
>> If that's the only case where this fails in LKP, I'd rather remove the
>> EXPERT dependency so that it cannot be enabled. Architectures that want
>> to experiment with this feature will have to select
>> ARCH_HAS_DEBUG_VM_PGTABLE explicitly.
>>

Dropping the EXPERT dependency here seems like the best solution even
though I have always tried to avoid that (many times).

> 
> But when something is not selectable, people won't even know it exists

We will probably revisit this option later but for now it is really not
an absolute necessity for the test.

> 
> Why not try and fix the problems reported by the robots instead ?
Enabling all non-enabled platforms will be an ongoing process that will
require support and collaboration from their respective platforms folks.
Similar collaborative approach earlier had enabled successfully test run
on arc, s390, ppc32, ppc64 platforms after starting with just arm64 and
x86.
