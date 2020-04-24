Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20300C55186
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 03:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03F2520706
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 03:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbgDXDnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 23:43:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:61792 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725823AbgDXDnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 23:43:07 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03O3gLck027909;
        Thu, 23 Apr 2020 23:42:36 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30ghu9npbr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Apr 2020 23:42:36 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 03O3gZIC028150;
        Thu, 23 Apr 2020 23:42:35 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30ghu9nnbs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Apr 2020 23:42:35 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 03O3RjWX003478;
        Fri, 24 Apr 2020 03:32:20 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma01fra.de.ibm.com with ESMTP id 30fs658g0r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Apr 2020 03:32:19 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03O3WHhk000350
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Apr 2020 03:32:17 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2F8B152050;
        Fri, 24 Apr 2020 03:32:17 +0000 (GMT)
Received: from [9.199.51.89] (unknown [9.199.51.89])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id D12BA5204E;
        Fri, 24 Apr 2020 03:32:13 +0000 (GMT)
Subject: Re: [PATCH v3 13/16] powerpc/watchpoint: Prepare handler to handle
 more than one watcnhpoint
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     mpe@ellerman.id.au, mikey@neuling.org, apopple@linux.ibm.com,
        paulus@samba.org, npiggin@gmail.com,
        naveen.n.rao@linux.vnet.ibm.com, peterz@infradead.org,
        jolsa@kernel.org, oleg@redhat.com, fweisbec@gmail.com,
        mingo@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20200414031659.58875-1-ravi.bangoria@linux.ibm.com>
 <20200414031659.58875-14-ravi.bangoria@linux.ibm.com>
 <67349339-03df-091a-47f0-78c1b14c5981@c-s.fr>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Message-ID: <f571127c-89b0-a333-be71-18f411dc6586@linux.ibm.com>
Date:   Fri, 24 Apr 2020 09:02:12 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <67349339-03df-091a-47f0-78c1b14c5981@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-23_19:2020-04-23,2020-04-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=695
 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0 adultscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 mlxscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004240020
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

>> @@ -101,14 +129,20 @@ static bool is_ptrace_bp(struct perf_event *bp)
>>    */
>>   void arch_unregister_hw_breakpoint(struct perf_event *bp)
>>   {
>> +    int i;
>> +
> 
> This declaration should be in the block using it.
> 
>>       /*
>>        * If the breakpoint is unregistered between a hw_breakpoint_handler()
>>        * and the single_step_dabr_instruction(), then cleanup the breakpoint
>>        * restoration variables to prevent dangling pointers.
>>        * FIXME, this should not be using bp->ctx at all! Sayeth peterz.
>>        */
>> -    if (bp->ctx && bp->ctx->task && bp->ctx->task != ((void *)-1L))
>> -        bp->ctx->task->thread.last_hit_ubp = NULL;
>> +    if (bp->ctx && bp->ctx->task && bp->ctx->task != ((void *)-1L)) {
> 
> Add declaration of 'int i' here.

How will that help? Keeping declaration at the start of function is also
common practice and I don't see any recommendation to move them inside
conditional block.

Thanks,
Ravi
