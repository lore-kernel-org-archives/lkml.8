Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D890BC1975A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 01:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F93420722
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 01:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="RWwGJOKf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbgCWBui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 21:50:38 -0400
Received: from vps.xff.cz ([195.181.215.36]:37720 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726954AbgCWBui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 21:50:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
        t=1584928236; bh=1N30fcEiZZHKBwEnOj8WWoevPWmYxyTUVcPdUGEd8VE=;
        h=Date:From:To:Cc:Subject:References:X-My-GPG-KeyId:From;
        b=RWwGJOKfp8Gr8AiVOHHK7dNKWIZF6ArzehJDlzDMofSgs5dGvdFPbF8uLA46sy7+d
         FC6NjOMYhiCFGsUgEimFwvK1Pohb6g+OehoXJ8QMdkjysSzdA41/i5Qhs/sCE/behe
         qJnW95oq0YmXDfKASbPTNv7dvLxQKugaEmHkMMSE=
Date:   Mon, 23 Mar 2020 02:50:36 +0100
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH v3] f2fs: fix potential .flags overflow on 32bit
 architecture
Message-ID: <20200323015036.pniupuucfl3dug4m@core.my.home>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>,
        Chao Yu <yuchao0@huawei.com>, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
References: <20200323012519.41536-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323012519.41536-1-yuchao0@huawei.com>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Chao Yu,

On Mon, Mar 23, 2020 at 09:25:19AM +0800, Chao Yu wrote:
> [snip]
>  
> +static inline void __set_inode_flag(struct inode *inode, int flag)
> +{
> +	test_and_set_bit(flag % BITS_PER_LONG,
> +			&F2FS_I(inode)->flags[BIT_WORD(flag)]);

This can simply be:

    test_and_set_bit(flag, F2FS_I(inode)->flags);

all of these bitmap manipulation functions already will do the
right thing to access the correct location in the flags array:

  https://elixir.bootlin.com/linux/latest/source/include/asm-generic/bitops/atomic.h#L32

see BIT_MASK and BIT_WORD use in that function.

> +}
> +
>  static inline void set_inode_flag(struct inode *inode, int flag)
>  {
> -	if (!test_bit(flag, &F2FS_I(inode)->flags))
> -		set_bit(flag, &F2FS_I(inode)->flags);
> +	__set_inode_flag(inode, flag);
>  	__mark_inode_dirty_flag(inode, flag, true);
>  }
>  
>  static inline int is_inode_flag_set(struct inode *inode, int flag)
>  {
> -	return test_bit(flag, &F2FS_I(inode)->flags);
> +	return test_bit(flag % BITS_PER_LONG,
> +				&F2FS_I(inode)->flags[BIT_WORD(flag)]);

ditto

>  }
>  
>  static inline void clear_inode_flag(struct inode *inode, int flag)
>  {
> -	if (test_bit(flag, &F2FS_I(inode)->flags))
> -		clear_bit(flag, &F2FS_I(inode)->flags);
> +	test_and_clear_bit(flag % BITS_PER_LONG,
> +				&F2FS_I(inode)->flags[BIT_WORD(flag)]);

ditto

I'm going to test the patch. It looks like that this was really
the root cause of all those locking issues I was seeing on my
32-bit tablet. It seems to explain why my 64-bit systems were
not affected, and why reverting compession fixed it too.
Great job figuring this out.

I'll let you know soon.

thank you and regards,
	o.

>  	__mark_inode_dirty_flag(inode, flag, false);
>  }
>  
