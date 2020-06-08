Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B22FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 02:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B4EB2077D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 02:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728736AbgFHC6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 22:58:55 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5862 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728065AbgFHC6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 22:58:55 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D4266A8D4C9B446D8409;
        Mon,  8 Jun 2020 10:58:51 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 8 Jun 2020
 10:58:49 +0800
Subject: Re: [PATCH] f2fs: allow writeback on error status filesystem
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
References: <20200605085453.45717-1-yuchao0@huawei.com>
 <20200607211748.GA26785@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <025cde14-3b4e-b9db-d359-513a44e9c1a1@huawei.com>
Date:   Mon, 8 Jun 2020 10:58:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200607211748.GA26785@google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/6/8 5:17, Jaegeuk Kim wrote:
> On 06/05, Chao Yu wrote:
>>     71.07%     0.01%  kworker/u256:1+  [kernel.kallsyms]  [k] wb_writeback
>>             |
>>              --71.06%--wb_writeback
>>                        |
>>                        |--68.96%--__writeback_inodes_wb
>>                        |          |
>>                        |           --68.95%--writeback_sb_inodes
>>                        |                     |
>>                        |                     |--65.08%--__writeback_single_inode
>>                        |                     |          |
>>                        |                     |           --64.35%--do_writepages
>>                        |                     |                     |
>>                        |                     |                     |--59.83%--f2fs_write_node_pages
>>                        |                     |                     |          |
>>                        |                     |                     |           --59.74%--f2fs_sync_node_pages
>>                        |                     |                     |                     |
>>                        |                     |                     |                     |--27.91%--pagevec_lookup_range_tag
>>                        |                     |                     |                     |          |
>>                        |                     |                     |                     |           --27.90%--find_get_pages_range_tag
>>
>> If filesystem was injected w/ checkpoint errror, before umount, kworker
>> will always hold one core in order to writeback a large number of node
>> pages, that looks not reasonable, to avoid that, we can allow data/node
>> write in such case, since we can force all data/node writes with OPU mode,
>> and clear recovery flag on node, and checkpoint is not allowed as well,
>> so we don't need to worry about writeback's effect on data/node in
>> previous checkpoint, then with this way, it can decrease memory footprint
>> cost by node/data pages and avoid looping into data/node writeback
>> process.
> 
> This patch breaks fault injection test with filesystem corruption. Please check.

My bad, will check soon.

Thanks,

> 
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>  fs/f2fs/data.c | 19 ++++++++++++-------
>>  fs/f2fs/node.c |  7 +++++--
>>  2 files changed, 17 insertions(+), 9 deletions(-)
>>
>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>> index 9d40db50cd65..2b3c846181bb 100644
>> --- a/fs/f2fs/data.c
>> +++ b/fs/f2fs/data.c
>> @@ -2519,6 +2519,8 @@ bool f2fs_should_update_outplace(struct inode *inode, struct f2fs_io_info *fio)
>>  {
>>  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>>  
>> +	if (unlikely(f2fs_cp_error(sbi)))
>> +		return true;
>>  	if (f2fs_lfs_mode(sbi))
>>  		return true;
>>  	if (S_ISDIR(inode->i_mode))
>> @@ -2702,13 +2704,16 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
>>  	/* we should bypass data pages to proceed the kworkder jobs */
>>  	if (unlikely(f2fs_cp_error(sbi))) {
>>  		mapping_set_error(page->mapping, -EIO);
>> -		/*
>> -		 * don't drop any dirty dentry pages for keeping lastest
>> -		 * directory structure.
>> -		 */
>> -		if (S_ISDIR(inode->i_mode))
>> -			goto redirty_out;
>> -		goto out;
>> +
>> +		if (has_not_enough_free_secs(sbi, 0, 0)) {
>> +			/*
>> +			 * don't drop any dirty dentry pages for keeping lastest
>> +			 * directory structure.
>> +			 */
>> +			if (S_ISDIR(inode->i_mode))
>> +				goto redirty_out;
>> +			goto out;
>> +		}
>>  	}
>>  
>>  	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
>> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
>> index 03e24df1c84f..372c04efad38 100644
>> --- a/fs/f2fs/node.c
>> +++ b/fs/f2fs/node.c
>> @@ -1527,7 +1527,10 @@ static int __write_node_page(struct page *page, bool atomic, bool *submitted,
>>  			unlock_page(page);
>>  			return 0;
>>  		}
>> -		goto redirty_out;
>> +		if (has_not_enough_free_secs(sbi, 0, 0))
>> +			goto redirty_out;
>> +		set_fsync_mark(page, 0);
>> +		set_dentry_mark(page, 0);
>>  	}
>>  
>>  	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
>> @@ -1568,7 +1571,7 @@ static int __write_node_page(struct page *page, bool atomic, bool *submitted,
>>  		goto redirty_out;
>>  	}
>>  
>> -	if (atomic && !test_opt(sbi, NOBARRIER))
>> +	if (atomic && !test_opt(sbi, NOBARRIER) && !f2fs_cp_error(sbi))
>>  		fio.op_flags |= REQ_PREFLUSH | REQ_FUA;
>>  
>>  	/* should add to global list before clearing PAGECACHE status */
>> -- 
>> 2.18.0.rc1
> .
> 
