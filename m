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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 447F5C10DCE
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 02:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E6C02067C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 02:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G8/2ZwP3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbgCICS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 22:18:28 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34357 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbgCICS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 22:18:28 -0400
Received: by mail-pl1-f193.google.com with SMTP id a23so642440plm.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Mar 2020 19:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HMwZoEE+7ccFZK+8oLvgSBtGicHQVdPT9j30hR6yRhE=;
        b=G8/2ZwP3L6NLPQ75+Dw6l6SDFMEdcBa0fYV47kE5wH4poHvo++Fv8DFGP7j58HErYg
         5BNzx1DaSu423F3a5nWbTWApFy5NFXjAcqkhiGdgiAN62nGNLpzxoTTphNfTqth6V4/N
         ZX/gYzoRA+tysRsDyKtrCBtDnZ1Q3hKFoJ7d0wuqLW9uWLEcQpmc2bXZ7uOIXrH75rLz
         FBUQMTNw9zihhA7j2Au2pC9K+N5L1GakWTyNXWkv6YJPXLnQI+Fbt3SHTfPfQDlZHvtn
         /f/eEfCledSVckE3WPJXdfRVvhcRSkOV6EGgpmmiHGdYe6uGeg9rWwwWlP4Tsre1IbK3
         CzBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HMwZoEE+7ccFZK+8oLvgSBtGicHQVdPT9j30hR6yRhE=;
        b=ipcKvS619t3LZm8k3oItDixpyYlRyhx3jKVwM8NtliDrqMdLmDwCuLQoFaHYK3Ki6Z
         /RslnSgolTpaHeZ2+bBli4+RTmjtyPOmBQ8hK5/JLMMhDEdGl/SA3U0EqT7Scny6dShh
         MwkECMFPsqqMP1rZh+OioD2mPLNa/pkjSDJx8KAKch7CoB7bYPwnXbtRGpapA35eAoFV
         zkfCuY/ru0HVIvZPWV9+NazkGcOwdfeK+2ZVjdaSWwqso4Y6oAKie/3PNN8b3xS3+NIp
         fTOa+UowRAdR50lRJHkWqCPwUDiOJd7EHTPOl73R4oZ2j9JTikRrPTc51ATqe88HLiOv
         kLCA==
X-Gm-Message-State: ANhLgQ2JK1mPZl0CmCvzWKFPBpK6uq2KJladyg/mIkp7zhGfX/sppJ50
        4x7loSLc0qJoArXEYeqck7z+Mt1r
X-Google-Smtp-Source: ADFU+vvS1HRalQijcgOdNbOTCUwuQ3rMJbmaxNecPD1jfeXxA1USP3/sBxy++KWvQZeZ9Hav7ZDnLA==
X-Received: by 2002:a17:90a:3270:: with SMTP id k103mr16700071pjb.30.1583720305442;
        Sun, 08 Mar 2020 19:18:25 -0700 (PDT)
Received: from ZB-PF114XEA.360buyad.local ([103.90.76.242])
        by smtp.gmail.com with ESMTPSA id r12sm42394043pgu.93.2020.03.08.19.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2020 19:18:24 -0700 (PDT)
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
        William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: [PATCH RFC 3/3] speakup: misc: Use dynamic minor numbers for speakup devices
Date:   Mon,  9 Mar 2020 10:17:47 +0800
Message-Id: <20200309021747.626-4-zhenzhong.duan@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200309021747.626-1-zhenzhong.duan@gmail.com>
References: <20200309021747.626-1-zhenzhong.duan@gmail.com>
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
Cc: William Hubbs <w.d.hubbs@gmail.com>
Cc: Chris Brannon <chris@the-brannons.com>
Cc: Kirk Reiser <kirk@reisers.ca>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
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

