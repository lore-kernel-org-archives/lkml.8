Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D41C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 06:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 809FA20771
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 06:11:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730512AbgFWGLk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 02:11:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:41762 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728800AbgFWGLj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 02:11:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 51F58AB3D;
        Tue, 23 Jun 2020 06:11:38 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     corbet@lwn.net
Cc:     linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH] MAINTAINERS: use my kernel.org address
Date:   Tue, 23 Jun 2020 08:11:38 +0200
Message-Id: <20200623061138.14694-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There were enough problems with suse.{com,cz} MTAs recently. I am bored
by restoring lost e-mails from public archives. Let's switch (all) my
MAINTAINERS addresses to @kernel.org and forward it there as I wish.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 MAINTAINERS | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d282ee3492e0..abc7b8fab240 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2881,7 +2881,7 @@ S:	Supported
 F:	drivers/net/wireless/ath/*
 
 ATHEROS ATH5K WIRELESS DRIVER
-M:	Jiri Slaby <jirislaby@gmail.com>
+M:	Jiri Slaby <jirislaby@kernel.org>
 M:	Nick Kossifidis <mickflemm@gmail.com>
 M:	Luis Chamberlain <mcgrof@kernel.org>
 L:	linux-wireless@vger.kernel.org
@@ -11554,7 +11554,7 @@ F:	drivers/media/pci/meye/
 F:	include/uapi/linux/meye.h
 
 MOXA SMARTIO/INDUSTIO/INTELLIO SERIAL CARD
-M:	Jiri Slaby <jirislaby@gmail.com>
+M:	Jiri Slaby <jirislaby@kernel.org>
 S:	Maintained
 F:	Documentation/driver-api/serial/moxa-smartio.rst
 F:	drivers/tty/mxser.*
@@ -15364,7 +15364,7 @@ F:	scripts/selinux/
 F:	security/selinux/
 
 SENSABLE PHANTOM
-M:	Jiri Slaby <jirislaby@gmail.com>
+M:	Jiri Slaby <jirislaby@kernel.org>
 S:	Maintained
 F:	drivers/misc/phantom.c
 F:	include/uapi/linux/phantom.h
@@ -17381,7 +17381,7 @@ K:	^Subject:.*(?i)trivial
 
 TTY LAYER
 M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
-M:	Jiri Slaby <jslaby@suse.com>
+M:	Jiri Slaby <jirislaby@kernel.org>
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
 F:	Documentation/driver-api/serial/
-- 
2.27.0

