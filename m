Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E23D7C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 02:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5CC32082E
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 02:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbgF1C4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 22:56:25 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:42838 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725880AbgF1C4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 22:56:24 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 514568FD9B6562E8C76E;
        Sun, 28 Jun 2020 10:56:22 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.208) with Microsoft SMTP Server (TLS) id 14.3.487.0; Sun, 28 Jun
 2020 10:56:18 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: remove unnecessary judgments in
 __insert_free_nid()
To:     Liu Song <fishland@aliyun.com>, <jaegeuk@kernel.org>,
        <chao@kernel.org>
CC:     <liu.song11@zte.com.cn>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20200626143927.2792-1-fishland@aliyun.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <34a73209-8384-2818-b6e1-c97fc9c32e69@huawei.com>
Date:   Sun, 28 Jun 2020 10:56:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200626143927.2792-1-fishland@aliyun.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/6/26 22:39, Liu Song via Linux-f2fs-devel wrote:
> From: Liu Song <liu.song11@zte.com.cn>
> 
> The value of state must be equal to FREE_NID, so the if
> condition judgment can be removed.
> 
> Signed-off-by: Liu Song <liu.song11@zte.com.cn>
> ---
>  fs/f2fs/node.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 03e24df1c84f..0adeb20f19c9 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -2118,8 +2118,7 @@ static int __insert_free_nid(struct f2fs_sb_info *sbi,
>  
>  	f2fs_bug_on(sbi, state != i->state);
>  	nm_i->nid_cnt[state]++;
> -	if (state == FREE_NID)
> -		list_add_tail(&i->list, &nm_i->free_nid_list);
> +	list_add_tail(&i->list, &nm_i->free_nid_list);

In previous design, @state allow accepting both FREE_NID and PREALLOC_NID,
If you remove that condition, it's not correct to add free nid entry into
free_nid_list when passing PREALLOC_NID in @state, now, we only pass @state
with FREE_NID, so it's better to remove that parameter directly.

Thanks,

>  	return 0;
>  }
>  
> 
