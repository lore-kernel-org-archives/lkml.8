Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 991D9C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 07:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C1E622247
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 07:48:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgDTHs0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 03:48:26 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:47458 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725930AbgDTHs0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 03:48:26 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9753B57C67BC89FC2A2A;
        Mon, 20 Apr 2020 15:48:12 +0800 (CST)
Received: from [127.0.0.1] (10.166.215.235) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Mon, 20 Apr 2020
 15:48:03 +0800
Subject: Re: bcache: unlock new_nodes[i]->write_lock in btree_gc_coalesce
To:     Coly Li <colyli@suse.de>
CC:     <kmo@daterainc.com>, <linux-bcache@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, "wubo (T)" <wubo40@huawei.com>,
        Mingfangsen <mingfangsen@huawei.com>,
        Yanxiaodan <yanxiaodan@huawei.com>,
        linfeilong <linfeilong@huawei.com>
References: <f4a66326-5ac5-7089-a570-0e02ad3093fa@huawei.com>
 <c913f4bb-cbae-d8e5-e8cb-a3a527392b00@huawei.com>
 <94f5343a-66c6-713c-4ce9-78c12ae5fd7a@suse.de>
From:   Zhiqiang Liu <liuzhiqiang26@huawei.com>
Message-ID: <e4e1738c-7e42-5bb0-2e6b-3d7b1571f2c5@huawei.com>
Date:   Mon, 20 Apr 2020 15:48:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <94f5343a-66c6-713c-4ce9-78c12ae5fd7a@suse.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.166.215.235]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/4/20 15:10, Coly Li wrote:
> On 2020/4/20 14:55, Zhiqiang Liu wrote:
>> friendly ping...
>>
> 
> The patch is good. Just it would be better if the commit log can be more
> accurate and understandable for other readers who are not very familiar
> with bcache code.
> 
> Thanks.
> 
> 
> Coly Li

Thanks for your reply. I will try my best to rewrite the commit log.

Regards.
Zhiqiang Liu.

> 
> 
>> On 2020/4/15 19:42, Zhiqiang Liu wrote:
>>> From: Zhiqiang Liu <liuzhiqiang26@huawei.com>
>>>
>>> coccicheck reports:
>>>   drivers/md//bcache/btree.c:1538:1-7: preceding lock on line 1417
>>>
>>> After obtaining new_nodes[i]->write_lock, we may go to out_nocoalesce
>>> tag without releasing lock. Here, we add a new tag
>>> 'out_unlock_nocoalesce' before out_nocoalesce tag to release
>>> new_nodes[i]->write_lock.
>>>
>>> Fixes: 2a285686c1 ("bcache: btree locking rework")
>>> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
>>> ---
>>>  drivers/md/bcache/btree.c | 8 ++++++--
>>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
>>> index fa872df4e770..cad8b0b97e33 100644
>>> --- a/drivers/md/bcache/btree.c
>>> +++ b/drivers/md/bcache/btree.c
>>> @@ -1447,7 +1447,7 @@ static int btree_gc_coalesce(struct btree *b, struct btree_op *op,
>>>  			if (__set_blocks(n1, n1->keys + n2->keys,
>>>  					 block_bytes(b->c)) >
>>>  			    btree_blocks(new_nodes[i]))
>>> -				goto out_nocoalesce;
>>> +				goto out_unlock_nocoalesce;
>>>
>>>  			keys = n2->keys;
>>>  			/* Take the key of the node we're getting rid of */
>>> @@ -1476,7 +1476,7 @@ static int btree_gc_coalesce(struct btree *b, struct btree_op *op,
>>>
>>>  		if (__bch_keylist_realloc(&keylist,
>>>  					  bkey_u64s(&new_nodes[i]->key)))
>>> -			goto out_nocoalesce;
>>> +			goto out_unlock_nocoalesce;
>>>
>>>  		bch_btree_node_write(new_nodes[i], &cl);
>>>  		bch_keylist_add(&keylist, &new_nodes[i]->key);
>>> @@ -1522,6 +1522,10 @@ static int btree_gc_coalesce(struct btree *b, struct btree_op *op,
>>>  	/* Invalidated our iterator */
>>>  	return -EINTR;
>>>
>>> +out_unlock_nocoalesce:
>>> +	for (i = 0; i < nodes; i++)
>>> +		mutex_unlock(&new_nodes[i]->write_lock);
>>> +
>>>  out_nocoalesce:
>>>  	closure_sync(&cl);
>>>
>>
> 
> 

