Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E639BC35DEE
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 00:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEB1B20838
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 00:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728661AbgBYAxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 19:53:25 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:56571 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727696AbgBYAxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 19:53:25 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04452;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Tqr7D9j_1582592002;
Received: from JosephdeMacBook-Pro.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0Tqr7D9j_1582592002)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 25 Feb 2020 08:53:22 +0800
Subject: Re: [PATCH] ocfs2: Add missing annotations for
 ocfs2_refcount_cache_lock() and ocfs2_refcount_cache_unlock()
To:     Jules Irenge <jbi.octave@gmail.com>, boqun.feng@gmail.com
Cc:     joseph.qi@linux.alibab.com, Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        "moderated list:ORACLE CLUSTER FILESYSTEM 2 (OCFS2)" 
        <ocfs2-devel@oss.oracle.com>,
        open list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20200224204130.18178-1-jbi.octave@gmail.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <0f1b869e-080a-2785-e4c1-01f308f246bb@linux.alibaba.com>
Date:   Tue, 25 Feb 2020 08:53:21 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200224204130.18178-1-jbi.octave@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/2/25 04:41, Jules Irenge wrote:
> Sparse reports warnings at ocfs2_refcount_cache_lock()
> 	and ocfs2_refcount_cache_unlock()
> 
> warning: context imbalance in ocfs2_refcount_cache_lock()
> 	- wrong count at exit
> warning: context imbalance in ocfs2_refcount_cache_unlock()
> 	- unexpected unlock
> 
> The root cause is the missing annotation at ocfs2_refcount_cache_lock()
> 	and at ocfs2_refcount_cache_unlock()
> 
> Add the missing __acquires(&rf->rf_lock) annotation
> 	to ocfs2_refcount_cache_lock()
> Add the missing __releases(&rf->rf_lock) annotation
> 	to ocfs2_refcount_cache_unlock()
> 
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>

Acked-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
>  fs/ocfs2/refcounttree.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/ocfs2/refcounttree.c b/fs/ocfs2/refcounttree.c
> index ee43e51188be..da99c80f49da 100644
> --- a/fs/ocfs2/refcounttree.c
> +++ b/fs/ocfs2/refcounttree.c
> @@ -154,6 +154,7 @@ ocfs2_refcount_cache_get_super(struct ocfs2_caching_info *ci)
>  }
>  
>  static void ocfs2_refcount_cache_lock(struct ocfs2_caching_info *ci)
> +	__acquires(&rf->rf_lock)
>  {
>  	struct ocfs2_refcount_tree *rf = cache_info_to_refcount(ci);
>  
> @@ -161,6 +162,7 @@ static void ocfs2_refcount_cache_lock(struct ocfs2_caching_info *ci)
>  }
>  
>  static void ocfs2_refcount_cache_unlock(struct ocfs2_caching_info *ci)
> +	__releases(&rf->rf_lock)
>  {
>  	struct ocfs2_refcount_tree *rf = cache_info_to_refcount(ci);
>  
> 
