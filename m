Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59674C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 02:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33FC420665
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 02:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uO1xIZZa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgCICSV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 22:18:21 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42943 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbgCICSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 22:18:20 -0400
Received: by mail-pg1-f195.google.com with SMTP id h8so3993114pgs.9
        for <linux-kernel@vger.kernel.org>; Sun, 08 Mar 2020 19:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=T3Z1bNGuCV9o6RzKcLSsD5DNO7+IpTMMs5GirpLlnjk=;
        b=uO1xIZZauRAYv1JxGtTXYaSTX6oNFJjGo8DcHZTPkmZTW7wTIdIWdGoH3aS3E2uRuF
         3PiyR9oC/bFWls43VzbMnSAmEm/uhxr85VXYetX2UUsDn/7yzx1be4beaLhVc/GShO2T
         y3xOZb+UtZaraR/1mRZPT09sr5/TlSQtoOTJ0HWKaiozNt2AVGYffSsrxbonSPBetzv/
         Sfetjk5/nznJW6t4OrDqmsA7PqqRQMrNjA+Dl/yIQU00RANE7hflQuZknu6z9go30nkB
         BVYWRkXQgz7e4se0i8+IKutRo9pQsi9A/6T6B3nNh9Om+AtqvbV9ifsqWcut7PltX5Om
         hwhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=T3Z1bNGuCV9o6RzKcLSsD5DNO7+IpTMMs5GirpLlnjk=;
        b=TUTSgT7a8h4XcoDBNn/Eg3Ll8eKGeWo7rUCDnqFR/zjv4gmYeVX+IPfsjoU5wUtW0k
         WL/w16BiCBOpHiIqxR4Iz9nup5V4nHiy103X00Bie+5zfZtFIJI8xYu5iXVRph2M4Tk9
         BX1dd5ZxPVM9WDw+udA1/bcgpGQnNy2pmNiPcwnLxg1baBL/fBoRyjg6gLtHgy9IbTsE
         x6Q/UCKdphJIev/oN33o8u8VciVgy4+Vt7cJBUq7JPFLbVy4tOdGKlgnYTBI2DYOljen
         leFLv4tkNe50yiod8gZBO/q8P9fht4S5J2dwsolrhGzm3kQiflBKhTS6u5E5qZjA91sC
         niBw==
X-Gm-Message-State: ANhLgQ1T72KCI9HxqBHfQ+w+8eioBEWwArtNmEwxdwB9z//ERB6Z8w5b
        3VP7UFy9+5c/0BqXc6nli6ucWo/B
X-Google-Smtp-Source: ADFU+vtifvg5GlZo+bWqB5Quoge+thCTsQZgb4S64ykHNWszqXIwGMw2u6nIrk0vKMnY5peEZgchQA==
X-Received: by 2002:a63:180c:: with SMTP id y12mr14784316pgl.120.1583720299290;
        Sun, 08 Mar 2020 19:18:19 -0700 (PDT)
Received: from ZB-PF114XEA.360buyad.local ([103.90.76.242])
        by smtp.gmail.com with ESMTPSA id r12sm42394043pgu.93.2020.03.08.19.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2020 19:18:18 -0700 (PDT)
From:   Zhenzhong Duan <zhenzhong.duan@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        miguel.ojeda.sandonis@gmail.com, willy@haproxy.com,
        ksenija.stanojevic@gmail.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, mpm@selenic.com,
        herbert@gondor.apana.org.au, jonathan@buzzard.org.uk,
        benh@kernel.crashing.org, davem@davemloft.net,
        b.zolnierkie@samsung.com, rjw@rjwysocki.net, pavel@ucw.cz,
        len.brown@intel.com, Zhenzhong Duan <zhenzhong.duan@gmail.com>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH RFC 2/3] misc: move FLASH_MINOR into miscdevice.h and fix conflicts
