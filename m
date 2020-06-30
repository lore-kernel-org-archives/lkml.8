Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2394C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 11:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87CE92065F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 11:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732860AbgF3LIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 07:08:17 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:37534 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728534AbgF3LIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 07:08:15 -0400
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id B2E2F1B405B;
        Tue, 30 Jun 2020 20:08:13 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.15.2/8.15.2/Debian-19) with ESMTPS id 05UB8C1E115375
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 30 Jun 2020 20:08:13 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.15.2/8.15.2/Debian-19) with ESMTPS id 05UB8CXh1272933
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 30 Jun 2020 20:08:12 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.15.2/8.15.2/Submit) id 05UB8CsR1272932;
        Tue, 30 Jun 2020 20:08:12 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Anupam Aggarwal <anupam.al@samsung.com>
Cc:     linux-kernel@vger.kernel.org, a.sahrawat@samsung.com
Subject: Re: [PATCH] fs: fat: add check for dir size in fat_calc_dir_size
References: <CGME20200629110320epcas5p34ccccc7c293f077b34b350935c328215@epcas5p3.samsung.com>
        <1593428559-13920-1-git-send-email-anupam.al@samsung.com>
Date:   Tue, 30 Jun 2020 20:08:12 +0900
In-Reply-To: <1593428559-13920-1-git-send-email-anupam.al@samsung.com> (Anupam
        Aggarwal's message of "Mon, 29 Jun 2020 16:32:39 +0530")
Message-ID: <87ftacolpf.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Anupam Aggarwal <anupam.al@samsung.com> writes:

> Max directory size of FAT filesystem is FAT_MAX_DIR_SIZE(2097152 bytes)
> It is possible that, due to corruption, directory size calculated in
> fat_calc_dir_size() can be greater than FAT_MAX_DIR_SIZE, i.e.
> can be in GBs, hence directory traversal can take long time.
> for example when command "ls -lR" is executed on corrupted FAT
> formatted USB, fat_search_long() function will lookup for a filename from
> position 0 till end of corrupted directory size, multiple such lookups
> will lead to long directory traversal
>
> Added sanity check for directory size fat_calc_dir_size(),
> and return EIO error, which will prevent lookup in corrupted directory
>
> Signed-off-by: Anupam Aggarwal <anupam.al@samsung.com>
> Signed-off-by: Amit Sahrawat <a.sahrawat@samsung.com>

There are many implementation that doesn't follow the spec strictly. And
when I tested in past, Windows also allowed to read the directory beyond
that limit. I can't recall though if there is in real case or just test
case though.

So if there is no strong reason to apply the limit, I don't think it is
good to limit it. (btw, the current code should detect the corruption of
infinite loop already)

Thanks.

> ---
>  fs/fat/inode.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/fs/fat/inode.c b/fs/fat/inode.c
> index a0cf99d..9b2e81e 100644
> --- a/fs/fat/inode.c
> +++ b/fs/fat/inode.c
> @@ -490,6 +490,13 @@ static int fat_calc_dir_size(struct inode *inode)
>  		return ret;
>  	inode->i_size = (fclus + 1) << sbi->cluster_bits;
>  
> +	if (i_size_read(inode) > FAT_MAX_DIR_SIZE) {
> +		fat_fs_error(inode->i_sb,
> +			     "%s corrupted directory (invalid size %lld)\n",
> +			     __func__, i_size_read(inode));
> +		return -EIO;
> +	}
> +
>  	return 0;
>  }

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
