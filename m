Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA5AC433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 12:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FF562073A
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 12:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgHaMh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 08:37:27 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:53659 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726359AbgHaMd7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 08:33:59 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4Bg8l06gcFz9tyMC;
        Mon, 31 Aug 2020 14:33:48 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 3D-n1lCu5hCn; Mon, 31 Aug 2020 14:33:48 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4Bg8l04qkCz9tyM9;
        Mon, 31 Aug 2020 14:33:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0FB438B7D1;
        Mon, 31 Aug 2020 14:33:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id QjhsIo_zieyb; Mon, 31 Aug 2020 14:33:53 +0200 (CEST)
Received: from [10.25.210.31] (po15451.idsi0.si.c-s.fr [10.25.210.31])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D11EF8B7C5;
        Mon, 31 Aug 2020 14:33:53 +0200 (CEST)
Subject: Re: Warning on Kernel 5.9.0-rc1 on PowerBook G4 (ppc32), bisected to
 a5c3b9ffb0f4
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>
References: <dffc63e4-5554-822e-268e-92f9327bd056@lwfinger.net>
 <6beb6fcd-6b9a-b25a-3e63-77bac571ab5d@arm.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <88763202-6fac-c3b1-5242-02b08f45665a@csgroup.eu>
Date:   Mon, 31 Aug 2020 14:33:46 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <6beb6fcd-6b9a-b25a-3e63-77bac571ab5d@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 31/08/2020 à 12:46, Anshuman Khandual a écrit :
> 
> 
> On 08/29/2020 06:40 AM, Larry Finger wrote:
>> In kernel 5.9.0-rc1 on a PowerBook G4 (ppc32), several warnings of the following type are logged:
>>
>>   ------------[ cut here ]------------
>>   WARNING: CPU: 0 PID: 1 at arch/powerpc/mm/pgtable.c:185 set_pte_at+0x20/0x100
> 
> All those warnings triggered at the same place i.e arch/powerpc/mm/pgtable.c:185 ?
> 
>>   Modules linked in:
>>   CPU: 0 PID: 1 Comm: swapper Not tainted 5.9.0-rc2 #2
>>   NIP:  c002add4 LR: c07dba40 CTR: 00000000
>>   REGS: f1019d70 TRAP: 0700   Not tainted  (5.9.0-rc2)
>>   MSR:  00029032 <EE,ME,IR,DR,RI>  CR: 22000888  XER: 00000000
>>
>>     GPR00: c07dba40 f1019e28 eeca3220 eef7ace0 4e999000 eef7d664 f1019e50 00000000
>>     GPR08: 007c2315 00000001 007c2315 f1019e48 22000888 00000000 c00054dc 00000000
>>     GPR16: 00000000 00000000 2ef7d000 000007c2 fffffff0 eef7b000 000004e8 eef7d000
>>     GPR24: eef7c5c0 00000000 007c2315 4e999000 c05ef548 eef7d664 c087cda8 007c2315
>>   NIP [c002add4] set_pte_at+0x20/0x100
>>   LR [c07dba40] debug_vm_pgtable+0x29c/0x654
>>   Call Trace:
>>   [f1019e28] [c002b4ac] pte_fragment_alloc+0x24/0xe4 (unreliable)
>>   [f1019e48] [c07dba40] debug_vm_pgtable+0x29c/0x654
>>   [f1019e98] [c0005160] do_one_initcall+0x70/0x158
>>   [f1019ef8] [c07c352c] kernel_init_freeable+0x1f4/0x1f8
>>   [f1019f28] [c00054f0] kernel_init+0x14/0xfc
>>   [f1019f38] [c001516c] ret_from_kernel_thread+0x14/0x1c
>>   Instruction dump:
>>   57ff053e 39610010 7c63fa14 4800308c 9421ffe0 7c0802a6 81250000 bfa10014
>>   7cbd2b78 90010024 552907fe 83e60000 <0f090000> 3d20c089 83c91280 813e0018
>>   ---[ end trace 4ef67686e5133716 ]---
>>
>> Although the warnings do no harm, I suspect that they should be fixed in case some future modification turns the warning statements into BUGS.
> 
> These warnings are from mm/debug_vm_pgtable.c test, wont be converted into BUGS.
> But nonetheless, need to be addressed though.
> 
>>
>> The problem was bisected to commit a5c3b9ffb0f4 ("mm/debug_vm_pgtable: add tests validating advanced arch page table helpers") by Anshuman Khandual <anshuman.khandual@arm.com>
> 
> There are some known issues wrt DEBUG_VM_PGTABLE on certain ppc64 platforms. But
> I thought it worked all right on ppc32 platforms though. Adding Christophe Leroy
> here. Currently, there is a series under review that makes DEBUG_VM_PGTABLE work
> correctly on ppc64 platforms. Could you please give it a try and see if it fixes
> these warnings ?

I think all the tests I did were without CONFIG_DEBUG_VM. The warning at 
arch/powerpc/mm/pgtable.c:185 is a VM_WARN_ON(), it means it generates a 
real WARNING only when CONFIG_DEBUG_VM is set.

But that's one of the points reported by Aneesh for ppc64: set_pte_at() 
should never be used to update an already existing PTE. That should be 
fixed by Aneesh's series.

Christophe
