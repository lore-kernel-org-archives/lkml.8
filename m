Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78AACC10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 09:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5625E2076D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 09:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbgCRJWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 05:22:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10118 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726586AbgCRJWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 05:22:38 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02I92rEt003434
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 05:22:36 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yua2aneww-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 05:22:36 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Wed, 18 Mar 2020 09:22:34 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 18 Mar 2020 09:22:30 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02I9MTSx63111330
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Mar 2020 09:22:29 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 093E252052;
        Wed, 18 Mar 2020 09:22:29 +0000 (GMT)
Received: from [9.203.170.80] (unknown [9.203.170.80])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 9A0BA5204F;
        Wed, 18 Mar 2020 09:22:07 +0000 (GMT)
Subject: Re: [PATCH 09/15] powerpc/watchpoint: Convert thread_struct->hw_brk
 to an array
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     mpe@ellerman.id.au, mikey@neuling.org, apopple@linux.ibm.com,
        paulus@samba.org, npiggin@gmail.com,
        naveen.n.rao@linux.vnet.ibm.com, peterz@infradead.org,
        jolsa@kernel.org, oleg@redhat.com, fweisbec@gmail.com,
        mingo@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20200309085806.155823-1-ravi.bangoria@linux.ibm.com>
 <20200309085806.155823-10-ravi.bangoria@linux.ibm.com>
 <0fc9489d-9955-f649-9007-ce6f5da345be@c-s.fr>
 <5efe2f41-2bf3-6927-aa6a-dcedb672c69d@linux.ibm.com>
 <a1794506-ada3-7b1e-2fa7-bcebf6ec9d68@c-s.fr>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date:   Wed, 18 Mar 2020 14:52:01 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <a1794506-ada3-7b1e-2fa7-bcebf6ec9d68@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20031809-0016-0000-0000-000002F31650
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031809-0017-0000-0000-000033569A90
Message-Id: <a41a244b-8eef-037e-42a1-8bf2e4275ca1@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-18_03:2020-03-17,2020-03-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=990 malwarescore=0 suspectscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 spamscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003180043
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/18/20 2:26 PM, Christophe Leroy wrote:
> 
> 
> Le 18/03/2020 à 09:36, Ravi Bangoria a écrit :
>>
>>
>> On 3/17/20 4:07 PM, Christophe Leroy wrote:
>>>
>>>
>>> Le 09/03/2020 à 09:58, Ravi Bangoria a écrit :
>>>> So far powerpc hw supported only one watchpoint. But Future Power
>>>> architecture is introducing 2nd DAWR. Convert thread_struct->hw_brk
>>>> into an array.
>>>
>>> Looks like you are doing a lot more than that in this patch.
>>>
>>> Should this patch be splitted in two parts ?
>>
>> So far thread_struct->hw_brk was a normal variable so accessing it was simple.
>> Once it gets converted into an array, loop needs to be used to access it. So
>> all misc changes are basically converting simple access into loops.
>>
>> I don't see how this can be splitted.
>>
> 
> You could first change all thread_struct->hw_brk to thread_struct->hw_brk[0] or thread_struct->hw_brk[i] when you know that i can only be 0 for now. Then add the loops and new functions in a second patch.

Ok. I've already tried that :) But it looked unnecessary split to
me because _all_ hw_brk => hw_brk[0] changes will again need to be
changed to use loop in 2nd patch. So I thought it's better to do
both changes in one patch.

Thanks,
Ravi

