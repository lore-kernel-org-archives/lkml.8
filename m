Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B3ECC2D0F0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6A0620658
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585758071;
	bh=5XjkFM5wyNFBP6SLOe9dlSinzdyO5temJPYtDJ7S7Ak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yi2m4+8uHk/LFVwEzGtqPPNEyhE0es+i6GYKYGzDS9gxVGj3a2f+/WAJpx0oslc1F
	 Ix3QivaHInRm/d53RxK219GpObBLbo0M24MmJ7MHdxvl7dxhWSkX+qEuaOw0VajaD3
	 z6sDAwYOeQxOOhzTax6M4qVO+jK9qjiZ/yRXKwr8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732442AbgDAQVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:21:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:43710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732273AbgDAQUz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:20:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE38320658;
        Wed,  1 Apr 2020 16:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585758055;
        bh=5XjkFM5wyNFBP6SLOe9dlSinzdyO5temJPYtDJ7S7Ak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EKPbn95pjqt5LXWfcdgWNDKemfix1ypownDEKIBSlMBBOUoVGkLD1pZH/LaywUwPh
         4zgS8mfdfUVVW7p8RHPr1eYLnGSRNrMJLv8anXSoWR3pvLmLqz2ngCOlSbwtpG75U6
         3aaBBwms00ftrKqb+hPnIKwmHLLZNZX94s8Ix9TI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 5.5 07/30] vt: switch vt_dont_switch to bool
Date:   Wed,  1 Apr 2020 18:17:11 +0200
Message-Id: <20200401161420.268112172@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161414.345528747@linuxfoundation.org>
References: <20200401161414.345528747@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Slaby <jslaby@suse.cz>

commit f400991bf872debffb01c46da882dc97d7e3248e upstream.

vt_dont_switch is pure boolean, no need for whole char.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Link: https://lore.kernel.org/r/20200219073951.16151-6-jslaby@suse.cz
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/vt/vt_ioctl.c |    6 +++---
 include/linux/vt_kern.h   |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/tty/vt/vt_ioctl.c
+++ b/drivers/tty/vt/vt_ioctl.c
@@ -39,7 +39,7 @@
 #include <linux/kbd_diacr.h>
 #include <linux/selection.h>
 
-char vt_dont_switch;
+bool vt_dont_switch;
 
 static inline bool vt_in_use(unsigned int i)
 {
@@ -1026,12 +1026,12 @@ int vt_ioctl(struct tty_struct *tty,
 	case VT_LOCKSWITCH:
 		if (!capable(CAP_SYS_TTY_CONFIG))
 			return -EPERM;
-		vt_dont_switch = 1;
+		vt_dont_switch = true;
 		break;
 	case VT_UNLOCKSWITCH:
 		if (!capable(CAP_SYS_TTY_CONFIG))
 			return -EPERM;
-		vt_dont_switch = 0;
+		vt_dont_switch = false;
 		break;
 	case VT_GETHIFONTMASK:
 		ret = put_user(vc->vc_hi_font_mask,
--- a/include/linux/vt_kern.h
+++ b/include/linux/vt_kern.h
@@ -135,7 +135,7 @@ extern int do_unbind_con_driver(const st
 			     int deflt);
 int vty_init(const struct file_operations *console_fops);
 
-extern char vt_dont_switch;
+extern bool vt_dont_switch;
 extern int default_utf8;
 extern int global_cursor_default;
 


