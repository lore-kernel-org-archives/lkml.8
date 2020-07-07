Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A6AAC433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40B50204EC
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594135924;
	bh=Jz4gFQK5q46RmtPj1m4NWM1unA7WG2z/dnwJHV6seIo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tUyO5EBw5tzkcAM1PdE+Kw5WhuS5NmVdj5dVLQitK8M/11mt/bVvGTFM5H7cesfLa
	 iQGilP/6X3gSEXDc+M34tQ9ePy3BFSqKKH11gZhEnCcIp3rgXeXvscCAzjhj+IdCDr
	 PRIIabOn4xzdMRVW0c/UB8B6L44h/BRNuEIetuJI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729327AbgGGPWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:22:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:35050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729853AbgGGPW1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 11:22:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0953F20663;
        Tue,  7 Jul 2020 15:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594135347;
        bh=Jz4gFQK5q46RmtPj1m4NWM1unA7WG2z/dnwJHV6seIo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XpnHjXqbr5ajA/jPxFHXC2lG77stvvxPwkWVcVshu21IoIIraF+wY3U1BZoaokZvj
         3WE1tym/3cZF5q/OmYEdciBUOdvXJKFRIt7/zaz+24dMP7k6NPpcJwb6BSlomRp3sJ
         osZu9yvUF/XOzUdUQVJWHxlwtthOc48zyBoTkus8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Aurich <paul@darkrain42.org>,
        Steve French <stfrench@microsoft.com>,
        Aurelien Aptel <aaptel@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 40/65] SMB3: Honor posix flag for multiuser mounts
Date:   Tue,  7 Jul 2020 17:17:19 +0200
Message-Id: <20200707145754.396140663@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200707145752.417212219@linuxfoundation.org>
References: <20200707145752.417212219@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Aurich <paul@darkrain42.org>

[ Upstream commit 5391b8e1b7b7e5cfa2dd4ffdc4b8c6b64dfd1866 ]

The flag from the primary tcon needs to be copied into the volume info
so that cifs_get_tcon will try to enable extensions on the per-user
tcon. At that point, since posix extensions must have already been
enabled on the superblock, don't try to needlessly adjust the mount
flags.

Fixes: ce558b0e17f8 ("smb3: Add posix create context for smb3.11 posix mounts")
Fixes: b326614ea215 ("smb3: allow "posix" mount option to enable new SMB311 protocol extensions")
Signed-off-by: Paul Aurich <paul@darkrain42.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Reviewed-by: Aurelien Aptel <aaptel@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/connect.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 947c4aad5d6a4..134a90dc72322 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -5282,6 +5282,7 @@ cifs_construct_tcon(struct cifs_sb_info *cifs_sb, kuid_t fsuid)
 	vol_info->nohandlecache = master_tcon->nohandlecache;
 	vol_info->local_lease = master_tcon->local_lease;
 	vol_info->no_linux_ext = !master_tcon->unix_ext;
+	vol_info->linux_ext = master_tcon->posix_extensions;
 	vol_info->sectype = master_tcon->ses->sectype;
 	vol_info->sign = master_tcon->ses->sign;
 
@@ -5309,10 +5310,6 @@ cifs_construct_tcon(struct cifs_sb_info *cifs_sb, kuid_t fsuid)
 		goto out;
 	}
 
-	/* if new SMB3.11 POSIX extensions are supported do not remap / and \ */
-	if (tcon->posix_extensions)
-		cifs_sb->mnt_cifs_flags |= CIFS_MOUNT_POSIX_PATHS;
-
 	if (cap_unix(ses))
 		reset_cifs_unix_caps(0, tcon, NULL, vol_info);
 
-- 
2.25.1



