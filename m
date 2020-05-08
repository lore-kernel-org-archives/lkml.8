Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD60C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 07:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4A0C208D6
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 07:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbgEHHJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 03:09:16 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4293 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725991AbgEHHJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 03:09:15 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5FCB6F3B03B25BE65E27;
        Fri,  8 May 2020 15:09:10 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.206) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 8 May 2020
 15:09:07 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: remove race condition in releasing
 cblocks
To:     Daeho Jeong <daeho43@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <kernel-team@android.com>, Daeho Jeong <daehojeong@google.com>
References: <20200508042506.143395-1-daeho43@gmail.com>
 <4dfb73d9-03a0-bb2f-a112-1dd42db4d7bb@huawei.com>
 <CACOAw_z0BU3t7V+BN7TvaO96GckwNh2SRLreGxO60EDbMb_epw@mail.gmail.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <cd08c824-c5d3-9603-7a81-a48cb191ac99@huawei.com>
Date:   Fri, 8 May 2020 15:09:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACOAw_z0BU3t7V+BN7TvaO96GckwNh2SRLreGxO60EDbMb_epw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/5/8 14:58, Daeho Jeong wrote:
> I moved checking i_compr_blocks phrase after calling inode_lock()
> already, because we should check this after writing pages.
> 
> So, if it fails to check i_compr_blocks, we need to call inode_unlock().
> 
> Am I missing something?

After applying this patch, I get this:

	ret = mnt_want_write_file(filp);
	if (ret)
		return ret;

	if (!F2FS_I(inode)->i_compr_blocks)
		goto out;

	f2fs_balance_fs(F2FS_I_SB(inode), true);

	inode_lock(inode);

> 
> 2020년 5월 8일 (금) 오후 3:50, Chao Yu <yuchao0@huawei.com>님이 작성:
>>
>> On 2020/5/8 12:25, Daeho Jeong wrote:
>>> From: Daeho Jeong <daehojeong@google.com>
>>>
>>> Now, if writing pages and releasing compress blocks occur
>>> simultaneously, and releasing cblocks is executed more than one time
>>> to a file, then total block count of filesystem and block count of the
>>> file could be incorrect and damaged.
>>>
>>> We have to execute releasing compress blocks only one time for a file
>>> without being interfered by writepages path.
>>>
>>> Signed-off-by: Daeho Jeong <daehojeong@google.com>
>>> ---
>>>  fs/f2fs/file.c | 31 ++++++++++++++++++++++++-------
>>>  1 file changed, 24 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>>> index 4aab4b42d8ba..a92bc51b9b28 100644
>>> --- a/fs/f2fs/file.c
>>> +++ b/fs/f2fs/file.c
>>> @@ -3488,6 +3488,7 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
>>>       pgoff_t page_idx = 0, last_idx;
>>>       unsigned int released_blocks = 0;
>>>       int ret;
>>> +     int writecount;
>>>
>>>       if (!f2fs_sb_has_compression(F2FS_I_SB(inode)))
>>>               return -EOPNOTSUPP;
>>
>> Before inode_lock(), there is one case we may jump to out label, in
>> this case, we may unlock inode incorrectly.
>>
>>         if (!F2FS_I(inode)->i_compr_blocks)
>>                 goto out;
>>
>>> -
>>> -     inode_unlock(inode);
>>>  out:
>>> +     inode_unlock(inode);
>>> +
>>>       mnt_drop_write_file(filp);
>>
>> Thanks,
> .
> 
