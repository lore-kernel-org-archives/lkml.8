Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB1E1C2BA18
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 04:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 869B720719
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 04:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgDFEnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 00:43:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:43684 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbgDFEnQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 00:43:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id ECBFBACC3;
        Mon,  6 Apr 2020 04:43:13 +0000 (UTC)
Subject: Re: [PATCH] bcache: remove set but not used variable 'i'
To:     Wang Hai <wanghai38@huawei.com>, kent.overstreet@gmail.com
Cc:     linux-bcache@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1586259407-23673-1-git-send-email-wanghai38@huawei.com>
From:   Coly Li <colyli@suse.de>
Organization: SUSE Labs
Message-ID: <dee5c875-4b4e-c425-ec8d-35e7599c4f5f@suse.de>
Date:   Mon, 6 Apr 2020 12:43:08 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1586259407-23673-1-git-send-email-wanghai38@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/4/7 7:36 下午, Wang Hai wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/md/bcache/btree.c: In function bch_btree_check_thread:
> drivers/md/bcache/btree.c:1910:6: warning:
>  variable ‘i’ set but not used [-Wunused-but-set-variable]
> 
> It's not used since commit 8e7102273f59 ("bcache: make bch_btree_check()
> to be multithreaded"), so remove it.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wang Hai <wanghai38@huawei.com>

Hi Hai,

Colin King already submitted a similar patch on Apr 2 to fix it.

Thanks.

Coly Li


> ---
>  drivers/md/bcache/btree.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
> index 72856e5..b962313 100644
> --- a/drivers/md/bcache/btree.c
> +++ b/drivers/md/bcache/btree.c
> @@ -1907,10 +1907,10 @@ static int bch_btree_check_thread(void *arg)
>  	struct btree_iter iter;
>  	struct bkey *k, *p;
>  	int cur_idx, prev_idx, skip_nr;
> -	int i, n;
> +	int n;
>  
>  	k = p = NULL;
> -	i = n = 0;
> +	n = 0;
>  	cur_idx = prev_idx = 0;
>  	ret = 0;
>  
> 

