Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C283C35671
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 13:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FCEF20684
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 13:17:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbgBVNRS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 08:17:18 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:62176 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726839AbgBVNRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 08:17:18 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01MD4S1N145188
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2020 08:17:16 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2yb1apnabw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2020 08:17:16 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Sat, 22 Feb 2020 13:17:14 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 22 Feb 2020 13:17:12 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01MDHBtJ46072260
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Feb 2020 13:17:11 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AB040A404D;
        Sat, 22 Feb 2020 13:17:11 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4BB04A4040;
        Sat, 22 Feb 2020 13:17:00 +0000 (GMT)
Received: from [9.199.56.192] (unknown [9.199.56.192])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat, 22 Feb 2020 13:16:59 +0000 (GMT)
Subject: Re: [PATCH] powerpc/watchpoint: Don't call dar_within_range() for
 Book3S
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     mpe@ellerman.id.au, mikey@neuling.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20200222082049.330435-1-ravi.bangoria@linux.ibm.com>
 <d2aad6ea-5b61-7321-13a6-5faef361c57d@c-s.fr>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date:   Sat, 22 Feb 2020 18:46:55 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <d2aad6ea-5b61-7321-13a6-5faef361c57d@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20022213-0016-0000-0000-000002E9447B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022213-0017-0000-0000-0000334C6734
Message-Id: <22698949-553b-c15d-27b1-983d3fb47507@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-22_03:2020-02-21,2020-02-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=999 malwarescore=0 mlxscore=0 adultscore=0
 phishscore=0 bulkscore=0 clxscore=1015 impostorscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002220116
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/22/20 4:56 PM, Christophe Leroy wrote:
> 
> 
> On 02/22/2020 08:20 AM, Ravi Bangoria wrote:
>> DAR is set to the first byte of overlap between actual access and
>> watched range at DSI on Book3S processor. But actual access range
>> might or might not be within user asked range. So for Book3S, it
>> must not call dar_within_range().
>>
>> This revert portion of commit 39413ae00967 ("powerpc/hw_breakpoints:
>> Rewrite 8xx breakpoints to allow any address range size.").
>>
>> Before patch:
>>    # ./tools/testing/selftests/powerpc/ptrace/perf-hwbreak
>>    ...
>>    TESTED: No overlap
>>    FAILED: Partial overlap: 0 != 2
>>    TESTED: Partial overlap
>>    TESTED: No overlap
>>    FAILED: Full overlap: 0 != 2
>>    failure: perf_hwbreak
>>
>> After patch:
>>    TESTED: No overlap
>>    TESTED: Partial overlap
>>    TESTED: Partial overlap
>>    TESTED: No overlap
>>    TESTED: Full overlap
>>    success: perf_hwbreak
>>
>> Fixes: 39413ae00967 ("powerpc/hw_breakpoints: Rewrite 8xx breakpoints to allow any address range size.")
> 
> Oh, this seems to have been introduced by 27985b2a640e ("powerpc/watchpoint: Don't ignore extraneous exceptions blindly").
> 
> I must have lost it through a rebase as we were doing our series approximately at the same time, sorry for that.
> 
> Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>

No worries. Thanks for the review :)

Ravi

