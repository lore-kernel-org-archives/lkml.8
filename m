Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0865BC54EEB
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 15:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D35932074D
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 15:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584976229;
	bh=DEot+U5aAhQnERI+yODgTb0Q/N9eQ71HwwOhlgIpZNg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xOteWfghfjFstXvHGRGh9D1jEuZYa0DOQZZkMjgh9WrkyBkBEy3lOyuZW1AOW9rwn
	 MZYVVTu2haNwsW1SOFO4rOlotbZhhRX31cGwSch+zvzj8LX+ne4m7kgAXfoDN6Vqsa
	 vHBOUKC0rybouYE6pO8suYMFpjsNuU0x57a9DKnU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbgCWPK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 11:10:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:32926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727064AbgCWPK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 11:10:28 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89130206F8;
        Mon, 23 Mar 2020 15:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584976227;
        bh=DEot+U5aAhQnERI+yODgTb0Q/N9eQ71HwwOhlgIpZNg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fp35Xy2S29GLP/ffijwK4fWsN+7zW24b/sRU3E5KJRjWgG2NDU9PL5qcUH5rARgsq
         U/XhqJhFFnjVPTVydoGD1OUz86UQbWzlEmA/IJXfp1RWhT6z5RLNP6inFn/hEAWGja
         x4PkJp+QG2cQ6qnZ7pz53hrZcikOl+4Q50CiCUls=
Date:   Mon, 23 Mar 2020 08:10:27 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH v5] f2fs: fix potential .flags overflow on 32bit
 architecture
Message-ID: <20200323151027.GA123526@google.com>
References: <20200323031807.94473-1-yuchao0@huawei.com>
 <afa74570dacebb3b93d4b9c27d6c8a87186cef2d.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afa74570dacebb3b93d4b9c27d6c8a87186cef2d.camel@perches.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/23, Joe Perches wrote:
> On Mon, 2020-03-23 at 11:18 +0800, Chao Yu wrote:
> > f2fs_inode_info.flags is unsigned long variable, it has 32 bits
> > in 32bit architecture, since we introduced FI_MMAP_FILE flag
> > when we support data compression, we may access memory cross
> > the border of .flags field, corrupting .i_sem field, result in
> > below deadlock.
> []
> > diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> []
> > @@ -362,7 +362,7 @@ static int do_read_inode(struct inode *inode)
> >  	fi->i_flags = le32_to_cpu(ri->i_flags);
> >  	if (S_ISREG(inode->i_mode))
> >  		fi->i_flags &= ~F2FS_PROJINHERIT_FL;
> > -	fi->flags = 0;
> > +	bitmap_zero(fi->flags, BITS_TO_LONGS(FI_MAX));
> 
> Sorry, I misled you here, this should be
> 
> 	bitmap_zero(fi->flags, FI_MAX);

Thanks, I applied this directly in the f2fs tree.
