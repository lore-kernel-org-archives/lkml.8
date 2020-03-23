Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A95DC4332E
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 10:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57EFB20769
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 10:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbgCWKmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 06:42:08 -0400
Received: from smtprelay0192.hostedemail.com ([216.40.44.192]:40866 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727908AbgCWKmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 06:42:07 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 1FBD8100E7B47;
        Mon, 23 Mar 2020 10:42:07 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: spot70_125bc865c5d12
X-Filterd-Recvd-Size: 1557
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Mon, 23 Mar 2020 10:42:06 +0000 (UTC)
Message-ID: <afa74570dacebb3b93d4b9c27d6c8a87186cef2d.camel@perches.com>
Subject: Re: [PATCH v5] f2fs: fix potential .flags overflow on 32bit
 architecture
From:   Joe Perches <joe@perches.com>
To:     Chao Yu <yuchao0@huawei.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Date:   Mon, 23 Mar 2020 03:40:16 -0700
In-Reply-To: <20200323031807.94473-1-yuchao0@huawei.com>
References: <20200323031807.94473-1-yuchao0@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-03-23 at 11:18 +0800, Chao Yu wrote:
> f2fs_inode_info.flags is unsigned long variable, it has 32 bits
> in 32bit architecture, since we introduced FI_MMAP_FILE flag
> when we support data compression, we may access memory cross
> the border of .flags field, corrupting .i_sem field, result in
> below deadlock.
[]
> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
[]
> @@ -362,7 +362,7 @@ static int do_read_inode(struct inode *inode)
>  	fi->i_flags = le32_to_cpu(ri->i_flags);
>  	if (S_ISREG(inode->i_mode))
>  		fi->i_flags &= ~F2FS_PROJINHERIT_FL;
> -	fi->flags = 0;
> +	bitmap_zero(fi->flags, BITS_TO_LONGS(FI_MAX));

Sorry, I misled you here, this should be

	bitmap_zero(fi->flags, FI_MAX);


