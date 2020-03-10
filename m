Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1BFCC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 18:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66E15208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 18:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TyXQ9jl5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbgCJSeE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 14:34:04 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:59246 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbgCJSeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 14:34:03 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02AIOLpO169047;
        Tue, 10 Mar 2020 18:33:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=nSnnZ7g2cbXnihnvJKcHJLxpjIrf2X0eh4bFkB9OoxY=;
 b=TyXQ9jl5+TI0ibn9OXAShxhDty94+FDTJMg1Gawvp6oHOr6bejSIS7/PnM6hsZrsdX5C
 EbwMCKJjofgIYnV1Ew2ofkDdbTObPU+H7myHtV1gNa2xbgwAya39deFpMsiAKU/ejW5G
 nhNh1HD4Uu1emOmaCt/IPmpL+5ZmRPzSHmvfaQPQR0ZkZCINhAvKKFZDXwrFiVMKomGL
 cI37g+iRjwoLwb4WlJ050W1sMvsAv7qcGqBPEy6wM7xEl4LETJhg06flsUcO1Xa0rpic
 s7wxB+a4SL/H6E/7iu+9clLhHo2TQ6fGoJ0DDm8M4IgsGtIuobE1TZyU0rSRugLVVI64 GQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2yp9v62eaw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Mar 2020 18:33:51 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02AIXkXs019662;
        Tue, 10 Mar 2020 18:33:50 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2yp8rkgefq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Mar 2020 18:33:50 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02AIXmfP031746;
        Tue, 10 Mar 2020 18:33:49 GMT
Received: from [192.168.1.206] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 10 Mar 2020 11:33:48 -0700
Subject: Re: [PATCH v2] mm: hugetlb: optionally allocate gigantic hugepages
 using cma
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org,
        Rik van Riel <riel@surriel.com>
References: <20200310002524.2291595-1-guro@fb.com>
 <5cfa9031-fc15-2bcc-adb9-9779285ef0f7@oracle.com>
 <20200310180558.GD85000@carbon.dhcp.thefacebook.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <4b78a8a9-7b5a-eb62-acaa-2677e615bea1@oracle.com>
Date:   Tue, 10 Mar 2020 11:33:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200310180558.GD85000@carbon.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9556 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0 mlxscore=0
 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003100110
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9556 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003100110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/20 11:05 AM, Roman Gushchin wrote:
> On Tue, Mar 10, 2020 at 10:27:01AM -0700, Mike Kravetz wrote:
>> On 3/9/20 5:25 PM, Roman Gushchin wrote:
>>> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
>>> index a74262c71484..ceeb06ddfd41 100644
>>> --- a/arch/x86/kernel/setup.c
>>> +++ b/arch/x86/kernel/setup.c
>>> @@ -16,6 +16,7 @@
>>>  #include <linux/pci.h>
>>>  #include <linux/root_dev.h>
>>>  #include <linux/sfi.h>
>>> +#include <linux/hugetlb.h>
>>>  #include <linux/tboot.h>
>>>  #include <linux/usb/xhci-dbgp.h>
>>>  
>>> @@ -1158,6 +1159,8 @@ void __init setup_arch(char **cmdline_p)
>>>  	initmem_init();
>>>  	dma_contiguous_reserve(max_pfn_mapped << PAGE_SHIFT);
>>>  
>>> +	hugetlb_cma_reserve();
>>> +
>>
>> I know this is called from arch specific code here to fit in with the timing
>> of CMA setup/reservation calls.  However, there really is nothing architecture
>> specific about this functionality.  It would be great IMO if we could make
>> this architecture independent.  However, I can not think of a straight forward
>> way to do this.
> 
> I agree. Unfortunately I have no better idea than having an arch-dependent hook.
> 
>>
>>>  	/*
>>>  	 * Reserve memory for crash kernel after SRAT is parsed so that it
>>>  	 * won't consume hotpluggable memory.
>> <snip>
>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> <snip>
>>> +void __init hugetlb_cma_reserve(void)
>>> +{
>>> +	unsigned long totalpages = 0;
>>> +	unsigned long start_pfn, end_pfn;
>>> +	phys_addr_t size;
>>> +	int nid, i, res;
>>> +
>>> +	if (!hugetlb_cma_size && !hugetlb_cma_percent)
>>> +		return;
>>> +
>>> +	if (hugetlb_cma_percent) {
>>> +		for_each_mem_pfn_range(i, MAX_NUMNODES, &start_pfn, &end_pfn,
>>> +				       NULL)
>>> +			totalpages += end_pfn - start_pfn;
>>> +
>>> +		size = PAGE_SIZE * (hugetlb_cma_percent * 100 * totalpages) /
>>> +			10000UL;
>>> +	} else {
>>> +		size = hugetlb_cma_size;
>>> +	}
>>> +
>>> +	pr_info("hugetlb_cma: reserve %llu, %llu per node\n", size,
>>> +		size / nr_online_nodes);
>>> +
>>> +	size /= nr_online_nodes;
>>> +
>>> +	for_each_node_state(nid, N_ONLINE) {
>>> +		unsigned long min_pfn = 0, max_pfn = 0;
>>> +
>>> +		for_each_mem_pfn_range(i, nid, &start_pfn, &end_pfn, NULL) {
>>> +			if (!min_pfn)
>>> +				min_pfn = start_pfn;
>>> +			max_pfn = end_pfn;
>>> +		}
>>> +
>>> +		res = cma_declare_contiguous(PFN_PHYS(min_pfn), size,
>>> +					     PFN_PHYS(max_pfn), (1UL << 30),
>>
>> The alignment is hard coded for x86 gigantic page size.  If this supports
>> more architectures or becomes arch independent we will need to determine
>> what this alignment should be.  Perhaps an arch specific call back to get
>> the alignment for gigantic pages.  That will require a little thought as
>> some arch's support multiple gigantic page sizes.
> 
> Good point!
> Should we take the biggest possible size as a reference?
> Or the smallest (larger than MAX_ORDER)?

As mentioned, it is pretty simple for architectures like x86 that only
have one gigantic page size.  Just a random thought, but since
hugetlb_cma_reserve is called from arch specific code perhaps the arch
code could pass in at least alignment as an argument to this function?
That way we can somewhat push the issue to the architectures.  For example,
power supports 16GB gigantic page size but I believe they are allocated
via firmware somehow.  So, they would not pass 16G as alignment.  In this
case setup of the CMA area is somewhat architecture dependent.  So, perhaps
the call from arch specific code is not such a bad idea.

With that in mind, we may want some type of coordination between arch
specific and independent code.  Right now, cmdline_parse_hugetlb_cma
is will accept a hugetlb_cma command line option without complaint even
if the architecture does not call hugetlb_cma_reserve.

Just a nit, but cma_declare_contiguous if going to round up size by alignment.  So, the actual reserved size may not match what is printed with,
+		pr_info("hugetlb_cma: successfully reserved %llu on node %d\n",
+			size, nid);

I found this out by testing code and specifying hugetlb_cma=2M.  Messages
in log were:
	kernel: hugetlb_cma: reserve 2097152, 1048576 per node
	kernel: hugetlb_cma: successfully reserved 1048576 on node 0
	kernel: hugetlb_cma: successfully reserved 1048576 on node 1
But, it really reserved 1GB per node.
-- 
Mike Kravetz
