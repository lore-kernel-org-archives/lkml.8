Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04995C11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 18:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C36CD20838
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 18:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582568520;
	bh=HHffBA1xZRZJMcbypgR4QrM3PbiivCptJcaucVhdCx4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v5ZY/1IpBX/0Ry9/Bp78NUqdWZs8aNvJQn1gJuLTW8Ixh0mX+1wmks+p6ZV0zRAX5
	 YMz+UaFk8LEEEl0GJOZBwcs3XuddmA2CnnZtN4T9iap0rdKVKp5vf1Jg6yHqCfHPvm
	 ifhrIb3IeaMVpMTBi+1RCxnbH4gqnQYUM8U9Lt/w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbgBXSV7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 13:21:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:58860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727727AbgBXSVw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 13:21:52 -0500
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DD0D2084E;
        Mon, 24 Feb 2020 18:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582568512;
        bh=HHffBA1xZRZJMcbypgR4QrM3PbiivCptJcaucVhdCx4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LD8DxQ3oknenBHer0gtf++MxWrn5G/pw1pR3EHAuHoD0J8hzJNry3BXTJ2BbkYXrq
         fRuyBA37lI58VOhUMoPLvf5KfRgc3M9TA2Wq7w/vUIsAGu+pwKwzk+d72QTeswXQsj
         FF/yW1GimcDuuMu9Kg52GjA+742jdXWuyvSFM8c8=
From:   Eric Biggers <ebiggers@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v2 1/2] tty: fix compat TIOCGSERIAL leaking uninitialized memory
Date:   Mon, 24 Feb 2020 10:20:43 -0800
Message-Id: <20200224182044.234553-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
In-Reply-To: <20200224182044.234553-1-ebiggers@kernel.org>
References: <20200224181532.GA109047@gmail.com>
 <20200224182044.234553-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Commit 77654350306a ("take compat TIOC[SG]SERIAL treatment into
tty_compat_ioctl()") changed the compat version of TIOCGSERIAL to start
copying a whole 'serial_struct32' to userspace rather than individual
fields, but failed to initialize all padding and fields -- namely the
hole after the 'iomem_reg_shift' field, and the 'reserved' field.

Fix this by initializing the struct to zero.

[v2: use sizeof, and convert the adjacent line for consistency.]

Reported-by: syzbot+8da9175e28eadcb203ce@syzkaller.appspotmail.com
Fixes: 77654350306a ("take compat TIOC[SG]SERIAL treatment into tty_compat_ioctl()")
Cc: <stable@vger.kernel.org> # v4.20+
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 drivers/tty/tty_io.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 1fcf7ad83dfa0a..db4a13bc855ed6 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -2730,7 +2730,9 @@ static int compat_tty_tiocgserial(struct tty_struct *tty,
 	struct serial_struct32 v32;
 	struct serial_struct v;
 	int err;
-	memset(&v, 0, sizeof(struct serial_struct));
+
+	memset(&v, 0, sizeof(v));
+	memset(&v32, 0, sizeof(v32));
 
 	if (!tty->ops->set_serial)
 		return -ENOTTY;
-- 
2.25.0.265.gbab2e86ba0-goog

