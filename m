Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87015C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 12:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E6CC2076D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 12:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QDR+C2Zs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgHRMWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 08:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgHRMWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 08:22:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C93C061389;
        Tue, 18 Aug 2020 05:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=+TgE1JF1d6UB4sQBGOF/uowtc9cBOuBWtMOMxeYqtZE=; b=QDR+C2ZsGEXI1Md5uEzhyt12rB
        wxfv99K4RX3S/Sm6bDwMNyKWKMGtv/py0zHaJC/knCmgpjQEmJzt/bu5uwDmbnu0iM1EBLEsTqLe/
        b0VOfKDyXWZkT11IJ3r1GaF/ZPC2KAEwHx5s1wG/l+4Qv5YLs6oN/8uIsPxVpLZLSdZLEoLJKiu0G
        1jAzlEzVdjQYtEXW4gCuml3TT58SQDpoKNtoZteS44eyVLL+DnwtR8iaOnLvaPMSMU9aYJs2Zb/cZ
        QlOtVUubgBGtn2wr76F8kHMJkJBIhoAZh3rYBVh83LrT/7mzpmin/jcjgLUTCAS6zHjYLbVeuxc8x
        oGoxueaA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k80ct-0008FN-SK; Tue, 18 Aug 2020 12:22:03 +0000
Date:   Tue, 18 Aug 2020 13:22:03 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Ian Kent <raven@themaw.net>, autofs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Harden autofs ioctl table
Message-ID: <20200818122203.GO17456@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The table of ioctl functions should be marked const in order to put them
in read-only memory, and we should use array_index_nospec() to avoid
speculation disclosing the contents of kernel memory to userspace.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

diff --git a/fs/autofs/dev-ioctl.c b/fs/autofs/dev-ioctl.c
index 75105f45c51a..322b7dfb4ea0 100644
--- a/fs/autofs/dev-ioctl.c
+++ b/fs/autofs/dev-ioctl.c
@@ -8,6 +8,7 @@
 #include <linux/compat.h>
 #include <linux/syscalls.h>
 #include <linux/magic.h>
+#include <linux/nospec.h>
 
 #include "autofs_i.h"
 
@@ -563,7 +564,7 @@ static int autofs_dev_ioctl_ismountpoint(struct file *fp,
 
 static ioctl_fn lookup_dev_ioctl(unsigned int cmd)
 {
-	static ioctl_fn _ioctls[] = {
+	static const ioctl_fn _ioctls[] = {
 		autofs_dev_ioctl_version,
 		autofs_dev_ioctl_protover,
 		autofs_dev_ioctl_protosubver,
@@ -581,7 +582,10 @@ static ioctl_fn lookup_dev_ioctl(unsigned int cmd)
 	};
 	unsigned int idx = cmd_idx(cmd);
 
-	return (idx >= ARRAY_SIZE(_ioctls)) ? NULL : _ioctls[idx];
+	if (idx >= ARRAY_SIZE(_ioctls))
+		return NULL;
+	idx = array_index_nospec(idx, ARRAY_SIZE(_ioctls));
+	return _ioctls[idx];
 }
 
 /* ioctl dispatcher */
