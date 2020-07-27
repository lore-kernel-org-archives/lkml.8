Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0954FC433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E20FD22B43
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729496AbgG0OuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:50:16 -0400
Received: from verein.lst.de ([213.95.11.211]:43952 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727032AbgG0OuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:50:16 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 22BB968B05; Mon, 27 Jul 2020 16:50:13 +0200 (CEST)
Date:   Mon, 27 Jul 2020 16:50:13 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: Re: bpfilter logging write errors in dmesg
Message-ID: <20200727145013.GA2154@lst.de>
References: <20200727104636.nuz3u4xb7ba7ue5a@wittgenstein> <20200727132855.GA28165@lst.de> <20200727141337.liwdfjxq4cwvt5if@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727141337.liwdfjxq4cwvt5if@wittgenstein>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Strange.  Can you add this additional debugging patch:

diff --git a/fs/read_write.c b/fs/read_write.c
index 4fb797822567a6..d0a8ada1efd954 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -369,8 +369,10 @@ int rw_verify_area(int read_write, struct file *file, const loff_t *ppos, size_t
 	int retval = -EINVAL;
 
 	inode = file_inode(file);
-	if (unlikely((ssize_t) count < 0))
+	if (unlikely((ssize_t) count < 0)) {
+		printk("count invalid: %zd\n", count);
 		return retval;
+	}
 
 	/*
 	 * ranged mandatory locking does not apply to streams - it makes sense
@@ -380,25 +382,35 @@ int rw_verify_area(int read_write, struct file *file, const loff_t *ppos, size_t
 		loff_t pos = *ppos;
 
 		if (unlikely(pos < 0)) {
-			if (!unsigned_offsets(file))
+			if (!unsigned_offsets(file)) {
+				printk("pos invalid: %lld\n", pos);
 				return retval;
+			}
 			if (count >= -pos) /* both values are in 0..LLONG_MAX */
 				return -EOVERFLOW;
 		} else if (unlikely((loff_t) (pos + count) < 0)) {
-			if (!unsigned_offsets(file))
+			if (!unsigned_offsets(file)) {
+				printk("pos+count invalid: %lld, %zd\n", pos, count);
 				return retval;
+			}
 		}
 
 		if (unlikely(inode->i_flctx && mandatory_lock(inode))) {
 			retval = locks_mandatory_area(inode, file, pos, pos + count - 1,
 					read_write == READ ? F_RDLCK : F_WRLCK);
-			if (retval < 0)
+			if (retval < 0) {
+				if (retval == -EINVAL)
+					printk("locks_mandatory_area\n");
 				return retval;
+			}
 		}
 	}
 
-	return security_file_permission(file,
+	retval = security_file_permission(file,
 				read_write == READ ? MAY_READ : MAY_WRITE);
+	if (retval == -EINVAL)
+		printk("security_file_permission\n");
+	return retval;
 }
 
 static ssize_t new_sync_read(struct file *filp, char __user *buf, size_t len, loff_t *ppos)
