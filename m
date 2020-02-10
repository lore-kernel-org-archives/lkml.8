Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24BFEC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4F4C20733
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581340881;
	bh=rSh3R8xY6L76Nno7pwqyOzKKxTJ7fEguyZYa2B7n3O0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=q38dg0FVhVmybTpPslXRSYt74YuOTcnjyu4g7BPY7hetMgLCcN8ThkPk8nlLkwd+A
	 EMzx9Ut0Mx4jZb5Z0Kprnw9Aq/ZrFlTBM4W/1esL2KSnNyVRepp+tJ5mTz/Rvx29kV
	 TAvOSgcWpIQmOiny6Pg1FGFcTrAGinw+y6eNifgU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728919AbgBJNVT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:21:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:59466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728794AbgBJMhd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:37:33 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85B0320661;
        Mon, 10 Feb 2020 12:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338252;
        bh=rSh3R8xY6L76Nno7pwqyOzKKxTJ7fEguyZYa2B7n3O0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uSNYw5XBC3391L3xtafBf79SJIakVvi/A4AwLYMSbJ3o0NA4DJP7fnV4ZCu4rpbrE
         iHZgXZQMKOD78OxXVYv+9bSUxpdDD5NxQMsQcM2x67QhfPb6r4PXgod9N9EwOKV4au
         JRSthC/dgBc6dg9FwNEKr1odvYrjomrRgGcBuMiA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 5.4 116/309] ovl: fix wrong WARN_ON() in ovl_cache_update_ino()
Date:   Mon, 10 Feb 2020 04:31:12 -0800
Message-Id: <20200210122417.690355831@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122406.106356946@linuxfoundation.org>
References: <20200210122406.106356946@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amir Goldstein <amir73il@gmail.com>

commit 4c37e71b713ecffe81f8e6273c6835e54306d412 upstream.

The WARN_ON() that child entry is always on overlay st_dev became wrong
when we allowed this function to update d_ino in non-samefs setup with xino
enabled.

It is not true in case of xino bits overflow on a non-dir inode.  Leave the
WARN_ON() only for directories, where assertion is still true.

Fixes: adbf4f7ea834 ("ovl: consistent d_ino for non-samefs with xino")
Cc: <stable@vger.kernel.org> # v4.17+
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/overlayfs/readdir.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -504,7 +504,13 @@ get:
 		if (err)
 			goto fail;
 
-		WARN_ON_ONCE(dir->d_sb->s_dev != stat.dev);
+		/*
+		 * Directory inode is always on overlay st_dev.
+		 * Non-dir with ovl_same_dev() could be on pseudo st_dev in case
+		 * of xino bits overflow.
+		 */
+		WARN_ON_ONCE(S_ISDIR(stat.mode) &&
+			     dir->d_sb->s_dev != stat.dev);
 		ino = stat.ino;
 	} else if (xinobits && !OVL_TYPE_UPPER(type)) {
 		ino = ovl_remap_lower_ino(ino, xinobits,


