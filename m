Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE03C33C9E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 07:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C1B520721
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 07:00:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="nhiXeQCr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbgBCHAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 02:00:30 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:65110 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727606AbgBCHAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 02:00:30 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 489zHB2pFqz9tyMB;
        Mon,  3 Feb 2020 08:00:22 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=nhiXeQCr; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id U5Z89vlm2Rxs; Mon,  3 Feb 2020 08:00:22 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 489zHB1Pwpz9tyM8;
        Mon,  3 Feb 2020 08:00:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1580713222; bh=ZhStMLTmbK9vNWyJhbxY2QaPbPPHTUFefa5zkTcuAxw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=nhiXeQCrDGl2DcpUIbuV/o1hrY2osRxOgV2GSYlZIrfu3VY7PPaF2K6IByRhR0b9f
         N9atplGPxvIv25yG4GnYYjufuIx+hC66QjadVUJiHz90D4zIXsDWnkK/eMv7Y8o2+d
         ZdPC8MufUZinVhup0pE5Coa3NfV5+HSLbqGg9K0Y=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id AD3088B791;
        Mon,  3 Feb 2020 08:00:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id DgX32bIJY_vQ; Mon,  3 Feb 2020 08:00:26 +0100 (CET)
Received: from [172.25.230.102] (po15451.idsi0.si.c-s.fr [172.25.230.102])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 73A078B752;
        Mon,  3 Feb 2020 08:00:26 +0100 (CET)
Subject: Re: [PATCH v2 2/7] powerpc/kprobes: Mark newly allocated probes as RO
To:     Russell Currey <ruscur@russell.cc>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <84be5ad6a996adf5693260749dcb4d8c69182073.1580477672.git.christophe.leroy@c-s.fr>
 <01fdf1b7375b3e1e43a634bf6719b576c4c5db11.1580477672.git.christophe.leroy@c-s.fr>
 <3078df74c232e54aef3e8bb3523587a3053ab0ec.camel@russell.cc>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <d6451710-3582-305b-ad81-018a1ea0ef3d@c-s.fr>
Date:   Mon, 3 Feb 2020 08:00:26 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <3078df74c232e54aef3e8bb3523587a3053ab0ec.camel@russell.cc>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 03/02/2020 à 05:50, Russell Currey a écrit :
> On Fri, 2020-01-31 at 13:34 +0000, Christophe Leroy wrote:
>> With CONFIG_STRICT_KERNEL_RWX=y and CONFIG_KPROBES=y, there will be
>> one
>> W+X page at boot by default.  This can be tested with
>> CONFIG_PPC_PTDUMP=y and CONFIG_PPC_DEBUG_WX=y set, and checking the
>> kernel log during boot.
>>
>> powerpc doesn't implement its own alloc() for kprobes like other
>> architectures do, but we couldn't immediately mark RO anyway since we
>> do
>> a memcpy to the page we allocate later.  After that, nothing should
>> be
>> allowed to modify the page, and write permissions are removed well
>> before the kprobe is armed.
>>
>> The memcpy() would fail if >1 probes were allocated, so use
>> patch_instruction() instead which is safe for RO.
>>
>> Reviewed-by: Daniel Axtens <dja@axtens.net>
>> Signed-off-by: Russell Currey <ruscur@russell.cc>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>> v2: removed the redundant flush
>> ---
>>   arch/powerpc/kernel/kprobes.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/powerpc/kernel/kprobes.c
>> b/arch/powerpc/kernel/kprobes.c
>> index 2d27ec4feee4..d3e594e6094c 100644
>> --- a/arch/powerpc/kernel/kprobes.c
>> +++ b/arch/powerpc/kernel/kprobes.c
>> @@ -24,6 +24,7 @@
>>   #include <asm/sstep.h>
>>   #include <asm/sections.h>
>>   #include <linux/uaccess.h>
>> +#include <linux/set_memory.h>
>>   
>>   DEFINE_PER_CPU(struct kprobe *, current_kprobe) = NULL;
>>   DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
>> @@ -124,13 +125,12 @@ int arch_prepare_kprobe(struct kprobe *p)
>>   	}
>>   
>>   	if (!ret) {
>> -		memcpy(p->ainsn.insn, p->addr,
>> -				MAX_INSN_SIZE *
>> sizeof(kprobe_opcode_t));
>> +		patch_instruction(p->ainsn.insn, *p->addr);
>>   		p->opcode = *p->addr;
>> -		flush_icache_range((unsigned long)p->ainsn.insn,
>> -			(unsigned long)p->ainsn.insn +
>> sizeof(kprobe_opcode_t));
>>   	}
>>   
>> +	set_memory_ro((unsigned long)p->ainsn.insn, 1);
>> +
> 
> 
> Since this can be called multiple times on the same page, can avoid by
> implementing:
> 
> void *alloc_insn_page(void)
> {
> 	void *page;
> 
> 	page = vmalloc_exec(PAGE_SIZE);
> 	if (page)
> 		set_memory_ro((unsigned long)page, 1);
> 
> 	return page;
> }
> 
> Which is pretty much the same as what's in arm64.  Works for me and
> passes ftracetest, I was originally doing this but cut it because it
> broke with the memcpy, but works with patch_instruction().
> 
>>   	p->ainsn.boostable = 0;
>>   	return ret;
>>   }

Ok. I'll send out v3 as patch 1 fails on PPC64, so I'll take that in.

Christophe
