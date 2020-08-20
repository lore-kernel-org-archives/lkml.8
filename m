Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4534DC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14FEE20738
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597926287;
	bh=ng2dWQPIygJnSwEabXZLLCmhiuRhUXoVKVZys+erk0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D7GwSdOYj0Bp06Payandopl4tLsy6vu7GYGNEakvP83evQMapH3NAjFSbDS517HWU
	 8t0dXpAQk4fh7l4pO/8uL3FTnn8mXFUyH16japebK+UCQyBsdULv+3jkmB03CKTMoR
	 JonIEtozbMp0D09dNo0rGMe3xdt9pg/nATmk4dD8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730213AbgHTMYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 08:24:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:35826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730071AbgHTJxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:53:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DAF0821775;
        Thu, 20 Aug 2020 09:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597917224;
        bh=ng2dWQPIygJnSwEabXZLLCmhiuRhUXoVKVZys+erk0A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EUVejZn/cAiveBWTpASi2nk6sFV7RMmEVlhpVuasLyXX7Iv2BdAhuuxkCaEGJX+eO
         QSFx3Cwo/4OCBXwaa0GmkXeW+EHfCLzxFlaviOK0Bd86GxJu6yDIu8IqBWeo7tNCvg
         fNpMTSzLzlkApPdzrLfdpFGDBowhDADqj16Wdbo4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        "Pavel Machek (CIP)" <pavel@denx.de>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.19 17/92] btrfs: fix return value mixup in btrfs_get_extent
Date:   Thu, 20 Aug 2020 11:21:02 +0200
Message-Id: <20200820091538.452622277@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091537.490965042@linuxfoundation.org>
References: <20200820091537.490965042@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Machek <pavel@denx.de>

commit 881a3a11c2b858fe9b69ef79ac5ee9978a266dc9 upstream.

btrfs_get_extent() sets variable ret, but out: error path expect error
to be in variable err so the error code is lost.

Fixes: 6bf9e4bd6a27 ("btrfs: inode: Verify inode mode to avoid NULL pointer dereference")
CC: stable@vger.kernel.org # 5.4+
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Pavel Machek (CIP) <pavel@denx.de>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/inode.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7014,7 +7014,7 @@ struct extent_map *btrfs_get_extent(stru
 	    found_type == BTRFS_FILE_EXTENT_PREALLOC) {
 		/* Only regular file could have regular/prealloc extent */
 		if (!S_ISREG(inode->vfs_inode.i_mode)) {
-			ret = -EUCLEAN;
+			err = -EUCLEAN;
 			btrfs_crit(fs_info,
 		"regular/prealloc extent found for non-regular inode %llu",
 				   btrfs_ino(inode));


