Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 226C0C1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 03:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6D7C2076E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 03:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ccSpNGpD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbgCYDcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 23:32:11 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34468 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727285AbgCYDcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 23:32:10 -0400
Received: by mail-pl1-f196.google.com with SMTP id a23so283204plm.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 20:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=jIvdWurQrynQPs8bJVrUivnNx43ycQqIFEr2BSEWluk=;
        b=ccSpNGpD6C2895cDQtq0ZJTPecpCphHKwHbe2fRQv3Dx4qC5leA2NooEr9SY0nvk9W
         FasSSGlppzIf1uIaRW9FfPvL2GlpokW7eLf/QNPf1ZzWV/RAo+tYgLUEGxd51kQeRaEI
         MK62IwckRCwGw0zvjfA10MoYUCPEpcwlRZdy7kxGgUo893Sdi42hhrNqy9ZRUKYRT9wJ
         p8l3xIhsqcn/Q0puMc+SM9/uBSWeIffknMn6Y55ghzpGch6Iq9ccTWL6T2Lw5GiSkGKp
         PEDLYPjDaCPuFx3wf/W56XVumoQKYWhWWNTMDewXMy4+4xUh537UEvJgokdUj4k7Nd7i
         C4WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jIvdWurQrynQPs8bJVrUivnNx43ycQqIFEr2BSEWluk=;
        b=kX5wwHZy/TVmv0iu/GOss6nVUCsyO+ik2WRb38Y08Nn5l6ONB158688ACIR4vHhThi
         QIuVL1BwYjiA7kswl9hCB5D2kH6vK2UF1/yi/jFy8ICV1KiFtLiFf5iiCzCuv1KwzIn5
         idKWDURxm3HxEGR/JqA8LPaj/z1HR/9/lCNb4W2/n+eVn9a8lsjHBIMHIdsnpSTAL3L7
         XoYj5KIN0iYJz5Xx7x/L19wgIZfh3bwipkkT7sXUdwBnt+wzfgm082yj25XEl5vVhbuF
         kQgQo/RqAVunMSs1hbxTjdSzjJq6GLcOTs0Pq8Znw1khw/1O/QgDqXXl7I8uXZrFSdM7
         vpPA==
X-Gm-Message-State: ANhLgQ2BHHZLvSeP3ZVUgA12gxuEifRQJ2MhPivcwX9cRpuSQJA1/hmd
        vcDBzZkk8eQ9mAnfsWyaU21GnG1E
X-Google-Smtp-Source: ADFU+vudM19tUZZbtqVtqyB7O5dRUBpZVboHld80msIPoDguY0PD5yh39rmNnalx5XnBTHnT7aGrlQ==
X-Received: by 2002:a17:902:59dd:: with SMTP id d29mr1217203plj.246.1585107128212;
        Tue, 24 Mar 2020 20:32:08 -0700 (PDT)
Received: from ZB-PF114XEA.360buyad.local ([103.90.76.242])
        by smtp.gmail.com with ESMTPSA id w127sm17194978pfb.70.2020.03.24.20.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 20:32:07 -0700 (PDT)
From:   Zhenzhong Duan <zhenzhong.duan@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        miguel.ojeda.sandonis@gmail.com, willy@haproxy.com,
        ksenija.stanojevic@gmail.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, mpm@selenic.com,
        herbert@gondor.apana.org.au, benh@kernel.crashing.org,
        davem@davemloft.net, b.zolnierkie@samsung.com, rjw@rjwysocki.net,
        pavel@ucw.cz, len.brown@intel.com, speakup@linux-speakup.org,
        devel@driverdev.osuosl.org,
        Zhenzhong Duan <zhenzhong.duan@gmail.com>,
        William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>
Subject: [PATCH v2] speakup: misc: Use dynamic minor numbers for speakup devices
Date:   Wed, 25 Mar 2020 11:30:08 +0800
Message-Id: <20200325033008.9633-1-zhenzhong.duan@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd notes in the link:
   | To clarify: the only numbers that I think should be changed to dynamic
   | allocation are for drivers/staging/speakup. While this is a fairly old
   | subsystem, I would expect that it being staging means we can be a
   | little more progressive with the changes.

This releases misc device minor numbers 25-27 for dynamic usage.

