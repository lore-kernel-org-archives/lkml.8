Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 522EEC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B68A20775
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585055881;
	bh=iBjbZ09cVGZ1XntUHNiVR6x9U+7Uef9bZjfXZREwfb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wwjZlMsSokHmdQR3Q9IMUPD+vJPSAmNLCiT3l+cyPyqOXx566yjAmxk785Txz4yPY
	 TIS3zqhdRYQb/zdIxsJooFfVwbq1lGHMmcFZp7oXv4akmI6nzcxzGvSexid54yA4ki
	 WxjCZVRjTlVrG69gULMGDlHZFDlDLJe0A3S+HVoE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbgCXNR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:17:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:37908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728171AbgCXNR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:17:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1700208CA;
        Tue, 24 Mar 2020 13:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585055876;
        bh=iBjbZ09cVGZ1XntUHNiVR6x9U+7Uef9bZjfXZREwfb8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u0dTNzDH0Dk1SAjRGJZzNqE9nkvhzhcsbTrkTpmS3uUbOPH3t48juawAUYz7KhyUc
         VZaXM8dCDSbqz9pF5Mbbov1V7Ukj+ra8XvyJtEOFX7n7Z0ZLTDEO/oDtUkmwJ+IRLM
         e3OqXb2mVAXztVxoXh4he+DZeObtjRmeBQpc7gkg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 5.4 055/102] tty: fix compat TIOCGSERIAL checking wrong function ptr
Date:   Tue, 24 Mar 2020 14:10:47 +0100
Message-Id: <20200324130812.314596042@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200324130806.544601211@linuxfoundation.org>
References: <20200324130806.544601211@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

commit 6e622cd8bd888c7fa3ee2b7dfb3514ab53b21570 upstream.

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
Acked-by: Jiri Slaby <jslaby@suse.cz>
Link: https://lore.kernel.org/r/20200224182044.234553-3-ebiggers@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/tty_io.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -2735,7 +2735,7 @@ static int compat_tty_tiocgserial(struct
 	memset(&v, 0, sizeof(v));
 	memset(&v32, 0, sizeof(v32));
 
-	if (!tty->ops->set_serial)
+	if (!tty->ops->get_serial)
 		return -ENOTTY;
 	err = tty->ops->get_serial(tty, &v);
 	if (!err) {


