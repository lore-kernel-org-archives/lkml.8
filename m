Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57EEDC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 03:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0CEF25388
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 03:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="h8uyWq6y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731114AbgFVDCi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 23:02:38 -0400
Received: from mail.zx2c4.com ([192.95.5.64]:32849 "EHLO mail.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726663AbgFVDCi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 23:02:38 -0400
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 1dc30710;
        Mon, 22 Jun 2020 02:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-transfer-encoding;
         s=mail; bh=w/C+/peO/GKCjVxNCmUvVhdvlWE=; b=h8uyWq6yNHptnxTxpp1d
        chgRc+ICh0KLYbnRjj0QnBZuvC3O902RVGYZzRoxFnoquVDcIijADSTaEUwxkLLy
        YFZMq0xt+YBda7kWJjSxpXwsn+fwcZf7ZN9cLKA/T8RYQnpgbm07ZH3+aEEg5owP
        tVixPBxh11GMC79eyLNFV3oXgzesCY5MO8NcRUKB3kXN3rsApg/vmo/uB3hbFKBs
        g7TP5kpTV57S38p45jMY7Zes3eD9BvU3UEuly/lQTiG/1Kb4B8DS5OtrK6zbCrT7
        QaamWcOpR9DylhxMWWiWailmcNbA69jmhm2yMxbd7GzG0/CLvDaBODpwEpcBFI01
        7Q==
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 53c7124b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 22 Jun 2020 02:43:53 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     pmladek@suse.com, linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Bruno Meneguele <bmeneg@redhat.com>,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        David.Laight@ACULAB.COM,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] Revert "kernel/printk: add kmsg SEEK_CUR handling"
Date:   Sun, 21 Jun 2020 21:02:22 -0600
Message-Id: <20200622030222.1370098-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 8ece3b3eb576a78d2e67ad4c3a80a39fa6708809.

This commit broke userspace. Bash uses ESPIPE to determine whether or
not the file should be read using "unbuffered I/O", which means reading
1 byte at a time instead of 128 bytes at a time. I used to use bash to
read through kmsg in a really quite nasty way:

    while read -t 0.1 -r line 2>/dev/null || [[ $? -ne 142 ]]; do
       echo "SARU $line"
    done < /dev/kmsg

This will show all lines that can fit into the 128 byte buffer, and skip
lines that don't. That's pretty awful, but at least it worked.

With this change, bash now tries to do 1-byte reads, which means it
skips all the lines, which is worse than before.

Now, I don't really care very much about this, and I'm already look for
a workaround. But I did just spend an hour trying to figure out why my
scripts were broken. Either way, it makes no difference to me personally
whether this is reverted, but it might be something to consider. If you
declare that "trying to read /dev/kmsg with bash is terminally stupid
anyway," I might be inclined to agree with you. But do note that bash
uses lseek(fd, 0, SEEK_CUR)==>ESPIPE to determine whether or not it's
reading from a pipe.

Cc: Bruno Meneguele <bmeneg@redhat.com>
Cc: pmladek@suse.com
Cc: sergey.senozhatsky@gmail.com
Cc: rostedt@goodmis.org
Cc: David.Laight@ACULAB.COM
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 Documentation/ABI/testing/dev-kmsg |  5 -----
 kernel/printk/printk.c             | 10 ----------
 2 files changed, 15 deletions(-)

diff --git a/Documentation/ABI/testing/dev-kmsg b/Documentation/ABI/testing/dev-kmsg
index 1e6c28b1942b..f307506eb54c 100644
--- a/Documentation/ABI/testing/dev-kmsg
+++ b/Documentation/ABI/testing/dev-kmsg
@@ -56,11 +56,6 @@ Description:	The /dev/kmsg character device node provides userspace access
 		  seek after the last record available at the time
 		  the last SYSLOG_ACTION_CLEAR was issued.
 
-		Due to the record nature of this interface with a "read all"
-		behavior and the specific positions each seek operation sets,
-		SEEK_CUR is not supported, returning -ESPIPE (invalid seek) to
-		errno whenever requested.
-
 		The output format consists of a prefix carrying the syslog
 		prefix including priority and facility, the 64 bit message
 		sequence number and the monotonic timestamp in microseconds,
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 8c14835be46c..b71eaf5f5a86 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -974,16 +974,6 @@ static loff_t devkmsg_llseek(struct file *file, loff_t offset, int whence)
 		user->idx = log_next_idx;
 		user->seq = log_next_seq;
 		break;
-	case SEEK_CUR:
-		/*
-		 * It isn't supported due to the record nature of this
-		 * interface: _SET _DATA and _END point to very specific
-		 * record positions, while _CUR would be more useful in case
-		 * of a byte-based log. Because of that, return the default
-		 * errno value for invalid seek operation.
-		 */
-		ret = -ESPIPE;
-		break;
 	default:
 		ret = -EINVAL;
 	}
-- 
2.27.0

