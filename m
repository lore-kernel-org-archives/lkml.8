Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA52CC1975A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 03:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CCCF2073E
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 03:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="jb0LErdb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgCWDFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 23:05:52 -0400
Received: from vps.xff.cz ([195.181.215.36]:38156 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726916AbgCWDFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 23:05:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
        t=1584932750; bh=dWxO70ZTLWZJ/KAhe6blVdbhTNEFPju6heLfNQ0Z/9U=;
        h=Date:From:To:Cc:Subject:References:X-My-GPG-KeyId:From;
        b=jb0LErdb9VgV2rmrGqNGuWkkc6q8J/yibcY2EIVwy/McVutQzIq9iRJXhWRWsH1OS
         qjXwx0iPNQXjLu/JS1P0bwqR6nZl6tMLE4KHtqLuN5zV5XC0KyFD48G78KWOVUyRuH
         XFne/Mtcbekr6lhg0nZHmRWFForeLeoQurKCxNIk=
Date:   Mon, 23 Mar 2020 04:05:49 +0100
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH v4] f2fs: fix potential .flags overflow on 32bit
 architecture
Message-ID: <20200323030549.rwlexq76ng4nq7nt@core.my.home>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>,
        Chao Yu <yuchao0@huawei.com>, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
References: <20200323024109.60967-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323024109.60967-1-yuchao0@huawei.com>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Mar 23, 2020 at 10:41:09AM +0800, Chao Yu wrote:
> f2fs_inode_info.flags is unsigned long variable, it has 32 bits
> in 32bit architecture, since we introduced FI_MMAP_FILE flag
> when we support data compression, we may access memory cross
> the border of .flags field, corrupting .i_sem field, result in
> below deadlock.
> 
> To fix this issue, let's expand .flags as an array to grab enough
> space to store new flags.
> 
> Call Trace:
>  __schedule+0x8d0/0x13fc
>  ? mark_held_locks+0xac/0x100
>  schedule+0xcc/0x260
>  rwsem_down_write_slowpath+0x3ab/0x65d
>  down_write+0xc7/0xe0
>  f2fs_drop_nlink+0x3d/0x600 [f2fs]
>  f2fs_delete_inline_entry+0x300/0x440 [f2fs]
>  f2fs_delete_entry+0x3a1/0x7f0 [f2fs]
>  f2fs_unlink+0x500/0x790 [f2fs]
>  vfs_unlink+0x211/0x490
>  do_unlinkat+0x483/0x520
>  sys_unlink+0x4a/0x70
>  do_fast_syscall_32+0x12b/0x683
>  entry_SYSENTER_32+0xaa/0x102
> 
> Fixes: 4c8ff7095bef ("f2fs: support data compression")
> Signed-off-by: Chao Yu <yuchao0@huawei.com>

Tested-by: Ondrej Jirman <megous@megous.com>

This patch alone also fixes all the other lockups I reported recently,
that were easier to trigger than this one.

thanks,
	o.
