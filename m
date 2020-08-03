Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC17C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 10:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A956F2064B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 10:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SdHqgDuy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgHCKvS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 06:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgHCKu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 06:50:58 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E39EC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 03:50:58 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id u185so17925776pfu.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 03:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3Z1ZDTD6Tg8XxJTQmSvKl8eqGSKtEjijAySS8RcSIuA=;
        b=SdHqgDuysuUtOrOX7qZpC0H1s9tmcoKqOlSL7Y3pc9+yzYLSz69VCFuelB5DgcCxaC
         e+s/31Z5Uqk5PoFGENrTAJaVmk+3LDWf441NlrPbfeRslj8cYNSTbof8yLAaiMxPp8Fe
         slC4IuS4kNEUYKKF6t5++XPP31JeZxzbTPGdmU3BAvEOHHAU5ODeDbdm5RV0ub61l/11
         00iytVTbqGtoZdLWkS2Q2uJK38x6jor+pMNCM0gY89fx9T3pAuYSRLoNg3r4LgobG9st
         DFUQc1+jO+wB2Fby2OTVBHEtM/rQPQ2buA2vdZUVWryWDYk88OUd+TFrLsTmQpULxiOG
         6DMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3Z1ZDTD6Tg8XxJTQmSvKl8eqGSKtEjijAySS8RcSIuA=;
        b=UAJXCcytxCoqWhaQQ88ytRwTEn/xlJs44Ctn5586C4g+zPQnsqRBTN3LZUA8FaHdqT
         v8pUs1PzHkB8l49ZGC13ZUOnVXyRPj6anLiySF5sYyaqLHUyOEYJrefKNIa3Z4JTcs/0
         KFpvwvm7HHJFN9dMm5kJYg3Zs2lHG3gRBC5OrTBvdNPRbIUthk+aZvosAQ60MKT0rqtY
         H+qkFscAMd7ANMASU1O3cALQIH2hyh+18q55+OwpuOD6FoUkz3/lcG3tjqCdhyY3AWXf
         qJdSPcf1cwox0s1VCJvCY62cyj/vTFpcmBJi6p80ajPtw+fX4lMcs6/U+c2Dximu64r2
         0K8w==
X-Gm-Message-State: AOAM531KNzghBSLkEhQQHP8RN/cxSnR2y4faMAjNYVD1dcNh0YJRXwpo
        heKW34VZxXavNlR+v+M5eQ==
X-Google-Smtp-Source: ABdhPJz4MJYfm503B+o6UCjEobOs+CC49Q1FjllwEmTkBjUid/UBmcSg+PehF5a53tAAo0ITOmEjUg==
X-Received: by 2002:aa7:8e0c:: with SMTP id c12mr15055788pfr.38.1596451857441;
        Mon, 03 Aug 2020 03:50:57 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:ce2:8573:b0b2:951:c50:ed47])
        by smtp.gmail.com with ESMTPSA id fh14sm16886074pjb.38.2020.08.03.03.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 03:50:56 -0700 (PDT)
From:   madhuparnabhowmik10@gmail.com
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, andrianov@ispras.ru,
        ldv-project@linuxtesting.org,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Subject: [PATCH] drivers: char: applicom.c: Add lock for protecting DeviceErrorCount
Date:   Mon,  3 Aug 2020 16:20:49 +0530
Message-Id: <20200803105049.11089-1-madhuparnabhowmik10@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>

The variable DeviceErrorCount is used to keep track of the number of
errors in read, write and interrupt routines, however it was not
protected by proper locking.
Therefore, this patch adds a spinlock: error_lock to protect the
variable.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
---
 drivers/char/applicom.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/char/applicom.c b/drivers/char/applicom.c
index 14b2d8034c51..6df7450b8b99 100644
--- a/drivers/char/applicom.c
+++ b/drivers/char/applicom.c
@@ -106,6 +106,7 @@ static DECLARE_WAIT_QUEUE_HEAD(FlagSleepRec);
 static unsigned int WriteErrorCount;	/* number of write error      */
 static unsigned int ReadErrorCount;	/* number of read error       */
 static unsigned int DeviceErrorCount;	/* number of device error     */
