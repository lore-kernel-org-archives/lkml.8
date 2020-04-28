Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D73EC83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 03:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D791206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 03:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbgD1DyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 23:54:15 -0400
Received: from foss.arm.com ([217.140.110.172]:45390 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbgD1DyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 23:54:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A40B31B;
        Mon, 27 Apr 2020 20:54:14 -0700 (PDT)
Received: from [10.163.70.197] (unknown [10.163.70.197])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C8713F73D;
        Mon, 27 Apr 2020 20:54:05 -0700 (PDT)
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
References: <096a07fc-4525-feb6-5658-40bcffbd0a58@arm.com>
 <D30E4C88-408A-438B-803B-D9F8F82D87A7@lca.pw>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <a7816294-05af-b325-c699-84bb143b3d6a@arm.com>
Date:   Tue, 28 Apr 2020 09:23:37 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <D30E4C88-408A-438B-803B-D9F8F82D87A7@lca.pw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/28/2020 08:21 AM, Qian Cai wrote:
> 
> 
>> On Apr 27, 2020, at 10:35 PM, Anshuman Khandual <Anshuman.Khandual@arm.com> wrote:
>>
>> Letting CONFIG_DEBUG_VM_PGTABLE enabled via CONFIG_EXPERT for unsupported
>> platforms i.e without ARCH_HAS_DEBUG_VM_PGTABLE, was a conscious decision
>> meant to expand it's adaptability and coverage without requiring any code
>> (i.e Kconfig) change. The easier it is to enable the test on unsupported
>> platforms right now, more folks are likely to try it out thus increasing
>> it's probability to get fixed on those platforms. That is a valid enough
>> reason to have CONFIG_EXPERT based enablement method, IMHO. Also even with
>> CONFIG_EXPERT set, CONFIG_DEBUG_VM_PGTABLE does not get enabled by default
>> automatically.
> 
> No, I am talking about PAE. There is a distinction between known broken that nobody cares (like arm32) and in-progress/unknown status (like s390).
> 
> Also, it is not very nice to introduce regressions for robots when testing PAE because they always select CONFIG__EXPERT and CONFIG_DEBUG_VM.

Okay, will add X86_PAE to the explicitly disabled list along with
IA64 and ARM.

----
From: Anshuman Khandual <anshuman.khandual@arm.com>
Date: Tue, 28 Apr 2020 04:30:04 +0100
Subject: [PATCH 3/3] mm/debug/pgtable: Completely disable X86_PAE

Completely disable X86_PAE, even via CONFIG_EXPERT.

Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 lib/Kconfig.debug | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 6a492e32579a..79e097a2285f 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -697,7 +697,7 @@ config DEBUG_VM_PGFLAGS
 config DEBUG_VM_PGTABLE
        bool "Debug arch page table for semantics compliance"
        depends on MMU
-       depends on !IA64 && !ARM
+       depends on !IA64 && !ARM && !X86_PAE
        depends on ARCH_HAS_DEBUG_VM_PGTABLE || EXPERT
        default y if ARCH_HAS_DEBUG_VM_PGTABLE && DEBUG_VM
        help
-- 

Hello Andrew/Stephen,

Could you please fold the above patch in linux-next. Also please do
let me know if I should respin the series as well. Thank you.

- Anshuman
