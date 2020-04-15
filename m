Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FCE4C2BA2B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 04:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC46F20784
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 04:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="xiP4TU9+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgDOEHh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 00:07:37 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:49246 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbgDOEHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 00:07:33 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03F3xaBq062340;
        Wed, 15 Apr 2020 04:03:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=9NQ5WeNJ7Iv+24QC1+wY7jkwi8kOw5H1cwv/Zv7oQA8=;
 b=xiP4TU9+VcpcF3NEZPUqTz6u4PPJFd0SV4g38A5z62M/rswdIs+LEG32/U43bDi20KEC
 xmjuN0KMiXtdU6JwUFPslWVW7zAQ+sPhhDW0x4m0M8QVLGvw5585v52LCgN5rfBznhtb
 ukbCcJgfwf8PuUfcgtquJ7DHHFihsKj9HyfxQlm3vTc+DVBksQn70yOEa0aTo5ZTKR4/
 qXEJ2Q7PwBvxx2e2/kmyWXO2URvymWVkaqhxRZqTX3dDbgIg6d7/TyN0eqn5NBtrFAWb
 RVUC9OKhCMB8dW4Wxm0J/OMIZp0TfVNTmn5iPmH2GJ/0TSW47kgHoU9AXkqk7e7/GalQ sQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 30dn9cgycb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Apr 2020 04:03:59 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03F3vmBO154179;
        Wed, 15 Apr 2020 04:03:59 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 30dn98rv6y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Apr 2020 04:03:58 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03F43sjQ029144;
        Wed, 15 Apr 2020 04:03:55 GMT
Received: from [192.168.1.206] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 14 Apr 2020 21:03:54 -0700
Subject: Re: [PATCH] mm/hugetlb: avoid weird message in hugetlb_init
To:     Nitesh Narayan Lal <nitesh@redhat.com>,
        "Longpeng (Mike)" <longpeng2@huawei.com>
Cc:     arei.gonglei@huawei.com, huangzhichao@huawei.com,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Qian Cai <cai@lca.pw>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20200305033014.1152-1-longpeng2@huawei.com>
 <fe9af2ff-01de-93ce-9628-10a54543be07@oracle.com>
 <cb3da0cf-9d4e-633d-c098-cac16d876956@huawei.com>
 <43017337-fe28-16e0-fbdd-d6368bdd2eb2@oracle.com>
 <641eae15-1ea7-c573-0d64-09dcccc1717d@redhat.com>
 <f2bb2878-0584-6774-8e69-162a9ec68728@oracle.com>
 <aec9dc31-6858-3d3d-405e-8fc270167c4f@redhat.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <0b8d283f-dd31-b980-5d53-4bbca4014da7@oracle.com>
Date:   Tue, 14 Apr 2020 21:03:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <aec9dc31-6858-3d3d-405e-8fc270167c4f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9591 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004150028
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9591 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004150028
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/13/20 2:21 PM, Nitesh Narayan Lal wrote:
> 
> On 4/13/20 2:33 PM, Mike Kravetz wrote:
>> On 4/10/20 8:47 AM, Nitesh Narayan Lal wrote:
>>> Hi Mike,
>>>
>>> On platforms that support multiple huge page sizes when 'hugepagesz' is not
>>> specified before 'hugepages=', hugepages are not allocated. (For example
>>> if we are requesting 1GB hugepages)
>> Hi Nitesh,
>>
>> This should only be an issue with gigantic huge pages.  This is because
>> hugepages=X not following a hugepagesz=Y specifies the number of huge pages
>> of default size to allocate.  It does not currently work for gigantic pages.
> 
> I see, since we changed the default hugepages to gigantic pages and we missed
> 'hugepagesz=' no page were allocated of any type.
> 
>> In the other thread, I provided this explanation as to why:
>> It comes about because we do not definitively set the default huge page size
>> until after command line processing (in hugetlb_init).  And, we must
>> preallocate gigantic huge pages during command line processing because that
>> is when the bootmem allocater is available.
>>
>> I will be looking into modifying this behavior to allocate the pages as
>> expected, even for gigantic pages.
> 
> Nice, looking forward to it.
> 
>>
>>> In terms of reporting meminfo and /sys/kernel/../nr_hugepages reports the
>>> expected results but if we use sysctl vm.nr_hugepages then it reports a non-zero
>>> value as it reads the max_huge_pages from the default hstate instead of
>>> nr_huge_pages.
>>> AFAIK nr_huge_pages is the one that indicates the number of huge pages that are
>>> successfully allocated.
>>>
>>> Does vm.nr_hugepages is expected to report the maximum number of hugepages? If
>>> so, will it not make sense to rename the procname?
>>>
>>> However, if we expect nr_hugepages to report the number of successfully
>>> allocated hugepages then we should use nr_huge_pages in
>>> hugetlb_sysctl_handler_common().
>> This looks like a bug.  Neither sysctl or the /proc file should be reporting
>> a non-zero value if huge pages do not exist.
> 
> Yeap, as I mentioned it reports max_huge_pages instead of the nr_huge_pages.

Does this only happen when you specify gigantic pages as the default huge
page size and they are not allocated at boot time?  Or, are there other
situations where this happens?  If so, can you provide a sample of the
boot parameters used, or how to recreate.

I am fixing up the issue with gigantic pages, and suspect this will take
are of all the issues you are seeing.  This will be part of the command line
cleanup series.  Just want to make sure I am not missing something.
-- 
Mike Kravetz
