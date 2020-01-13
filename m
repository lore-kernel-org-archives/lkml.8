Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48CEFC33CA8
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 03:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19C99206D7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 03:49:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q3HB9cHW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387513AbgAMDtX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 22:49:23 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:55835 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387415AbgAMDtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 22:49:23 -0500
Received: by mail-pj1-f68.google.com with SMTP id d5so3555077pjz.5
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jan 2020 19:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=D+7MeuHXy0NhWSarj5D/qI26f2ir0S/6H8J91FVIu5A=;
        b=q3HB9cHWPqzVkA+G0PHimyXQhKp3KG2dJ+rkJPjF7w0BIEaU1JN8cbo0W9+1ntvKxq
         sZzkWrl+wMW5oofKWApNrOETpd0UJLsUD46RLJjb9lxjSEGwnX/8Fxe4MUOjQuGuV8hl
         zIMrk+GwN5gNOY6lg0tpU9UT57MJ2BxkB8Q7nDOrdXWc1N2AytQopflpB6zbOBQs065a
         AyTnXgp7Zzk7EXToE/8phaDY5DxUSd184msGOaB3EZMgEnIf/hDoSjw+ggFsSox664mV
         8Fe+mII9E1HLUdGpu/7aWPCNqXq4NhTuXhMg+8OrZTtByJEhKySyOQWO1Q4eNASHZSv0
         CEtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=D+7MeuHXy0NhWSarj5D/qI26f2ir0S/6H8J91FVIu5A=;
        b=cFglWCmD6lsoJYGvCPZBfAmRdpz40HMJXpr1J0yM6ybD1hBfKURqPtkFaufkDjjt14
         Vsuq0ZB9Prad0/TWsznvUuUYBW81C6pJXvLl7PPUCCdM4RSPf+sdTXE8FYRpz1puAt+c
         vdJ6wVNjw2a+mOcMP15xrIFQbM9XMybG44icRihsNUxdU5sicvnhga6on0SSi7lZmAu2
         qRlMcciDhOpUNy+uCbogdA8JeoToxr6Er1vdNKPxGfI8QwizM5ApCMeoLiJQd2jV9IkB
         5WIEvG8I3BFsywu8G7Xo1pwZbJ+1lGf3+4w/sYUVPNIZgrnqu3i315GgdIO8VnAy3N2J
         6uCQ==
X-Gm-Message-State: APjAAAXqRORoQxGZ5WPpzG5sk74sIaWXqSerhCst3oSBsA38TCUntAP7
        6xm6juXY0MNQex+7ejFptNGEsfmi
X-Google-Smtp-Source: APXvYqxH1PYalPSs7uvXPgRN3Ujq7Br7w0B1HeHg+DwNBRF9NrE4nnSORmkLWb5NYi75fcZIP8tVzw==
X-Received: by 2002:a17:90a:a596:: with SMTP id b22mr20719475pjq.28.1578887361988;
        Sun, 12 Jan 2020 19:49:21 -0800 (PST)
Received: from ZB-PF114XEA.360buyad.local ([103.90.76.242])
        by smtp.gmail.com with ESMTPSA id v4sm11871605pgo.63.2020.01.12.19.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2020 19:49:21 -0800 (PST)
From:   Zhenzhong Duan <zhenzhong.duan@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Zhenzhong Duan <zhenzhong.duan@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v3] ttyprintk: fix a potential deadlock in interrupt context issue
Date:   Mon, 13 Jan 2020 11:48:42 +0800
Message-Id: <20200113034842.435-1-zhenzhong.duan@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tpk_write()/tpk_close() could be interrupted when holding a mutex, then
in timer handler tpk_write() may be called again trying to acquire same
mutex, lead to deadlock.

Google syzbot reported this issue with CONFIG_DEBUG_ATOMIC_SLEEP
enabled:

BUG: sleeping function called from invalid context at
kernel/locking/mutex.c:938
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 0, name: swapper/1
1 lock held by swapper/1/0:
...
Call Trace:
  <IRQ>
  dump_stack+0x197/0x210
  ___might_sleep.cold+0x1fb/0x23e
  __might_sleep+0x95/0x190
  __mutex_lock+0xc5/0x13c0
  mutex_lock_nested+0x16/0x20
  tpk_write+0x5d/0x340
  resync_tnc+0x1b6/0x320
  call_timer_fn+0x1ac/0x780
  run_timer_softirq+0x6c3/0x1790
  __do_softirq+0x262/0x98c
  irq_exit+0x19b/0x1e0
  smp_apic_timer_interrupt+0x1a3/0x610
  apic_timer_interrupt+0xf/0x20
  </IRQ>

See link https://syzkaller.appspot.com/bug?extid=2eeef62ee31f9460ad65 for
more details.

Fix it by using spinlock in process context instead of mutex and having
interrupt disabled in critical section.

Reported-by: syzbot+2eeef62ee31f9460ad65@syzkaller.appspotmail.com
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v3: add Reported-by, add Google link about the issue, update
patch description, per Greg K-H
v2: fix mailformed issue, no functional change.

 drivers/char/ttyprintk.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/char/ttyprintk.c b/drivers/char/ttyprintk.c
index 4f24e46..56db949 100644
--- a/drivers/char/ttyprintk.c
+++ b/drivers/char/ttyprintk.c
@@ -15,10 +15,11 @@
 #include <linux/serial.h>
 #include <linux/tty.h>
 #include <linux/module.h>
+#include <linux/spinlock.h>
 
 struct ttyprintk_port {
 	struct tty_port port;
-	struct mutex port_write_mutex;
+	spinlock_t spinlock;
 };
 
 static struct ttyprintk_port tpk_port;
@@ -99,11 +100,12 @@ static int tpk_open(struct tty_struct *tty, struct file *filp)
 static void tpk_close(struct tty_struct *tty, struct file *filp)
 {
 	struct ttyprintk_port *tpkp = tty->driver_data;
+	unsigned long flags;
 
-	mutex_lock(&tpkp->port_write_mutex);
+	spin_lock_irqsave(&tpkp->spinlock, flags);
 	/* flush tpk_printk buffer */
 	tpk_printk(NULL, 0);
-	mutex_unlock(&tpkp->port_write_mutex);
+	spin_unlock_irqrestore(&tpkp->spinlock, flags);
 
 	tty_port_close(&tpkp->port, tty, filp);
 }
@@ -115,13 +117,14 @@ static int tpk_write(struct tty_struct *tty,
 		const unsigned char *buf, int count)
 {
 	struct ttyprintk_port *tpkp = tty->driver_data;
+	unsigned long flags;
 	int ret;
 
 
 	/* exclusive use of tpk_printk within this tty */
-	mutex_lock(&tpkp->port_write_mutex);
+	spin_lock_irqsave(&tpkp->spinlock, flags);
 	ret = tpk_printk(buf, count);
-	mutex_unlock(&tpkp->port_write_mutex);
+	spin_unlock_irqrestore(&tpkp->spinlock, flags);
 
 	return ret;
 }
@@ -171,7 +174,7 @@ static int __init ttyprintk_init(void)
 {
 	int ret = -ENOMEM;
 
-	mutex_init(&tpk_port.port_write_mutex);
+	spin_lock_init(&tpk_port.spinlock);
 
 	ttyprintk_driver = tty_alloc_driver(1,
 			TTY_DRIVER_RESET_TERMIOS |
-- 
1.8.3.1

