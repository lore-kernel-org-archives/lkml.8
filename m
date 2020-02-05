Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CEF9C35249
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 08:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FB8E2072B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 08:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbgBEIl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 03:41:29 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:50515 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727070AbgBEIl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 03:41:29 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R381e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04427;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0TpCH2sh_1580892081;
Received: from JosephdeMacBook-Pro.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0TpCH2sh_1580892081)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 05 Feb 2020 16:41:22 +0800
Subject: Re: [PATCH] OCFS2: remove useless err
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        ChenGang <cg.chen@huawei.com>,
        Richard Fontana <rfontana@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
References: <1579577836-251879-1-git-send-email-alex.shi@linux.alibaba.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <c8f90c2a-1dab-2052-5662-ef634d8f7ecc@linux.alibaba.com>
Date:   Wed, 5 Feb 2020 16:41:21 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <1579577836-251879-1-git-send-email-alex.shi@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/1/21 11:37, Alex Shi wrote:
> We don't need 'err' in these 2 places, better to remove them.
> 
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Mark Fasheh <mark@fasheh.com> 
> Cc: Joel Becker <jlbec@evilplan.org> 
> Cc: Joseph Qi <joseph.qi@linux.alibaba.com> 
> Cc: Andrew Morton <akpm@linux-foundation.org> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org> 
> Cc: Kate Stewart <kstewart@linuxfoundation.org> 
> Cc: ChenGang <cg.chen@huawei.com> 
> Cc: Richard Fontana <rfontana@redhat.com> 
> Cc: Thomas Gleixner <tglx@linutronix.de> 
> Cc: ocfs2-devel@oss.oracle.com 
> Cc: linux-kernel@vger.kernel.org

Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
>  fs/ocfs2/cluster/tcp.c | 3 +--
>  fs/ocfs2/dir.c         | 4 ++--
>  2 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ocfs2/cluster/tcp.c b/fs/ocfs2/cluster/tcp.c
> index 48a3398f0bf5..9261c1f06a9f 100644
> --- a/fs/ocfs2/cluster/tcp.c
> +++ b/fs/ocfs2/cluster/tcp.c
> @@ -1948,7 +1948,6 @@ static void o2net_accept_many(struct work_struct *work)
>  {
>  	struct socket *sock = o2net_listen_sock;
>  	int	more;
> -	int	err;
>  
>  	/*
>  	 * It is critical to note that due to interrupt moderation
> @@ -1963,7 +1962,7 @@ static void o2net_accept_many(struct work_struct *work)
>  	 */
>  
>  	for (;;) {
> -		err = o2net_accept_one(sock, &more);
> +		o2net_accept_one(sock, &more);
>  		if (!more)
>  			break;
>  		cond_resched();
> diff --git a/fs/ocfs2/dir.c b/fs/ocfs2/dir.c
> index bdef72c0f099..5761060d2ba8 100644
> --- a/fs/ocfs2/dir.c
> +++ b/fs/ocfs2/dir.c
> @@ -676,7 +676,7 @@ static struct buffer_head *ocfs2_find_entry_el(const char *name, int namelen,
>  	int ra_ptr = 0;		/* Current index into readahead
>  				   buffer */
>  	int num = 0;
> -	int nblocks, i, err;
> +	int nblocks, i;
>  
>  	sb = dir->i_sb;
>  
> @@ -708,7 +708,7 @@ static struct buffer_head *ocfs2_find_entry_el(const char *name, int namelen,
>  				num++;
>  
>  				bh = NULL;
> -				err = ocfs2_read_dir_block(dir, b++, &bh,
> +				ocfs2_read_dir_block(dir, b++, &bh,
>  							   OCFS2_BH_READAHEAD);
>  				bh_use[ra_max] = bh;
>  			}
> 
