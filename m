Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93123C2BC11
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 10:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56EBD2076C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 10:31:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725864AbgIKKbK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 06:31:10 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:26516 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725710AbgIKKbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 06:31:09 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BnsVK1rsmz9tylB;
        Fri, 11 Sep 2020 12:31:05 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id j5nddWbOqQY9; Fri, 11 Sep 2020 12:31:05 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BnsVJ732fz9tyl8;
        Fri, 11 Sep 2020 12:31:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 45B148B83F;
        Fri, 11 Sep 2020 12:31:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Rv6156DPUzkX; Fri, 11 Sep 2020 12:31:06 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B56038B837;
        Fri, 11 Sep 2020 12:31:03 +0200 (CEST)
Subject: Re: [PATCH] powerpc/powermac: Fix low_sleep_handler with KUAP and
 KUEP
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <74472ea2a7e8698273643cde7d382bd9f31cd1dd.1598945727.git.christophe.leroy@csgroup.eu>
 <871rj9rxt1.fsf@mpe.ellerman.id.au>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <d56e42c0-0117-81bb-b583-4944e7bf0383@csgroup.eu>
Date:   Fri, 11 Sep 2020 12:30:53 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <871rj9rxt1.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 11/09/2020 à 01:56, Michael Ellerman a écrit :
> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
>> low_sleep_handler() has an hardcoded restore of segment registers
>> that doesn't take KUAP and KUEP into account.
>>
>> Use head_32's load_segment_registers() routine instead.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> Fixes: a68c31fc01ef ("powerpc/32s: Implement Kernel Userspace Access Protection")
>> Fixes: 31ed2b13c48d ("powerpc/32s: Implement Kernel Userspace Execution Prevention.")
>> Cc: stable@vger.kernel.org
>> ---
>>   arch/powerpc/platforms/powermac/sleep.S | 9 +--------
>>   1 file changed, 1 insertion(+), 8 deletions(-)
> 
> Doesn't build? pmac32_defconfig, gcc 9.3.0:
> 
> ld: arch/powerpc/platforms/powermac/sleep.o: in function `core99_wake_up':
> (.text+0x25c): undefined reference to `load_segment_registers'
> 
> Missing _GLOBAL() presumably?

Oops .. :(

v2 sent out.

Thanks
Christophe
