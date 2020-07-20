Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F862C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 01:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D58F208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 01:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbgGTBQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 21:16:38 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:56939 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726225AbgGTBQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 21:16:38 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0U3AOGOv_1595207795;
Received: from JosephdeMacBook-Pro.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0U3AOGOv_1595207795)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 20 Jul 2020 09:16:36 +0800
Subject: Re: [PATCH] ocfs2: fix remounting needed after setfacl command
To:     Gang He <ghe@suse.com>, mark@fasheh.com, jlbec@evilplan.org
Cc:     linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        akpm@linux-foundation.org
References: <20200717023751.9922-1-ghe@suse.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <3bcaf181-9a1a-e9d1-c41b-0dd1edc79d63@linux.alibaba.com>
Date:   Mon, 20 Jul 2020 09:16:35 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200717023751.9922-1-ghe@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/7/17 10:37, Gang He wrote:
> When use setfacl command to change a file's acl, the user cannot
> get the latest acl information from the file via getfacl command,
> until remounting the file system.
> e.g.
> setfacl -m u:ivan:rw /ocfs2/ivan
> getfacl /ocfs2/ivan
> getfacl: Removing leading '/' from absolute path names
> file: ocfs2/ivan
> owner: root
> group: root
> user::rw-
> group::r--
> mask::r--
> other::r--
> 
> The latest acl record("u:ivan:rw") cannot be returned via getfacl
> command until remounting.
> 
> Signed-off-by: Gang He <ghe@suse.com>

Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
>  fs/ocfs2/acl.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/ocfs2/acl.c b/fs/ocfs2/acl.c
> index bb981ec76456..7b07f5df3a29 100644
> --- a/fs/ocfs2/acl.c
> +++ b/fs/ocfs2/acl.c
> @@ -256,6 +256,8 @@ static int ocfs2_set_acl(handle_t *handle,
>  		ret = ocfs2_xattr_set(inode, name_index, "", value, size, 0);
>  
>  	kfree(value);
> +	if (!ret)
> +		set_cached_acl(inode, type, acl);
>  
>  	return ret;
>  }
> 
