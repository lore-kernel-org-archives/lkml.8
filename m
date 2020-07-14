Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D420BC433F1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 12:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF0E9222D9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 12:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbgGNMNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 08:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728252AbgGNMNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 08:13:07 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E16C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 05:13:06 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 1001)
        id C9AB1C01B; Tue, 14 Jul 2020 14:13:04 +0200 (CEST)
Date:   Tue, 14 Jul 2020 14:12:49 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Victor Hsieh <victorhsieh@google.com>
Cc:     v9fs-developer@lists.sourceforge.net,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] fs/9p: Fix TCREATE's fid in protocol
Message-ID: <20200714121249.GA21928@nautica>
References: <20200713215759.3701482-1-victorhsieh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200713215759.3701482-1-victorhsieh@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Victor Hsieh wrote on Mon, Jul 13, 2020:
> The fid parameter of TCREATE represents the directory that the file

This is not TCREATE, this is TLCREATE.
The fid represents the directory before the call, but on success
represents the file that has been created.

> should be created at. The current implementation mistakenly passes a
> locally created fid for the file. The correct file fid is usually
> retrieved by another WALK call, which does happen right after.
> 
> The problem happens when a new created fd is read from (i.e. where
> private_data->fid is used), but not write to.

I'm not sure why the code currently does a 2nd walk from the directory
with the name which is prone to a race instead of cloning ofid without a
path, but I fail to see the problem you ran into - file->private_data is
a fid pointing to the file as it should be.

Could you describe what kind of errors you get and if possible how to
reproduce?

> Fixes: 5643135a2846 ("fs/9p: This patch implements TLCREATE for 9p2000.L protocol.")
> Signed-off-by: Victor Hsieh <victorhsieh@google.com>
> Cc: stable@vger.kernel.org

(afaiu it is normally frowned upon for developers to add this cc (I can
understand stable@ not wanting spam discussing issues left and right
before maintainers agreed on them!) ; I can add it to the commit itself
if requested but they normally pick most such fixes pretty nicely for
backport anyway; I see most 9p patches backported as long as the patch
applies cleanly which is pretty much all the time.
Please let me know if I understood that incorrectly)

> ---
>  fs/9p/vfs_inode_dotl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
> index 60328b21c5fb..90a7aaea918d 100644
> --- a/fs/9p/vfs_inode_dotl.c
> +++ b/fs/9p/vfs_inode_dotl.c
> @@ -285,7 +285,7 @@ v9fs_vfs_atomic_open_dotl(struct inode *dir, struct dentry *dentry,
>  			 err);
>  		goto error;
>  	}
> -	err = p9_client_create_dotl(ofid, name, v9fs_open_to_dotl_flags(flags),
> +	err = p9_client_create_dotl(dfid, name, v9fs_open_to_dotl_flags(flags),
>  				    mode, gid, &qid);
>  	if (err < 0) {
>  		p9_debug(P9_DEBUG_VFS, "p9_client_open_dotl failed in creat %d\n",
