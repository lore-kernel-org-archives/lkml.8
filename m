Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49EE6C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 22:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21D1B2073E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 22:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="u4njCZCc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730764AbgFVWCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 18:02:00 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50854 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730634AbgFVWB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 18:01:59 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05MLwLRH160428;
        Mon, 22 Jun 2020 22:01:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=CCgJV8PTfFcnadZ8v1sJiXpodQW9KDHDNAir5Ypvneo=;
 b=u4njCZCcNPDBdH6MGDrdycuDwRayYxhbSKKeu+HlKTiyFRFU/9snwR7UJGj16mm3r3R7
 JlBr+ZcfFzLJYZEuhsAB+9MG3Dd8rvR3WgoCDYMcEzliEcmC2ZufifnlRMG+DZs/jbdM
 6EMJK1IsUdvQKMCqqdy/DQSmsbyFbVwQ/p3GTsGK+hbOUsDk1vSG7Rgt6ZSYvx4KJTt1
 0kX/iTvRfE5z4jRKC0cQNvIWBFoYRNE+T3gsXHIZLP+DnWSys2TWZJSm/jpM3e8d1tVl
 PnLwLWdGIDDv0zroPrYjDYpVMlm5nAnt2cIOJf6kWlz75HcqpePxOB88GRPTgfUR3vN5 Wg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 31sebbhvhu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 22 Jun 2020 22:01:45 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05MLrbO8020941;
        Mon, 22 Jun 2020 22:01:44 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 31sv1mds0g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Jun 2020 22:01:44 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 05MM1ehe032343;
        Mon, 22 Jun 2020 22:01:40 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 22 Jun 2020 22:01:40 +0000
Subject: Re: [hugetlbfs] c0d0381ade: vm-scalability.throughput -33.4%
 regression
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
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <e140ec78-1fbd-73e2-7a11-7db3b714874d@oracle.com>
Date:   Mon, 22 Jun 2020 15:01:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200622005551.GK5535@shao2-debian>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9660 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006220141
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9660 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=999 cotscore=-2147483648 mlxscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 suspectscore=0 clxscore=1011
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006220141
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/21/20 5:55 PM, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed a -33.4% regression of vm-scalability.throughput due to commit:
> 
> 
> commit: c0d0381ade79885c04a04c303284b040616b116e ("hugetlbfs: use i_mmap_rwsem for more pmd sharing synchronization")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> in testcase: vm-scalability
> on test machine: 288 threads Intel(R) Xeon Phi(TM) CPU 7295 @ 1.50GHz with 80G memory
> with following parameters:
> 
> 	runtime: 300s
> 	size: 8T
> 	test: anon-cow-seq-hugetlb
> 	cpufreq_governor: performance
> 	ucode: 0x11
> 

Some performance regression is not surprising as the change includes acquiring
and holding the i_mmap_rwsem (in read mode) during hugetlb page faults.  33.4%
seems a bit high.  But, the test is primarily exercising the hugetlb page
fault path and little else.

The reason for taking the i_mmap_rwsem is to prevent PMD unsharing from
invalidating the pmd we are operating on.  This specific test case is operating
on anonymous private mappings.  So, PMD sharing is not possible and we can
eliminate acquiring the mutex in this case.  In fact, we should check all
mappings (even sharable) for the possibly of PMD sharing and only take the
mutex if necessary.  It will make the code a bit uglier, but will take care
of some of these regressions.  We still need to take the mutex in the case
of PMD sharing.  I'm afraid a regression is unavoidable in that case.

I'll put together a patch.
-- 
Mike Kravetz
