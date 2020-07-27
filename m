Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89DBBC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 23:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6690420809
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 23:09:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WzM2vOKu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbgG0XJ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 19:09:27 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:40548 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgG0XJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 19:09:26 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06RN7bfj146823;
        Mon, 27 Jul 2020 23:09:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=EM2szTfHxhcNcUnxiraVqc2XvgYTpD04zBO+/KMacU0=;
 b=WzM2vOKuGzSmDI5BQSg+1kvuvWOSQA21Ddj8KefCiR8DAtVL0/jgBtOKqVDZwZ2Ft/ji
 hsYYIDHrcdTpGzLuSKDiAVCx5yk1lNh5CwGdzNmAU5vjV4ToTk3SnywlWQ79QtDn1b6x
 P5tnlPYCXsHGjhlLwIsXyhy9xycl/0ctnU9SKmbocq0p02qdUqyewlqF9W8fQxFn6GZr
 LFJI+5Wo3P1V5y70Wg0+1ay3zPTVylBEWqw+kGJ0361gdn2JK2LHCGOwqMlip5Ucslqf
 UBAgikXNY+zLMOPaam98Iduy0nO1uV4PuIYdVD0qLBSGmFbOcci1LaDUT3LRtyozV/V4 cA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 32hu1j4afs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Jul 2020 23:09:17 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06RN8OC6072853;
        Mon, 27 Jul 2020 23:09:17 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 32hu5s0tvr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jul 2020 23:09:16 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06RN9DCr018180;
        Mon, 27 Jul 2020 23:09:13 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 27 Jul 2020 16:09:13 -0700
Subject: Re: [PATCH v3] mm/hugetlb: add mempolicy check in the reservation
 routine
To:     Muchun Song <songmuchun@bytedance.com>, akpm@linux-foundation.org,
        mhocko@kernel.org
Cc:     rientjes@google.com, mgorman@suse.de, walken@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jianchao Guo <guojianchao@bytedance.com>
References: <20200725080749.70470-1-songmuchun@bytedance.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <b2dd0138-ed3e-c704-0625-6b6158d5b434@oracle.com>
Date:   Mon, 27 Jul 2020 16:09:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200725080749.70470-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9695 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007270156
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9695 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 clxscore=1015 mlxscore=0 impostorscore=0
 phishscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007270156
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/20 1:07 AM, Muchun Song wrote:
> In the reservation routine, we only check whether the cpuset meets
> the memory allocation requirements. But we ignore the mempolicy of
> MPOL_BIND case. If someone mmap hugetlb succeeds, but the subsequent
> memory allocation may fail due to mempolicy restrictions and receives
> the SIGBUS signal. This can be reproduced by the follow steps.
> 
>  1) Compile the test case.
>     cd tools/testing/selftests/vm/
>     gcc map_hugetlb.c -o map_hugetlb
> 
>  2) Pre-allocate huge pages. Suppose there are 2 numa nodes in the
>     system. Each node will pre-allocate one huge page.
>     echo 2 > /proc/sys/vm/nr_hugepages
> 
>  3) Run test case(mmap 4MB). We receive the SIGBUS signal.
>     numactl --membind=0 ./map_hugetlb 4
> 
> With this patch applied, the mmap will fail in the step 3) and throw
> "mmap: Cannot allocate memory".
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Reported-by: Jianchao Guo <guojianchao@bytedance.com>
> Suggested-by: Michal Hocko <mhocko@kernel.org>

Thank you Muchun and Michal,

This patch forced me to once again look at the bad the interaction of
hugetlb reservations and cpusets or mempolicy.  This new code will help
produce a quick failure as described in the commit message, and it does
not make existing interactions any worse.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz
