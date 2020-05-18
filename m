Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E874EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 04:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C88F620809
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 04:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iQhUbUFw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbgEREQg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 00:16:36 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52138 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbgEREQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 00:16:36 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04I4EdwZ104806;
        Mon, 18 May 2020 04:16:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=ZRniTmpB+UuFRdeuuUX10p+GAyzdj6frhKbG345loM0=;
 b=iQhUbUFwwCYRvGdtY/721XmeKscPtlZjAoHaQXYgFwWTmjEbrHzJgdKFiFSuZ6qUZ7kg
 CaOVviH8ZY+JeFv9IifMOjouln3gYitVTq5O+ztHjMQn+dFFUYiJnCzkZv/REk1vsciQ
 0sOh1SYQykapEPD9h9sO4XzptjiSvwmhY7+V7NLTgVLSnVbMEpS4QI/hHXqWDfQsmEKM
 GyTSo5bCr7zsWGU6PFzO5utmKWvcVDm+VmakJzhOsb44Q2lfNj/vpmwGAXr4bAhCdNIX
 3J3tC0oNmyt7cy0uujC6zi63pnss7mKeaMkNT9xD/ibcgfbbJfGq8YQRgFNRS7rxOJum Zg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 3127kqvf82-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 18 May 2020 04:16:24 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04I4D1NT068398;
        Mon, 18 May 2020 04:16:23 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 312sxpjcwd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 May 2020 04:16:23 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04I4GL4V022308;
        Mon, 18 May 2020 04:16:22 GMT
Received: from [192.168.0.157] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 17 May 2020 21:16:21 -0700
Subject: Re: [PATCH v5] hugetlbfs: Get unmapped area below TASK_UNMAPPED_BASE
 for hugetlbfs
To:     Hushijie <hushijie3@huawei.com>
Cc:     "will@kernel.org" <will@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nixiaoming <nixiaoming@huawei.com>,
        "wangxu (AE)" <wangxu72@huawei.com>,
        "Wangkefeng (OS Kernel Lab)" <wangkefeng.wang@huawei.com>,
        yangerkun <yangerkun@huawei.com>,
        "Wangle (RTOS FAE)" <wangle6@huawei.com>,
        "Chengang (L)" <cg.chen@huawei.com>,
        "Chenjie (K)" <chenjie6@huawei.com>,
        "Huangjianhui (Alex)" <alex.huangjianhui@huawei.com>
References: <87d618c778584d2386c0f0c81be6319b@huawei.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <273e15fc-8b54-84d0-992c-76e4598d1590@oracle.com>
Date:   Sun, 17 May 2020 21:16:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <87d618c778584d2386c0f0c81be6319b@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9624 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005180038
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9624 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 clxscore=1015 priorityscore=1501 mlxscore=0 impostorscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 cotscore=-2147483648
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005180037
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/16/20 12:47 AM, Hushijie wrote:
>> On 5/14/20 7:31 AM, Shijie Hu wrote:
>>> +	if (mm->get_unmapped_area == arch_get_unmapped_area)
>>> +		return hugetlb_get_unmapped_area_bottomup(file, addr, len,
>>> +				pgoff, flags);
>>> +	return hugetlb_get_unmapped_area_topdown(file, addr, len,
>>> +			pgoff, flags);
>>
>> I like this code using the value of mm->get_unmapped_area to determine
>> which routine to call.  It is used by a few architectures.   However, I
>> noticed that on at least one architecture (powerpc) mm->get_unmapped_area
>> may be assigned to routines other than arch_get_unmapped_area or
>> arch_get_unmapped_area_topdown.  In such a case, we would call the 'new'
>> topdown routine.  I would prefer that we call the bottomup routine in this
>> default case.
>>
>> In reality, this does not impact powerpc as that architecture has it's
>> own hugetlb_get_unmapped_area routine.
>>
> 
> Yes, I also noticed this before, powerpc uses radix__arch_get_unmapped_area*() 
> when CONFIG_PPC_RADIX_MMU opened as 'y' and radix_enabled() returns 
> true. However, powerpc implemented its own hugetlb_get_unmapped_area(). This
> patch actually has no effect on powerpc.
> 
>> Because of this, I suggest we add a comment above this code and switch
>> the if/else order.  For example,
>>
>> +       /*
>> +        * Use mm->get_unmapped_area value as a hint to use topdown routine.
>> +        * If architectures have special needs, they should define their own
>> +        * version of hugetlb_get_unmapped_area.
>> +        */
>> +       if (mm->get_unmapped_area == arch_get_unmapped_area_topdown)
>> +               return hugetlb_get_unmapped_area_topdown(file, addr, len,
>> +                               pgoff, flags);
>> +       return hugetlb_get_unmapped_area_bottomup(file, addr, len,
>> +                       pgoff, flags);
>>
>> Thoughts?
>> -- 
>> Mike Kravetz
>>
> I agree with you. It's clever to switch the if/else order. If there is such
> a case, mm->get_unmapped_area() is neihter arch_get_unmapped_area() nor
> arch_get_unmapped_area_topdown(), it is indeed more appropriate to make the
> bottomup routine as the default behavior.
> 
> May I put this code and comment you show above into patch v6 and add 
> "Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>" to it?

Feel free to add this code and my Signed-off-by.

I assume this still works for your use case.  Correct?
-- 
Mike Kravetz
