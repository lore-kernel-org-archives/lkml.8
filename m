Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B037C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 06:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CBDA20719
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 06:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbgCXGOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 02:14:08 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56462 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725951AbgCXGOH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 02:14:07 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 423F98E17D8711737378;
        Tue, 24 Mar 2020 14:13:33 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 24 Mar
 2020 14:13:29 +0800
Subject: Re: [PATCH v5] f2fs: fix potential .flags overflow on 32bit
 architecture
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Joe Perches <joe@perches.com>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
References: <20200323031807.94473-1-yuchao0@huawei.com>
 <afa74570dacebb3b93d4b9c27d6c8a87186cef2d.camel@perches.com>
 <20200323151027.GA123526@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <e811683f-8906-a152-5d76-cd284fca6a2f@huawei.com>
Date:   Tue, 24 Mar 2020 14:13:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200323151027.GA123526@google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/3/23 23:10, Jaegeuk Kim wrote:
> On 03/23, Joe Perches wrote:
>> On Mon, 2020-03-23 at 11:18 +0800, Chao Yu wrote:
>>> f2fs_inode_info.flags is unsigned long variable, it has 32 bits
>>> in 32bit architecture, since we introduced FI_MMAP_FILE flag
>>> when we support data compression, we may access memory cross
>>> the border of .flags field, corrupting .i_sem field, result in
>>> below deadlock.
>> []
>>> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
>> []
>>> @@ -362,7 +362,7 @@ static int do_read_inode(struct inode *inode)
>>>  	fi->i_flags = le32_to_cpu(ri->i_flags);
>>>  	if (S_ISREG(inode->i_mode))
>>>  		fi->i_flags &= ~F2FS_PROJINHERIT_FL;
>>> -	fi->flags = 0;
>>> +	bitmap_zero(fi->flags, BITS_TO_LONGS(FI_MAX));
>>
>> Sorry, I misled you here, this should be
>>
>> 	bitmap_zero(fi->flags, FI_MAX);

Oh, I missed to check that as well. :(

> 
> Thanks, I applied this directly in the f2fs tree.

Thanks for the help.

Thanks,

> .
> 
