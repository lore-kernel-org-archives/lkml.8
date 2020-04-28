Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A67C83002
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 01:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 037892070B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 01:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbgD1BtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 21:49:24 -0400
Received: from foss.arm.com ([217.140.110.172]:44470 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbgD1BtX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 21:49:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D80230E;
        Mon, 27 Apr 2020 18:49:22 -0700 (PDT)
Received: from [10.163.70.197] (unknown [10.163.70.197])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A02363F305;
        Mon, 27 Apr 2020 18:49:14 -0700 (PDT)
Subject: Re: [mm/debug] fa6726c1e7: kernel_BUG_at_include/linux/mm.h
To:     kernel test robot <lkp@intel.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Qian Cai <cai@lca.pw>,
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
References: <20200427140706.GC5770@shao2-debian>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <51dcbcbf-6020-6672-05b0-5bb10c6292b5@arm.com>
Date:   Tue, 28 Apr 2020 07:18:46 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200427140706.GC5770@shao2-debian>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/27/2020 07:37 PM, kernel test robot wrote:
> 
> [   10.263354] kernel BUG at include/linux/mm.h:699!
> [   10.264320] invalid opcode: 0000 [#1] SMP
> [   10.264872] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.7.0-rc2-00230-gfa6726c1e7f01 #2
> [   10.265928] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> [   10.267074] EIP: __free_pages+0x4f/0x62
> [   10.267615] Code: 85 ff 74 0e 89 fa 89 f0 e8 83 ed ff ff 5b 5e 5f 5d c3 89 f0 e8 57 ff ff ff 5b 5e 5f 5d c3 ba fc 86 fc c1 89 f0 e8 ff 2e fe ff <0f> 0b 0f b6 cb ba ff ff ff ff 89 f0 e8 07 8f 01 00 eb bf 55 89 e5
> [   10.270098] EAX: 0000003e EBX: ee800000 ECX: 00000000 EDX: c0068000
> [   10.270925] ESI: eece0640 EDI: c016d020 EBP: c0071f10 ESP: c0071f04
> [   10.271786] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010286
> [   10.272724] CR0: 80050033 CR2: b7d6467d CR3: 023d0000 CR4: 000006b0
> [   10.273572] Call Trace:
> [   10.273912]  free_pages+0x3d/0x43
> [   10.274367]  pgd_free+0xea/0x11b
> [   10.274807]  __mmdrop+0x3c/0xc7
> [   10.275237]  ? __free_pages+0x3e/0x62
> [   10.275761]  debug_vm_pgtable+0x411/0x419
> [   10.276305]  ? rest_init+0x23c/0x23c
> [   10.276767]  kernel_init+0x15/0xf4
> [   10.277208]  ? schedule_tail_wrapper+0x9/0xc
> [   10.277756]  ret_from_fork+0x2e/0x38
> [   10.278217] Modules linked in: stm_p_basic
> [   10.278776] ---[ end trace b838f89424113a3a ]---
This is an unsupported (enabled via CONFIG_EXPERT) X86 platform (CONFIG_X86_PAE)
and is known to fail. The latest (V17) patch had moved the test invocation into
a late_initcall() per Linus thus pushing down any possible failures (like this)
after early boot. Please ignore this report.

Apart from this X86_PAE based config, no other platform failures have reported
so far. Assuming that this test robot does have a good platform coverage, the
CONFIG_EXPERT method of enabling CONFIG_DEBUG_VM_PGTABLE should help in getting
more platform coverage for this test.

- Anshuman
