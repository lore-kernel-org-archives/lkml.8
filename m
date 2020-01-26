Return-Path: <SRS0=fzvl=3P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE2DC35242
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 01:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 333362071E
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 01:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbgAZBfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 20:35:31 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:44755 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728266AbgAZBfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 20:35:31 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04455;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0ToWxMHv_1580002507;
Received: from JosephdeMacBook-Pro.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0ToWxMHv_1580002507)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 26 Jan 2020 09:35:27 +0800
Subject: Re: [PATCH] OCFS2: remove FS_OCFS2_NM
To:     Alex Shi <alex.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
References: <1579577812-251572-1-git-send-email-alex.shi@linux.alibaba.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <693015a3-5ead-9cd6-e95b-5b246722166b@linux.alibaba.com>
Date:   Sun, 26 Jan 2020 09:35:06 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <1579577812-251572-1-git-send-email-alex.shi@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/1/21 11:36, Alex Shi wrote:
> This macro is't used from commit ab09203e302b ("sysctl fs: Remove
> dead binary sysctl support"). Better to remove it.
> 
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Mark Fasheh <mark@fasheh.com> 
> Cc: Joel Becker <jlbec@evilplan.org> 
> Cc: Joseph Qi <joseph.qi@linux.alibaba.com> 
> Cc: ocfs2-devel@oss.oracle.com 
> Cc: linux-kernel@vger.kernel.org

Acked-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
>  fs/ocfs2/stackglue.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/fs/ocfs2/stackglue.c b/fs/ocfs2/stackglue.c
> index 8aa6a667860c..a191094694c6 100644
> --- a/fs/ocfs2/stackglue.c
> +++ b/fs/ocfs2/stackglue.c
> @@ -656,8 +656,6 @@ static int ocfs2_sysfs_init(void)
>   * and easier to preserve the name.
>   */
>  
> -#define FS_OCFS2_NM		1
> -
>  static struct ctl_table ocfs2_nm_table[] = {
>  	{
>  		.procname	= "hb_ctl_path",
> 
