Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D93FC35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4048A2192A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580747908;
	bh=r1lGX2Mng4ClaeSrt7x81WB+42Hz2OebGAffvnIC3Oc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=T7Dzc7MkMXB5Ek4pzwS0tqnczJKQAOdzGQsgp8psJM7lMkAVwroxYNRTqrRh13i1i
	 EqHp2GtJ+n2nW2YRA9omH3PMS3TJZP/zyIi+vuBNyxShxWvK0+EKYTTArT0fk++jjK
	 uw+WVli94jgGmM8WfKZDeXcZGCwPrO6q7GbQw4U0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731500AbgBCQi0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:38:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:54358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731482AbgBCQiY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:38:24 -0500
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D03D721775;
        Mon,  3 Feb 2020 16:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580747903;
        bh=r1lGX2Mng4ClaeSrt7x81WB+42Hz2OebGAffvnIC3Oc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I3Kzp8z6tT2kllZaPkLpkhklLYl+hIgC1lcEOLblMQMvOEP7qZYQ7gSxGWjYW5sjE
         0MibCMFcnII7kjvfqec9zptuyfJwOJCvu37ne7JVw7ilnrzFR9QO7LPJcfEbd7C8Rs
         9ukNYQLqASNIupek/LbHBqd3gif176PFs4Gc0ZKY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+2eeef62ee31f9460ad65@syzkaller.appspotmail.com,
        Zhenzhong Duan <zhenzhong.duan@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 5.5 21/23] ttyprintk: fix a potential deadlock in interrupt context issue
Date:   Mon,  3 Feb 2020 16:20:41 +0000
Message-Id: <20200203161906.653049928@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200203161902.288335885@linuxfoundation.org>
References: <20200203161902.288335885@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhenzhong Duan <zhenzhong.duan@gmail.com>

commit 9a655c77ff8fc65699a3f98e237db563b37c439b upstream.

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
Link: https://lore.kernel.org/r/20200113034842.435-1-zhenzhong.duan@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/ttyprintk.c |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

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
@@ -99,11 +100,12 @@ static int tpk_open(struct tty_struct *t
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
@@ -115,13 +117,14 @@ static int tpk_write(struct tty_struct *
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


