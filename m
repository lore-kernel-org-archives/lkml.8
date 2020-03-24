Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05BF5C2BAEE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92CCE2073E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585056605;
	bh=N4fXa6BWlAkxno12kmSG/DrQ+vfBVHlWoVdXT7PuMXE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Oj+fibD42xFiCO14xR6deUPM/pJQdAUI814FpCBtuJ/mvB4mB2szucRlJ36fP3S1j
	 4kSQnxipXyTtjy4jQWx87Ya2i0tN81/wS+SvN0f7xkez48/Ohtasxv1MnMffdCe3zS
	 ZRlIQTp5opGek8e9+yUW3VbookDyK6tL28LbHd5E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729461AbgCXNXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:23:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:46946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728243AbgCXNXo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:23:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 368D3208D6;
        Tue, 24 Mar 2020 13:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585056223;
        bh=N4fXa6BWlAkxno12kmSG/DrQ+vfBVHlWoVdXT7PuMXE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xK1eEyvANQg0VRZ1i0zXDNhMg73+9NhDblCsd5iBnSA29HnMPA3vBx2FKxHbFFDVC
         head/FJZ6qydt6XNJZhSB9NvOLavapsPq6KqMvx4GPUmDwrQCnHhC9UicIPoGqx1ae
         6EyUec0pwDHCDRA3ZKkF+089MjD2zNP/oreuMhrw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 5.5 061/119] tty: fix compat TIOCGSERIAL checking wrong function ptr
Date:   Tue, 24 Mar 2020 14:10:46 +0100
Message-Id: <20200324130814.308198624@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200324130808.041360967@linuxfoundation.org>
References: <20200324130808.041360967@linuxfoundation.org>
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
@@ -2738,7 +2738,7 @@ static int compat_tty_tiocgserial(struct
 	memset(&v, 0, sizeof(v));
 	memset(&v32, 0, sizeof(v32));
 
-	if (!tty->ops->set_serial)
+	if (!tty->ops->get_serial)
 		return -ENOTTY;
 	err = tty->ops->get_serial(tty, &v);
 	if (!err) {


