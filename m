Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BDAFC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DA51206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I0bokXCD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbgGHRqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 13:46:04 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46686 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbgGHRqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 13:46:01 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 068HRmiv143784;
        Wed, 8 Jul 2020 17:45:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=SGcETknvroZPnOEphS/ri5hHqeOz1JhXChmVZzAmGPI=;
 b=I0bokXCDBqSMX5cA9s+1vma0ijyA+9PpPQmmuUxCgskx6HuvU7hLmDPzvD0VtRL+NPz8
 3GUcGntxSOpgCIIZmJDcHVY57HNX18uuWbpcgFtwUvHAI3VQnSVOGVkn5J2EYOyrLeR5
 3PMSsunSyGuJ98OGJ//93ZqvKmqNCqp4CzTUyPZlRdRa/2nF51uFy9k8tazUWnLhsNnp
 B3lfp0vpOU3XKbEZp2cBPQofJ6Eye+waCg5t/blp7FGe6AqRJe1mEIqqlFFUsgNfge5W
 FgGZgj3g/QrmVr+nsbduLxZMBs1YmXkhhXC+KreL3GOmdc6MH4zcXSIJ+vu9ilLkOQWh EQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 323wacr3q0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 08 Jul 2020 17:45:20 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 068HTFsr022300;
        Wed, 8 Jul 2020 17:45:19 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 3233br7db0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Jul 2020 17:45:19 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 068HjIUk008256;
        Wed, 8 Jul 2020 17:45:18 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 08 Jul 2020 10:45:17 -0700
Subject: Re: [PATCH v3] mm/hugetlb: avoid hardcoding while checking if cma is
 enable
To:     Andrew Morton <akpm@linux-foundation.org>,
        Barry Song <song.bao.hua@hisilicon.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Roman Gushchin <guro@fb.com>
References: <20200707040204.30132-1-song.bao.hua@hisilicon.com>
 <20200707125641.dbd2ccd63f525aa5870069d8@linux-foundation.org>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <9066e009-5ed2-1992-d70d-fd27b4bf5871@oracle.com>
Date:   Wed, 8 Jul 2020 10:45:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200707125641.dbd2ccd63f525aa5870069d8@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9676 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 adultscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007080111
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9676 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 spamscore=0 mlxlogscore=999 adultscore=0 cotscore=-2147483648
 suspectscore=0 impostorscore=0 bulkscore=0 mlxscore=0 clxscore=1011
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2007080111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/7/20 12:56 PM, Andrew Morton wrote:
> On Tue, 7 Jul 2020 16:02:04 +1200 Barry Song <song.bao.hua@hisilicon.com> wrote:
> 
>> hugetlb_cma[0] can be NULL due to various reasons, for example, node0 has
>> no memory. so NULL hugetlb_cma[0] doesn't necessarily mean cma is not
>> enabled. gigantic pages might have been reserved on other nodes.
> 
> I'm trying to figure out whether this should be backported into 5.7.1,
> but the changelog doesn't describe any known user-visible effects of
> the bug.  Are there any?

Barry must have missed this email.  He reported the issue so I was hoping
he would reply.

Based on the code changes, I believe the following could happen:
- Someone uses 'hugetlb_cma=' kernel command line parameter to reserve
  CMA for gigantic pages.
- The system topology is such that no memory is on node 0.  Therefore,
  no CMA can be reserved for gigantic pages on node 0.  CMA is reserved
  on other nodes.
- The user also specifies a number of gigantic pages to pre-allocate on
  the command line with hugepagesz=<gigantic_page_size> hugepages=<N>
- The routine which allocates gigantic pages from the bootmem allocator
  will not detect CMA has been reserved as there is no memory on node 0.
  Therefore, pages will be pre-allocated from bootmem allocator as well
  as reserved in CMA.

This double allocation (bootmem and CMA) is the worst case scenario.  Not
sure if this is what Barry saw, and I suspect this would rarely happen.

After writing this, I started to think that perhaps command line parsing
should be changed.  If hugetlb_cma= is specified, it makes no sense to
pre-allocate gigantic pages.  Therefore, the hugepages=<N> paramemter
should be ignored and flagged with a warning if  hugetlb_cma= is specified.
This could be checked at parsing time and there would be no need for such
a check in the allocation code (except for sanity cheching).

Thoughts?  I just cleaned up the parsing code and could make such a change
quite easily.
-- 
Mike Kravetz
