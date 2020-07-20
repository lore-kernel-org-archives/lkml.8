Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C82FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 14:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 528F122C9C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 14:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbgGTOx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 10:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726601AbgGTOx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 10:53:58 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0A7C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 07:53:58 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 1001)
        id C2768C009; Mon, 20 Jul 2020 16:53:55 +0200 (CEST)
Date:   Mon, 20 Jul 2020 16:53:40 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Jianyong Wu <jianyong.wu@arm.com>
Cc:     ericvh@gmail.com, hch@lst.de, dhowells@redhat.com,
        lucho@ionkov.net, v9fs-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Kaly.Xin@arm.com, justin.he@arm.com,
        wei.chen@arm.com
Subject: Re: [RFC PATCH 1/2] vfs: pass file down when getattr to avoid losing
 info.
Message-ID: <20200720145340.GA13275@nautica>
References: <20200720014622.37364-1-jianyong.wu@arm.com>
 <20200720014622.37364-2-jianyong.wu@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200720014622.37364-2-jianyong.wu@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jianyong Wu wrote on Mon, Jul 20, 2020:
> Currently, getting attribute for a file represented by fd is always
> by inode or path which may lead to bug for a certain network file system.
> Adding file struct into struct kstat and assigning file for it in
> vfs_statx_fd can avoid this issue. This change refers to struct istat.
> 
> Signed-off-by: Jianyong Wu <jianyong.wu@arm.com>
> ---
>  fs/stat.c            | 1 +
>  include/linux/stat.h | 6 ++++++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/fs/stat.c b/fs/stat.c
> index 44f8ad346db4..0dee5487f6d6 100644
> --- a/fs/stat.c
> +++ b/fs/stat.c
> @@ -147,6 +147,7 @@ int vfs_statx_fd(unsigned int fd, struct kstat *stat,
>  		return -EINVAL;
>  
>  	f = fdget_raw(fd);
> +	stat->filp = f.file;
>  	if (f.file) {
>  		error = vfs_getattr(&f.file->f_path, stat,
>  				    request_mask, query_flags);
> diff --git a/include/linux/stat.h b/include/linux/stat.h
> index 56614af83d4a..4755c528d49a 100644
> --- a/include/linux/stat.h
> +++ b/include/linux/stat.h
> @@ -48,6 +48,12 @@ struct kstat {
>  	struct timespec64 btime;			/* File creation time */
>  	u64		blocks;
>  	u64		mnt_id;
> +
> +	/*
> +	 * Not an attribute, but an auxiliary info for filesystems wanting to
> +	 * implement an fstat() like method.
> +	 */
> +	struct file	*filp;

Just, no ; don't touch this, it isn't likely to get accepted ever.
file operations should all have a filp around already, we need to fix
this in our code.

(also missing quite a few Cc if you ever want to touch these bits, at
least linux-fsdevel@)



FWIW the problem has been discussed a few times previously.

I'd appreciate if you could take over from Eric and Greg's old series
that intended to fix that:
https://lore.kernel.org/lkml/146659832556.15781.17414806975641516683.stgit@bahia.lan/

it introduced a race somewhere, but the idea looked good at the time so
it's worth looking into.

-- 
Dominique
