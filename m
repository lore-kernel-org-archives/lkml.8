Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A436C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 16:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 254ED207F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 16:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jS3wlQhL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731545AbgG1QqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 12:46:24 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:51262 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731367AbgG1QqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 12:46:24 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06SGQnYv075547;
        Tue, 28 Jul 2020 16:46:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=9Q2kYStNOHgpHWriBFxQkO5X/fGsC6hhvGvECKZaMr4=;
 b=jS3wlQhL9/pOFKYvl/K/hqMOo9fDCw9x4SvbCP8FSoZbj14yIzog5siK/4v2DzqM0KRZ
 lQXdQXsaGqAJ4JbbhJr9y5xhtl2x9wK2TkYClvx7zWsCSfnB3HuhXljoJIomFKRkAzp1
 J8EwhyZ4jVYfpgYUNPQYxhhm6Cqx2M/3NmYChUaClasKxSf1FSVbmiNSDN73JeMWNaY1
 ff0voXn+LX4xZZ7pcCHXzp+6k0jzgbMO9nV4RrIH4AAiBWUugda1VtQlFErR5u14tklS
 cK6F53Cl0vvzBlGzActaRLYPIJ/VbBLlwAEJd5KpArZrfs6LF1uEt5n6BkQ+vfNGhuGN 1w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 32hu1j8nfn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 28 Jul 2020 16:46:08 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06SGgiR4160123;
        Tue, 28 Jul 2020 16:46:08 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 32hu5udre9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jul 2020 16:46:08 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06SGk5DL014410;
        Tue, 28 Jul 2020 16:46:06 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 Jul 2020 09:46:05 -0700
Subject: Re: [PATCH v4] mm/hugetlb: add mempolicy check in the reservation
 routine
To:     Baoquan He <bhe@redhat.com>, Muchun Song <songmuchun@bytedance.com>
Cc:     akpm@linux-foundation.org, mhocko@kernel.org, rientjes@google.com,
        mgorman@suse.de, walken@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Jianchao Guo <guojianchao@bytedance.com>
References: <20200728034938.14993-1-songmuchun@bytedance.com>
 <20200728132453.GB14854@MiWiFi-R3L-srv>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <1b507031-d475-b495-bb4a-2cd9e665d02f@oracle.com>
Date:   Tue, 28 Jul 2020 09:46:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200728132453.GB14854@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9696 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007280125
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9696 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 clxscore=1015
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007280124
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/20 6:24 AM, Baoquan He wrote:
> Hi Muchun,
> 
> On 07/28/20 at 11:49am, Muchun Song wrote:
>> In the reservation routine, we only check whether the cpuset meets
>> the memory allocation requirements. But we ignore the mempolicy of
>> MPOL_BIND case. If someone mmap hugetlb succeeds, but the subsequent
>> memory allocation may fail due to mempolicy restrictions and receives
>> the SIGBUS signal. This can be reproduced by the follow steps.
>>
>>  1) Compile the test case.
>>     cd tools/testing/selftests/vm/
>>     gcc map_hugetlb.c -o map_hugetlb
>>
>>  2) Pre-allocate huge pages. Suppose there are 2 numa nodes in the
>>     system. Each node will pre-allocate one huge page.
>>     echo 2 > /proc/sys/vm/nr_hugepages
>>
>>  3) Run test case(mmap 4MB). We receive the SIGBUS signal.
>>     numactl --membind=0 ./map_hugetlb 4
> 
> I think supporting the  mempolicy of MPOL_BIND case is a good idea.
> I am wondering what about the other mempolicy cases, e.g MPOL_INTERLEAVE,
> MPOL_PREFERRED. Asking these because we already have similar handling in
> sysfs, proc nr_hugepages_mempolicy writting. Please see
> __nr_hugepages_store_common() for detail.

There is a high level difference in the function of this code and the code
called by the sysfs and proc interfaces.  This patch is dealing with reserving
huge pages in the pool for later use.  The sysfs and proc interfaces are
allocating huge pages to be added to the pool.

Using mempolicy to decide how to allocate huge pages is pretty straight
forward.  Using mempolicy to reserve pages is almost impossible to get
correct.  The comment at the beginning of hugetlb_acct_memory() and modified
by this patch summarizes the issues.

IMO, at this time it makes little sense to perform checks for more than
MPOL_BIND at reservation time.  If we ever take on the monumental task of
supporting mempolicy directed per-node reservations throughout the life of
a process, support for other policies will need to be taken into account.

-- 
Mike Kravetz
