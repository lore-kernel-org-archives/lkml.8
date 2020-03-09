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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72CD0C10DCE
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 02:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3643B20665
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 02:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AreR6Tdz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbgCICSR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 22:18:17 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45641 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbgCICSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 22:18:17 -0400
Received: by mail-pg1-f195.google.com with SMTP id m15so3986511pgv.12
        for <linux-kernel@vger.kernel.org>; Sun, 08 Mar 2020 19:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=n3AZqCObN8yCkAM4r2TeHasBdUhswlQfEhgIVXeg/Rw=;
        b=AreR6TdzW3qVyK/JkNGvr/39zR/S8aTj4OUHv2M3cE7cs+Ow4JasTuCAiwhgnYtYYn
         ssjqx0Tm1+airWauNS5/MCWmaxeUtM8qR4wl0soUT4Q8BH/wkK/3qMl/6n0xOslZ6Ar2
         uAkg0N+d8jd108CThY97gD1my4RmJs5KsCaQHkVkx2l49DBSu2XzRUSvm83fzQYq2qad
         MeGaaCIIG51nHykvJg6vikt0BI5OwjOw1l08Z74atazaOOJbnPs4eVny5hv9A5yXz3rG
         NN0bopOAtU4annpoGw314f/ntQZKWakVD3chbukyJ6JMBEMEyIvVWKVaz1w/wgtMllx+
         fVQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=n3AZqCObN8yCkAM4r2TeHasBdUhswlQfEhgIVXeg/Rw=;
        b=lwYa804y1PpmURRSX1PKqZWcARDUxaiDKSTJhaH4vjxO7nuAWemJd9COtEiKK9oORs
         yukfFsYnPy6P14S1XpVmllwt0NrifK+8+4En+yq+LJioFXFStIJuTI9TPTyGtrA7N48y
         1kzTBCA0Q5arC+kwkV8Vw2v0k/L3JDC4YQFT46xzrqzFT1Xf6Cvupn6kzl1PwC2Do8YK
         W+IW06IEsj/9GljdzX8qYUEGtRX523j1OOzIe2xn5S208DWemXG3V3+cmJ2dMRQkmLvx
         AD1rghEhCD0X0mYTRpJ905iRIz+7exlY5HkN/tocrA3ZmC8ApfFuCmEGvsfgKCXRNzVu
         K8gw==
X-Gm-Message-State: ANhLgQ0YDt78w7LiFiyu35EJqPR2i5IX9eWPCu/JPBKpWve9oPT8dFgg
        sMJeZoP9fbMkgN8Fmt/bZ2jwg4u0
X-Google-Smtp-Source: ADFU+vv+aTtnHmWuNaN6PfLN+EPuqq8mVioEN+0paM6aKnRLeJwT3hVrvipabnjOPOELmXWc6a70hw==
X-Received: by 2002:aa7:9464:: with SMTP id t4mr8540759pfq.260.1583720293704;
        Sun, 08 Mar 2020 19:18:13 -0700 (PDT)
Received: from ZB-PF114XEA.360buyad.local ([103.90.76.242])
        by smtp.gmail.com with ESMTPSA id r12sm42394043pgu.93.2020.03.08.19.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2020 19:18:13 -0700 (PDT)
From:   Zhenzhong Duan <zhenzhong.duan@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        miguel.ojeda.sandonis@gmail.com, willy@haproxy.com,
        ksenija.stanojevic@gmail.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, mpm@selenic.com,
        herbert@gondor.apana.org.au, jonathan@buzzard.org.uk,
        benh@kernel.crashing.org, davem@davemloft.net,
        b.zolnierkie@samsung.com, rjw@rjwysocki.net, pavel@ucw.cz,
        len.brown@intel.com, Zhenzhong Duan <zhenzhong.duan@gmail.com>
Subject: [PATCH RFC 1/3] misc: cleanup minor number definitions in c file into miscdevice.h
Date:   Mon,  9 Mar 2020 10:17:45 +0800
Message-Id: <20200309021747.626-2-zhenzhong.duan@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200309021747.626-1-zhenzhong.duan@gmail.com>
References: <20200309021747.626-1-zhenzhong.duan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HWRNG_MINOR and RNG_MISCDEV_MINOR are duplicate definitions, use
unified RNG_MINOR instead and moved into miscdevice.h

