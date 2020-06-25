Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C120C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 21:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D51D20781
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 21:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="g4OfPnHj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407221AbgFYVdv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 17:33:51 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:54518 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406463AbgFYVdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 17:33:50 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05PLM3P7123610;
        Thu, 25 Jun 2020 21:33:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=krpcMCcVgqrHU4DozYxPJLFrcQvFdH0H3fHWBcByblE=;
 b=g4OfPnHj6bPVjnXho9D/R/RyP2UU9IDVzUcHKfYUgXzeKXJBuR0YOOtp2ttdv6OC9dzl
 XGct37bY4u4DNRRpgtxk8QOPEo1a3mP0eb3f/POW7REAr0e6TCX5/qh0sEc1CNsU4ssJ
 9w38Go2idTL7G0ZncmJ4CuNw17E2N0s4OErjGCpi/eQt2dIfvL6sAmqX1QBdk2oXJmXD
 U/3B+dQ0b39oHzQZAovsHaYiZF0ZuA8SAT/gjpyFKKVOU8ki93aVNuuwVfJYNY9GXS2s
 JOO4/wOc0tO+2RzJzBHE1mUPeXihr468ZI+/deg5l7WaEXmxw8r+QZul3/t0cbsSlcCL VQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 31uusu2yaj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 25 Jun 2020 21:33:33 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05PLO10Z092210;
        Thu, 25 Jun 2020 21:33:33 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 31uur1tdch-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Jun 2020 21:33:33 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05PLXUX9018695;
        Thu, 25 Jun 2020 21:33:30 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 25 Jun 2020 21:33:30 +0000
Subject: Re: [hugetlbfs] c0d0381ade: vm-scalability.throughput -33.4%
 regression
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A.Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
References: <20200622005551.GK5535@shao2-debian>
 <e140ec78-1fbd-73e2-7a11-7db3b714874d@oracle.com>
Message-ID: <718e1653-b273-096b-0ee3-f720cf794612@oracle.com>
Date:   Thu, 25 Jun 2020 14:33:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <e140ec78-1fbd-73e2-7a11-7db3b714874d@oracle.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9663 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006250125
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9663 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 cotscore=-2147483648 malwarescore=0 mlxscore=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 priorityscore=1501
 spamscore=0 impostorscore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006250125
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/22/20 3:01 PM, Mike Kravetz wrote:
> On 6/21/20 5:55 PM, kernel test robot wrote:
>> Greeting,
>>
>> FYI, we noticed a -33.4% regression of vm-scalability.throughput due to commit:
>>
>>
>> commit: c0d0381ade79885c04a04c303284b040616b116e ("hugetlbfs: use i_mmap_rwsem for more pmd sharing synchronization")
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>>
>> in testcase: vm-scalability
>> on test machine: 288 threads Intel(R) Xeon Phi(TM) CPU 7295 @ 1.50GHz with 80G memory
>> with following parameters:
>>
>> 	runtime: 300s
>> 	size: 8T
>> 	test: anon-cow-seq-hugetlb
>> 	cpufreq_governor: performance
>> 	ucode: 0x11
>>
> 
> Some performance regression is not surprising as the change includes acquiring
> and holding the i_mmap_rwsem (in read mode) during hugetlb page faults.  33.4%
> seems a bit high.  But, the test is primarily exercising the hugetlb page
> fault path and little else.
> 
> The reason for taking the i_mmap_rwsem is to prevent PMD unsharing from
> invalidating the pmd we are operating on.  This specific test case is operating
> on anonymous private mappings.  So, PMD sharing is not possible and we can
> eliminate acquiring the mutex in this case.  In fact, we should check all
> mappings (even sharable) for the possibly of PMD sharing and only take the
> mutex if necessary.  It will make the code a bit uglier, but will take care
> of some of these regressions.  We still need to take the mutex in the case
> of PMD sharing.  I'm afraid a regression is unavoidable in that case.
> 
> I'll put together a patch.

Not acquiring the mutex on faults when sharing is not possible is quite
straight forward.  We can even use the existing routine vma_shareable()
to easily check.  However, the next patch in the series 87bf91d39bb5
"hugetlbfs: Use i_mmap_rwsem to address page fault/truncate race" depends
on always acquiring the mutex.  If we break this assumption, then the
code to back out hugetlb reservations needs to be written.  A high level
view of what needs to be done is in the commit message for 87bf91d39bb5.

I'm working on the code to back out reservations.
-- 
Mike Kravetz
