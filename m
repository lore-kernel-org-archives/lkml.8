Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D80C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 873B120672
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:52:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbgGHHw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 03:52:57 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:8233 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726291AbgGHHw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 03:52:57 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4B1s3n3hS3z9ttw5;
        Wed,  8 Jul 2020 09:52:53 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id pMFOMNr9q3WY; Wed,  8 Jul 2020 09:52:53 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4B1s3n2bWGz9ttw4;
        Wed,  8 Jul 2020 09:52:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B2CE38B7F3;
        Wed,  8 Jul 2020 09:52:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id FkR4CCf8Gi86; Wed,  8 Jul 2020 09:52:54 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id AD3DF8B76B;
        Wed,  8 Jul 2020 09:52:53 +0200 (CEST)
Subject: Re: [PATCH v3 1/9] powerpc/watchpoint: Fix 512 byte boundary limit
To:     Jordan Niethe <jniethe5@gmail.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>, mikey@neuling.org,
        apopple@linux.ibm.com, Paul Mackerras <paulus@samba.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        naveen.n.rao@linux.vnet.ibm.com, peterz@infradead.org,
        jolsa@kernel.org, oleg@redhat.com, fweisbec@gmail.com,
        mingo@kernel.org, pedromfc@br.ibm.com, miltonm@us.ibm.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20200708045046.135702-1-ravi.bangoria@linux.ibm.com>
 <20200708045046.135702-2-ravi.bangoria@linux.ibm.com>
 <CACzsE9qka0j7vKm186Z70fhNy9L4dNR3B97-jQ2oZZAwYduaRw@mail.gmail.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <2e418e64-e40a-f33d-8a1f-8f09a4605db9@csgroup.eu>
Date:   Wed, 8 Jul 2020 09:52:45 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CACzsE9qka0j7vKm186Z70fhNy9L4dNR3B97-jQ2oZZAwYduaRw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 08/07/2020 à 09:44, Jordan Niethe a écrit :
> On Wed, Jul 8, 2020 at 2:53 PM Ravi Bangoria
> <ravi.bangoria@linux.ibm.com> wrote:
>>
>> Milton Miller reported that we are aligning start and end address to
>> wrong size SZ_512M. It should be SZ_512. Fix that.
>>
>> While doing this change I also found a case where ALIGN() comparison
>> fails. Within a given aligned range, ALIGN() of two addresses does not
>> match when start address is pointing to the first byte and end address
>> is pointing to any other byte except the first one. But that's not true
>> for ALIGN_DOWN(). ALIGN_DOWN() of any two addresses within that range
>> will always point to the first byte. So use ALIGN_DOWN() instead of
>> ALIGN().
>>
>> Fixes: e68ef121c1f4 ("powerpc/watchpoint: Use builtin ALIGN*() macros")
>> Reported-by: Milton Miller <miltonm@us.ibm.com>
>> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
>> ---
>>   arch/powerpc/kernel/hw_breakpoint.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
>> index 0000daf0e1da..031e6defc08e 100644
>> --- a/arch/powerpc/kernel/hw_breakpoint.c
>> +++ b/arch/powerpc/kernel/hw_breakpoint.c
>> @@ -419,7 +419,7 @@ static int hw_breakpoint_validate_len(struct arch_hw_breakpoint *hw)
>>          if (dawr_enabled()) {
>>                  max_len = DAWR_MAX_LEN;
>>                  /* DAWR region can't cross 512 bytes boundary */
>> -               if (ALIGN(start_addr, SZ_512M) != ALIGN(end_addr - 1, SZ_512M))
>> +               if (ALIGN_DOWN(start_addr, SZ_512) != ALIGN_DOWN(end_addr - 1, SZ_512))
> I wonder if you should use end_addr - 1, but rather end_addr. For example:
> 512 -> 1023, because of the -1, 1024 will now be included in this
> range meaning 513 bytes?

end_addr is not part of the range.

If you want the range [512;1023], it means addr 512 len 512, that is 
end_addr = addr + len = 1024

Christophe
