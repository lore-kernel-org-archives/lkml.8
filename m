Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B243AC83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 03:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9149620B80
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 03:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgD2D2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 23:28:38 -0400
Received: from foss.arm.com ([217.140.110.172]:33520 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726636AbgD2D2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 23:28:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 802C2C14;
        Tue, 28 Apr 2020 20:28:37 -0700 (PDT)
Received: from [192.168.0.129] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 653D03F73D;
        Tue, 28 Apr 2020 20:28:31 -0700 (PDT)
Subject: Re: [mm/debug] fa6726c1e7: kernel_BUG_at_include/linux/mm.h
To:     Catalin Marinas <catalin.marinas@arm.com>, Qian Cai <cai@lca.pw>
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        kernel test robot <lkp@intel.com>,
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
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <b62c66c8-1550-087f-f5d2-b33a18bb0edc@arm.com>
Date:   Wed, 29 Apr 2020 08:58:02 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200428092105.GB3868@gaia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/28/2020 02:51 PM, Catalin Marinas wrote:
> On Tue, Apr 28, 2020 at 04:41:11AM -0400, Qian Cai wrote:
>> On Apr 28, 2020, at 1:54 AM, Anshuman Khandual <Anshuman.Khandual@arm.com> wrote:
>>> That is true. There is a slight change in the rules, making it explicit yes
>>> only when both ARCH_HAS_DEBUG_VM_PGTABLE and DEBUG_VM are enabled.
>>>
>>> +config DEBUG_VM_PGTABLE
>>> +    bool "Debug arch page table for semantics compliance"
>>> +    depends on MMU
>>> +    depends on !IA64 && !ARM
>>> +    depends on ARCH_HAS_DEBUG_VM_PGTABLE || EXPERT
>>> +    default y if ARCH_HAS_DEBUG_VM_PGTABLE && DEBUG_VM
>>> +    help
>>>
>>> The default is really irrelevant as the config option can be set explicitly.
>>
>> That could also explain. Since not long time ago, it was only “default
>> y if DEBUG_VM”, that caused the robot saved a .config with
>> DEBUG_VM_PGTABLE=y by default.
>>
>> Even though you changed the rule recently, it has no effect as the
>> robot could “make oldconfig” from the saved config for each linux-next
>> tree execution and the breakage will go on.
> 
> I'm not entirely sure that's the case. This report still points at the
> old commit fa6726c1e7 which has:
> 
> +       depends on ARCH_HAS_DEBUG_VM_PGTABLE || EXPERT
> +       default n if !ARCH_HAS_DEBUG_VM_PGTABLE
> +       default y if DEBUG_VM
> 
> In -next we now have commit 647d9a0de34c and subsequently modified by
> commit 0a8646638865. So hopefully with the latest -next tree we won't
> see this report.

Could some one from LKP test framework, please confirm if this still causes
above problem on the latest linux-next by default ?
