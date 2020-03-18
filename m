Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A113C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 12:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3561320767
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 12:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgCRMiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 08:38:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42112 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726647AbgCRMiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 08:38:06 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02ICXrwq004205
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 08:38:05 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yu7wcr9s6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 08:38:05 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Wed, 18 Mar 2020 12:38:02 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 18 Mar 2020 12:37:59 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02ICbvuv48365752
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Mar 2020 12:37:57 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 996C45204F;
        Wed, 18 Mar 2020 12:37:57 +0000 (GMT)
Received: from [9.199.38.35] (unknown [9.199.38.35])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 9D80B52052;
        Wed, 18 Mar 2020 12:35:52 +0000 (GMT)
Subject: Re: [PATCH 13/15] powerpc/watchpoint: Don't allow concurrent perf and
 ptrace events
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     mpe@ellerman.id.au, mikey@neuling.org, apopple@linux.ibm.com,
        paulus@samba.org, npiggin@gmail.com,
        naveen.n.rao@linux.vnet.ibm.com, peterz@infradead.org,
        jolsa@kernel.org, oleg@redhat.com, fweisbec@gmail.com,
        mingo@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20200309085806.155823-1-ravi.bangoria@linux.ibm.com>
 <20200309085806.155823-14-ravi.bangoria@linux.ibm.com>
 <673cf087-1422-84b3-e3bc-13c4dd491414@c-s.fr>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date:   Wed, 18 Mar 2020 18:05:44 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <673cf087-1422-84b3-e3bc-13c4dd491414@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20031812-0020-0000-0000-000003B67BA4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031812-0021-0000-0000-0000220EE50B
Message-Id: <ee92b133-c5f8-0191-a4b0-858794ebe69a@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-18_05:2020-03-18,2020-03-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003180061
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/17/20 4:38 PM, Christophe Leroy wrote:
> 
> 
> Le 09/03/2020 à 09:58, Ravi Bangoria a écrit :
>> ptrace and perf watchpoints on powerpc behaves differently. Ptrace
> 
> On the 8xx, ptrace generates signal after executing the instruction.

8xx logic is unchanged. I should have mentioned "Book3s DAWR".

> 
>> watchpoint works in one-shot mode and generates signal before executing
>> instruction. It's ptrace user's job to single-step the instruction and
>> re-enable the watchpoint. OTOH, in case of perf watchpoint, kernel
>> emulates/single-steps the instruction and then generates event. If perf
>> and ptrace creates two events with same or overlapping address ranges,
>> it's ambiguous to decide who should single-step the instruction. Because
>> of this issue ptrace and perf event can't coexist when the address range
>> overlaps.
> 
> Ok, and then ? What's the purpose of this (big) patch ?

Don't allow perf and ptrace watchpoint at the same time if their address
range overlaps.

...

>> +struct breakpoint {
>> +    struct list_head list;
>> +    struct perf_event *bp;
>> +    bool ptrace_bp;
>> +};
> 
> Don't we have an equivalent struct already ?

No. Using this we track percpu and perthread watchpoints for both perf and
ptrace. This problems is powerpc(DAWR) specific and thus we need to hook arch
specific logic in watchopint installation/uninstallation path.

...

>> +static bool bp_addr_range_overlap(struct perf_event *bp1, struct perf_event *bp2)
>> +{
>> +    __u64 bp1_saddr, bp1_eaddr, bp2_saddr, bp2_eaddr;
>> +
>> +    bp1_saddr = bp1->attr.bp_addr & ~HW_BREAKPOINT_ALIGN;
>> +    bp1_eaddr = (bp1->attr.bp_addr + bp1->attr.bp_len - 1) | HW_BREAKPOINT_ALIGN;
>> +    bp2_saddr = bp2->attr.bp_addr & ~HW_BREAKPOINT_ALIGN;
>> +    bp2_eaddr = (bp2->attr.bp_addr + bp2->attr.bp_len - 1) | HW_BREAKPOINT_ALIGN;
>> +
>> +    return (bp1_saddr <= bp2_eaddr && bp1_eaddr >= bp2_saddr);
> 
> Would be better with something like (HW_BREAKPOINT_SIZE needs to be defined).
> 
>      bp1_saddr = ALIGN_DOWN(bp1->attr.bp_addr, HW_BREAKPOINT_SIZE);
>      bp1_eaddr = ALIGN(bp1->attr.bp_addr, HW_BREAKPOINT_SIZE);
>      bp2_saddr = ALIGN_DOWN(bp2->attr.bp_addr, HW_BREAKPOINT_SIZE);
>      bp2_eaddr = ALIGN(bp2->attr.bp_addr, HW_BREAKPOINT_SIZE);
> 
>      return (bp1_saddr < bp2_eaddr && bp1_eaddr > bp2_saddr);

Ok.

Thanks,
Ravi