ANSLCD_MINOR and LCD_MINOR are duplicate definitions, use unified
LCD_MINOR instead and moved into miscdevice.h

MISCDEV_MINOR is renamed to PXA3XXX_GCU_MINOR and moved into
miscdevice.h

Other definitions are just moved without any change.

Link: https://lore.kernel.org/lkml/20200120221323.GJ15860@mit.edu/t/
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/um/drivers/random.c         |  4 +---
 drivers/auxdisplay/charlcd.c     |  2 --
 drivers/auxdisplay/panel.c       |  2 --
 drivers/char/applicom.c          |  1 -
 drivers/char/hw_random/core.c    |  2 +-
 drivers/char/nwbutton.h          |  1 -
 drivers/char/toshiba.c           |  2 --
 drivers/macintosh/ans-lcd.c      |  2 +-
 drivers/macintosh/ans-lcd.h      |  2 --
 drivers/macintosh/via-pmu.c      |  3 ---
 drivers/sbus/char/envctrl.c      |  2 --
 drivers/sbus/char/uctrl.c        |  2 --
 drivers/video/fbdev/pxa3xx-gcu.c |  7 +++----
 include/linux/miscdevice.h       | 12 +++++++++++-
 kernel/power/user.c              |  2 --
 15 files changed, 17 insertions(+), 29 deletions(-)

diff --git a/arch/um/drivers/random.c b/arch/um/drivers/random.c
index 1d5d305..687ae80 100644
--- a/arch/um/drivers/random.c
+++ b/arch/um/drivers/random.c
@@ -23,8 +23,6 @@
 #define RNG_VERSION "1.0.0"
 #define RNG_MODULE_NAME "hw_random"
 
-#define RNG_MISCDEV_MINOR		183 /* official */
-
 /* Changed at init time, in the non-modular case, and at module load
  * time, in the module case.  Presumably, the module subsystem
  * protects against a module being loaded twice at the same time.
@@ -104,7 +102,7 @@ static ssize_t rng_dev_read (struct file *filp, char __user *buf, size_t size,
 
 /* rng_init shouldn't be called more than once at boot time */
 static struct miscdevice rng_miscdev = {
-	RNG_MISCDEV_MINOR,
+	RNG_MINOR,
 	RNG_MODULE_NAME,
 	&rng_chrdev_ops,
 };
diff --git a/drivers/auxdisplay/charlcd.c b/drivers/auxdisplay/charlcd.c
index 874c259..e704865 100644
--- a/drivers/auxdisplay/charlcd.c
+++ b/drivers/auxdisplay/charlcd.c
@@ -22,8 +22,6 @@
 
 #include "charlcd.h"
 
-#define LCD_MINOR		156
-
 #define DEFAULT_LCD_BWIDTH      40
 #define DEFAULT_LCD_HWIDTH      64
 
diff --git a/drivers/auxdisplay/panel.c b/drivers/auxdisplay/panel.c
index 85965953..99980aa 100644
--- a/drivers/auxdisplay/panel.c
+++ b/drivers/auxdisplay/panel.c
@@ -57,8 +57,6 @@
 
 #include "charlcd.h"
 
-#define KEYPAD_MINOR		185
-
 #define LCD_MAXBYTES		256	/* max burst write */
 
 #define KEYPAD_BUFFER		64
diff --git a/drivers/char/applicom.c b/drivers/char/applicom.c
index 51121a4..14b2d80 100644
--- a/drivers/char/applicom.c
+++ b/drivers/char/applicom.c
@@ -53,7 +53,6 @@
 #define MAX_BOARD 8		/* maximum of pc board possible */
 #define MAX_ISA_BOARD 4
 #define LEN_RAM_IO 0x800
-#define AC_MINOR 157
 
 #ifndef PCI_VENDOR_ID_APPLICOM
 #define PCI_VENDOR_ID_APPLICOM                0x1389
diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
index d2d7a42..f4c86b5 100644
--- a/drivers/char/hw_random/core.c
+++ b/drivers/char/hw_random/core.c
@@ -289,7 +289,7 @@ static ssize_t rng_dev_read(struct file *filp, char __user *buf,
 static const struct attribute_group *rng_dev_groups[];
 
 static struct miscdevice rng_miscdev = {
-	.minor		= HWRNG_MINOR,
+	.minor		= RNG_MINOR,
 	.name		= RNG_MODULE_NAME,
 	.nodename	= "hwrng",
 	.fops		= &rng_chrdev_ops,
diff --git a/drivers/char/nwbutton.h b/drivers/char/nwbutton.h
index 9dedfd7..f2b9fdc 100644
--- a/drivers/char/nwbutton.h
+++ b/drivers/char/nwbutton.h
@@ -14,7 +14,6 @@
 #define NUM_PRESSES_REBOOT 2	/* How many presses to activate shutdown */
 #define BUTTON_DELAY 30 	/* How many jiffies for sequence to end */
 #define VERSION "0.3"		/* Driver version number */
-#define BUTTON_MINOR 158	/* Major 10, Minor 158, /dev/nwbutton */
 
 /* Structure definitions: */
 
diff --git a/drivers/char/toshiba.c b/drivers/char/toshiba.c
index 98f3150..aff0a8e 100644
--- a/drivers/char/toshiba.c
+++ b/drivers/char/toshiba.c
@@ -61,8 +61,6 @@
 #include <linux/mutex.h>
 #include <linux/toshiba.h>
 
-#define TOSH_MINOR_DEV 181
-
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Jonathan Buzzard <jonathan@buzzard.org.uk>");
 MODULE_DESCRIPTION("Toshiba laptop SMM driver");
diff --git a/drivers/macintosh/ans-lcd.c b/drivers/macintosh/ans-lcd.c
index b1314d1..b4821c7 100644
--- a/drivers/macintosh/ans-lcd.c
+++ b/drivers/macintosh/ans-lcd.c
@@ -142,7 +142,7 @@
 };
 
 static struct miscdevice anslcd_dev = {
-	ANSLCD_MINOR,
+	LCD_MINOR,
 	"anslcd",
 	&anslcd_fops
 };
diff --git a/drivers/macintosh/ans-lcd.h b/drivers/macintosh/ans-lcd.h
index f0a6e4c..bca7d76 100644
--- a/drivers/macintosh/ans-lcd.h
+++ b/drivers/macintosh/ans-lcd.h
@@ -2,8 +2,6 @@
 #ifndef _PPC_ANS_LCD_H
 #define _PPC_ANS_LCD_H
 
-#define ANSLCD_MINOR		156
-
 #define ANSLCD_CLEAR		0x01
 #define ANSLCD_SENDCTRL		0x02
 #define ANSLCD_SETSHORTDELAY	0x03
diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
index d38fb78..83eb05b 100644
--- a/drivers/macintosh/via-pmu.c
+++ b/drivers/macintosh/via-pmu.c
@@ -75,9 +75,6 @@
 /* Some compile options */
 #undef DEBUG_SLEEP
 
-/* Misc minor number allocated for /dev/pmu */
-#define PMU_MINOR		154
-
 /* How many iterations between battery polls */
 #define BATTERY_POLLING_COUNT	2
 
diff --git a/drivers/sbus/char/envctrl.c b/drivers/sbus/char/envctrl.c
index 12d66aa..843e830 100644
--- a/drivers/sbus/char/envctrl.c
+++ b/drivers/sbus/char/envctrl.c
@@ -37,8 +37,6 @@
 #define DRIVER_NAME	"envctrl"
 #define PFX		DRIVER_NAME ": "
 
-#define ENVCTRL_MINOR	162
-
 #define PCF8584_ADDRESS	0x55
 
 #define CONTROL_PIN	0x80
diff --git a/drivers/sbus/char/uctrl.c b/drivers/sbus/char/uctrl.c
index 7173a2e..37d252f2 100644
--- a/drivers/sbus/char/uctrl.c
+++ b/drivers/sbus/char/uctrl.c
@@ -23,8 +23,6 @@
 #include <asm/io.h>
 #include <asm/pgtable.h>
 
-#define UCTRL_MINOR	174
-
 #define DEBUG 1
 #ifdef DEBUG
 #define dprintk(x) printk x
diff --git a/drivers/video/fbdev/pxa3xx-gcu.c b/drivers/video/fbdev/pxa3xx-gcu.c
index 74ffb44..cb2eaab 100644
--- a/drivers/video/fbdev/pxa3xx-gcu.c
+++ b/drivers/video/fbdev/pxa3xx-gcu.c
@@ -36,7 +36,6 @@
 #include "pxa3xx-gcu.h"
 
 #define DRV_NAME	"pxa3xx-gcu"
-#define MISCDEV_MINOR	197
 
 #define REG_GCCR	0x00
 #define GCCR_SYNC_CLR	(1 << 9)
@@ -595,7 +594,7 @@ static int pxa3xx_gcu_probe(struct platform_device *pdev)
 	 * container_of(). This isn't really necessary as we have a fixed minor
 	 * number anyway, but this is to avoid statics. */
 
-	priv->misc_dev.minor	= MISCDEV_MINOR,
+	priv->misc_dev.minor	= PXA3XXX_GCU_MINOR,
 	priv->misc_dev.name	= DRV_NAME,
 	priv->misc_dev.fops	= &pxa3xx_gcu_miscdev_fops;
 
@@ -638,7 +637,7 @@ static int pxa3xx_gcu_probe(struct platform_device *pdev)
 	ret = misc_register(&priv->misc_dev);
 	if (ret < 0) {
 		dev_err(dev, "misc_register() for minor %d failed\n",
-			MISCDEV_MINOR);
+			PXA3XXX_GCU_MINOR);
 		goto err_free_dma;
 	}
 
