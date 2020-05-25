Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C5F9C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 06:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E4012078B
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 06:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388896AbgEYGak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 02:30:40 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:44998 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388631AbgEYGaj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 02:30:39 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0D714C6D2510EF809AD4;
        Mon, 25 May 2020 14:30:27 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.201) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 25 May
 2020 14:30:26 +0800
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: avoid inifinite loop to wait for
 flushing node pages at cp_error
To:     Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <kernel-team@android.com>
References: <20200522144752.216197-1-jaegeuk@kernel.org>
 <20200522233243.GA94020@google.com> <20200525035655.GA135148@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <565af47c-8364-d910-8d1c-93645c12e660@huawei.com>
Date:   Mon, 25 May 2020 14:30:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200525035655.GA135148@google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/5/25 11:56, Jaegeuk Kim wrote:
> Shutdown test is somtimes hung, since it keeps trying to flush dirty node pages

IMO, for umount case, we should drop dirty reference and dirty pages on meta/data
pages like we change for node pages to avoid potential dead loop...

Thanks,

> in an inifinite loop. Let's drop dirty pages at umount in that case.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
> v3:
>  - fix wrong unlock
> 
> v2:
>  - fix typos
> 
>  fs/f2fs/node.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index e632de10aedab..e0bb0f7e0506e 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -1520,8 +1520,15 @@ static int __write_node_page(struct page *page, bool atomic, bool *submitted,
>  
>  	trace_f2fs_writepage(page, NODE);
>  
> -	if (unlikely(f2fs_cp_error(sbi)))
> +	if (unlikely(f2fs_cp_error(sbi))) {
> +		if (is_sbi_flag_set(sbi, SBI_IS_CLOSE)) {
> +			ClearPageUptodate(page);
> +			dec_page_count(sbi, F2FS_DIRTY_NODES);
> +			unlock_page(page);
> +			return 0;
> +		}
>  		goto redirty_out;
> +	}
>  
>  	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
>  		goto redirty_out;
> 
