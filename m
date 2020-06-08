Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B6CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 01:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B4522063A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 01:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbgFHBxz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 21:53:55 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:37930 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727871AbgFHBxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 21:53:54 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04427;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0U-reyhA_1591581229;
Received: from JosephdeMacBook-Pro.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0U-reyhA_1591581229)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 08 Jun 2020 09:53:50 +0800
Subject: Re: [PATCH v3] fs: ocfs2: fix spelling mistake and grammar
To:     Keyur Patel <iamkeyur96@gmail.com>, mark@fasheh.com,
        jlbec@evilplan.org, ocfs2-devel@oss.oracle.com,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <20200607212115.99278-1-iamkeyur96@gmail.com>
 <20200608014818.102358-1-iamkeyur96@gmail.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <84cbc852-740b-7f8f-051e-b8c532ab70a4@linux.alibaba.com>
Date:   Mon, 8 Jun 2020 09:53:49 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200608014818.102358-1-iamkeyur96@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/6/8 09:48, Keyur Patel wrote:
> ./ocfs2/mmap.c:65: bebongs ==> belonging
> 
> Signed-off-by: Keyur Patel <iamkeyur96@gmail.com>

Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
>  fs/ocfs2/mmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ocfs2/mmap.c b/fs/ocfs2/mmap.c
> index 3a44e461828a..39a77e903fdf 100644
> --- a/fs/ocfs2/mmap.c
> +++ b/fs/ocfs2/mmap.c
> @@ -62,7 +62,7 @@ static vm_fault_t __ocfs2_page_mkwrite(struct file *file,
>  	last_index = (size - 1) >> PAGE_SHIFT;
>  
>  	/*
> -	 * There are cases that lead to the page no longer bebongs to the
> +	 * There are cases that lead to the page no longer belonging to the
>  	 * mapping.
>  	 * 1) pagecache truncates locally due to memory pressure.
>  	 * 2) pagecache truncates when another is taking EX lock against 
> 
