Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 382D8C35DEE
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 00:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1453820838
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 00:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbgBYAyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 19:54:08 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:60106 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727696AbgBYAyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 19:54:08 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04396;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TqrAEr4_1582592044;
Received: from JosephdeMacBook-Pro.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0TqrAEr4_1582592044)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 25 Feb 2020 08:54:05 +0800
Subject: Re: [PATCH 30/30] sgi-xp: Add missing annotation for
 ocfs2_inode_cache_lock() and ocfs2_inode_cache_unlock()
To:     Jules Irenge <jbi.octave@gmail.com>, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        "moderated list:ORACLE CLUSTER FILESYSTEM 2 (OCFS2)" 
        <ocfs2-devel@oss.oracle.com>
References: <0/30> <20200223231711.157699-1-jbi.octave@gmail.com>
 <20200223231711.157699-31-jbi.octave@gmail.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <4c565e87-30c4-4a5a-ae9f-cd12a449f8a9@linux.alibaba.com>
Date:   Tue, 25 Feb 2020 08:54:04 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200223231711.157699-31-jbi.octave@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/2/24 07:17, Jules Irenge wrote:
> Sparse reports a warning at ocfs2_inode_cache_lock()
> and ocfs2_inode_cache_unlock()
> warning: context imbalance in ocfs2_inode_cache_lock()
> 	- wrong count at exit
> 
> warning: context imbalance in ocfs2_inode_cache_unlock()
> 	- unexpected unlock
> The root cause is a missing annotation at ocfs2_inode_cache_lock()
> and at ocfs2_inode_cache_unlock()
> 
> Add the missing __acquires(&oi->ip_lock) annotation
> Add the missing __releases(&oi->ip_lock) annotation
> 
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>

Acked-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
>  fs/ocfs2/inode.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
> index 7c9dfd50c1c1..0b87e0a63ab9 100644
> --- a/fs/ocfs2/inode.c
> +++ b/fs/ocfs2/inode.c
> @@ -1623,6 +1623,7 @@ static struct super_block *ocfs2_inode_cache_get_super(struct ocfs2_caching_info
>  }
>  
>  static void ocfs2_inode_cache_lock(struct ocfs2_caching_info *ci)
> +	__acquires(&oi->ip_lock)
>  {
>  	struct ocfs2_inode_info *oi = cache_info_to_inode(ci);
>  
> @@ -1630,6 +1631,7 @@ static void ocfs2_inode_cache_lock(struct ocfs2_caching_info *ci)
>  }
>  
>  static void ocfs2_inode_cache_unlock(struct ocfs2_caching_info *ci)
> +	__releases(&oi->ip_lock)
>  {
>  	struct ocfs2_inode_info *oi = cache_info_to_inode(ci);
>  
> 
