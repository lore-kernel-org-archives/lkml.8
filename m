Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89A0C10F25
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 20:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 744E9206D7
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 20:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TncCXCWT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgCFUMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 15:12:37 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:37730 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgCFUMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 15:12:37 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 026K4OQp102474;
        Fri, 6 Mar 2020 20:12:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=VmYC9Cb7z5Eh1PZNw2fzoRVeEN/Leq6vW/IaT9jR/ow=;
 b=TncCXCWTzGGbLXYWgRCJE9Bb0mSRswT66DxyyZiZ8zv6/mhApTw8oQkByQMH213zu/le
 Dop6cpx0zzm+nhne4vwf9FvOAYy5TKhnMOBb3+LSzE845rJzu7z6BV54ulJAeYpZVcAE
 Z2fOOvuPUY4KLybwGqvnw/FZY5ThsEINlSipfNlgzHzfgAAwmSyplz9qdzVY0IhF6gz2
 audFluzI9i2rpz8cXenKD/6NLE/z9kwqkZ7RN9JW+/quBgniT9GyTH3g/n3PM4UlnEVo
 ka7FGbyvFa17jhhLBGdlaZUaU3o2VK7gIuqtuL38kigyunwJYo4sr534GvonLMz2od8p Bw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2ykgys3xy3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Mar 2020 20:12:22 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 026K3TVo133796;
        Fri, 6 Mar 2020 20:12:21 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2yjuf4ey36-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Mar 2020 20:12:21 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 026KCE1i004505;
        Fri, 6 Mar 2020 20:12:14 GMT
Received: from [192.168.1.206] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 06 Mar 2020 12:12:14 -0800
Subject: Re: [PATCH] mm/hugetlb: avoid weird message in hugetlb_init
To:     "Longpeng (Mike)" <longpeng2@huawei.com>
Cc:     arei.gonglei@huawei.com, huangzhichao@huawei.com,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Qian Cai <cai@lca.pw>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20200305033014.1152-1-longpeng2@huawei.com>
 <fe9af2ff-01de-93ce-9628-10a54543be07@oracle.com>
 <cb3da0cf-9d4e-633d-c098-cac16d876956@huawei.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <43017337-fe28-16e0-fbdd-d6368bdd2eb2@oracle.com>
Date:   Fri, 6 Mar 2020 12:12:13 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <cb3da0cf-9d4e-633d-c098-cac16d876956@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9552 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 malwarescore=0
 bulkscore=0 adultscore=0 suspectscore=2 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003060121
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9552 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 lowpriorityscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0 phishscore=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003060121
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/5/20 10:36 PM, Longpeng (Mike) wrote:
> 在 2020/3/6 8:09, Mike Kravetz 写道:
>> On 3/4/20 7:30 PM, Longpeng(Mike) wrote:
>>> From: Longpeng <longpeng2@huawei.com>
> 
>> I am thinking we may want to have a more generic solution by allowing
>> the default_hugepagesz= processing code to verify the passed size and
>> set up the corresponding hstate.  This would require more cooperation
>> between architecture specific and independent code.  This could be
>> accomplished with a simple arch_hugetlb_valid_size() routine provided
>> by the architectures.  Below is an untested patch to add such support
>> to the architecture independent code and x86.  Other architectures would
>> be similar.
>>
>> In addition, with architectures providing arch_hugetlb_valid_size() it
>> should be possible to have a common routine in architecture independent
>> code to read/process hugepagesz= command line arguments.
>>
> I just want to use the minimize changes to address this issue, so I choosed a
> way which my patch did.
> 
> To be honest, the approach you suggested above is much better though it need
> more changes.
> 
>> Of course, another approach would be to simply require ALL architectures
>> to set up hstates for ALL supported huge page sizes.
>>
> I think this is also needed, then we can request all supported size of hugepages
> by sysfs(e.g. /sys/kernel/mm/hugepages/*) dynamically. Currently, (x86) we can
> only request 1G-hugepage through sysfs if we boot with 'default_hugepagesz=1G',
> even with the first approach.

I 'think' you can use sysfs for 1G huge pages on x86 today.  Just booted a
system without any hugepage options on the command line.

# cat /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
0
# cat /sys/kernel/mm/hugepages/hugepages-1048576kB/^Cugepages
# echo 1 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
# cat /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
1
# cat /sys/kernel/mm/hugepages/hugepages-1048576kB/free_hugepages
1

x86 and riscv will set up hstates for PUD_SIZE hstates by default if
CONFIG_CONTIG_ALLOC.  This is because of a somewhat recent feature that
allowed dynamic allocation of gigantic (page order >= MAX_ORDER) pages.
Before that feature, it made no sense to set up an hstate for gigantic
pages if they were not allocated at boot time and could not be dynamically
added later.

I'll code up a proposal that does the following:
- Have arch specific code provide a list of supported huge page sizes
- Arch independent code uses list to create all hstates
- Move processing of "hugepagesz=" to arch independent code
- Validate "default_hugepagesz=" when value is read from command line

It make take a few days.  When ready, I will pull in the architecture
specific people.


> BTW, because it's not easy to discuss with you due to the time difference, I
> have another question about the default hugepages to consult you here. Why the
> /proc/meminfo only show the info about the default hugepages, but not others?
> meminfo is more well know than sysfs, some ordinary users know meminfo but don't
> know use the sysfs to get the hugepages status(e.g. total, free).

I believe that is simply history.  In the beginning there was only the
default huge page size and that was added to meminfo.  People then wrote
scripts to parse huge page information in meminfo.  When support for
other huge pages was added, it was not added to meminfo as it could break
user scripts parsing the file.  Adding information for all potential
huge page sizes may create lots of entries that are unused.  I was not
around when these decisions were made, but that is my understanding.
BTW - A recently added meminfo field 'Hugetlb' displays the amount of
memory consumed by huge pages of ALL sizes.
-- 
Mike Kravetz
