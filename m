Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E82C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 10:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E2AF2067D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 10:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732719AbgF3K7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 06:59:18 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:37528 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732592AbgF3K7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 06:59:17 -0400
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id 14A251B405B;
        Tue, 30 Jun 2020 19:59:16 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.15.2/8.15.2/Debian-19) with ESMTPS id 05UAxEpR115301
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 30 Jun 2020 19:59:15 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.15.2/8.15.2/Debian-19) with ESMTPS id 05UAxExX1271894
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 30 Jun 2020 19:59:14 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.15.2/8.15.2/Submit) id 05UAxEtj1271893;
        Tue, 30 Jun 2020 19:59:14 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     fengyubo <fengyubo3@huawei.com>, <fangwei1@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fatfs: switch write_lock to read_lock in
 fat_ioctl_get_attributes
References: <1593308053-12702-1-git-send-email-fengyubo3@huawei.com>
Date:   Tue, 30 Jun 2020 19:59:14 +0900
In-Reply-To: <1593308053-12702-1-git-send-email-fengyubo3@huawei.com>
        (fengyubo's message of "Sun, 28 Jun 2020 09:34:13 +0800")
Message-ID: <87k0zoom4d.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fengyubo <fengyubo3@huawei.com> writes:

> From: Yubo Feng <fengyubo3@huawei.com>
>
> There is no necessery to hold write_lock in fat_ioctl_get_attributes.
> write_lock may make an impact on concurrency of fat_ioctl_get_attributes.
>
> Signed-off-by: Yubo Feng <fengyubo3@huawei.com>

Looks good.

Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

> ---
>  fs/fat/file.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/fat/file.c b/fs/fat/file.c
> index 42134c5..f9ee27c 100644
> --- a/fs/fat/file.c
> +++ b/fs/fat/file.c
> @@ -25,9 +25,9 @@ static int fat_ioctl_get_attributes(struct inode *inode, u32 __user *user_attr)
>  {
>  	u32 attr;
>  
> -	inode_lock(inode);
> +	inode_lock_shared(inode);
>  	attr = fat_make_attrs(inode);
> -	inode_unlock(inode);
> +	inode_unlock_shared(inode);
>  
>  	return put_user(attr, user_attr);
>  }

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
