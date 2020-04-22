Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35D9C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 07:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7321F2070B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 07:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbgDVHwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 03:52:09 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:37629 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726154AbgDVHwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 03:52:08 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R511e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01355;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TwIs7uZ_1587541925;
Received: from JosephdeMacBook-Pro.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0TwIs7uZ_1587541925)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 22 Apr 2020 15:52:05 +0800
Subject: Re: [PATCH] fs:ocfs2:remove unneeded variable 'o2dlm_flags'
To:     Wu Bo <wubo40@huawei.com>, mark@fasheh.com, jlbec@evilplan.org
Cc:     linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        liuzhiqiang26@huawei.com, linfeilong@huawei.com
References: <1587539521-461177-1-git-send-email-wubo40@huawei.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <7214599d-3bd2-96b7-59f9-d731bb27f744@linux.alibaba.com>
Date:   Wed, 22 Apr 2020 15:52:05 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1587539521-461177-1-git-send-email-wubo40@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/4/22 15:12, Wu Bo wrote:
> Fix the following coccicheck warning:
> fs/ocfs2/stack_o2cb.c:69:5-16: Unneeded variable: "o2dlm_flags". 
> Return "0" on line 84
> 
Umm... This is not right, NAK.
Something tricky is in map_flag() so that coccicheck doesn't recognize.

Thanks,
Joseph

> Signed-off-by: Wu Bo <wubo40@huawei.com>
> ---
>  fs/ocfs2/stack_o2cb.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/fs/ocfs2/stack_o2cb.c b/fs/ocfs2/stack_o2cb.c
> index dbf8b57..2da9633 100644
> --- a/fs/ocfs2/stack_o2cb.c
> +++ b/fs/ocfs2/stack_o2cb.c
> @@ -66,8 +66,6 @@ static inline int mode_to_o2dlm(int mode)
>  	}
>  static int flags_to_o2dlm(u32 flags)
>  {
> -	int o2dlm_flags = 0;
> -
>  	map_flag(DLM_LKF_NOQUEUE, LKM_NOQUEUE);
>  	map_flag(DLM_LKF_CANCEL, LKM_CANCEL);
>  	map_flag(DLM_LKF_CONVERT, LKM_CONVERT);
> @@ -81,7 +79,7 @@ static int flags_to_o2dlm(u32 flags)
>  	/* map_flag() should have cleared every flag passed in */
>  	BUG_ON(flags != 0);
>  
> -	return o2dlm_flags;
> +	return 0;
>  }
>  #undef map_flag
>  
> 
