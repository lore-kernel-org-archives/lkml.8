Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01821C1975A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 02:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFF3520769
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 02:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbgCWC7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 22:59:00 -0400
Received: from smtprelay0204.hostedemail.com ([216.40.44.204]:45076 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727067AbgCWC7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 22:59:00 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id BCE4E1802926E;
        Mon, 23 Mar 2020 02:58:59 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: foot07_314bb36a3e01d
X-Filterd-Recvd-Size: 2428
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Mon, 23 Mar 2020 02:58:58 +0000 (UTC)
Message-ID: <8d435607bd79f518bd9420d68894ddda521bac5a.camel@perches.com>
Subject: Re: [PATCH v4] f2fs: fix potential .flags overflow on 32bit
 architecture
From:   Joe Perches <joe@perches.com>
To:     Chao Yu <yuchao0@huawei.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Date:   Sun, 22 Mar 2020 19:57:09 -0700
In-Reply-To: <20200323024109.60967-1-yuchao0@huawei.com>
References: <20200323024109.60967-1-yuchao0@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-03-23 at 10:41 +0800, Chao Yu wrote:
> f2fs_inode_info.flags is unsigned long variable, it has 32 bits
> in 32bit architecture, since we introduced FI_MMAP_FILE flag
> when we support data compression, we may access memory cross
> the border of .flags field, corrupting .i_sem field, result in
> below deadlock.
[]
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
[]
> @@ -682,6 +682,47 @@ enum {
[]
> +/* used for f2fs_inode_info->flags */
> +enum {
[]
> +	FI_MAX,			/* max flag, never be used */
> +};
> +
> +/* f2fs_inode_info.flags array size */
> +#define FI_ARRAY_SIZE		(BITS_TO_LONGS(FI_MAX))

Perhaps FI_ARRAY_SIZE isn't necessary.

> +
>  struct f2fs_inode_info {
>  	struct inode vfs_inode;		/* serve a vfs inode */
>  	unsigned long i_flags;		/* keep an inode flags for ioctl */
> @@ -694,7 +735,7 @@ struct f2fs_inode_info {
>  	umode_t i_acl_mode;		/* keep file acl mode temporarily */
>  
>  	/* Use below internally in f2fs*/
> -	unsigned long flags;		/* use to pass per-file flags */
> +	unsigned long flags[FI_ARRAY_SIZE];	/* use to pass per-file flags */

and BITS_TO_LONGS should be used here.

> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
[]
> @@ -362,7 +363,8 @@ static int do_read_inode(struct inode *inode)
>  	fi->i_flags = le32_to_cpu(ri->i_flags);
>  	if (S_ISREG(inode->i_mode))
>  		fi->i_flags &= ~F2FS_PROJINHERIT_FL;
> -	fi->flags = 0;
> +	for (i = 0; i < FI_ARRAY_SIZE; i++)
> +		fi->flags[i] = 0;

And this could become

	bitmap_zero(fi->flags, BITS_TO_LONG(FI_MAX));

Is FI_ARRAY_SIZE used anywhere else?

