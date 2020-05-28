Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5049EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 01:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D2522078C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 01:20:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgE1BUu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 21:20:50 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:48924 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725294AbgE1BUu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 21:20:50 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1F5C510104ED80D4744C;
        Thu, 28 May 2020 09:20:47 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.206) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 28 May
 2020 09:20:41 +0800
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: avoid inifinite loop to wait for
 flushing node pages at cp_error
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <kernel-team@android.com>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20200522144752.216197-1-jaegeuk@kernel.org>
 <20200522233243.GA94020@google.com> <20200525035655.GA135148@google.com>
 <565af47c-8364-d910-8d1c-93645c12e660@huawei.com>
 <20200525150608.GA55033@google.com>
 <92afae8b-2dd3-171a-562c-404a67f9aab2@huawei.com>
 <a44f9c2e-3859-6c5d-6f06-7c4c6b4c01c5@huawei.com>
 <20200526015650.GA207949@google.com>
 <765a1ac5-a318-14d6-666f-eab46f892d01@huawei.com>
 <20200527205603.GB206249@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <d2f2c623-b0e8-e875-410d-f542e86417e4@huawei.com>
Date:   Thu, 28 May 2020 09:20:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200527205603.GB206249@google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/5/28 4:56, Jaegeuk Kim wrote:
> On 05/27, Chao Yu wrote:
>> On 2020/5/26 9:56, Jaegeuk Kim wrote:
>>> On 05/26, Chao Yu wrote:
>>>> On 2020/5/26 9:11, Chao Yu wrote:
>>>>> On 2020/5/25 23:06, Jaegeuk Kim wrote:
>>>>>> On 05/25, Chao Yu wrote:
>>>>>>> On 2020/5/25 11:56, Jaegeuk Kim wrote:
>>>>>>>> Shutdown test is somtimes hung, since it keeps trying to flush dirty node pages
>>
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
>> Before umount, kworker will always hold one core, that looks not reasonable,
>> to avoid that, could we just allow node write, since it's out-place-update,
>> and cp is not allowed, we don't need to worry about its effect on data on
>> previous checkpoint, and it can decrease memory footprint cost by node pages.
> 
> It can cause some roll-forward recovery?

Yup, recovery should be considered,

Later fsync() will fail due to:

int f2fs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
{
	if (unlikely(f2fs_cp_error(F2FS_I_SB(file_inode(file)))))
		return -EIO;


And we need to adjust f2fs_fsync_node_pages() to handle in-process fsyncing node
pages as well:

if (f2fs_cp_error()) {
	set_fsync_mark(page, 0);
	set_dentry_mark(page, 0);
	if (atomic) {
		unlock & put page;
		ret = -EIO;
		break;
	}
}

ret = __write_node_page();

Thanks,

> 
>>
>> Thanks,
>>
>>>>>>>
>>>>>>> IMO, for umount case, we should drop dirty reference and dirty pages on meta/data
>>>>>>> pages like we change for node pages to avoid potential dead loop...
>>>>>>
>>>>>> I believe we're doing for them. :P
>>>>>
>>>>> Actually, I mean do we need to drop dirty meta/data pages explicitly as below:
>>>>>
>>>>> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
>>>>> index 3dc3ac6fe143..4c08fd0a680a 100644
>>>>> --- a/fs/f2fs/checkpoint.c
>>>>> +++ b/fs/f2fs/checkpoint.c
>>>>> @@ -299,8 +299,15 @@ static int __f2fs_write_meta_page(struct page *page,
>>>>>
>>>>>  	trace_f2fs_writepage(page, META);
>>>>>
>>>>> -	if (unlikely(f2fs_cp_error(sbi)))
>>>>> +	if (unlikely(f2fs_cp_error(sbi))) {
>>>>> +		if (is_sbi_flag_set(sbi, SBI_IS_CLOSE)) {
>>>>> +			ClearPageUptodate(page);
>>>>> +			dec_page_count(sbi, F2FS_DIRTY_META);
>>>>> +			unlock_page(page);
>>>>> +			return 0;
>>>>> +		}
>>>>>  		goto redirty_out;
>>>>> +	}
>>>>>  	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
>>>>>  		goto redirty_out;
>>>>>  	if (wbc->for_reclaim && page->index < GET_SUM_BLOCK(sbi, 0))
>>>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>>>> index 48a622b95b76..94b342802513 100644
>>>>> --- a/fs/f2fs/data.c
>>>>> +++ b/fs/f2fs/data.c
>>>>> @@ -2682,6 +2682,12 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
>>>>>
>>>>>  	/* we should bypass data pages to proceed the kworkder jobs */
>>>>>  	if (unlikely(f2fs_cp_error(sbi))) {
>>>>> +		if (is_sbi_flag_set(sbi, SBI_IS_CLOSE)) {
>>>>> +			ClearPageUptodate(page);
>>>>> +			inode_dec_dirty_pages(inode);
>>>>> +			unlock_page(page);
>>>>> +			return 0;
>>>>> +		}
>>>>
>>>> Oh, I notice previously, we will drop non-directory inode's dirty pages directly,
>>>> however, during umount, we'd better drop directory inode's dirty pages as well, right?
>>>
>>> Hmm, I remember I dropped them before. Need to double check.
>>>
>>>>
>>>>>  		mapping_set_error(page->mapping, -EIO);
>>>>>  		/*
>>>>>  		 * don't drop any dirty dentry pages for keeping lastest
>>>>>
>>>>>>
>>>>>>>
>>>>>>> Thanks,
>>>>>>>
>>>>>>>> in an inifinite loop. Let's drop dirty pages at umount in that case.
>>>>>>>>
>>>>>>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>>>>>>> ---
>>>>>>>> v3:
>>>>>>>>  - fix wrong unlock
>>>>>>>>
>>>>>>>> v2:
>>>>>>>>  - fix typos
>>>>>>>>
>>>>>>>>  fs/f2fs/node.c | 9 ++++++++-
>>>>>>>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>>>>>>>
>>>>>>>> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
>>>>>>>> index e632de10aedab..e0bb0f7e0506e 100644
>>>>>>>> --- a/fs/f2fs/node.c
>>>>>>>> +++ b/fs/f2fs/node.c
>>>>>>>> @@ -1520,8 +1520,15 @@ static int __write_node_page(struct page *page, bool atomic, bool *submitted,
>>>>>>>>  
>>>>>>>>  	trace_f2fs_writepage(page, NODE);
>>>>>>>>  
>>>>>>>> -	if (unlikely(f2fs_cp_error(sbi)))
>>>>>>>> +	if (unlikely(f2fs_cp_error(sbi))) {
>>>>>>>> +		if (is_sbi_flag_set(sbi, SBI_IS_CLOSE)) {
>>>>>>>> +			ClearPageUptodate(page);
>>>>>>>> +			dec_page_count(sbi, F2FS_DIRTY_NODES);
>>>>>>>> +			unlock_page(page);
>>>>>>>> +			return 0;
>>>>>>>> +		}
>>>>>>>>  		goto redirty_out;
>>>>>>>> +	}
>>>>>>>>  
>>>>>>>>  	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
>>>>>>>>  		goto redirty_out;
>>>>>>>>
>>>>>> .
>>>>>>
>>>>>
>>>>>
>>>>> _______________________________________________
>>>>> Linux-f2fs-devel mailing list
>>>>> Linux-f2fs-devel@lists.sourceforge.net
>>>>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
>>>>> .
>>>>>
>>> .
>>>
> .
> 
