Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98AF2C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 00:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CE9C2082E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 00:35:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cock.li header.i=@cock.li header.b="knpvXt/S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbgBEAfr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 19:35:47 -0500
Received: from mx1.cock.li ([185.10.68.5]:60785 "EHLO cock.li"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727627AbgBEAfr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 19:35:47 -0500
From:   Sergey Alirzaev <l29ah@cock.li>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cock.li; s=mail;
        t=1580862943; bh=Hjws4hd6gO2//6ej+Q1oLOrL7jmkiZKIXGuthMfEYqY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=knpvXt/SYh3/6+DkvT/RYVyVwKyKqP/J1WLMVs3qP/R++J9A2mtZwIjjvtJ+MN2bQ
         RPoGVCnorvJAyGWi7TMoFHUM6NGBdUXi+mvX9iws//EgMbGGoh1lDdfcbzCOdQ7jo4
         Tnb5CJldbRPd0ul46RllaNuUEHWk/V+GGAVJTVYs2gXiYkiNpi9EXJeYJkFkCK5mQa
         6jwTP1VU3bw4b6GV1vCe3OAweiRo5yudSefxBK/A3jqcvpYelAt/JYEW/BOe6XyBpZ
         Bwrj+uL4xBSfVGZNAN9N0VQ1sfdv0psNuGfwbs7dLeF+inGP4LOFs/i6RFbrSY9F01
         4XnN3SCgmrXJg==
To:     v9fs-developer@lists.sourceforge.net
Cc:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sergey Alirzaev <l29ah@cock.li>
Subject: [PATCH 2/2] 9p: read only once on O_NONBLOCK
Date:   Wed,  5 Feb 2020 03:34:57 +0300
Message-Id: <20200205003457.24340-2-l29ah@cock.li>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200205003457.24340-1-l29ah@cock.li>
References: <20200205003457.24340-1-l29ah@cock.li>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A proper way to handle O_NONBLOCK would be making the requests and
responses happen asynchronously, but this would require serious code
refactoring.

Signed-off-by: Sergey Alirzaev <l29ah@cock.li>
---
 fs/9p/vfs_file.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index fe7f0bd2048e..92cd1d80218d 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -388,7 +388,10 @@ v9fs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	p9_debug(P9_DEBUG_VFS, "count %zu offset %lld\n",
 		 iov_iter_count(to), iocb->ki_pos);
 
-	ret = p9_client_read(fid, iocb->ki_pos, to, &err);
+	if (iocb->ki_filp->f_flags & O_NONBLOCK)
+		ret = p9_client_read_once(fid, iocb->ki_pos, to, &err);
+	else
+		ret = p9_client_read(fid, iocb->ki_pos, to, &err);
 	if (!ret)
 		return err;
 
-- 
2.25.0

