Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66FFC433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 21:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF1B12067D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 21:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Yh2iAWYP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbgGNVMR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 17:12:17 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:48032 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbgGNVMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 17:12:17 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06EKtOu4069740;
        Tue, 14 Jul 2020 21:12:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=ntwITgDlCNnMl4sAC0C0ThmwSxWIuQYTwTUOGx4B2X0=;
 b=Yh2iAWYPCxuMrcSHXr6xdbX2bJpucnK7duJ+qcMdhXceR9w7iw5G62yI67IaSRLY8kyQ
 SmtfRuO68fEhKdkoxFHhfPRaI+w68A8rJpdQxjV3MDJWITDJqBhl8uOyyotPQBphq1y/
 3W29cWBGX9ht1yxZuqjv9w7NKq2zk15O2P1aW64BxefyXNDujPigmr5VbKjBbhIaQPph
 Q4BfYkwpdy9I+DY3jbQnufZKYacS1dAmn6M8hWJMsuIBabYlo2Zr7Wwg83m3awL8LAST
 Hf2rqi49xx429P0ZMDyX/H/XVKiJH3dOIjffuDemA8+M49qxPcVJtudg51+HtmtGN8la VQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 3275cm7v8b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 14 Jul 2020 21:12:07 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06EKraL0056099;
        Tue, 14 Jul 2020 21:12:06 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 327qb58wve-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jul 2020 21:12:06 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06ELC4au006456;
        Tue, 14 Jul 2020 21:12:04 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 14 Jul 2020 14:12:04 -0700
Subject: Re: [PATCH] mm/hugetlb: hide nr_nodes in the internal of
 for_each_node_mask_to_[alloc|free]
To:     Vlastimil Babka <vbabka@suse.cz>,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20200714073404.84863-1-richard.weiyang@linux.alibaba.com>
 <cd1651a0-35c6-7535-5782-ce7e31cc26e8@suse.cz>
 <807a1e32-926b-2882-740b-6484b8dca2b6@suse.cz>
 <20200714095713.GA86690@L-31X9LVDL-1304.local>
 <e0d384a7-34bc-43ce-dc20-db4808b0f736@suse.cz>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <694bb1ac-4f9c-a6a5-7c87-1fc0cdd948a6@oracle.com>
Date:   Tue, 14 Jul 2020 14:12:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <e0d384a7-34bc-43ce-dc20-db4808b0f736@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9682 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 spamscore=0 phishscore=0 suspectscore=2 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007140145
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9682 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 priorityscore=1501
 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 clxscore=1011 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007140145
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/20 3:02 AM, Vlastimil Babka wrote:
> On 7/14/20 11:57 AM, Wei Yang wrote:
>> On Tue, Jul 14, 2020 at 11:22:03AM +0200, Vlastimil Babka wrote:
>>> On 7/14/20 11:13 AM, Vlastimil Babka wrote:
>>>> On 7/14/20 9:34 AM, Wei Yang wrote:
>>>>> The second parameter of for_each_node_mask_to_[alloc|free] is a loop
>>>>> variant, which is not used outside of loop iteration.
>>>>>
>>>>> Let's hide this.
>>>>>
>>>>> Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
>>>>> ---
>>>>>  mm/hugetlb.c | 38 ++++++++++++++++++++------------------
>>>>>  1 file changed, 20 insertions(+), 18 deletions(-)
>>>>>
>>>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>>>> index 57ece74e3aae..9c3d15fb317e 100644
>>>>> --- a/mm/hugetlb.c
>>>>> +++ b/mm/hugetlb.c
>>>>> @@ -1196,17 +1196,19 @@ static int hstate_next_node_to_free(struct hstate *h, nodemask_t *nodes_allowed)
>>>>>  	return nid;
>>>>>  }
>>>>>  
>>>>> -#define for_each_node_mask_to_alloc(hs, nr_nodes, node, mask)		\
>>>>> -	for (nr_nodes = nodes_weight(*mask);				\
>>>>> -		nr_nodes > 0 &&						\
>>>>> +#define for_each_node_mask_to_alloc(hs, node, mask)			\
>>>>> +	int __nr_nodes;							\
>>>>> +	for (__nr_nodes = nodes_weight(*mask);				\
>>>>
>>>> The problem with this is that if I use the macro twice in the same block, this
>>>> will redefine __nr_nodes and fail to compile, no?
>>>> In that case it's better to avoid setting up this trap, IMHO.
>>>
>>> Ah, and it will also generate the following warning, if the use of for_each*
>>> macro is not the first thing after variable declarations, but there's another
>>> statement before:
>>>
>>> warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
>>>
>>> Instead we should switch to C99 and declare it as "for (int __nr_nodes" :P
>>
>> Hmm... I tried what you suggested, but compiler complains.
>>
>> 'for' loop initial declarations are only allowed in C99 or C11 mode
> 
> Yes, by "we should switch to C99" I meant that the kernel kbuild system would
> need to switch. Not a trivial change...
> Without that, I don't see how your patch is possible to do safely.

Vlastimil, thanks for pointing out future potential issues with this patch.
I likely would have missed that.

Wei, thanks for taking the time to put together the patch.  However, I tend
to agree with Vlastimil's assesment.  The cleanup is not worth the risk of
running into issues if someone uses multiple instances of the macro.
-- 
Mike Kravetz
