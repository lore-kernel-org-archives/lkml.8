Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D56AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 07:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55D7A20714
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 07:15:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbgG0HPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 03:15:09 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:46571 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726116AbgG0HPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 03:15:08 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R821e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0U3tikPA_1595834105;
Received: from JosephdeMacBook-Pro.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0U3tikPA_1595834105)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 27 Jul 2020 15:15:05 +0800
Subject: Re: [PATCH] ocfs2: fix unbalanced locking
To:     Pavel Machek <pavel@ucw.cz>, trivial@kernel.org, mark@fasheh.com,
        jlbec@evilplan.org, ocfs2-devel@oss.oracle.com,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Junxiao Bi <junxiao.bi@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20200724124443.GA28164@duo.ucw.cz>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <41de02bf-3c16-3492-6f9c-7ae4b519778e@linux.alibaba.com>
Date:   Mon, 27 Jul 2020 15:15:04 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200724124443.GA28164@duo.ucw.cz>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/7/24 20:44, Pavel Machek wrote:
> 
> Based on what fails, function can return with nfs_sync_rwlock either
> locked or unlocked. That can not be right.
> 
> Always return with lock unlocked on error.
> 
> Signed-off-by: Pavel Machek (CIP) <pavel@denx.de>

Looks good.

Fixes: 4cd9973f9ff6 ("ocfs2: avoid inode removal while nfsd is accessing it")
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>

> 
> diff --git a/fs/ocfs2/dlmglue.c b/fs/ocfs2/dlmglue.c
> index 751bc4dc7466..8e3a369086db 100644
> --- a/fs/ocfs2/dlmglue.c
> +++ b/fs/ocfs2/dlmglue.c
> @@ -2871,9 +2871,15 @@ int ocfs2_nfs_sync_lock(struct ocfs2_super *osb, int ex)
>  
>  	status = ocfs2_cluster_lock(osb, lockres, ex ? LKM_EXMODE : LKM_PRMODE,
>  				    0, 0);
> -	if (status < 0)
> +	if (status < 0) {
>  		mlog(ML_ERROR, "lock on nfs sync lock failed %d\n", status);
>  
> +		if (ex)
> +			up_write(&osb->nfs_sync_rwlock);
> +		else
> +			up_read(&osb->nfs_sync_rwlock);
> +	}
> +
>  	return status;
>  }
>  
> 
