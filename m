Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C9F6C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 06:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C7EB22B47
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 06:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbgH0GsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 02:48:00 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:30811 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726123AbgH0Gr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 02:47:59 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BcYFl3bpzz9vD3v;
        Thu, 27 Aug 2020 08:47:55 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id oApkwu2Z5dlT; Thu, 27 Aug 2020 08:47:55 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BcYFl1t8Lz9vD3t;
        Thu, 27 Aug 2020 08:47:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0DD3D8B85C;
        Thu, 27 Aug 2020 08:47:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id kPtxLO6nQspm; Thu, 27 Aug 2020 08:47:55 +0200 (CEST)
Received: from localhost.localdomain (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A1A1C8B85A;
        Thu, 27 Aug 2020 08:47:55 +0200 (CEST)
Subject: Re: [PATCH v1 4/9] powerpc/vdso: Remove unnecessary ifdefs in
 vdso_pagelist initialization
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <df48ed76cf8a756a7f97ed42a1a39d0a404014bc.1598363608.git.christophe.leroy@csgroup.eu>
 <834f362626e18bc36226f46ed4113c461a3ad032.1598363608.git.christophe.leroy@csgroup.eu>
 <87ft89h2st.fsf@mpe.ellerman.id.au>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <04a968f6-88c0-0603-43aa-202196a68df2@csgroup.eu>
Date:   Thu, 27 Aug 2020 06:47:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <87ft89h2st.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/26/2020 02:58 PM, Michael Ellerman wrote:
> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
>> diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
>> index daef14a284a3..bbb69832fd46 100644
>> --- a/arch/powerpc/kernel/vdso.c
>> +++ b/arch/powerpc/kernel/vdso.c
>> @@ -718,16 +710,14 @@ static int __init vdso_init(void)
> ...
>>   
>> -
>> -#ifdef CONFIG_VDSO32
>>   	vdso32_kbase = &vdso32_start;
>>   
>>   	/*
>> @@ -735,8 +725,6 @@ static int __init vdso_init(void)
>>   	 */
>>   	vdso32_pages = (&vdso32_end - &vdso32_start) >> PAGE_SHIFT;
>>   	DBG("vdso32_kbase: %p, 0x%x pages\n", vdso32_kbase, vdso32_pages);
>> -#endif
> 
> This didn't build for ppc64le:
> 
>    /opt/cross/gcc-8.20_binutils-2.32/powerpc64-unknown-linux-gnu/bin/powerpc64-unknown-linux-gnu-ld: arch/powerpc/kernel/vdso.o:(.toc+0x0): undefined reference to `vdso32_end'
>    /opt/cross/gcc-8.20_binutils-2.32/powerpc64-unknown-linux-gnu/bin/powerpc64-unknown-linux-gnu-ld: arch/powerpc/kernel/vdso.o:(.toc+0x8): undefined reference to `vdso32_start'
>    make[1]: *** [/scratch/michael/build/maint/Makefile:1166: vmlinux] Error 1
>    make: *** [Makefile:185: __sub-make] Error 2
> 
> So I just put that ifdef back.
> 

The problem is because is_32bit() can still return true even when 
CONFIG_VDSO32 is not set.

The change below fixes the problem:

diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index bbb69832fd46..38abff60cbe2 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -132,11 +132,7 @@ int arch_setup_additional_pages(struct linux_binprm 
*bprm, int uses_interp)
  	if (!vdso_ready)
  		return 0;

-	if (is_32bit_task()) {
-		vdso_pagelist = vdso32_pagelist;
-		vdso_pages = vdso32_pages;
-		vdso_base = VDSO32_MBASE;
-	} else {
+	if (!is_32bit_task()) {
  		vdso_pagelist = vdso64_pagelist;
  		vdso_pages = vdso64_pages;
  		/*
@@ -145,6 +141,12 @@ int arch_setup_additional_pages(struct linux_binprm 
*bprm, int uses_interp)
  		 * and most likely share a SLB entry.
  		 */
  		vdso_base = 0;
+	} else if (IS_ENABLED(CONFIG_VDSO32)) {
+		vdso_pagelist = vdso32_pagelist;
+		vdso_pages = vdso32_pages;
+		vdso_base = VDSO32_MBASE;
+	} else {
+		vdso_pages = 0;
  	}

  	current->mm->context.vdso_base = 0;

With this change all vdso32 static objects (functions and vars) go away 
as expected.

We get a simple conflict with the following patch.

Do you prefer an updated series or a follow up patch, or you take the 
above change yourself ?

Christophe