+DEFINE_SPINLOCK(error_lock);		/* lock to protect error count variables */
 
 static ssize_t ac_read (struct file *, char __user *, size_t, loff_t *);
 static ssize_t ac_write (struct file *, const char __user *, size_t, loff_t *);
@@ -428,7 +429,9 @@ static ssize_t ac_write(struct file *file, const char __user *buf, size_t count,
 		spin_unlock_irqrestore(&apbs[IndexCard].mutex, flags);
 		printk(KERN_WARNING "APPLICOM driver write error board %d, DataFromPcReady = %d\n",
 		       IndexCard,(int)readb(apbs[IndexCard].RamIO + DATA_FROM_PC_READY));
+		spin_lock_irqsave(&error_lock, flags);
 		DeviceErrorCount++;
+		spin_unlock_irqrestore(&error_lock, flags);
 		return -EIO;
 	}
 	
@@ -593,7 +596,9 @@ static ssize_t ac_read (struct file *filp, char __user *buf, size_t count, loff_
 				
 				printk(KERN_WARNING "APPLICOM driver read error board %d, DataToPcReady = %d\n",
 				       i,(int)readb(apbs[i].RamIO + DATA_TO_PC_READY));
+				spin_lock_irqsave(&error_lock, flags);
 				DeviceErrorCount++;
+				spin_unlock_irqrestore(&error_lock, flags);
 				return -EIO;
 			}
 			
@@ -653,7 +658,9 @@ static irqreturn_t ac_interrupt(int vec, void *dev_instance)
 			if (readb(apbs[i].RamIO + DATA_TO_PC_READY) > 2) {
 				printk(KERN_WARNING "APPLICOM driver interrupt err board %d, DataToPcReady = %d\n",
 				       i+1,(int)readb(apbs[i].RamIO + DATA_TO_PC_READY));
+				spin_lock(&error_lock);
 				DeviceErrorCount++;
+				spin_unlock(&error_lock);
 			}
 
 			if((readb(apbs[i].RamIO + DATA_FROM_PC_READY) > 2) && 
@@ -661,7 +668,9 @@ static irqreturn_t ac_interrupt(int vec, void *dev_instance)
 				
 				printk(KERN_WARNING "APPLICOM driver interrupt err board %d, DataFromPcReady = %d\n",
 				       i+1,(int)readb(apbs[i].RamIO + DATA_FROM_PC_READY));
+				spin_lock(&error_lock);
 				DeviceErrorCount++;
+				spin_unlock(&error_lock);
 			}
 
 			if (readb(apbs[i].RamIO + DATA_TO_PC_READY) == 2) {	/* mailbox sent by the card ?   */
@@ -699,6 +708,7 @@ static long ac_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
      
 {				/* @ ADG ou ATO selon le cas */
 	int i;
+	unsigned long flags;
 	unsigned char IndexCard;
 	void __iomem *pmem;
 	int ret = 0;
@@ -819,12 +829,14 @@ static long ac_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 			else
 				printk("\n");
 		}
+		spin_lock_irqsave(&error_lock, flags);
 		if (DeviceErrorCount != 0)
 			printk(KERN_INFO "DeviceErrorCount ........... %d\n", DeviceErrorCount);
 		if (ReadErrorCount != 0)
 			printk(KERN_INFO "ReadErrorCount ............. %d\n", ReadErrorCount);
 		if (WriteErrorCount != 0)
 			printk(KERN_INFO "WriteErrorCount ............ %d\n", WriteErrorCount);
+		spin_unlock_irqrestore(&error_lock, flags);
 		if (waitqueue_active(&FlagSleepRec))
 			printk(KERN_INFO "Process in read pending\n");
 		for (i = 0; i < MAX_BOARD; i++) {
-- 
2.17.1

