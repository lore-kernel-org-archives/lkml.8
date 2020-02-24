Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BFC4C3567B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 07:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E9B12080D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 07:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582528555;
	bh=O5gx7RXQR9bY77xQn2cdv1ZCNWAV+F97wB/3j6ceEDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=j7xfNza5tsFk53XPiyxEgo8OTo8lXMe+SGWck5TJlWmSg8ttAPRO9G4JweCzIyIaG
	 zWBkC4Ln8VHRjw0J+J/RDciRngo8dM0vYgN0rwq1CRMoPnBPeQheDYoq4/XDCT8VCP
	 ij5gV2bm+PsQ/giSKHAtDo7d+OvLYY+/vBRURH8U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbgBXHPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 02:15:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:33226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725792AbgBXHPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 02:15:53 -0500
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DB8620714;
        Mon, 24 Feb 2020 07:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582528552;
        bh=O5gx7RXQR9bY77xQn2cdv1ZCNWAV+F97wB/3j6ceEDc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F5icqZq8NWiQPJCM2anA+SM7RyQ500TqlEkxw6ErzWdFhog1nm4Ga9ywtcx7ffzNB
         6lZwDGWQWYoSeJdwzLT7VMDPQkQLLEY4oYEBLL/+d0jYwHRD7L3e/Pa5wIH816Qk6G
         q/SuzJPyI9vNSaRyO5p/V3PBr3dBoSiyfzSMmtYk=
From:   Eric Biggers <ebiggers@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Eric Dumazet <edumazet@google.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Subject: [PATCH] vt: vt_ioctl: fix VT_DISALLOCATE freeing in-use virtual console
Date:   Sun, 23 Feb 2020 23:12:47 -0800
Message-Id: <20200224071247.283098-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <0000000000006663de0598d25ab1@google.com>
References: <0000000000006663de0598d25ab1@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

The VT_DISALLOCATE ioctl can free a virtual console while tty_release()
is still running, causing a use-after-free in con_shutdown().  This
occurs because VT_DISALLOCATE only considers a virtual console to be
in-use if it has a tty_struct with count > 0.  But actually when
count == 0, the tty is still in the process of being closed.

Fix this by treating a virtual console as in-use if it has a tty_struct
at all, even with zero count; and by making VT_DISALLOCATE take the
tty_mutex in order to provide synchronization with release_tty().

Reproducer:
	#include <fcntl.h>
	#include <linux/vt.h>
	#include <sys/ioctl.h>
	#include <unistd.h>

	int main()
	{
		if (fork()) {
			for (;;)
				close(open("/dev/tty5", O_RDWR));
		} else {
			int fd = open("/dev/tty10", O_RDWR);

			for (;;)
				ioctl(fd, VT_DISALLOCATE, 5);
		}
	}

KASAN report:
	BUG: KASAN: use-after-free in con_shutdown+0x76/0x80 drivers/tty/vt/vt.c:3278
	Write of size 8 at addr ffff88806a4ec108 by task syz_vt/129

	CPU: 0 PID: 129 Comm: syz_vt Not tainted 5.6.0-rc2 #11
	Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20191223_100556-anatol 04/01/2014
	Call Trace:
	 [...]
	 con_shutdown+0x76/0x80 drivers/tty/vt/vt.c:3278
	 release_tty+0xa8/0x410 drivers/tty/tty_io.c:1514
	 tty_release_struct+0x34/0x50 drivers/tty/tty_io.c:1629
	 tty_release+0x984/0xed0 drivers/tty/tty_io.c:1789
	 [...]

	Allocated by task 129:
	 [...]
	 kzalloc include/linux/slab.h:669 [inline]
	 vc_allocate drivers/tty/vt/vt.c:1085 [inline]
	 vc_allocate+0x1ac/0x680 drivers/tty/vt/vt.c:1066
	 con_install+0x4d/0x3f0 drivers/tty/vt/vt.c:3229
	 tty_driver_install_tty drivers/tty/tty_io.c:1228 [inline]
	 tty_init_dev+0x94/0x350 drivers/tty/tty_io.c:1341
	 tty_open_by_driver drivers/tty/tty_io.c:1987 [inline]
	 tty_open+0x3ca/0xb30 drivers/tty/tty_io.c:2035
	 [...]

	Freed by task 130:
	 [...]
	 kfree+0xbf/0x1e0 mm/slab.c:3757
	 vt_disallocate drivers/tty/vt/vt_ioctl.c:300 [inline]
	 vt_ioctl+0x16dc/0x1e30 drivers/tty/vt/vt_ioctl.c:818
	 tty_ioctl+0x9db/0x11b0 drivers/tty/tty_io.c:2660
	 [...]

Fixes: 4001d7b7fc27 ("vt: push down the tty lock so we can see what is left to tackle")
Cc: <stable@vger.kernel.org> # v3.4+
Reported-by: syzbot+522643ab5729b0421998@syzkaller.appspotmail.com
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 drivers/tty/vt/vt_ioctl.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
index ee6c91ef1f6cf..57d681706fa85 100644
--- a/drivers/tty/vt/vt_ioctl.c
+++ b/drivers/tty/vt/vt_ioctl.c
@@ -42,7 +42,7 @@
 char vt_dont_switch;
 extern struct tty_driver *console_driver;
 
-#define VT_IS_IN_USE(i)	(console_driver->ttys[i] && console_driver->ttys[i]->count)
+#define VT_IS_IN_USE(i)	(console_driver->ttys[i] != NULL)
 #define VT_BUSY(i)	(VT_IS_IN_USE(i) || i == fg_console || vc_cons[i].d == sel_cons)
 
 /*
@@ -288,12 +288,14 @@ static int vt_disallocate(unsigned int vc_num)
 	struct vc_data *vc = NULL;
 	int ret = 0;
 
+	mutex_lock(&tty_mutex); /* synchronize with release_tty() */
 	console_lock();
 	if (VT_BUSY(vc_num))
 		ret = -EBUSY;
 	else if (vc_num)
 		vc = vc_deallocate(vc_num);
 	console_unlock();
+	mutex_unlock(&tty_mutex);
 
 	if (vc && vc_num >= MIN_NR_CONSOLES) {
 		tty_port_destroy(&vc->port);
@@ -309,6 +311,7 @@ static void vt_disallocate_all(void)
 	struct vc_data *vc[MAX_NR_CONSOLES];
 	int i;
 
+	mutex_lock(&tty_mutex); /* synchronize with release_tty() */
 	console_lock();
 	for (i = 1; i < MAX_NR_CONSOLES; i++)
 		if (!VT_BUSY(i))
@@ -316,6 +319,7 @@ static void vt_disallocate_all(void)
 		else
 			vc[i] = NULL;
 	console_unlock();
+	mutex_unlock(&tty_mutex);
 
 	for (i = 1; i < MAX_NR_CONSOLES; i++) {
 		if (vc[i] && i >= MIN_NR_CONSOLES) {
-- 
2.25.1