Date:   Mon,  9 Mar 2020 10:17:46 +0800
Message-Id: <20200309021747.626-3-zhenzhong.duan@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200309021747.626-1-zhenzhong.duan@gmail.com>
References: <20200309021747.626-1-zhenzhong.duan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FLASH_MINOR is used in both drivers/char/nwflash.c and
drivers/sbus/char/flash.c with conflict minor numbers.

Move all the definitions of FLASH_MINOR into miscdevice.h.
Rename FLASH_MINOR for drivers/char/nwflash.c to NWFLASH_MINOR
and FLASH_MINOR for drivers/sbus/char/flash.c to SBUS_FLASH_MINOR.

Link: https://lore.kernel.org/lkml/20200120221323.GJ15860@mit.edu/t/
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: "David S. Miller" <davem@davemloft.net>
---
 arch/arm/include/asm/nwflash.h | 1 -
 drivers/char/nwflash.c         | 2 +-
 drivers/sbus/char/flash.c      | 4 +---
 include/linux/miscdevice.h     | 2 ++
 4 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/nwflash.h b/arch/arm/include/asm/nwflash.h
index 0ec6f07..66b7e68 100644
--- a/arch/arm/include/asm/nwflash.h
+++ b/arch/arm/include/asm/nwflash.h
@@ -2,7 +2,6 @@
 #ifndef _FLASH_H
 #define _FLASH_H
 
-#define FLASH_MINOR		 160	/* MAJOR is 10 - miscdevice */
 #define CMD_WRITE_DISABLE	 0
 #define CMD_WRITE_ENABLE	 0x28
 #define CMD_WRITE_BASE64K_ENABLE 0x47
diff --git a/drivers/char/nwflash.c b/drivers/char/nwflash.c
index a4a0797d..0973c2c 100644
--- a/drivers/char/nwflash.c
+++ b/drivers/char/nwflash.c
@@ -576,7 +576,7 @@ static void kick_open(void)
 
 static struct miscdevice flash_miscdev =
 {
-	FLASH_MINOR,
+	NWFLASH_MINOR,
 	"nwflash",
 	&flash_fops
 };
diff --git a/drivers/sbus/char/flash.c b/drivers/sbus/char/flash.c
index e85a05a..4147d22 100644
--- a/drivers/sbus/char/flash.c
+++ b/drivers/sbus/char/flash.c
@@ -31,8 +31,6 @@
 	unsigned long busy;		/* In use? */
 } flash;
 
-#define FLASH_MINOR	152
-
 static int
 flash_mmap(struct file *file, struct vm_area_struct *vma)
 {
@@ -157,7 +155,7 @@
 	.release =	flash_release,
 };
 
-static struct miscdevice flash_dev = { FLASH_MINOR, "flash", &flash_fops };
+static struct miscdevice flash_dev = { SBUS_FLASH_MINOR, "flash", &flash_fops };
 
 static int flash_probe(struct platform_device *op)
 {
diff --git a/include/linux/miscdevice.h b/include/linux/miscdevice.h
index 35294c6..41dc10b 100644
--- a/include/linux/miscdevice.h
+++ b/include/linux/miscdevice.h
@@ -30,12 +30,14 @@
 #define SUN_OPENPROM_MINOR	139
 #define DMAPI_MINOR		140	/* unused */
 #define NVRAM_MINOR		144
+#define SBUS_FLASH_MINOR	152
 #define SGI_MMTIMER		153
 #define PMU_MINOR		154
 #define STORE_QUEUE_MINOR	155	/* unused */
 #define LCD_MINOR		156
 #define AC_MINOR		157
 #define BUTTON_MINOR		158	/* Major 10, Minor 158, /dev/nwbutton */
+#define NWFLASH_MINOR		160	/* MAJOR is 10 - miscdevice */
 #define ENVCTRL_MINOR		162
 #define I2O_MINOR		166
 #define UCTRL_MINOR		174
-- 
1.8.3.1

