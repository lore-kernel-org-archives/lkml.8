Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE91C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 10:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C67D20786
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 10:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgHRKBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 06:01:42 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9758 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726145AbgHRKBm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 06:01:42 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 39D7F7C5D9FE4F502BC5;
        Tue, 18 Aug 2020 18:01:38 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 18 Aug
 2020 18:01:33 +0800
Subject: Re: [PATCH] f2fs: fix indefinite loop scanning for free nid
To:     Sahitya Tummala <stummala@codeaurora.org>
CC:     Jaegeuk Kim <jaegeuk@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <1597392335-4998-1-git-send-email-stummala@codeaurora.org>
 <e1251327-bd48-215d-e558-08780474bddb@huawei.com>
 <20200818095547.GA5062@codeaurora.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <cf2eb391-65a0-a309-6ab7-950ff6f1d660@huawei.com>
Date:   Tue, 18 Aug 2020 18:01:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200818095547.GA5062@codeaurora.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/8/18 17:55, Sahitya Tummala wrote:
> On Tue, Aug 18, 2020 at 04:29:05PM +0800, Chao Yu wrote:
>> On 2020/8/14 16:05, Sahitya Tummala wrote:
>>> If the sbi->ckpt->next_free_nid is not NAT block aligned and if there
>>> are free nids in that NAT block between the start of the block and
>>> next_free_nid, then those free nids will not be scanned in scan_nat_page().
>>> This results into mismatch between nm_i->available_nids and the sum of
>>> nm_i->free_nid_count of all NAT blocks scanned. And nm_i->available_nids
>>> will always be greater than the sum of free nids in all the blocks.
>>> Under this condition, if we use all the currently scanned free nids,
>>> then it will loop forever in f2fs_alloc_nid() as nm_i->available_nids
>>> is still not zero but nm_i->free_nid_count of that partially scanned
>>> NAT block is zero.
>>>
>>> Fix this to align the nm_i->next_scan_nid to the first nid of the
>>> corresponding NAT block.
>>>
>>> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
>>> ---
>>>   fs/f2fs/node.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
>>> index 9bbaa26..d615e59 100644
>>> --- a/fs/f2fs/node.c
>>> +++ b/fs/f2fs/node.c
>>> @@ -2402,6 +2402,8 @@ static int __f2fs_build_free_nids(struct f2fs_sb_info *sbi,
>>>   			if (IS_ERR(page)) {
>>>   				ret = PTR_ERR(page);
>>>   			} else {
>>> +				if (nid % NAT_ENTRY_PER_BLOCK)
>>> +					nid = NAT_BLOCK_OFFSET(nid) * NAT_ENTRY_PER_BLOCK;
>>
>> How about moving this logic to the beginning of __f2fs_build_free_nids(),
>> after nid reset?
>>
> 
> Sure, I will move it.
> 
>> BTW, it looks we can add unlikely in this judgment condition?
> 
> But it may not be an unlikely as it can happen whenever checkpoint is done,
> based on the next available free nid in function next_free_nid(), which can happen
> quite a few times, right?

Oh, yes, I missed that place, please ignore that suggestion.. :)

Thanks,

> 
> Hitting the loop forever issue condition due to this could be a rare/difficult to
> reproduce but this check itself may not be unlikely in my opinion.
> 
> Thanks,
> 
>>
>> Thanks,
>>
>>>   				ret = scan_nat_page(sbi, page, nid);
>>>   				f2fs_put_page(page, 1);
>>>   			}
>>>
> 
