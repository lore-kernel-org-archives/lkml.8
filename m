Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4872C10F25
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 07:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9744208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 07:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hT7lzc6Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbgCKHRt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 03:17:49 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34263 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbgCKHRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 03:17:48 -0400
Received: by mail-pf1-f193.google.com with SMTP id 23so802633pfj.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 00:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iuLWRCnwI5Es2pCunfLJ3i9sOSoy9rpEkn76xPgxdQ4=;
        b=hT7lzc6Y9cKwW7N7zRSNsJiWlZG0353YL2YPUR+5FAGHtssrHwnxzl+CfV/apIEIDZ
         htMgSisOR8b3TOedLN+eFMI4XhVNGGP+bRlax286kXVku5RKeqm1jVucushcuRsdJieW
         kvEs76B7goWazwFA83c+9Ft87I1o7CKLlSuXYqnDBWICktnnabW7CUSxvje3yu6XFLrn
         DNQsx9T7jNeSn6dO8VwYbFEusMjemqcgO+OSGfsBJ30xu0uSoLp3aEvYUTCPlsWMgimp
         umImgLMLTMQlmqtUJ5LsavIlgtXs3Yz/HubPtg00qFvrGPqBXBAIlMjO3o+OGMrrsoY0
         sOmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iuLWRCnwI5Es2pCunfLJ3i9sOSoy9rpEkn76xPgxdQ4=;
        b=Ms6G5dNCsGMh7khGHJeI/e3jXdcUVcEz5PvZ30ozYaUyLL28a5w7+9s8XzpQMpdDvQ
         BwUuw/AyB6mA28FZT70IFbM2E3Q+8g5QH8Q2L9W52so7B7t2soQmTRCkNXmUbXlwJVN4
         VTJ/NyeCwQFT7oPzdWJlwlSH1RDBipp7TKFrJvpP65e16jhX9gVFSSlI170uC7Fy13Kb
         saHz7dkUsss8wd8Trwp/n3rmawRTHGf26O/s6giXq+iCYixo/3zSzlmlU4RTZf8xuna8
         rfF46E/BHJdoxTxjOd8MAJFJf2SC0wE3r9/i4u3f0xUTd+LWtD9zHUh5XbvtuLiXvq8N
         bxDg==
X-Gm-Message-State: ANhLgQ3seed92VEpSw8UY5eudPC7v/iWmWFo9rsSlzqe97ZcBpx2ekiQ
        +resT9xe+Xj2UIwGzDishK6tmjdL
X-Google-Smtp-Source: ADFU+vsjnRwbJ6wMVkQS7UKn5TUozRtQ05t7wb+WmIp7RSDYwsBqaaFgIGaFrDAVZT/ACGLuYMpJWQ==
X-Received: by 2002:a62:e812:: with SMTP id c18mr1478463pfi.47.1583911067199;
        Wed, 11 Mar 2020 00:17:47 -0700 (PDT)
Received: from ZB-PF114XEA.360buyad.local ([103.90.76.242])
        by smtp.gmail.com with ESMTPSA id g18sm4352904pfh.174.2020.03.11.00.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 00:17:46 -0700 (PDT)
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
Subject: [PATCH v2 2/2] misc: move FLASH_MINOR into miscdevice.h and fix conflicts
Date:   Wed, 11 Mar 2020 15:16:54 +0800
Message-Id: <20200311071654.335-3-zhenzhong.duan@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200311071654.335-1-zhenzhong.duan@gmail.com>
References: <20200311071654.335-1-zhenzhong.duan@gmail.com>
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
Acked-by: Arnd Bergmann <arnd@arndb.de>
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
index 42360fc..66cc45e 100644
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

