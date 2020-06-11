Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2519C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 01:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E42E2074B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 01:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591840615;
	bh=beGVc6bpHeiEA8//p9B6LnBQfT/NH139uiChyIVI8JM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bZAlH/yVadBoJ6Yd7xrD78XVIVQon2Oh1A3g87uknX6anPHJRv6O8+QU88tuhvhsH
	 cF3Ns2a43M6QBQ6mUe6/rH7Yftk0LKHn8mqMC0wg5EOuhZyoLmEg1BJsDV9uJAEJOq
	 LQWBYb1xlOzOcTOnucM6A0LMSTh2DOD8RWkBf/YA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgFKB4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 21:56:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:55866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726326AbgFKB4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 21:56:52 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A1A2206FA;
        Thu, 11 Jun 2020 01:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591840612;
        bh=beGVc6bpHeiEA8//p9B6LnBQfT/NH139uiChyIVI8JM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ENNLJwPCrxED6GSeVc0lD6UMH8JWHDkxknOIE9Liy/jbqoCAuPZvUb2lHh+7Hi11g
         lpQyL9iP/WG0xcg97vS2Zl+6LgrB7/hJXnWZ2g8ocl6qMmFfXLuMayp2HXHZk/IAwB
         oc570nKJrn8AsZfX6H9xyEsZVETqdz6tHAvtUJY4=
Date:   Wed, 10 Jun 2020 18:56:51 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: add F2FS_IOC_SEC_TRIM_FILE ioctl
Message-ID: <20200611015651.GD1339@sol.localdomain>
References: <20200609060137.143501-1-daeho43@gmail.com>
 <20200609165107.GA228564@gmail.com>
 <CACOAw_xEZ+au9yhFerq9amkRO62Dzxj7h71gEc=i16ReYu5xrg@mail.gmail.com>
 <20200610031532.GA6286@sol.localdomain>
 <CACOAw_wErOPC=Kf3UU8nFGhWRy84ZnCeJbsyPhSCcXv51B_XxQ@mail.gmail.com>
 <CACOAw_zka6d06RxFOUTwEV7B6o8A2-_6FvqWh_A1nJ0+7FU9yQ@mail.gmail.com>
 <CACOAw_yc4hxdyxyO+Lb4MArHek1tP4wxCq0tezWOocgqvK+tqg@mail.gmail.com>
 <20200611000037.GC1339@sol.localdomain>
 <CACOAw_xqHnL0MthPykSrKJ8OXez-XigCFgC-vwm_keEZh_g8zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACOAw_xqHnL0MthPykSrKJ8OXez-XigCFgC-vwm_keEZh_g8zw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 11, 2020 at 09:23:23AM +0900, Daeho Jeong wrote:
> Yes, I saw the implementation in vfs_write().
> But if we use mnt_want_write_file() here, it'll call mnt_clone_write()
> internally if the file is already open in write mode.
> Don't you think the below thing is needed? We can increase the counter
> each of them, open and ioctl, like other filesystems such as ext4.
> 
> int mnt_clone_write(struct vfsmount *mnt)
> {
>         /* superblock may be r/o */
>         if (__mnt_is_readonly(mnt))
>                 return -EROFS;
>         preempt_disable();
>         mnt_inc_writers(real_mount(mnt));
>         preempt_enable();
>         return 0;
> }

No, this seems to be left over from when mnt_want_write_file() was paired with
mnt_drop_write() instead of mnt_drop_write_file().  I sent a patch to remove it:
https://lkml.kernel.org/r/20200611014945.237210-1-ebiggers@kernel.org

- Eric
