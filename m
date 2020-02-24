Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC0CC11D30
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 18:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1300120880
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 18:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582568515;
	bh=INkkX8BeAdlsUyfuW01txMYdtezcAInzGJF0a9bDL/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Y5EVVCfVBCaz6EQxX+iDvMvdjqbd/vSyV2+VFXb5qRx/W4dR93CQwYIM+bS6dxrM3
	 JYRuLXdLExZFHsqXpBjRaZ7XF7wF47bAm/Tqvr0689xBWc1w6Apm7sVMblM+sRBXa/
	 Fkn7br02sQBZ3uJvFAc5F9mkQcdfPwdhc6NTgtwc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgBXSVx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 13:21:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:58880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727796AbgBXSVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 13:21:53 -0500
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58FBE21556;
        Mon, 24 Feb 2020 18:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582568512;
        bh=INkkX8BeAdlsUyfuW01txMYdtezcAInzGJF0a9bDL/s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jJXJxiHTm22qH3SBmM4MRCguLBq1bAnC5/btGewKrr+QC8nsgutiJynfhYUD+wquk
         iYwAnVsP8bLB+onR6Pa8Ks8FPzHjkwHNyByGzJSf0cwLDbj57kkGK+n4I2zreTaYd4
         pUJMNq7FmNq05Vv86iXS9S8BTrnvonxalQqwy4AM=
From:   Eric Biggers <ebiggers@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v2 2/2] tty: fix compat TIOCGSERIAL checking wrong function ptr
Date:   Mon, 24 Feb 2020 10:20:44 -0800
Message-Id: <20200224182044.234553-3-ebiggers@kernel.org>
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
checking for the presence of the ->set_serial function pointer rather
than ->get_serial.  This appears to be a copy-and-paste error, since
->get_serial is the function pointer that is called as well as the
pointer that is checked by the non-compat version of TIOCGSERIAL.

Fix this by checking the correct function pointer.

Fixes: 77654350306a ("take compat TIOC[SG]SERIAL treatment into tty_compat_ioctl()")
Cc: <stable@vger.kernel.org> # v4.20+
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 drivers/tty/tty_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index db4a13bc855ed6..5a6f36b391d95d 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -2734,7 +2734,7 @@ static int compat_tty_tiocgserial(struct tty_struct *tty,
 	memset(&v, 0, sizeof(v));
 	memset(&v32, 0, sizeof(v32));
 
-	if (!tty->ops->set_serial)
+	if (!tty->ops->get_serial)
 		return -ENOTTY;
 	err = tty->ops->get_serial(tty, &v);
 	if (!err) {
-- 
2.25.0.265.gbab2e86ba0-goog

