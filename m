Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E7A9C2BBFD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 18:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42B4020735
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 18:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="zOuMqPky"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733014AbgDMSf7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 14:35:59 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:58700 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727904AbgDMSf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 14:35:58 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03DIYGCc128754;
        Mon, 13 Apr 2020 18:35:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=kHI/s/XL1uNxQtU+40CxGZHpcyxUeWj0KKl2D59WB0M=;
 b=zOuMqPkyNCMVhUGz0cyvPUrImA7yATaERnbDK55WpYkaQWvl2XQFezJjU9lCoE9tn0nK
 Ms/zIhw6wNfXLuYvHf2AU/tY0TQU8eAPrTryiNdW/isnvby/qFLlInnA4cuuEsMRaaEl
 ldBTMhguoF2kzGVvzq1JWe18zadosYjBYQT6M5yeVuQjEyYiBWe2b6xud1NSIJXxPblh
 sO/BS3EwbOHr0apGK60lDCZUFdRvEb4liX73F0Hf3pa05o9DXFkc3FCXrG7FTaT+YrKV
 3YZ3H5Tn3wzKz/lvJiVe/CcmsioPHxVqaNNAVu4FupiaAqaQQSUrOzyZ/2VyXIZr6ADE 4A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 30b5um07w1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Apr 2020 18:35:29 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03DI7nT8028022;
        Mon, 13 Apr 2020 18:33:29 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 30bqcew12y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Apr 2020 18:33:28 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03DIXPj8005391;
        Mon, 13 Apr 2020 18:33:26 GMT
Received: from [192.168.1.206] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 13 Apr 2020 11:33:25 -0700
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
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <f2bb2878-0584-6774-8e69-162a9ec68728@oracle.com>
Date:   Mon, 13 Apr 2020 11:33:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <641eae15-1ea7-c573-0d64-09dcccc1717d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9590 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004130139
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9590 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 bulkscore=0 mlxscore=0
 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004130140
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/20 8:47 AM, Nitesh Narayan Lal wrote:
> Hi Mike,
> 
> On platforms that support multiple huge page sizes when 'hugepagesz' is not
> specified before 'hugepages=', hugepages are not allocated. (For example
> if we are requesting 1GB hugepages)

Hi Nitesh,

This should only be an issue with gigantic huge pages.  This is because
hugepages=X not following a hugepagesz=Y specifies the number of huge pages
of default size to allocate.  It does not currently work for gigantic pages.
In the other thread, I provided this explanation as to why:
It comes about because we do not definitively set the default huge page size
until after command line processing (in hugetlb_init).  And, we must
preallocate gigantic huge pages during command line processing because that
is when the bootmem allocater is available.

I will be looking into modifying this behavior to allocate the pages as
expected, even for gigantic pages.

> In terms of reporting meminfo and /sys/kernel/../nr_hugepages reports the
> expected results but if we use sysctl vm.nr_hugepages then it reports a non-zero
> value as it reads the max_huge_pages from the default hstate instead of
> nr_huge_pages.
> AFAIK nr_huge_pages is the one that indicates the number of huge pages that are
> successfully allocated.
> 
> Does vm.nr_hugepages is expected to report the maximum number of hugepages? If
> so, will it not make sense to rename the procname?
> 
> However, if we expect nr_hugepages to report the number of successfully
> allocated hugepages then we should use nr_huge_pages in
> hugetlb_sysctl_handler_common().

This looks like a bug.  Neither sysctl or the /proc file should be reporting
a non-zero value if huge pages do not exist.
-- 
Mike Kravetz
