Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20C2C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 12:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A08324676
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 12:29:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbgANM3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 07:29:12 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37520 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726195AbgANM3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 07:29:12 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00ECRmZr054026
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 07:29:10 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xfvvbx14p-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 07:29:10 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Tue, 14 Jan 2020 12:29:08 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 14 Jan 2020 12:29:05 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00ECSFwo41615678
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jan 2020 12:28:15 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 562AE4C050;
        Tue, 14 Jan 2020 12:29:04 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6F20F4C044;
        Tue, 14 Jan 2020 12:29:02 +0000 (GMT)
Received: from [9.85.105.10] (unknown [9.85.105.10])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 14 Jan 2020 12:29:02 +0000 (GMT)
Subject: Re: [PATCH v3 0/9] Fixup page directory freeing
To:     Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     akpm@linux-foundation.org, will@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
References: <20200114100145.365527-1-aneesh.kumar@linux.ibm.com>
 <20200114105002.GD2844@hirez.programming.kicks-ass.net>
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date:   Tue, 14 Jan 2020 17:58:58 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200114105002.GD2844@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20011412-4275-0000-0000-0000039770B4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20011412-4276-0000-0000-000038AB69A8
Message-Id: <ed2e6567-30db-a3c7-2973-a307bf2dfa7b@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-14_03:2020-01-13,2020-01-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 mlxlogscore=619 phishscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 bulkscore=0 suspectscore=2 lowpriorityscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001140105
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/14/20 4:20 PM, Peter Zijlstra wrote:
> On Tue, Jan 14, 2020 at 03:31:36PM +0530, Aneesh Kumar K.V wrote:
>> This is a repost of patch series from Peter with the arch specific changes except ppc64 dropped.
>> ppc64 changes are added here because we are redoing the patch series on top of ppc64 changes. This makes it
>> easy to backport these changes. Only the first 3 patches need to be backported to stable.
>>
>> The thing is, on anything SMP, freeing page directories should observe the
>> exact same order as normal page freeing:
>>
>>   1) unhook page/directory
>>   2) TLB invalidate
>>   3) free page/directory
>>
>> Without this, any concurrent page-table walk could end up with a Use-after-Free.
>> This is esp. trivial for anything that has software page-table walkers
>> (HAVE_FAST_GUP / software TLB fill) or the hardware caches partial page-walks
>> (ie. caches page directories).
>>
>> Even on UP this might give issues since mmu_gather is preemptible these days.
>> An interrupt or preempted task accessing user pages might stumble into the free
>> page if the hardware caches page directories.
>>
>> This patch series fixup ppc64 and add generic MMU_GATHER changes to support the conversion of other architectures.
>> I haven't added patches w.r.t other architecture because they are yet to be acked.
> 
> Obviously looks good to me; will you route this through the Power tree
> since you're in a hurry to see this fixed?
> 

Michael,

Can you take this via your tree?

-aneesh

