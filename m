Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 780B8C433EC
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F00122AB0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594752750;
	bh=iv8j59IizSFovtJeOSAaB86Jk9Z6jur6Paq2/nEHfOw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YHblaz/i6eijiW7M49VAKWJETQSZJTXR7/hc+EwZLBkscwtJEXLMPUxvDYGPbMW+c
	 5Ux8mcbLoASeHOKLshKpYobRwsaigmZyU9shmPk4UJscZDoe5n9vDruQcRk7ZFSwGG
	 88v4CG40+73GnqkhvokST0mPq3hbLdy4pzikQxbA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730526AbgGNSw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 14:52:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:49136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730511AbgGNSwY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:52:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81BB422B42;
        Tue, 14 Jul 2020 18:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594752744;
        bh=iv8j59IizSFovtJeOSAaB86Jk9Z6jur6Paq2/nEHfOw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fTjQleT0YE61FAUpMxBNDHU/uOjYvrMHPtX8J06celY8+9W9iWjz/VkvGkCPzcDnX
         psyhMS55CEkKJIqdEHHCbl711T5wS4d06NFV047rCWpHpWTmVjwwQ5bM2MxrBBJ+9o
         kGrqiCHJYciE5KEU57q+dCqHUaYCA41GGyjKeZm4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 5.4 094/109] btrfs: fix double put of block group with nocow
Date:   Tue, 14 Jul 2020 20:44:37 +0200
Message-Id: <20200714184110.060376603@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714184105.507384017@linuxfoundation.org>
References: <20200714184105.507384017@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef Bacik <josef@toxicpanda.com>

commit 230ed397435e85b54f055c524fcb267ae2ce3bc4 upstream.

While debugging a patch that I wrote I was hitting use-after-free panics
when accessing block groups on unmount.  This turned out to be because
in the nocow case if we bail out of doing the nocow for whatever reason
we need to call btrfs_dec_nocow_writers() if we called the inc.  This
puts our block group, but a few error cases does

if (nocow) {
    btrfs_dec_nocow_writers();
    goto error;
}

unfortunately, error is

error:
	if (nocow)
		btrfs_dec_nocow_writers();

so we get a double put on our block group.  Fix this by dropping the
error cases calling of btrfs_dec_nocow_writers(), as it's handled at the
error label now.

Fixes: 762bf09893b4 ("btrfs: improve error handling in run_delalloc_nocow")
CC: stable@vger.kernel.org # 5.4+
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/inode.c |    9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1657,12 +1657,8 @@ out_check:
 			ret = fallback_to_cow(inode, locked_page, cow_start,
 					      found_key.offset - 1,
 					      page_started, nr_written);
-			if (ret) {
-				if (nocow)
-					btrfs_dec_nocow_writers(fs_info,
-								disk_bytenr);
+			if (ret)
 				goto error;
-			}
 			cow_start = (u64)-1;
 		}
 
@@ -1678,9 +1674,6 @@ out_check:
 					  ram_bytes, BTRFS_COMPRESS_NONE,
 					  BTRFS_ORDERED_PREALLOC);
 			if (IS_ERR(em)) {
-				if (nocow)
-					btrfs_dec_nocow_writers(fs_info,
-								disk_bytenr);
 				ret = PTR_ERR(em);
 				goto error;
 			}


