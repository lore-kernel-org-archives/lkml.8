Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 916B9C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 02:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 771D320734
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 02:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbgGUC0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 22:26:08 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:51494 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725862AbgGUC0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 22:26:08 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R951e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01419;MF=chge@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0U3MKo5._1595298289;
Received: from chge-ali-mac.local(mailfrom:chge@linux.alibaba.com fp:SMTPD_---0U3MKo5._1595298289)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Jul 2020 10:26:05 +0800
Subject: Re: [Ocfs2-devel] [PATCH] dlmfs: add a newline when printing
 'capabilities' by sysfs
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>, mark@fasheh.com,
        jlbec@evilplan.org, joseph.qi@linux.alibaba.com
Cc:     linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com
References: <20200720082433.164311-1-wangxiongfeng2@huawei.com>
From:   Changwei Ge <chge@linux.alibaba.com>
Message-ID: <5ee49484-1a8f-d4ed-c4b3-0d1d0cef4f52@linux.alibaba.com>
Date:   Tue, 21 Jul 2020 10:24:49 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20200720082433.164311-1-wangxiongfeng2@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi，

I am afraid that doing so might introduce a compatible risk into exited 
systems which reply ocfs2/dlmfs.

We can't guarantee that no system management tools is using the 
information reported from this file.

Basically, ocfs2-tools works of top of it. But after a quick glance at 
the source, I didn't see side effect if this path applied. Better you 
can do some test if this patch breaks ocfs2-tools.

Still my suggestion is that we don't try to touch this file as what I 
explained above.

Thanks,
Changwei


On 7/20/20 4:24 PM, Xiongfeng Wang wrote:
> When I cat module parameter 'capabilities' by sysfs, it displays as
> follows. It's better to add a newline for easy reading.
> 
> root@syzkaller:~# cat /sys/module/ocfs2_dlmfs/parameters/capabilities
> bast stackglueroot@syzkaller:~#
> 
> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> ---
>   fs/ocfs2/dlmfs/dlmfs.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ocfs2/dlmfs/dlmfs.c b/fs/ocfs2/dlmfs/dlmfs.c
> index ea868c6f9800..1f9c864ec09b 100644
> --- a/fs/ocfs2/dlmfs/dlmfs.c
> +++ b/fs/ocfs2/dlmfs/dlmfs.c
> @@ -82,8 +82,13 @@ static int param_set_dlmfs_capabilities(const char *val,
>   static int param_get_dlmfs_capabilities(char *buffer,
>   					const struct kernel_param *kp)
>   {
> -	return strlcpy(buffer, DLMFS_CAPABILITIES,
> +	int cnt;
> +
> +	cnt = strlcpy(buffer, DLMFS_CAPABILITIES,
>   		       strlen(DLMFS_CAPABILITIES) + 1);
> +	cnt += sprintf(buffer + cnt, "\n");
> +
> +	return cnt;
>   }
>   module_param_call(capabilities, param_set_dlmfs_capabilities,
>   		  param_get_dlmfs_capabilities, NULL, 0444);
> 
