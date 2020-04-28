Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72322C83002
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 02:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40D52206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 02:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgD1Cfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 22:35:40 -0400
Received: from foss.arm.com ([217.140.110.172]:44748 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726263AbgD1Cfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 22:35:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4AF6C30E;
        Mon, 27 Apr 2020 19:35:39 -0700 (PDT)
Received: from [10.163.70.197] (unknown [10.163.70.197])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF0443F305;
        Mon, 27 Apr 2020 19:35:30 -0700 (PDT)
Subject: Re: [mm/debug] fa6726c1e7: kernel_BUG_at_include/linux/mm.h
To:     Qian Cai <cai@lca.pw>
Cc:     kernel test robot <lkp@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
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
References: <51dcbcbf-6020-6672-05b0-5bb10c6292b5@arm.com>
 <31CD915D-2E14-4897-AF62-82B6C5FD567A@lca.pw>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <096a07fc-4525-feb6-5658-40bcffbd0a58@arm.com>
Date:   Tue, 28 Apr 2020 08:05:02 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <31CD915D-2E14-4897-AF62-82B6C5FD567A@lca.pw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/28/2020 07:35 AM, Qian Cai wrote:
> 
> 
>> On Apr 27, 2020, at 9:49 PM, Anshuman Khandual <Anshuman.Khandual@arm.com> wrote:
>>
>> This is an unsupported (enabled via CONFIG_EXPERT) X86 platform (CONFIG_X86_PAE)
>> and is known to fail. The latest (V17) patch had moved the test invocation into
>> a late_initcall() per Linus thus pushing down any possible failures (like this)
>> after early boot. Please ignore this report.
>>
>> Apart from this X86_PAE based config, no other platform failures have reported
>> so far. Assuming that this test robot does have a good platform coverage, the
>> CONFIG_EXPERT method of enabling CONFIG_DEBUG_VM_PGTABLE should help in getting
>> more platform coverage for this test.
> 
> This sounds really sloppy. Why can’t we make it impossible to select this combination if nobody is willing to fix it?

Letting CONFIG_DEBUG_VM_PGTABLE enabled via CONFIG_EXPERT for unsupported
platforms i.e without ARCH_HAS_DEBUG_VM_PGTABLE, was a conscious decision
meant to expand it's adaptability and coverage without requiring any code
(i.e Kconfig) change. The easier it is to enable the test on unsupported
platforms right now, more folks are likely to try it out thus increasing
it's probability to get fixed on those platforms. That is a valid enough
reason to have CONFIG_EXPERT based enablement method, IMHO. Also even with
CONFIG_EXPERT set, CONFIG_DEBUG_VM_PGTABLE does not get enabled by default
automatically.