Link: https://lore.kernel.org/lkml/20200120221323.GJ15860@mit.edu/t/
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@gmail.com>
Acked-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: William Hubbs <w.d.hubbs@gmail.com>
Cc: Chris Brannon <chris@the-brannons.com>
Cc: Kirk Reiser <kirk@reisers.ca>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v2: Add Acked-by from Maintainer, no other change.

 drivers/staging/speakup/devsynth.c     | 10 +++-------
 drivers/staging/speakup/speakup_soft.c | 14 +++++++-------
 2 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/speakup/devsynth.c b/drivers/staging/speakup/devsynth.c
index d920256..d305716 100644
--- a/drivers/staging/speakup/devsynth.c
+++ b/drivers/staging/speakup/devsynth.c
@@ -1,16 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/errno.h>
-#include <linux/miscdevice.h>	/* for misc_register, and SYNTH_MINOR */
+#include <linux/miscdevice.h>	/* for misc_register, and MISC_DYNAMIC_MINOR */
 #include <linux/types.h>
 #include <linux/uaccess.h>
 
 #include "speakup.h"
 #include "spk_priv.h"
 
-#ifndef SYNTH_MINOR
-#define SYNTH_MINOR 25
-#endif
-
 static int misc_registered;
 static int dev_opened;
 
@@ -67,7 +63,7 @@ static int speakup_file_release(struct inode *ip, struct file *fp)
 };
 
 static struct miscdevice synth_device = {
-	.minor = SYNTH_MINOR,
+	.minor = MISC_DYNAMIC_MINOR,
 	.name = "synth",
 	.fops = &synth_fops,
 };
@@ -81,7 +77,7 @@ void speakup_register_devsynth(void)
 		pr_warn("Couldn't initialize miscdevice /dev/synth.\n");
 	} else {
 		pr_info("initialized device: /dev/synth, node (MAJOR %d, MINOR %d)\n",
-			MISC_MAJOR, SYNTH_MINOR);
+			MISC_MAJOR, synth_device.minor);
 		misc_registered = 1;
 	}
 }
diff --git a/drivers/staging/speakup/speakup_soft.c b/drivers/staging/speakup/speakup_soft.c
index 9d85a3a..eed246f 100644
--- a/drivers/staging/speakup/speakup_soft.c
+++ b/drivers/staging/speakup/speakup_soft.c
@@ -10,7 +10,7 @@
  */
 
 #include <linux/unistd.h>
-#include <linux/miscdevice.h>	/* for misc_register, and SYNTH_MINOR */
+#include <linux/miscdevice.h>	/* for misc_register, and MISC_DYNAMIC_MINOR */
 #include <linux/poll.h>		/* for poll_wait() */
 
 /* schedule(), signal_pending(), TASK_INTERRUPTIBLE */
@@ -20,8 +20,6 @@
 #include "speakup.h"
 
 #define DRV_VERSION "2.6"
-#define SOFTSYNTH_MINOR 26 /* might as well give it one more than /dev/synth */
-#define SOFTSYNTHU_MINOR 27 /* might as well give it one more than /dev/synth */
 #define PROCSPEECH 0x0d
 #define CLEAR_SYNTH 0x18
 
@@ -375,7 +373,7 @@ static int softsynth_probe(struct spk_synth *synth)
 	if (misc_registered != 0)
 		return 0;
 	memset(&synth_device, 0, sizeof(synth_device));
-	synth_device.minor = SOFTSYNTH_MINOR;
+	synth_device.minor = MISC_DYNAMIC_MINOR;
 	synth_device.name = "softsynth";
 	synth_device.fops = &softsynth_fops;
 	if (misc_register(&synth_device)) {
@@ -384,7 +382,7 @@ static int softsynth_probe(struct spk_synth *synth)
 	}
 
 	memset(&synthu_device, 0, sizeof(synthu_device));
-	synthu_device.minor = SOFTSYNTHU_MINOR;
+	synthu_device.minor = MISC_DYNAMIC_MINOR;
 	synthu_device.name = "softsynthu";
 	synthu_device.fops = &softsynthu_fops;
 	if (misc_register(&synthu_device)) {
@@ -393,8 +391,10 @@ static int softsynth_probe(struct spk_synth *synth)
 	}
 
 	misc_registered = 1;
-	pr_info("initialized device: /dev/softsynth, node (MAJOR 10, MINOR 26)\n");
-	pr_info("initialized device: /dev/softsynthu, node (MAJOR 10, MINOR 27)\n");
+	pr_info("initialized device: /dev/softsynth, node (MAJOR 10, MINOR %d)\n",
+		synth_device.minor);
+	pr_info("initialized device: /dev/softsynthu, node (MAJOR 10, MINOR %d)\n",
+		synthu_device.minor);
 	return 0;
 }
 
-- 
1.8.3.1

