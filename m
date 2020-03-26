Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B9FC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 23:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4ADF2077D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 23:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585265082;
	bh=HlxskFbsYt3+njsgtfJZSeFdRTEuzk6dYipazKydfG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sYolFr7xZEWTxSs/Nr/z0vObN4AwPoELHSTe4sAj55kWvsy8k2SesU5W37h9RTMH1
	 IRzfaPJNBIH1m+6G+SHcyCS6aDsmAnBSwtGPtr9Bvjf8uj9zkudAnWBLmGFb+3/d5N
	 wV81cpCjskk4+wAVqQ2KuTwh5NP870wYIQj8BrOU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbgCZXYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 19:24:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:44172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727912AbgCZXY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 19:24:29 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C25220719;
        Thu, 26 Mar 2020 23:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585265068;
        bh=HlxskFbsYt3+njsgtfJZSeFdRTEuzk6dYipazKydfG4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ov/npAwsHIdau8ZhA0+WeQYN+p6KGJS6V45IV/2uW0db32+Ri1WIv37NB9UFBrtos
         uQ+Zk/TyItFpoxYCkMldWqA5RzBu4DBOxBU7HKLPK/5NVZFxJwfx7u+0Mqq+Q+FwgS
         P+klsysXlZzzen3mfxdj6/zdxrXW/oylqHBYpXt0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Eric Biggers <ebiggers@google.com>,
        syzbot+8da9175e28eadcb203ce@syzkaller.appspotmail.com,
        Jiri Slaby <jslaby@suse.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.5 27/28] tty: fix compat TIOCGSERIAL leaking uninitialized memory
Date:   Thu, 26 Mar 2020 19:23:56 -0400
Message-Id: <20200326232357.7516-27-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200326232357.7516-1-sashal@kernel.org>
References: <20200326232357.7516-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

[ Upstream commit 17329563a97df3ba474eca5037c1336e46e14ff8 ]

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
Acked-by: Jiri Slaby <jslaby@suse.cz>
Link: https://lore.kernel.org/r/20200224182044.234553-2-ebiggers@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/tty_io.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index d9f54c7d94f29..186e08a81b986 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -2734,7 +2734,9 @@ static int compat_tty_tiocgserial(struct tty_struct *tty,
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
2.20.1

