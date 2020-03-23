Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E638C1975A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 02:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A338E20714
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 02:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgCWCCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 22:02:49 -0400
Received: from smtprelay0176.hostedemail.com ([216.40.44.176]:44760 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726954AbgCWCCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 22:02:49 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id A55B2837F24F;
        Mon, 23 Mar 2020 02:02:48 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: cakes39_8cd2320f7ba51
X-Filterd-Recvd-Size: 2290
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Mon, 23 Mar 2020 02:02:47 +0000 (UTC)
Message-ID: <ed37a2a18060f71accb202c05724c0b66d0aa9f7.camel@perches.com>
Subject: Re: [PATCH v3] f2fs: fix potential .flags overflow on 32bit
 architecture
From:   Joe Perches <joe@perches.com>
To:     Chao Yu <yuchao0@huawei.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Date:   Sun, 22 Mar 2020 19:00:58 -0700
In-Reply-To: <20200323012519.41536-1-yuchao0@huawei.com>
References: <20200323012519.41536-1-yuchao0@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-03-23 at 09:25 +0800, Chao Yu wrote:
> f2fs_inode_info.flags is unsigned long variable, it has 32 bits
> in 32bit architecture, since we introduced FI_MMAP_FILE flag
> when we support data compression, we may access memory cross
> the border of .flags field, corrupting .i_sem field, result in
> below deadlock.
> 
> To fix this issue, let's expand .flags as an array to grab enough
> space to store new flags.
[]
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
[]
> @@ -2586,22 +2590,28 @@ static inline void __mark_inode_dirty_flag(struct inode *inode,
>  	}
>  }
>  
> +static inline void __set_inode_flag(struct inode *inode, int flag)
> +{
> +	test_and_set_bit(flag % BITS_PER_LONG,
> +			&F2FS_I(inode)->flags[BIT_WORD(flag)]);

I believe this should just use

	test_and_set_bit(flag, F2FS_I(inode)->flags);

>  static inline int is_inode_flag_set(struct inode *inode, int flag)
>  {
> -	return test_bit(flag, &F2FS_I(inode)->flags);
> +	return test_bit(flag % BITS_PER_LONG,
> +				&F2FS_I(inode)->flags[BIT_WORD(flag)]);

here too.

	test_bit(flag, F2FS_I(inode)->flags);

>  static inline void clear_inode_flag(struct inode *inode, int flag)
>  {
> -	if (test_bit(flag, &F2FS_I(inode)->flags))
> -		clear_bit(flag, &F2FS_I(inode)->flags);
> +	test_and_clear_bit(flag % BITS_PER_LONG,
> +				&F2FS_I(inode)->flags[BIT_WORD(flag)]);

and here.

I also don't know why these functions are used at all.


