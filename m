Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C28C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 17:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C43E724656
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 17:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="lzYFpKZf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbgANRTe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 12:19:34 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39536 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728799AbgANRTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 12:19:31 -0500
Received: by mail-pg1-f196.google.com with SMTP id b137so6689397pga.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 09:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ooYSvPvFrMFlUy8MpYWiSRM0XEN+JZi2w0GpqaV3Fsw=;
        b=lzYFpKZfPOed+rvrWagL3pCzcEzSfNi6MiQDYX7J6vu9LgBK1jgLRckxi2BMLEHg02
         9K+hsq2sPiWg+W6RGTfJO8u5FhKVHfD1IYGlfW5HM4X3w9fO+BE3zqj9ytlACuUDuXKK
         AKxgyW6Jx+tYv6M+834n01A4aqP1koFXtV9hiDDUscPt8B70y8vhh0IceEIAUA71A5bz
         kaSQtKyoKudwfK68TmOcRwMOvZ8dDITwzP11hq3f5mJ03ZTcuAQkOv8HimnApFdjwvCF
         iJ/RLetN7yxDBNJoFnQmgnxCAew165XBkpCKUpbIrK1ykLDfYhJS3JD20FNPznt3yEbA
         dtCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ooYSvPvFrMFlUy8MpYWiSRM0XEN+JZi2w0GpqaV3Fsw=;
        b=IxK0wYM9QoI1/mAjuEvN6nBuB/7Z3NsjVdvfzQOspMeK/rXcqeAB7P8ohXLYfw7Ajq
         jF7TJFHbVgxSBeqMt0/xaORAZ05z6jsRft/iM5QyvRi55sDvIN7PywL5ZsGl9xKxKB6+
         uVAkMnOfK3JpmHSaxRgnsOqXHqYaW8qKRQbA7JD+OGt5aGfAJ2fBJkdvmpr54iJMlK72
         jELC8Om0oBy+kS5pAnROSDrKsCwvXyfzmNhgnvwEe41H+2isYfJL4QGKkZ+ZN7NxtvFt
         D3S78OyHKnfnwF7d8QwPm20tLqsHYsWJp+ky58gG40GoBFH0kU70txdngEuMx2tS0Scf
         4fZg==
X-Gm-Message-State: APjAAAXMvPnR7Tc6HOpEJT1Hb880JdjyqYmIRHkO+cNlafIF/zZ2La2A
        quf073OEFp4MBsSbJtnkK3o5mMs8brA=
X-Google-Smtp-Source: APXvYqxLhXuuT3HRwLrN+gWHhY9azsVh+bCzmmDibV/+e9DQhL+W1pveW90y/ilr6NvZsdu58vSPRQ==
X-Received: by 2002:a63:510e:: with SMTP id f14mr28258497pgb.35.1579022370001;
        Tue, 14 Jan 2020 09:19:30 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id m128sm18965687pfm.183.2020.01.14.09.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 09:19:29 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Jiri Slaby <jslaby@suse.com>, Joe Perches <joe@perches.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org
Subject: [PATCHv2-next 2/3] serial/sysrq: Add MAGIC_SYSRQ_SERIAL_SEQUENCE
Date:   Tue, 14 Jan 2020 17:19:11 +0000
Message-Id: <20200114171912.261787-3-dima@arista.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114171912.261787-1-dima@arista.com>
References: <20200114171912.261787-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many embedded boards have a disconnected TTL level serial which can
generate some garbage that can lead to spurious false sysrq detects.

Currently, sysrq can be either completely disabled for serial console
or always disabled (with CONFIG_MAGIC_SYSRQ_SERIAL), since
commit 732dbf3a6104 ("serial: do not accept sysrq characters via serial port")

At Arista, we have such boards that can generate BREAK and random
garbage. While disabling sysrq for serial console would solve
the problem with spurious false sysrq triggers, it's also desirable
to have a way to enable sysrq back.

As a measure of balance between on and off options, add
MAGIC_SYSRQ_SERIAL_SEQUENCE which is a string sequence that can enable
sysrq if it follows BREAK on a serial line. The longer the string - the
less likely it may be in the garbage.

Having the way to enable sysrq was beneficial to debug lockups with
a manual investigation in field and on the other side preventing false
sysrq detections.

Based-on-patch-by: Vasiliy Khoruzhick <vasilykh@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/tty/serial/serial_core.c | 75 +++++++++++++++++++++++++++++---
 include/linux/serial_core.h      |  1 +
 lib/Kconfig.debug                |  8 ++++
 3 files changed, 77 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 76e506ee335c..3152df025569 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -20,6 +20,7 @@
 #include <linux/device.h>
 #include <linux/serial.h> /* for serial_state and serial_icounter_struct */
 #include <linux/serial_core.h>
+#include <linux/sysrq.h>
 #include <linux/delay.h>
 #include <linux/mutex.h>
 #include <linux/security.h>
@@ -40,6 +41,8 @@ static struct lock_class_key port_lock_key;
 
 #define HIGH_BITS_OFFSET	((sizeof(long)-sizeof(int))*8)
 
