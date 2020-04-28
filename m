Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74246C83006
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 05:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51887206A1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 05:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="UGa8QaCW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgD1FZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 01:25:02 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:8266 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726042AbgD1FZC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 01:25:02 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 49B97v2WbLz9txmF;
        Tue, 28 Apr 2020 07:24:59 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=UGa8QaCW; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id dbSHLh7BOsdd; Tue, 28 Apr 2020 07:24:59 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 49B97v1DN5z9txm4;
        Tue, 28 Apr 2020 07:24:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1588051499; bh=uMbK8WLr70h8PW6glfCgZpJZqP7qO7TNICYnbgqYa00=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=UGa8QaCW2cqAnXSk3u5qvlTJ4uxMvLVkz3zXa3LUK2UtD46IMfv1mfe/4KZZY3fMC
         v51hVcufYTGBQYEIjMdEruL/pQ84i2HRgMIe34/VKKolaCy+FygMTQ0dNj9A9YXpwG
         a1yrKlnHP51UcV4km6zx+bMLU7lcKInKePL3GCkw=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0D0FB8B7C5;
        Tue, 28 Apr 2020 07:25:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id BHhJz45fwYdI; Tue, 28 Apr 2020 07:24:59 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5D3FC8B75F;
        Tue, 28 Apr 2020 07:24:58 +0200 (CEST)
Subject: Re: [mm/debug] fa6726c1e7: kernel_BUG_at_include/linux/mm.h
To:     Qian Cai <cai@lca.pw>,
        Anshuman Khandual <Anshuman.Khandual@arm.com>
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
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <b3e5d138-9e14-826c-82c9-2cec9bd41ca5@c-s.fr>
Date:   Tue, 28 Apr 2020 07:24:52 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <D30E4C88-408A-438B-803B-D9F8F82D87A7@lca.pw>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 28/04/2020 à 04:51, Qian Cai a écrit :
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
> 

Having CONFIG_EXPERT and CONFIG_DEBUG_VM is not enough to get 
CONFIG_DEBUG_VM_PGTABLE set to yes.

By default, CONFIG_DEBUG_VM_PGTABLE is set to no when 
ARCH_HAS_DEBUG_VM_PGTABLE is not set.

Christophe
