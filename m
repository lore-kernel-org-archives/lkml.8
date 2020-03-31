Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDABCC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9431720848
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585645282;
	bh=KvzhaAcLy43FUwrIjwAkHeCXYc3rw3M7R9H8+Ql4ais=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D7zlpxf2bz7A/h9QWcJt2FXd506My5bc/L/+MMmJv7RqhllU+mtcmz9id01vAGh93
	 NZRJqPr5CBLlnHN14Wa+7GjbU0dk/SznvRCeNwhbb/FopNVql7GQrspI7Qy/mFt/bJ
	 USgd1r42jmyIh5vzA5K/OgF7CCTGAKzTH4OHoD8U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730545AbgCaJBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:01:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:40370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730529AbgCaJBQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:01:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3819420848;
        Tue, 31 Mar 2020 09:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585645275;
        bh=KvzhaAcLy43FUwrIjwAkHeCXYc3rw3M7R9H8+Ql4ais=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bKvV6ihgVF6p/GHTBXhoACaa6oY2O4W8iIHtWoSSmet1/V6S7xPhFXjgwBUjc7Tp9
         WfBqRWKjiz/ig1w9CYDKEtFA4nBD5bTIsvA3V2YBEQtPRJa6Tas7OwRUR+g+ptldKU
         ra9zKmZvDzuIE/jDR7U65r1tQypvZZQ32UQs2pIY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+fcab69d1ada3e8d6f06b@syzkaller.appspotmail.com,
        Alexander Potapenko <glider@google.com>,
        Eric Biggers <ebiggers@google.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 5.6 18/23] libfs: fix infoleak in simple_attr_read()
Date:   Tue, 31 Mar 2020 10:59:30 +0200
Message-Id: <20200331085316.284532826@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200331085308.098696461@linuxfoundation.org>
References: <20200331085308.098696461@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

commit a65cab7d7f05c2061a3e2490257d3086ff3202c6 upstream.

Reading from a debugfs file at a nonzero position, without first reading
at position 0, leaks uninitialized memory to userspace.

It's a bit tricky to do this, since lseek() and pread() aren't allowed
on these files, and write() doesn't update the position on them.  But
writing to them with splice() *does* update the position:

	#define _GNU_SOURCE 1
	#include <fcntl.h>
	#include <stdio.h>
	#include <unistd.h>
	int main()
	{
		int pipes[2], fd, n, i;
		char buf[32];

		pipe(pipes);
		write(pipes[1], "0", 1);
		fd = open("/sys/kernel/debug/fault_around_bytes", O_RDWR);
		splice(pipes[0], NULL, fd, NULL, 1, 0);
		n = read(fd, buf, sizeof(buf));
		for (i = 0; i < n; i++)
			printf("%02x", buf[i]);
		printf("\n");
	}

Output:
	5a5a5a5a5a5a5a5a5a5a5a5a5a5a5a5a5a5a5a5a5a5a5a30

Fix the infoleak by making simple_attr_read() always fill
simple_attr::get_buf if it hasn't been filled yet.

Reported-by: syzbot+fcab69d1ada3e8d6f06b@syzkaller.appspotmail.com
Reported-by: Alexander Potapenko <glider@google.com>
Fixes: acaefc25d21f ("[PATCH] libfs: add simple attribute files")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@google.com>
Acked-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20200308023849.988264-1-ebiggers@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/libfs.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -891,7 +891,7 @@ int simple_attr_open(struct inode *inode
 {
 	struct simple_attr *attr;
 
-	attr = kmalloc(sizeof(*attr), GFP_KERNEL);
+	attr = kzalloc(sizeof(*attr), GFP_KERNEL);
 	if (!attr)
 		return -ENOMEM;
 
@@ -931,9 +931,11 @@ ssize_t simple_attr_read(struct file *fi
 	if (ret)
 		return ret;
 
-	if (*ppos) {		/* continued read */
+	if (*ppos && attr->get_buf[0]) {
+		/* continued read */
 		size = strlen(attr->get_buf);
-	} else {		/* first read */
+	} else {
+		/* first read */
 		u64 val;
 		ret = attr->get(attr->data, &val);
 		if (ret)


