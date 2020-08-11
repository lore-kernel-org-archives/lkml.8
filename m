Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B83C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 02:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F38C206DC
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 02:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mNTtX+Bp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbgHKCSY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 22:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbgHKCSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 22:18:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A788C06174A;
        Mon, 10 Aug 2020 19:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=KC4Xk9+BSS3xq+MetJHETebtbJQTzZeqEni3gSzxfmc=; b=mNTtX+BpXnpeDwddUKKjrnzwkX
        6/Xv8r5K9M6I1W9KvQsuyr1pAErm2r2PSxN5xVmNHMy17n2fx/xxvdg/y8vVL2ppedhXd3Ob4pSKH
        kTYcstXlJfj7jvZ9l3sVUMHjDGErpgp+SYFTMvm1eOZMHT31TqDPvraaYLIuqCqcMRGuKsgVhhSs9
        4bwPopo7ywsLpdfvj6ygpRGIPuU9Ly7LkZcZX6CD0LLfMhxqIrTThjJWXXwfYxzgPZqE3F+ZDO9W6
        fVEWWGhO2QLohI+tALpW4otDWWweCKdQFFbhJmP3KXuAHCfeANMAm3+qshCQmqWCneblbWmktOoz6
        LVWvRxpQ==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k5Jro-0006ot-8X; Tue, 11 Aug 2020 02:18:21 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, Ian Kent <raven@themaw.net>,
        autofs@vger.kernel.org
Subject: [PATCH] fs: autofs: delete repeated words in comments
Date:   Mon, 10 Aug 2020 19:18:17 -0700
Message-Id: <20200811021817.24982-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop duplicated words {the, at} in comments.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org
---
 fs/autofs/dev-ioctl.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20200807.orig/fs/autofs/dev-ioctl.c
+++ linux-next-20200807/fs/autofs/dev-ioctl.c
@@ -20,7 +20,7 @@
  * another mount. This situation arises when starting automount(8)
  * or other user space daemon which uses direct mounts or offset
  * mounts (used for autofs lazy mount/umount of nested mount trees),
- * which have been left busy at at service shutdown.
+ * which have been left busy at service shutdown.
  */
 
 typedef int (*ioctl_fn)(struct file *, struct autofs_sb_info *,
@@ -496,7 +496,7 @@ static int autofs_dev_ioctl_askumount(st
  * located path is the root of a mount we return 1 along with
  * the super magic of the mount or 0 otherwise.
  *
- * In both cases the the device number (as returned by
+ * In both cases the device number (as returned by
  * new_encode_dev()) is also returned.
  */
 static int autofs_dev_ioctl_ismountpoint(struct file *fp,
