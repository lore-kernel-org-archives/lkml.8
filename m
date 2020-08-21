Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC0FC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 21:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9F312076E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 21:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KOyfYDEZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgHUVC6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 17:02:58 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:54658 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbgHUVC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 17:02:57 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07LKl3oK023227;
        Fri, 21 Aug 2020 21:02:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=k1eN3uoSdP/1edExEjcRkv+N76Epw583pD1psXvHo0k=;
 b=KOyfYDEZ8T1TBuzNmCmiHoCm3ppwumzELctzmxhCfu2efsmShdKU30Rx5zueG8Ur30Dh
 h+ifoqxlzmUOrHGNF7lXZPSP6n6R2HUO6W4P5mniA6TPm5OI6sFiMn5D9BspyWNa0bnN
 LPyhvutNgM+kdnHYaBKQrPXEdzRcPPBoBOJoNZ27WzXbMdohmyHPBh612PlQ8tyYfGcH
 P7EpJ6ZiK0/7ndOkZfYMHHIuP9eLEPzr8i21xfam7HDFwCHJLJjjRA+MfjUeZDo1Krnr
 NwlDF6Dz+OgLj432MRiPocb8gIyBtJxOcUcQ1P3i+/8RJLL/lF/e+2qZKG+ixFHGsGv0 9Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 3327gcbt8g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 21 Aug 2020 21:02:42 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07LKmRNS110803;
        Fri, 21 Aug 2020 21:02:42 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 3325374s9v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Aug 2020 21:02:41 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07LL2dro000457;
        Fri, 21 Aug 2020 21:02:39 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 21 Aug 2020 21:02:38 +0000
Subject: Re: [LKP] Re: [hugetlbfs] c0d0381ade: vm-scalability.throughput
 -33.4% regression
To:     Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        kernel test robot <rong.a.chen@intel.com>
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
 <718e1653-b273-096b-0ee3-f720cf794612@oracle.com>
 <d945497d-0edb-f540-33e1-8b1ba1e20f62@linux.intel.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <691152ef-6787-9598-4445-fd2a0164f70f@oracle.com>
Date:   Fri, 21 Aug 2020 14:02:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d945497d-0edb-f540-33e1-8b1ba1e20f62@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9720 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 phishscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008210194
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9720 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 impostorscore=0 mlxscore=0 phishscore=0 mlxlogscore=999 clxscore=1011
 adultscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008210194
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/21/20 1:39 AM, Xing Zhengjun wrote:
> 
> 
> On 6/26/2020 5:33 AM, Mike Kravetz wrote:
>> On 6/22/20 3:01 PM, Mike Kravetz wrote:
>>> On 6/21/20 5:55 PM, kernel test robot wrote:
>>>> Greeting,
>>>>
>>>> FYI, we noticed a -33.4% regression of vm-scalability.throughput due to commit:
>>>>
>>>>
>>>> commit: c0d0381ade79885c04a04c303284b040616b116e ("hugetlbfs: use i_mmap_rwsem for more pmd sharing synchronization")
>>>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>>>>
>>>> in testcase: vm-scalability
>>>> on test machine: 288 threads Intel(R) Xeon Phi(TM) CPU 7295 @ 1.50GHz with 80G memory
>>>> with following parameters:
>>>>
>>>>     runtime: 300s
>>>>     size: 8T
>>>>     test: anon-cow-seq-hugetlb
>>>>     cpufreq_governor: performance
>>>>     ucode: 0x11
>>>>
>>>
>>> Some performance regression is not surprising as the change includes acquiring
>>> and holding the i_mmap_rwsem (in read mode) during hugetlb page faults.  33.4%
>>> seems a bit high.  But, the test is primarily exercising the hugetlb page
>>> fault path and little else.
>>>
>>> The reason for taking the i_mmap_rwsem is to prevent PMD unsharing from
>>> invalidating the pmd we are operating on.  This specific test case is operating
>>> on anonymous private mappings.  So, PMD sharing is not possible and we can
>>> eliminate acquiring the mutex in this case.  In fact, we should check all
>>> mappings (even sharable) for the possibly of PMD sharing and only take the
>>> mutex if necessary.  It will make the code a bit uglier, but will take care
>>> of some of these regressions.  We still need to take the mutex in the case
>>> of PMD sharing.  I'm afraid a regression is unavoidable in that case.
>>>
>>> I'll put together a patch.
>>
>> Not acquiring the mutex on faults when sharing is not possible is quite
>> straight forward.  We can even use the existing routine vma_shareable()
>> to easily check.  However, the next patch in the series 87bf91d39bb5
>> "hugetlbfs: Use i_mmap_rwsem to address page fault/truncate race" depends
>> on always acquiring the mutex.  If we break this assumption, then the
>> code to back out hugetlb reservations needs to be written.  A high level
>> view of what needs to be done is in the commit message for 87bf91d39bb5.
>>
>> I'm working on the code to back out reservations.
>>
> 
> I find that 34ae204f18519f0920bd50a644abd6fefc8dbfcf(hugetlbfs: remove call to huge_pte_alloc without i_mmap_rwsem) fixed this regression, I test with the patch, the regression reduced to 10.1%, do you have plan to continue to improve it? Thanks.

Thank you for testing!

Commit 34ae204f1851 was not created to address performance.  Rather it was
created more for the sake of correctness.

IIRC, this test is going to stress the page fault path by continuing to produce
faults for the duration of the test.  Commit 34ae204f1851 removed an unneeded,
somewhat dangerous and redundant call to huge_pte_alloc in the fault path.
Your testing showed that removing this call helped address a good amount of the
performance regression.  The series proposed in this thread attempts to
eliminate more potentially unnecessary code in the hugetlb fault path.
Specifically, it will only acquire the i_mmap_rwsem when necessary.

Would you be willing to test this series on top of 34ae204f1851?  I will need
to rebase the series to take the changes made by 34ae204f1851 into account.

BTW - I believe that shared hugetlb mappings are the most common use case.
In the shared case, acquiring i_mmap_rwsem is necessary if pmd sharing is
possible.  There is little we can do to eliminate this.  The test suite does
not appear to test shared mappings.
-- 
Mike Kravetz
