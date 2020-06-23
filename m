Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49FA1C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 08:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D7C920716
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 08:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731756AbgFWIJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 04:09:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:35882 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731519AbgFWIJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 04:09:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0F1EAADAA;
        Tue, 23 Jun 2020 08:09:20 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     corbet@lwn.net
Cc:     linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
        Joe Perches <joe@perches.com>
Subject: [PATCH v2] MAINTAINERS: use my kernel.org address
Date:   Tue, 23 Jun 2020 10:09:19 +0200
Message-Id: <20200623080919.19976-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <b7636799383bfb85c59d27e140a3c0e56d4af87d.camel@perches.com>
References: <b7636799383bfb85c59d27e140a3c0e56d4af87d.camel@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There were enough problems with suse.{com,cz} MTAs recently. I am bored
by restoring lost e-mails from public archives. Let's switch (all) my
MAINTAINERS addresses to @kernel.org and forward the e-mails there as I
wish.

And add the whole history to .mailmap.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Joe Perches <joe@perches.com>

---

[v2] add .mailmap entries

 .mailmap    | 5 +++++
 MAINTAINERS | 8 ++++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/.mailmap b/.mailmap
index 86eb59ad4c54..4670b50da0a2 100644
--- a/.mailmap
+++ b/.mailmap
@@ -131,6 +131,11 @@ Jeff Layton <jlayton@kernel.org> <jlayton@poochiereds.net>
 Jeff Layton <jlayton@kernel.org> <jlayton@primarydata.com>
 Jens Axboe <axboe@suse.de>
 Jens Osterkamp <Jens.Osterkamp@de.ibm.com>
+Jiri Slaby <jirislaby@kernel.org> <jirislaby@gmail.com>
+Jiri Slaby <jirislaby@kernel.org> <jslaby@novell.com>
+Jiri Slaby <jirislaby@kernel.org> <jslaby@suse.com>
+Jiri Slaby <jirislaby@kernel.org> <jslaby@suse.cz>
+Jiri Slaby <jirislaby@kernel.org> <xslaby@fi.muni.cz>
 Johan Hovold <johan@kernel.org> <jhovold@gmail.com>
 Johan Hovold <johan@kernel.org> <johan@hovoldconsulting.com>
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
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