+#define SYSRQ_TIMEOUT	(HZ * 5)
+
 static void uart_change_speed(struct tty_struct *tty, struct uart_state *state,
 					struct ktermios *old_termios);
 static void uart_wait_until_sent(struct tty_struct *tty, int timeout);
@@ -3082,6 +3085,56 @@ void uart_insert_char(struct uart_port *port, unsigned int status,
 }
 EXPORT_SYMBOL_GPL(uart_insert_char);
 
+#ifdef CONFIG_MAGIC_SYSRQ_SERIAL
+static const char sysrq_toggle_seq[] = CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE;
+
+static void uart_sysrq_on(struct work_struct *w)
+{
+	sysrq_toggle_support(1);
+	pr_info("SysRq is enabled by magic sequence on serial\n");
+}
+static DECLARE_WORK(sysrq_enable_work, uart_sysrq_on);
+
+/**
+ *	uart_try_toggle_sysrq - Enables SysRq from serial line
+ *	@port: uart_port structure where char(s) after BREAK met
+ *	@ch: new character in the sequence after received BREAK
+ *
+ *	Enables magic SysRq when the required sequence is met on port
+ *	(see CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE).
+ *
+ *	Returns 0 if @ch is out of enabling sequence and should be
+ *	handled some other way, 1 if @ch was consumed.
+ */
+static bool uart_try_toggle_sysrq(struct uart_port *port, unsigned int ch)
+{
+	if (ARRAY_SIZE(sysrq_toggle_seq) <= 1)
+		return 0;
+
+	BUILD_BUG_ON(ARRAY_SIZE(sysrq_toggle_seq) >= sizeof(port->sysrq_seq)*U8_MAX);
+	if (sysrq_toggle_seq[port->sysrq_seq] != ch) {
+		port->sysrq_seq = 0;
+		return 0;
+	}
+
+	/* Without the last \0 */
+	if (++port->sysrq_seq < (ARRAY_SIZE(sysrq_toggle_seq) - 1)) {
+		port->sysrq = jiffies + SYSRQ_TIMEOUT;
+		return 1;
+	}
+
+	schedule_work(&sysrq_enable_work);
+
+	port->sysrq = 0;
+	return 1;
+}
+#else
+static inline bool uart_try_toggle_sysrq(struct uart_port *port, unsigned int ch)
+{
+	return 0;
+}
+#endif
+
 int uart_handle_sysrq_char(struct uart_port *port, unsigned int ch)
 {
 	if (!IS_ENABLED(CONFIG_MAGIC_SYSRQ_SERIAL))
@@ -3091,9 +3144,13 @@ int uart_handle_sysrq_char(struct uart_port *port, unsigned int ch)
 		return 0;
 
 	if (ch && time_before(jiffies, port->sysrq)) {
-		handle_sysrq(ch);
-		port->sysrq = 0;
-		return 1;
+		if (sysrq_get_mask()) {
+			handle_sysrq(ch);
+			port->sysrq = 0;
+			return 1;
+		}
+		if (uart_try_toggle_sysrq(port, ch))
+			return 1;
 	}
 	port->sysrq = 0;
 
@@ -3110,9 +3167,13 @@ int uart_prepare_sysrq_char(struct uart_port *port, unsigned int ch)
 		return 0;
 
 	if (ch && time_before(jiffies, port->sysrq)) {
-		port->sysrq_ch = ch;
-		port->sysrq = 0;
-		return 1;
+		if (sysrq_get_mask()) {
+			port->sysrq_ch = ch;
+			port->sysrq = 0;
+			return 1;
+		}
+		if (uart_try_toggle_sysrq(port, ch))
+			return 1;
 	}
 	port->sysrq = 0;
 
@@ -3152,7 +3213,7 @@ int uart_handle_break(struct uart_port *port)
 	if (port->has_sysrq) {
 		if (port->cons && port->cons->index == port->line) {
 			if (!port->sysrq) {
-				port->sysrq = jiffies + HZ*5;
+				port->sysrq = jiffies + SYSRQ_TIMEOUT;
 				return 1;
 			}
 			port->sysrq = 0;
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 255e86a474e9..9e0b66278430 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -243,6 +243,7 @@ struct uart_port {
 	unsigned long		sysrq;			/* sysrq timeout */
 	unsigned int		sysrq_ch;		/* char for sysrq */
 	unsigned char		has_sysrq;
+	unsigned char		sysrq_seq;		/* index in sysrq_toggle_seq */
 
 	unsigned char		hub6;			/* this should be in the 8250 driver */
 	unsigned char		suspended;
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index e4676b992eae..f21adfed2855 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -431,6 +431,14 @@ config MAGIC_SYSRQ_SERIAL
 	  This option allows you to decide whether you want to enable the
 	  magic SysRq key.
 
+config MAGIC_SYSRQ_SERIAL_SEQUENCE
+	string "Char sequence that enables magic SysRq over serial"
+	depends on MAGIC_SYSRQ_SERIAL
+	default ""
+	help
+	  Specifies a sequence of characters that can follow BREAK to enable
+	  SysRq on a serial console.
+
 config DEBUG_FS
 	bool "Debug Filesystem"
 	help
-- 
2.24.1

