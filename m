Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78EECC33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DC422072E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579218284;
	bh=jQT+WNioAeZDY5GTweyyOO5vpR1C6KAoTQe7/C5EF3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XnRwHNPBn6zUsgUu5Tf1Yiv8QKa/pQRPxAX3L/R+6H2RqRbhhtdcIgB1lnMrtXR6m
	 iOLEQJrrJ0uLOvopL6Ea5Wq0qv3zgPelH8iNmL7Z/yZwFX0mdgtqxNPhNR61C/sZMC
	 fK36vgvCxmuKpQN/CarQtcCEO/hahxiv/3Tw1gOw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbgAPXXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:23:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:52468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729770AbgAPXXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:23:48 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 836B020684;
        Thu, 16 Jan 2020 23:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579217028;
        bh=jQT+WNioAeZDY5GTweyyOO5vpR1C6KAoTQe7/C5EF3E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N57H+kKTsOxkI70j9SJG/G/eal5VNOKN8WyzXljQVUBMjumSSgB4pjE1mhcBzyeZS
         abIeMCtI3rIcXxXjZ82nzjh2zdEH4u+DaCtWTOjGGzxYsOEC3nWv7+ZtZgQebCOsis
         9gVZ2DNSrSs4KM2rn9poDQO+wWhiGKJzF4uT/UjQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 5.4 118/203] affs: fix a memory leak in affs_remount
Date:   Fri, 17 Jan 2020 00:17:15 +0100
Message-Id: <20200116231755.674843689@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200116231745.218684830@linuxfoundation.org>
References: <20200116231745.218684830@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Navid Emamdoost <navid.emamdoost@gmail.com>

commit 450c3d4166837c496ebce03650c08800991f2150 upstream.

In affs_remount if data is provided it is duplicated into new_opts.  The
allocated memory for new_opts is only released if parse_options fails.

There's a bit of history behind new_options, originally there was
save/replace options on the VFS layer so the 'data' passed must not
change (thus strdup), this got cleaned up in later patches. But not
completely.

There's no reason to do the strdup in cases where the filesystem does
not need to reuse the 'data' again, because strsep would modify it
directly.

Fixes: c8f33d0bec99 ("affs: kstrdup() memory handling")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
[ update changelog ]
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/affs/super.c |    6 ------
 1 file changed, 6 deletions(-)

--- a/fs/affs/super.c
+++ b/fs/affs/super.c
@@ -561,14 +561,9 @@ affs_remount(struct super_block *sb, int
 	int			 root_block;
 	unsigned long		 mount_flags;
 	int			 res = 0;
-	char			*new_opts;
 	char			 volume[32];
 	char			*prefix = NULL;
 
-	new_opts = kstrdup(data, GFP_KERNEL);
-	if (data && !new_opts)
-		return -ENOMEM;
-
 	pr_debug("%s(flags=0x%x,opts=\"%s\")\n", __func__, *flags, data);
 
 	sync_filesystem(sb);
@@ -579,7 +574,6 @@ affs_remount(struct super_block *sb, int
 			   &blocksize, &prefix, volume,
 			   &mount_flags)) {
 		kfree(prefix);
-		kfree(new_opts);
 		return -EINVAL;
 	}
 


