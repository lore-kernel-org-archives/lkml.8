Return-Path: <SRS0=BhYR=34=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CBFEC35242
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 18:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17A1F20661
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 18:33:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbgBHSdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Feb 2020 13:33:36 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34382 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727921AbgBHS3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 13:29:46 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1j0UrL-0003gP-6v; Sat, 08 Feb 2020 18:29:39 +0000
Received: from ben by deadeye with local (Exim 4.93)
        (envelope-from <ben@decadent.org.uk>)
        id 1j0UrI-000CQV-Ui; Sat, 08 Feb 2020 18:29:36 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Miklos Szeredi" <mszeredi@redhat.com>
Date:   Sat, 08 Feb 2020 18:20:27 +0000
Message-ID: <lsq.1581185940.112796972@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 088/148] fuse: verify nlink
In-Reply-To: <lsq.1581185939.857586636@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.82-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Miklos Szeredi <mszeredi@redhat.com>

commit c634da718db9b2fac201df2ae1b1b095344ce5eb upstream.

When adding a new hard link, make sure that i_nlink doesn't overflow.

Fixes: ac45d61357e8 ("fuse: fix nlink after unlink")
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/fuse/dir.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -890,7 +890,8 @@ static int fuse_link(struct dentry *entr
 
 		spin_lock(&fc->lock);
 		fi->attr_version = ++fc->attr_version;
-		inc_nlink(inode);
+		if (likely(inode->i_nlink < UINT_MAX))
+			inc_nlink(inode);
 		spin_unlock(&fc->lock);
 		fuse_invalidate_attr(inode);
 		fuse_update_ctime(inode);

