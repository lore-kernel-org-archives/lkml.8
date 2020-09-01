Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB1CCC433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 865F52098B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598977212;
	bh=tHKKDdx8BA02sDk2tqSPEaqF9p987xBjlq5hJtW7Gyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=k2ZcTpSiDhdXECQglBAuVfCm3mMoSLB/jWfcD/E5+DTWZY/3TGLA+vgwfWBFMD7s3
	 jz7ynsIx8Zrx8+fFa8OQzjK4o0DmxpYktlOkfpIWf4kux2BahMbdYxMLF8QylnZUdD
	 vgSAT+Y4NKjW9bCTlUM6Ps4oAwpUA1CJRcek6syU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731944AbgIAQUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 12:20:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:36936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731134AbgIAPc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:32:59 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E47F820866;
        Tue,  1 Sep 2020 15:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598974379;
        bh=tHKKDdx8BA02sDk2tqSPEaqF9p987xBjlq5hJtW7Gyg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zupNTItqKDHCKt0UHiiQciVEeRdF7on6Bj6hLk2dVEbcG5n8GfJJ+ymEtzduZB3Mx
         I0Naw+lUopH0tOFB6JkW9nEYO+V7vWd7atwx+SFz6qTQqwg/jx7ahAO+cexLf1qTKc
         eWFzixvd9FMKpyqRYgTFg23XBAcKqzidtwr3Ka9U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marcos Paulo de Souza <mpdesouza@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 5.4 153/214] btrfs: reset compression level for lzo on remount
Date:   Tue,  1 Sep 2020 17:10:33 +0200
Message-Id: <20200901151000.298059926@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901150952.963606936@linuxfoundation.org>
References: <20200901150952.963606936@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcos Paulo de Souza <mpdesouza@suse.com>

commit 282dd7d7718444679b046b769d872b188818ca35 upstream.

Currently a user can set mount "-o compress" which will set the
compression algorithm to zlib, and use the default compress level for
zlib (3):

  relatime,compress=zlib:3,space_cache

If the user remounts the fs using "-o compress=lzo", then the old
compress_level is used:

  relatime,compress=lzo:3,space_cache

But lzo does not expose any tunable compression level. The same happens
if we set any compress argument with different level, also with zstd.

Fix this by resetting the compress_level when compress=lzo is
specified.  With the fix applied, lzo is shown without compress level:

  relatime,compress=lzo,space_cache

CC: stable@vger.kernel.org # 4.4+
Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/super.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -544,6 +544,7 @@ int btrfs_parse_options(struct btrfs_fs_
 			} else if (strncmp(args[0].from, "lzo", 3) == 0) {
 				compress_type = "lzo";
 				info->compress_type = BTRFS_COMPRESS_LZO;
+				info->compress_level = 0;
 				btrfs_set_opt(info->mount_opt, COMPRESS);
 				btrfs_clear_opt(info->mount_opt, NODATACOW);
 				btrfs_clear_opt(info->mount_opt, NODATASUM);


