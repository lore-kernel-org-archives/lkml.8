Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82597C4332E
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 13:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A69620732
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 13:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584883144;
	bh=cJjXz7mTR35bJeZ7sip2Qhg3W0McxHjMQu+j8nUdb9I=;
	h=Subject:To:References:From:Date:In-Reply-To:List-ID:From;
	b=Hh3KI9qvArBQ+YdH/KEkt0C5A2HfUjasCGhzw0mC9UgyHvjJlps8QZ9p6XQqjYybi
	 tHa6Tg2LeyWiiP6FIWpKUSk89AkRlq0Eb86YUSxkX1+057rYulGVLBECD+2zKBF5Mt
	 NYFt6U4XViYZG0bvPJP7cCNg0xNBLpU9176mcL+U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgCVNTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 09:19:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:59238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbgCVNTD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 09:19:03 -0400
Received: from [192.168.0.107] (unknown [49.65.245.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E780E206C3;
        Sun, 22 Mar 2020 13:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584883142;
        bh=cJjXz7mTR35bJeZ7sip2Qhg3W0McxHjMQu+j8nUdb9I=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=iGx7KuSE6BZZ+GLWAPN1YBrpSItELWyoE/Xzm/PEjrv4sg5hgyoKQBzrSvh/GQj6y
         kKdo2c1WzRdzaA0gM6nnR5DGUMgAO4NId3hP5nuIiW9wGPdckIgaary/EHtSy933CG
         6ekP1qHBQdaH7NqRUOK91pRmJqq9QTYzeVh9MkXs=
Subject: Re: [PATCH] f2fs: fix potential .flags overflow on 32bit architecture
To:     =?UTF-8?Q?Ond=c5=99ej_Jirman?= <megi@xff.cz>, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
References: <20200322101327.5979-1-chao@kernel.org>
 <20200322121434.i2jea6o5tzanip7z@core.my.home>
From:   Chao Yu <chao@kernel.org>
Message-ID: <47c71fe9-e168-8080-d0ed-2cfaa9a77e5e@kernel.org>
Date:   Sun, 22 Mar 2020 21:18:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20200322121434.i2jea6o5tzanip7z@core.my.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2020-3-22 20:14, Ondřej Jirman wrote:
> Hello,
>
> On Sun, Mar 22, 2020 at 06:13:27PM +0800, Chao Yu wrote:
>> From: Chao Yu <yuchao0@huawei.com>
>>
>> f2fs_inode_info.flags is unsigned long variable, it has 32 bits
>> in 32bit architecture, since we introduced FI_MMAP_FILE flag
>> when we support data compression, we may access memory cross
>> the border of .flags field, corrupting .i_sem field, result in
>> below deadlock.
>>
>> To fix this issue, let's introduce .extra_flags to grab extra
>> space to store those new flags.
>>
>> Call Trace:
>>  __schedule+0x8d0/0x13fc
>>  ? mark_held_locks+0xac/0x100
>>  schedule+0xcc/0x260
>>  rwsem_down_write_slowpath+0x3ab/0x65d
>>  down_write+0xc7/0xe0
>>  f2fs_drop_nlink+0x3d/0x600 [f2fs]
>>  f2fs_delete_inline_entry+0x300/0x440 [f2fs]
>>  f2fs_delete_entry+0x3a1/0x7f0 [f2fs]
>>  f2fs_unlink+0x500/0x790 [f2fs]
>>  vfs_unlink+0x211/0x490
>>  do_unlinkat+0x483/0x520
>>  sys_unlink+0x4a/0x70
>>  do_fast_syscall_32+0x12b/0x683
>>  entry_SYSENTER_32+0xaa/0x102
>>
>> Fixes: 4c8ff7095bef ("f2fs: support data compression")
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>  fs/f2fs/f2fs.h  | 26 ++++++++++++++++++++------
>>  fs/f2fs/inode.c |  1 +
>>  2 files changed, 21 insertions(+), 6 deletions(-)
>>
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index fcafa68212eb..fcd22df2e9ca 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -695,6 +695,7 @@ struct f2fs_inode_info {
>>
>>  	/* Use below internally in f2fs*/
>>  	unsigned long flags;		/* use to pass per-file flags */
>> +	unsigned long extra_flags;	/* extra flags */
>>  	struct rw_semaphore i_sem;	/* protect fi info */
>>  	atomic_t dirty_pages;		/* # of dirty pages */
>>  	f2fs_hash_t chash;		/* hash value of given file name */
>> @@ -2569,7 +2570,7 @@ enum {
>>  };
>>
>>  static inline void __mark_inode_dirty_flag(struct inode *inode,
>> -						int flag, bool set)
>> +					unsigned long long flag, bool set)
>>  {
>>  	switch (flag) {
>>  	case FI_INLINE_XATTR:
>> @@ -2588,20 +2589,33 @@ static inline void __mark_inode_dirty_flag(struct inode *inode,
>>
>>  static inline void set_inode_flag(struct inode *inode, int flag)
>>  {
>> -	if (!test_bit(flag, &F2FS_I(inode)->flags))
>> -		set_bit(flag, &F2FS_I(inode)->flags);
>> +	if ((1 << flag) <= sizeof(unsigned long)) {
>
> ^ this is wrong. Maybe you meant flag <= BITS_PER_LONG

Oh, my bad, I meant that, thanks for pointing out this. :)

>
> And ditto for the same checks below. Maybe you can make flags an array of
> BIT_WORD(max_flag_value) + 1 and skip the branches altogether?

That will be better, let me revise this patch.

Thanks,

>
> thank you and regards,
> 	o.
>
>> +		if (!test_bit(flag, &F2FS_I(inode)->flags))
>> +			set_bit(flag, &F2FS_I(inode)->flags);
>> +	} else {
>> +		if (!test_bit(flag - 32, &F2FS_I(inode)->extra_flags))
>> +			set_bit(flag - 32, &F2FS_I(inode)->extra_flags);
>> +	}
>>  	__mark_inode_dirty_flag(inode, flag, true);
>>  }
>>
>>  static inline int is_inode_flag_set(struct inode *inode, int flag)
>>  {
>> -	return test_bit(flag, &F2FS_I(inode)->flags);
>> +	if ((1 << flag) <= sizeof(unsigned long))
>> +		return test_bit(flag, &F2FS_I(inode)->flags);
>> +	else
>> +		return test_bit(flag - 32, &F2FS_I(inode)->extra_flags);
>>  }
>>
>>  static inline void clear_inode_flag(struct inode *inode, int flag)
>>  {
>> -	if (test_bit(flag, &F2FS_I(inode)->flags))
>> -		clear_bit(flag, &F2FS_I(inode)->flags);
>> +	if ((1 << flag) <= sizeof(unsigned long)) {
>> +		if (test_bit(flag, &F2FS_I(inode)->flags))
>> +			clear_bit(flag, &F2FS_I(inode)->flags);
>> +	} else {
>> +		if (test_bit(flag - 32, &F2FS_I(inode)->extra_flags))
>> +			clear_bit(flag - 32, &F2FS_I(inode)->extra_flags);
>> +	}
>>  	__mark_inode_dirty_flag(inode, flag, false);
>>  }
>>
>> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
>> index 44e08bf2e2b4..ca924d7e0e30 100644
>> --- a/fs/f2fs/inode.c
>> +++ b/fs/f2fs/inode.c
>> @@ -363,6 +363,7 @@ static int do_read_inode(struct inode *inode)
>>  	if (S_ISREG(inode->i_mode))
>>  		fi->i_flags &= ~F2FS_PROJINHERIT_FL;
>>  	fi->flags = 0;
>> +	fi->extra_flags = 0;
>>  	fi->i_advise = ri->i_advise;
>>  	fi->i_pino = le32_to_cpu(ri->i_pino);
>>  	fi->i_dir_level = ri->i_dir_level;
>> --
>> 2.22.0
>>
