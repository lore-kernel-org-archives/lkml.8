Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 027D4C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 13:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB1FA20792
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 13:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgGUNdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 09:33:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57820 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726506AbgGUNdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 09:33:46 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06LDWKmR091526;
        Tue, 21 Jul 2020 09:33:16 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32d5h5t7bt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jul 2020 09:33:16 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06LDWLko091576;
        Tue, 21 Jul 2020 09:33:14 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32d5h5t7aw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jul 2020 09:33:14 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06LDV9nw005318;
        Tue, 21 Jul 2020 13:33:12 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 32brq7kxat-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jul 2020 13:33:12 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06LDX95K16843144
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jul 2020 13:33:09 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 96ECBAE045;
        Tue, 21 Jul 2020 13:33:09 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 78BA4AE053;
        Tue, 21 Jul 2020 13:33:05 +0000 (GMT)
Received: from [9.199.35.129] (unknown [9.199.35.129])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 21 Jul 2020 13:33:05 +0000 (GMT)
Subject: Re: [PATCH v4 09/10] powerpc/watchpoint: Return available watchpoints
 dynamically
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Jordan Niethe <jniethe5@gmail.com>, mikey@neuling.org,
        apopple@linux.ibm.com, Paul Mackerras <paulus@samba.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        naveen.n.rao@linux.vnet.ibm.com, peterz@infradead.org,
        jolsa@kernel.org, oleg@redhat.com, fweisbec@gmail.com,
        mingo@kernel.org, pedromfc@br.ibm.com, miltonm@us.ibm.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20200717040958.70561-1-ravi.bangoria@linux.ibm.com>
 <20200717040958.70561-10-ravi.bangoria@linux.ibm.com>
 <CACzsE9r0acLUkV35mVxy1AEK_xObs0yz+fD6UdbNdc6uz=Buqw@mail.gmail.com>
 <ccfcf488-0ec9-1737-8368-a848de1d72d1@linux.ibm.com>
 <87k0yxrtex.fsf@mpe.ellerman.id.au>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Message-ID: <d3e9bcc9-d73e-6726-edb5-cfdb771b1d61@linux.ibm.com>
Date:   Tue, 21 Jul 2020 19:03:04 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87k0yxrtex.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-21_08:2020-07-21,2020-07-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 clxscore=1015 mlxscore=0 malwarescore=0 bulkscore=0
 phishscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007210094
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/21/20 5:06 PM, Michael Ellerman wrote:
> Ravi Bangoria <ravi.bangoria@linux.ibm.com> writes:
>> On 7/20/20 9:12 AM, Jordan Niethe wrote:
>>> On Fri, Jul 17, 2020 at 2:11 PM Ravi Bangoria
>>> <ravi.bangoria@linux.ibm.com> wrote:
>>>>
>>>> So far Book3S Powerpc supported only one watchpoint. Power10 is
>>>> introducing 2nd DAWR. Enable 2nd DAWR support for Power10.
>>>> Availability of 2nd DAWR will depend on CPU_FTR_DAWR1.
>>>>
>>>> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
>>>> ---
>>>>    arch/powerpc/include/asm/cputable.h      | 4 +++-
>>>>    arch/powerpc/include/asm/hw_breakpoint.h | 5 +++--
>>>>    2 files changed, 6 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
>>>> index 3445c86e1f6f..36a0851a7a9b 100644
>>>> --- a/arch/powerpc/include/asm/cputable.h
>>>> +++ b/arch/powerpc/include/asm/cputable.h
>>>> @@ -633,7 +633,9 @@ enum {
>>>>     * Maximum number of hw breakpoint supported on powerpc. Number of
>>>>     * breakpoints supported by actual hw might be less than this.
>>>>     */
>>>> -#define HBP_NUM_MAX    1
>>>> +#define HBP_NUM_MAX    2
>>>> +#define HBP_NUM_ONE    1
>>>> +#define HBP_NUM_TWO    2
> 
>>> I wonder if these defines are necessary - has it any advantage over
>>> just using the literal?
>>
>> No, not really. Initially I had something like:
>>
>> #define HBP_NUM_MAX    2
>> #define HBP_NUM_P8_P9  1
>> #define HBP_NUM_P10    2
>>
>> But then I thought it's also not right. So I made it _ONE and _TWO.
>> Now the function that decides nr watchpoints dynamically (nr_wp_slots)
>> is in different file, I thought to keep it like this so it would be
>> easier to figure out why _MAX is 2.
> 
> I don't think it makes anything clearer.
> 
> I had to stare at it thinking there was some sort of mapping or
> indirection going on, before I realised it's just literally the number
> of breakpoints.
> 
> So please just do:
> 
> static inline int nr_wp_slots(void)
> {
>         return cpu_has_feature(CPU_FTR_DAWR1) ? 2 : 1;
> }
> 
> If you think HBP_NUM_MAX needs explanation then do that with a comment,
> it can refer to nr_wp_slots() if that's helpful.

Agreed. By adding a comment, we can remove those macros. Will change it.

Thanks,
Ravi