@@ -714,7 +713,7 @@ static int pxa3xx_gcu_remove(struct platform_device *pdev)
 
 MODULE_DESCRIPTION("PXA3xx graphics controller unit driver");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS_MISCDEV(MISCDEV_MINOR);
+MODULE_ALIAS_MISCDEV(PXA3XXX_GCU_MINOR);
 MODULE_AUTHOR("Janine Kropp <nin@directfb.org>, "
 		"Denis Oliver Kropp <dok@directfb.org>, "
 		"Daniel Mack <daniel@caiaq.de>");
diff --git a/include/linux/miscdevice.h b/include/linux/miscdevice.h
index becde69..35294c6 100644
--- a/include/linux/miscdevice.h
+++ b/include/linux/miscdevice.h
@@ -31,14 +31,23 @@
 #define DMAPI_MINOR		140	/* unused */
 #define NVRAM_MINOR		144
 #define SGI_MMTIMER		153
+#define PMU_MINOR		154
 #define STORE_QUEUE_MINOR	155	/* unused */
+#define LCD_MINOR		156
+#define AC_MINOR		157
+#define BUTTON_MINOR		158	/* Major 10, Minor 158, /dev/nwbutton */
+#define ENVCTRL_MINOR		162
 #define I2O_MINOR		166
+#define UCTRL_MINOR		174
 #define AGPGART_MINOR		175
-#define HWRNG_MINOR		183
+#define TOSH_MINOR_DEV		181
+#define RNG_MINOR		183
 #define MICROCODE_MINOR		184
+#define KEYPAD_MINOR		185
 #define IRNET_MINOR		187
 #define D7S_MINOR		193
 #define VFIO_MINOR		196
+#define PXA3XXX_GCU_MINOR	197
 #define TUN_MINOR		200
 #define CUSE_MINOR		203
 #define MWAVE_MINOR		219	/* ACP/Mwave Modem */
@@ -49,6 +58,7 @@
 #define MISC_MCELOG_MINOR	227
 #define HPET_MINOR		228
 #define FUSE_MINOR		229
+#define SNAPSHOT_MINOR		231
 #define KVM_MINOR		232
 #define BTRFS_MINOR		234
 #define AUTOFS_MINOR		235
diff --git a/kernel/power/user.c b/kernel/power/user.c
index 7743895..98fb659 100644
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -27,8 +27,6 @@
 #include "power.h"
 
 
-#define SNAPSHOT_MINOR	231
-
 static struct snapshot_data {
 	struct snapshot_handle handle;
 	int swap;
-- 
1.8.3.1

