Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A0EC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 12:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D758720716
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 12:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730119AbgC3MJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 08:09:43 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:51715 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729627AbgC3MJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 08:09:42 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04397;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Tu2RGTX_1585570174;
Received: from JosephdeMacBook-Pro.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0Tu2RGTX_1585570174)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 30 Mar 2020 20:09:34 +0800
Subject: Re: [RFC PATCH v1 29/50] fs/ocfs2/journal: Use prandom_u32() and not
 /dev/random for timeout
To:     George Spelvin <lkml@sdf.org>, linux-kernel@vger.kernel.org
Cc:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        ocfs2-devel@oss.oracle.com
References: <202003281643.02SGhIOY022599@sdf.org>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <016c2bdc-68eb-245f-2292-d00d0d8e45a5@linux.alibaba.com>
Date:   Mon, 30 Mar 2020 20:09:33 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <202003281643.02SGhIOY022599@sdf.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the late reply since I might miss this mail.

On 2019/3/21 11:07, George Spelvin wrote:
> get_random_bytes() is expensive crypto-quality random numbers.
> If we're just doing random backoff, prandom_u32() is plenty.
> 
> (Not to mention fetching 8 bytes of seed material only to
> reduce it modulo 5000 is a huge waste.)
> 
> Also, convert timeouts to jiffies at compile time; convert
> milliseconds to jiffies before picking a random number in the
> range to take advantage of compile-time constant folding.
> 
> Signed-off-by: George Spelvin <lkml@sdf.org>
> Cc: Mark Fasheh <mark@fasheh.com>
> Cc: Joel Becker <jlbec@evilplan.org>
> Cc: Joseph Qi <joseph.qi@linux.alibaba.com>
> Cc: ocfs2-devel@oss.oracle.com
> ---
>  fs/ocfs2/journal.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
> index 68ba354cf3610..939a12e57fa8b 100644
> --- a/fs/ocfs2/journal.c
> +++ b/fs/ocfs2/journal.c
> @@ -1884,11 +1884,8 @@ int ocfs2_mark_dead_nodes(struct ocfs2_super *osb)
>   */
>  static inline unsigned long ocfs2_orphan_scan_timeout(void)
>  {
> -	unsigned long time;
> -
> -	get_random_bytes(&time, sizeof(time));
> -	time = ORPHAN_SCAN_SCHEDULE_TIMEOUT + (time % 5000);
> -	return msecs_to_jiffies(time);
> +	return msecs_to_jiffies(ORPHAN_SCAN_SCHEDULE_TIMEOUT) +
> +		prandom_u32_max(5 * HZ);

Seems better include the prandom_u32_max() into msecs_to_jiffies()?

Thanks,
Joseph
>  }
>  
>  /*
> 
