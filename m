Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2663DC433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 10:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08E89206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 10:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgHaKr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 06:47:26 -0400
Received: from foss.arm.com ([217.140.110.172]:56396 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725964AbgHaKrY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 06:47:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA8E41FB;
        Mon, 31 Aug 2020 03:47:23 -0700 (PDT)
Received: from [10.163.69.240] (unknown [10.163.69.240])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C7C3D3F71F;
        Mon, 31 Aug 2020 03:47:21 -0700 (PDT)
Subject: Re: Warning on Kernel 5.9.0-rc1 on PowerBook G4 (ppc32), bisected to
 a5c3b9ffb0f4
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
References: <dffc63e4-5554-822e-268e-92f9327bd056@lwfinger.net>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <6beb6fcd-6b9a-b25a-3e63-77bac571ab5d@arm.com>
Date:   Mon, 31 Aug 2020 16:16:49 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <dffc63e4-5554-822e-268e-92f9327bd056@lwfinger.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/29/2020 06:40 AM, Larry Finger wrote:
> In kernel 5.9.0-rc1 on a PowerBook G4 (ppc32), several warnings of the following type are logged:
> 
>  ------------[ cut here ]------------
>  WARNING: CPU: 0 PID: 1 at arch/powerpc/mm/pgtable.c:185 set_pte_at+0x20/0x100

All those warnings triggered at the same place i.e arch/powerpc/mm/pgtable.c:185 ?

>  Modules linked in:
>  CPU: 0 PID: 1 Comm: swapper Not tainted 5.9.0-rc2 #2
>  NIP:  c002add4 LR: c07dba40 CTR: 00000000
>  REGS: f1019d70 TRAP: 0700   Not tainted  (5.9.0-rc2)
>  MSR:  00029032 <EE,ME,IR,DR,RI>  CR: 22000888  XER: 00000000
> 
>    GPR00: c07dba40 f1019e28 eeca3220 eef7ace0 4e999000 eef7d664 f1019e50 00000000
>    GPR08: 007c2315 00000001 007c2315 f1019e48 22000888 00000000 c00054dc 00000000
>    GPR16: 00000000 00000000 2ef7d000 000007c2 fffffff0 eef7b000 000004e8 eef7d000
>    GPR24: eef7c5c0 00000000 007c2315 4e999000 c05ef548 eef7d664 c087cda8 007c2315
>  NIP [c002add4] set_pte_at+0x20/0x100
>  LR [c07dba40] debug_vm_pgtable+0x29c/0x654
>  Call Trace:
>  [f1019e28] [c002b4ac] pte_fragment_alloc+0x24/0xe4 (unreliable)
>  [f1019e48] [c07dba40] debug_vm_pgtable+0x29c/0x654
>  [f1019e98] [c0005160] do_one_initcall+0x70/0x158
>  [f1019ef8] [c07c352c] kernel_init_freeable+0x1f4/0x1f8
>  [f1019f28] [c00054f0] kernel_init+0x14/0xfc
>  [f1019f38] [c001516c] ret_from_kernel_thread+0x14/0x1c
>  Instruction dump:
>  57ff053e 39610010 7c63fa14 4800308c 9421ffe0 7c0802a6 81250000 bfa10014
>  7cbd2b78 90010024 552907fe 83e60000 <0f090000> 3d20c089 83c91280 813e0018
>  ---[ end trace 4ef67686e5133716 ]---
> 
> Although the warnings do no harm, I suspect that they should be fixed in case some future modification turns the warning statements into BUGS.

These warnings are from mm/debug_vm_pgtable.c test, wont be converted into BUGS.
But nonetheless, need to be addressed though.

> 
> The problem was bisected to commit a5c3b9ffb0f4 ("mm/debug_vm_pgtable: add tests validating advanced arch page table helpers") by Anshuman Khandual <anshuman.khandual@arm.com>

There are some known issues wrt DEBUG_VM_PGTABLE on certain ppc64 platforms. But
I thought it worked all right on ppc32 platforms though. Adding Christophe Leroy
here. Currently, there is a series under review that makes DEBUG_VM_PGTABLE work
correctly on ppc64 platforms. Could you please give it a try and see if it fixes
these warnings ?

https://patchwork.kernel.org/project/linux-mm/list/?series=339387

- Anshuman
