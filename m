Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE1DC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 06:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D533920748
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 06:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729658AbgCaGoi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 02:44:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39698 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726339AbgCaGoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 02:44:38 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02V6YOFW023300
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 02:44:37 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 301yffd0j4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 02:44:37 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
        Tue, 31 Mar 2020 07:44:33 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 31 Mar 2020 07:44:29 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02V6hQID50856256
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Mar 2020 06:43:26 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0B552A405F;
        Tue, 31 Mar 2020 06:44:30 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9E18DA4060;
        Tue, 31 Mar 2020 06:44:29 +0000 (GMT)
Received: from localhost (unknown [9.85.74.140])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 31 Mar 2020 06:44:29 +0000 (GMT)
Date:   Tue, 31 Mar 2020 12:14:27 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH 10/12] powerpc/entry32: Blacklist exception entry points
 for kprobe.
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <dff05b59a161434a546010507000816750073f28.1585474724.git.christophe.leroy@c-s.fr>
        <aea027844b12fcbc29ea78d26c5848a6794d1688.1585474724.git.christophe.leroy@c-s.fr>
        <1585588031.jvow7mwq4x.naveen@linux.ibm.com>
        <7f367f35-1bb8-bbb6-f399-8e911f76e043@c-s.fr>
        <83053ddf-9ba6-d551-6711-890c3f3810b5@c-s.fr>
        <1585635379.0xixuk2jdc.naveen@linux.ibm.com>
        <bc184460-70be-0fe2-0a01-a97ee96652c0@c-s.fr>
In-Reply-To: <bc184460-70be-0fe2-0a01-a97ee96652c0@c-s.fr>
MIME-Version: 1.0
User-Agent: astroid/v0.15-13-gb675b421
 (https://github.com/astroidmail/astroid)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
x-cbid: 20033106-0028-0000-0000-000003EF2CA4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20033106-0029-0000-0000-000024B4AE22
Message-Id: <1585637023.fay3842pux.naveen@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-03-31_02:2020-03-30,2020-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 mlxscore=0 phishscore=0 clxscore=1015
 bulkscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003310048
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy wrote:
> 
> 
> Le 31/03/2020 à 08:17, Naveen N. Rao a écrit :
>> Christophe Leroy wrote:
>>>
>>>
>>> Le 30/03/2020 à 20:33, Christophe Leroy a écrit :
>>>>
>>>>
>>>> Le 30/03/2020 à 19:08, Naveen N. Rao a écrit :
>>>>> Christophe Leroy wrote:
>>>>>> kprobe does not handle events happening in real mode.
>>>>>>
>>>>>> As exception entry points are running with MMU disabled,
>>>>>> blacklist them.
>>>>>>
>>>>>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>>>>>> ---
>>>>>>  arch/powerpc/kernel/entry_32.S | 7 +++++++
>>>>>>  1 file changed, 7 insertions(+)
>>>>>>
>>>>>> diff --git a/arch/powerpc/kernel/entry_32.S 
>>>>>> b/arch/powerpc/kernel/entry_32.S
>>>>>> index 94f78c03cb79..9a1a45d6038a 100644
>>>>>> --- a/arch/powerpc/kernel/entry_32.S
>>>>>> +++ b/arch/powerpc/kernel/entry_32.S
>>>>>> @@ -51,6 +51,7 @@ mcheck_transfer_to_handler:
>>>>>>      mfspr    r0,SPRN_DSRR1
>>>>>>      stw    r0,_DSRR1(r11)
>>>>>>      /* fall through */
>>>>>> +_ASM_NOKPROBE_SYMBOL(mcheck_transfer_to_handler)
>>>>>>
>>>>>>      .globl    debug_transfer_to_handler
>>>>>>  debug_transfer_to_handler:
>>>>>> @@ -59,6 +60,7 @@ debug_transfer_to_handler:
>>>>>>      mfspr    r0,SPRN_CSRR1
>>>>>>      stw    r0,_CSRR1(r11)
>>>>>>      /* fall through */
>>>>>> +_ASM_NOKPROBE_SYMBOL(debug_transfer_to_handler)
>>>>>>
>>>>>>      .globl    crit_transfer_to_handler
>>>>>>  crit_transfer_to_handler:
>>>>>> @@ -94,6 +96,7 @@ crit_transfer_to_handler:
>>>>>>      rlwinm    r0,r1,0,0,(31 - THREAD_SHIFT)
>>>>>>      stw    r0,KSP_LIMIT(r8)
>>>>>>      /* fall through */
>>>>>> +_ASM_NOKPROBE_SYMBOL(crit_transfer_to_handler)
>>>>>>  #endif
>>>>>>
>>>>>>  #ifdef CONFIG_40x
>>>>>> @@ -115,6 +118,7 @@ crit_transfer_to_handler:
>>>>>>      rlwinm    r0,r1,0,0,(31 - THREAD_SHIFT)
>>>>>>      stw    r0,KSP_LIMIT(r8)
>>>>>>      /* fall through */
>>>>>> +_ASM_NOKPROBE_SYMBOL(crit_transfer_to_handler)
>>>>>>  #endif
>>>>>>
>>>>>>  /*
>>>>>> @@ -127,6 +131,7 @@ crit_transfer_to_handler:
>>>>>>      .globl    transfer_to_handler_full
>>>>>>  transfer_to_handler_full:
>>>>>>      SAVE_NVGPRS(r11)
>>>>>> +_ASM_NOKPROBE_SYMBOL(transfer_to_handler_full)
>>>>>>      /* fall through */
>>>>>>
>>>>>>      .globl    transfer_to_handler
>>>>>> @@ -286,6 +291,8 @@ reenable_mmu:
>>>>>>      lwz    r2, GPR2(r11)
>>>>>>      b    fast_exception_return
>>>>>>  #endif
>>>>>> +_ASM_NOKPROBE_SYMBOL(transfer_to_handler)
>>>>>> +_ASM_NOKPROBE_SYMBOL(transfer_to_handler_cont)
>>>>>
>>>>> These are added after 'reenable_mmu', which is itself not 
>>>>> blacklisted. Is that intentional?
>>>>
>>>> Yes I put it as the complete end of the entry part, ie just before 
>>>> stack_ovf which is a function by itself.
>>>>
>>>> Note that reenable_mmu is inside an #ifdef CONFIG_TRACE_IRQFLAGS.
>>>>
>>>> I'm not completely sure where to put the _ASM_NOKPROBE_SYMBOL()s, 
>>>> that's the reason why I put it close to the symbol itself in my first 
>>>> series.
>>>>
>>>> Could you have a look at the code and tell me what looks the most 
>>>> appropriate as a location to you ?
>>>>
>>>> https://elixir.bootlin.com/linux/v5.6/source/arch/powerpc/kernel/entry_32.S#L230 
>>>
>>>
>>> Ok, thinking about it once more, I guess we have a problem as 
>>> everything after that reenable_mmu will be visible.
>> 
>> I see that we reach reenable_mmu through a 'rfi' with MSR_KERNEL, which 
>> seems safe to me. So, I figured it can be probed without issues?
> 
> Yes it can. And that's the reason why I didn't blacklist it. However the 
> 4: and 7: which are after reenable_mmu are called from earlier, at a 
> time we are still in real mode. So I need to do something about that I 
> guess.

Ah yes, good catch. Makes sense to move 'reenable_mmu' after all.

Thanks,
Naveen

