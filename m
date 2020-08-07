Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C86C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 02:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0F9A2177B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 02:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgHGCL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 22:11:27 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:48098 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726126AbgHGCL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 22:11:26 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 66EEC3AA4F0D1AE01613;
        Fri,  7 Aug 2020 10:11:24 +0800 (CST)
Received: from [10.164.122.247] (10.164.122.247) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 7 Aug 2020
 10:11:23 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: remove unnecessary judgment in
 f2fs_drop_inode
To:     Liu Song <fishland@aliyun.com>, <jaegeuk@kernel.org>,
        <chao@kernel.org>
CC:     <liu.song11@zte.com.cn>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20200806150317.34618-1-fishland@aliyun.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <ea87263e-57d9-7521-6094-9aa7e1796f07@huawei.com>
Date:   Fri, 7 Aug 2020 10:11:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200806150317.34618-1-fishland@aliyun.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.164.122.247]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/8/6 23:03, Liu Song via Linux-f2fs-devel wrote:
> From: Liu Song <liu.song11@zte.com.cn>
> 
> Inode hash has been removed in "make_bad_inode". If inode_unhashed
> is false, it must not be a bad inode.
> 
> Signed-off-by: Liu Song <liu.song11@zte.com.cn>
> ---
>   fs/f2fs/super.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 20e56b0fa46a..ee01d15effe3 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1043,7 +1043,7 @@ static int f2fs_drop_inode(struct inode *inode)
>   	 *       - inode_wait_for_writeback(inode)
>   	 */
>   	if ((!inode_unhashed(inode) && inode->i_state & I_SYNC)) {

Since logic of "bad inode should be removed from hash" is not controlled by
f2fs, so let's add below condition to make sure the rule of vfs is as it is.

f2fs_bug_on(sbi, is_bad_inode(inode));

> -		if (!inode->i_nlink && !is_bad_inode(inode)) {
> +		if (!inode->i_nlink) {
>   			/* to avoid evict_inode call simultaneously */
>   			atomic_inc(&inode->i_count);
>   			spin_unlock(&inode->i_lock);
> 
