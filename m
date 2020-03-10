Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB89C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 20:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8539421D56
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 20:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IrBzzs8j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbgCJUab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 16:30:31 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50790 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgCJUab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 16:30:31 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02AKORGc030331;
        Tue, 10 Mar 2020 20:29:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=DrfQ0lB3dy1nzGMLhPPmHwa4L9kAgVtVba/L2Jsmdtc=;
 b=IrBzzs8ja+WkDjS+PadjAa5HAdZ3GsdJGKbZCYkN1OoGMkd0kgfBsitjBZ/ck3u5D173
 k0vq02Aj9PBql4kCUc6rToEluwe5qGpJGMz5pWGbNzpMSMgYyOAPl9VfZXW+OeIuqTvK
 liX7D0xXUuRXeqWd9uQrrbaoG66Tu0JWwdBw36e7L4wSgseiPZjIx5hP1fmW6+V0ISw0
 5ZkkabdSSa4KlLSj9bJMEVNF9Xw63sQXlq58sM3rgpGMj3MMwiw5OFVbifaBHv1B/HhS
 zLGMkXuKPMNklG/CfAzjc8eDqTmvnUL2jG52ru+/Tlz6MID0P4n0pnGOAfo++noVr2h6 XQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2ym31ufx1w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Mar 2020 20:29:44 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02AKTa8r061306;
        Tue, 10 Mar 2020 20:29:43 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2yp8ptredq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Mar 2020 20:29:43 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02AKTCb8021082;
        Tue, 10 Mar 2020 20:29:12 GMT
Received: from [192.168.1.206] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 10 Mar 2020 13:29:12 -0700
Subject: Re: [PATCH v2] mm: hugetlb: optionally allocate gigantic hugepages
 using cma
To:     Rik van Riel <riel@surriel.com>, Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
References: <20200310002524.2291595-1-guro@fb.com>
 <5cfa9031-fc15-2bcc-adb9-9779285ef0f7@oracle.com>
 <20200310180558.GD85000@carbon.dhcp.thefacebook.com>
 <4b78a8a9-7b5a-eb62-acaa-2677e615bea1@oracle.com>
 <20200310191906.GA96999@carbon.dhcp.thefacebook.com>
 <20200310193622.GC8447@dhcp22.suse.cz>
 <43e2e8443288260aa305f39ba566f81bf065d010.camel@surriel.com>
 <57494a9c-5c24-20b6-0bda-dac8bbb6f731@oracle.com>
 <4147bc1d429a4336dcb45a6cb2657d082f35ab25.camel@surriel.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <c20a0d81-341f-caac-0e47-f8753fbb6dbe@oracle.com>
Date:   Tue, 10 Mar 2020 13:29:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <4147bc1d429a4336dcb45a6cb2657d082f35ab25.camel@surriel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9556 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003100119
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9556 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003100118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/20 1:15 PM, Rik van Riel wrote:
> On Tue, 2020-03-10 at 13:11 -0700, Mike Kravetz wrote:
>> On 3/10/20 12:46 PM, Rik van Riel wrote:
>>>
>>> How would that work for architectures that have multiple
>>> possible hugetlbfs gigantic page sizes, where the admin
>>> can allocate different numbers of differently sized pages
>>> after bootup?
>>
>> For hugetlb page reservations at boot today, pairs specifying size
>> and
>> quantity are put on the command line.  For example,
>> hugepagesz=2M hugepages=512 hugepagesz=1G hugepages=64
>>
>> We could do something similiar for CMA.
>> hugepagesz=512M hugepages_cma=256 hugepagesz=1G hugepages_cma=64
>>
>> That would make things much more complicated (implies separate CMA
>> reservations per size) and may be overkill for the first
>> implementation.
>>
>> Perhaps we limit CMA reservations to one gigantic huge page
>> size.  The
>> architectures would need to define the default and there could be a
>> command line option to override.  Something like,
>> default_cmapagesz=  analogous to today's default_hugepagesz=.  Then
>> hugepages_cma= is only associated with that default gigantic huge
>> page
>> size.
>>
>> The more I think about it, the more I like limiting CMA reservations
>> to
>> only one gigantic huge page size (per arch).
> 
> Why, though?
> 
> The cma_alloc function can return allocations of different
> sizes at the same time.
> 
> There is no limitation in the underlying code that would stop
> a user from allocating hugepages of different sizes through
> sysfs.

True, there is no technical reason.

I was only trying to simplify the setup and answer the outstanding questions.
- What alignment to use for reservations?
- What is minimum size of reservations?

If only one gigantic page size is supported, the answer is simple.  In any
case, I think input from arch specific code will be needed.
-- 
Mike Kravetz

> Allowing the system administrator to allocate a little extra
> memory for the CMA pool could also allow us to work around
> initial issues of compaction/migration failing to move some
> of the pages, while we play whack-a-mole with the last corner
> cases.
