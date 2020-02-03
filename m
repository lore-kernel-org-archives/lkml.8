Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D779C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 17:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72CA020838
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 17:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="TBfGDlMp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729356AbgBCRQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 12:16:50 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:13247 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726192AbgBCRQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 12:16:50 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48BDyM0Gd0z9vC0j;
        Mon,  3 Feb 2020 18:16:43 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=TBfGDlMp; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id L2EgvSc5tJns; Mon,  3 Feb 2020 18:16:42 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48BDyL5k3bz9vC0h;
        Mon,  3 Feb 2020 18:16:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1580750202; bh=CbGM+lhkMhDFeqH22kN9rGKdr+DO5kF57vrZYdUevkk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=TBfGDlMpIs3iBnu1efmB/bvuM3U13ivka5Z4Mm2uZgaA1D0UVGDvJV0N5HTaaM+JN
         QBGASI28LFCqKPYZ5HGxOyKfb42DgiIxn0G+TFQx9n9IR+CT9iaWKsVDl0y8lNiplc
         pBDzIisDVtmnHs4n6EKOXL7Msf97rs+MltEXZ/wE=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 21B988B7B5;
        Mon,  3 Feb 2020 18:16:48 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ZylV4ap6PF-H; Mon,  3 Feb 2020 18:16:48 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A3BFA8B7AC;
        Mon,  3 Feb 2020 18:16:47 +0100 (CET)
Subject: Re: [PATCH] powerpc/32s: Slenderize _tlbia() for powerpc 603/603e
To:     Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "paulus@samba.org" <paulus@samba.org>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>
Cc:     "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <12f4f4f0ff89aeab3b937fc96c84fb35e1b2517e.1580748445.git.christophe.leroy@c-s.fr>
 <bfab6635148b83deed8ac9fcbb19dde8c32fb988.camel@infinera.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <5771d787-67f5-f29c-2a9e-0ea7194cffa1@c-s.fr>
Date:   Mon, 3 Feb 2020 18:16:47 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <bfab6635148b83deed8ac9fcbb19dde8c32fb988.camel@infinera.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 03/02/2020 à 17:57, Joakim Tjernlund a écrit :
> On Mon, 2020-02-03 at 16:47 +0000, Christophe Leroy wrote:
>> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you recognize the sender and know the content is safe.
>>
>>
>> _tlbia() is a function used only on 603/603e core, ie on CPUs which
>> don't have a hash table.
>>
>> _tlbia() uses the tlbia macro which implements a loop of 1024 tlbie.
>>
>> On the 603/603e core, flushing the entire TLB requires no more than
>> 32 tlbie.
>>
>> Replace tlbia by a loop of 32 tlbie.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>>   arch/powerpc/mm/book3s32/hash_low.S | 13 ++++++++-----
>>   1 file changed, 8 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/powerpc/mm/book3s32/hash_low.S b/arch/powerpc/mm/book3s32/hash_low.S
>> index c11b0a005196..a5039ad10429 100644
>> --- a/arch/powerpc/mm/book3s32/hash_low.S
>> +++ b/arch/powerpc/mm/book3s32/hash_low.S
>> @@ -696,18 +696,21 @@ _GLOBAL(_tlbia)
>>          bne-    10b
>>          stwcx.  r8,0,r9
>>          bne-    10b
>> +#endif /* CONFIG_SMP */
>> +       li      r5, 32
>> +       lis     r4, KERNELBASE@h
>> +       mtctr   r5
>>          sync
>> -       tlbia
>> +0:     tlbie   r4
>> +       addi    r4, r4, 0x1000
> 
> Is page size always 4096 here or does it not matter ?

603 and its derivatives (G2, e300, ...) only support 4k pages.

And regardless, the reference manual says:

The tlbia instruction is not implemented on the MPC603e and when its 
opcode is encountered, an illegal instruction program exception is 
generated. To invalidate all entries of both TLBs, 32 tlbie instructions 
must be executed, incrementing the value in EA[15–19] by 1 each time

Christophe
