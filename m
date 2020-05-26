Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE0A2C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 01:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9392A20706
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 01:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388404AbgEZBLl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 21:11:41 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:59606 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387888AbgEZBLl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 21:11:41 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9D04790BC102AFFC7773;
        Tue, 26 May 2020 09:11:39 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.208) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 26 May
 2020 09:11:34 +0800
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: avoid inifinite loop to wait for
 flushing node pages at cp_error
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <kernel-team@android.com>
References: <20200522144752.216197-1-jaegeuk@kernel.org>
 <20200522233243.GA94020@google.com> <20200525035655.GA135148@google.com>
 <565af47c-8364-d910-8d1c-93645c12e660@huawei.com>
 <20200525150608.GA55033@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <92afae8b-2dd3-171a-562c-404a67f9aab2@huawei.com>
Date:   Tue, 26 May 2020 09:11:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200525150608.GA55033@google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/5/25 23:06, Jaegeuk Kim wrote:
> On 05/25, Chao Yu wrote:
>> On 2020/5/25 11:56, Jaegeuk Kim wrote:
>>> Shutdown test is somtimes hung, since it keeps trying to flush dirty node pages
>>
>> IMO, for umount case, we should drop dirty reference and dirty pages on meta/data
>> pages like we change for node pages to avoid potential dead loop...
> 
> I believe we're doing for them. :P

Actually, I mean do we need to drop dirty meta/data pages explicitly as below:

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 3dc3ac6fe143..4c08fd0a680a 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -299,8 +299,15 @@ static int __f2fs_write_meta_page(struct page *page,

 	trace_f2fs_writepage(page, META);

-	if (unlikely(f2fs_cp_error(sbi)))
+	if (unlikely(f2fs_cp_error(sbi))) {
+		if (is_sbi_flag_set(sbi, SBI_IS_CLOSE)) {
+			ClearPageUptodate(page);
+			dec_page_count(sbi, F2FS_DIRTY_META);
+			unlock_page(page);
+			return 0;
+		}
 		goto redirty_out;
+	}
 	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
 		goto redirty_out;
 	if (wbc->for_reclaim && page->index < GET_SUM_BLOCK(sbi, 0))
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 48a622b95b76..94b342802513 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2682,6 +2682,12 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,

 	/* we should bypass data pages to proceed the kworkder jobs */
 	if (unlikely(f2fs_cp_error(sbi))) {
+		if (is_sbi_flag_set(sbi, SBI_IS_CLOSE)) {
+			ClearPageUptodate(page);
+			inode_dec_dirty_pages(inode);
+			unlock_page(page);
+			return 0;
+		}
 		mapping_set_error(page->mapping, -EIO);
 		/*
 		 * don't drop any dirty dentry pages for keeping lastest

> 
>>
>> Thanks,
>>
>>> in an inifinite loop. Let's drop dirty pages at umount in that case.
>>>
>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>> ---
>>> v3:
>>>  - fix wrong unlock
>>>
>>> v2:
>>>  - fix typos
>>>
>>>  fs/f2fs/node.c | 9 ++++++++-
>>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
>>> index e632de10aedab..e0bb0f7e0506e 100644
>>> --- a/fs/f2fs/node.c
>>> +++ b/fs/f2fs/node.c
>>> @@ -1520,8 +1520,15 @@ static int __write_node_page(struct page *page, bool atomic, bool *submitted,
>>>  
>>>  	trace_f2fs_writepage(page, NODE);
>>>  
>>> -	if (unlikely(f2fs_cp_error(sbi)))
>>> +	if (unlikely(f2fs_cp_error(sbi))) {
>>> +		if (is_sbi_flag_set(sbi, SBI_IS_CLOSE)) {
>>> +			ClearPageUptodate(page);
>>> +			dec_page_count(sbi, F2FS_DIRTY_NODES);
>>> +			unlock_page(page);
>>> +			return 0;
>>> +		}
>>>  		goto redirty_out;
>>> +	}
>>>  
>>>  	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
>>>  		goto redirty_out;
>>>
> .
> 
