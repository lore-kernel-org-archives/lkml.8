Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB17C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 20:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF975206B8
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 20:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lUNcp7I1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbgICU6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 16:58:33 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38866 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbgICU6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 16:58:32 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 083KrfR5158586;
        Thu, 3 Sep 2020 20:58:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=fO3N/VN0fHfx53KJLvm/o+1PXllytVmLBw9NiqFC718=;
 b=lUNcp7I1OPTsvfkY9Euq10BwePdjs2W9PPUonHdCCtRPQlxLn1MqR1yFPTDrb4pDT27y
 NHdtks8T46vXfzb2VCJVDVh7nzLZK2LdaoEmnoGoAFuRu+HLCpPlK+LLqV/sw1GClMza
 5Ahak67qkx9f6qjUSdmZri7smCGzJPziys6qtGmN7epuH51pu4399NVNHSQLGv6PffqI
 Jdp+gN12jRfmzU6laB1xH0n7uVVP2tZQXSxep+H260LZJo4SGp8FhSOGy/vWpsVWmxKC
 /trO2MY+yTdqQd2l2s+teL6it96pa8GC2AuQTCVT8Wx4yWZNJ/qFUs6+iZ1U/Im+BRbN nA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 339dmn9m71-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 03 Sep 2020 20:58:01 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 083Kt6sn097106;
        Thu, 3 Sep 2020 20:58:01 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 33b7syrcq9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Sep 2020 20:58:00 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 083Kvu96020787;
        Thu, 3 Sep 2020 20:57:56 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 03 Sep 2020 13:57:56 -0700
Subject: Re: [RFC PATCH 00/16] 1GB THP support on x86_64
To:     Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>
Cc:     Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
        Rik van Riel <riel@surriel.com>,
        "Kirill A.Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Nellans <dnellans@nvidia.com>,
        linux-kernel@vger.kernel.org
References: <20200902180628.4052244-1-zi.yan@sent.com>
 <20200903073254.GP4617@dhcp22.suse.cz>
 <20200903162527.GF60440@carbon.dhcp.thefacebook.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <d64a67fd-17e0-644d-7b2b-2a557f0e35f7@oracle.com>
Date:   Thu, 3 Sep 2020 13:57:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200903162527.GF60440@carbon.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9733 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 spamscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009030187
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9733 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=0
 spamscore=0 clxscore=1011 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009030186
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/3/20 9:25 AM, Roman Gushchin wrote:
> On Thu, Sep 03, 2020 at 09:32:54AM +0200, Michal Hocko wrote:
>> On Wed 02-09-20 14:06:12, Zi Yan wrote:
>>> From: Zi Yan <ziy@nvidia.com>
>>>
>>> Hi all,
>>>
>>> This patchset adds support for 1GB THP on x86_64. It is on top of
>>> v5.9-rc2-mmots-2020-08-25-21-13.
>>>
>>> 1GB THP is more flexible for reducing translation overhead and increasing the
>>> performance of applications with large memory footprint without application
>>> changes compared to hugetlb.
>>
>> Please be more specific about usecases. This better have some strong
>> ones because THP code is complex enough already to add on top solely
>> based on a generic TLB pressure easing.
> 
> Hello, Michal!
> 
> We at Facebook are using 1 GB hugetlbfs pages and are getting noticeable
> performance wins on some workloads.
> 
> Historically we allocated gigantic pages at the boot time, but recently moved
> to cma-based dynamic approach. Still, hugetlbfs interface requires more management
> than we would like to do. 1 GB THP seems to be a better alternative. So I definitely
> see it as a very useful feature.
> 
> Given the cost of an allocation, I'm slightly skeptical about an automatic
> heuristics-based approach, but if an application can explicitly mark target areas
> with madvise(), I don't see why it wouldn't work.
> 
> In our case we'd like to have a reliable way to get 1 GB THPs at some point
> (usually at the start of an application), and transparently destroy them on
> the application exit.

Hi Roman,

In your current use case at Facebook, are you adding 1G hugetlb pages to
the hugetlb pool and then using them within applications?  Or, are you
dynamically allocating them at fault time (hugetlb overcommit/surplus)?

Latency time for use of such pages includes:
- Putting together 1G contiguous
- Clearing 1G memory

In the 'allocation at fault time' mode you incur both costs at fault time.
If using pages from the pool, your only cost at fault time is clearing the
page.
-- 
Mike Kravetz
