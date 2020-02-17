Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC496C7619B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 01:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ACF520718
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 01:41:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgBQBk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 20:40:57 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:51808 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726240AbgBQBk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 20:40:56 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7CD18B4D637C8E4DA0A6;
        Mon, 17 Feb 2020 09:40:53 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.204) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 17 Feb
 2020 09:40:49 +0800
Subject: Re: [f2fs-dev] [PATCH 1/3] f2fs: skip GC when section is full
To:     Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20200214185855.217360-1-jaegeuk@kernel.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <2ea7ce0e-b40e-e80b-55b6-8256b3e9c2c1@huawei.com>
Date:   Mon, 17 Feb 2020 09:40:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200214185855.217360-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/2/15 2:58, Jaegeuk Kim wrote:
> This fixes skipping GC when segment is full in large section.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/gc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 53312d7bc78b..65c0687ee2bb 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -1018,8 +1018,8 @@ static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
>  		 * race condition along with SSR block allocation.
>  		 */
>  		if ((gc_type == BG_GC && has_not_enough_free_secs(sbi, 0, 0)) ||
> -				get_valid_blocks(sbi, segno, false) ==
> -							sbi->blocks_per_seg)
> +				get_valid_blocks(sbi, segno, true) ==
> +							BLKS_PER_SEC(sbi))

Then in large section, if current segment is all valid, we won't skip scanning
it, so do we need to change like this:

if ((gc_type == BG_GC && has_not_enough_free_secs(sbi, 0, 0)) ||
	get_valid_blocks(sbi, segno, false) == sbi->blocks_per_seg ||
	get_valid_blocks(sbi, segno, true) == BLKS_PER_SEC(sbi))
	return submitted;

>  			return submitted;
>  
>  		if (check_valid_map(sbi, segno, off) == 0)
> 
