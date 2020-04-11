Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE3F7C2BA19
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 19:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A46E020787
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 19:30:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="maFVxC7q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgDKTaI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 15:30:08 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40730 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbgDKTaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 15:30:07 -0400
Received: by mail-pg1-f195.google.com with SMTP id c5so2543437pgi.7
        for <linux-kernel@vger.kernel.org>; Sat, 11 Apr 2020 12:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=QDpChQMFaEygseW2gBl70FlwjpWjwYMaBg2WFKZnoBw=;
        b=maFVxC7qLrgqHuS2/OBvUZJNtEEkncZSM4gkNy8vnwkHnFBhi2QVDpgDB5q7RItFDb
         EzYuPj6ER//eFys0qNxwapFCGz1GEg7feOm+nUJYE6uFpLyQsCCQlMZNoSMnomPSvbHg
         uALW/Aa+kPEED57qqTHPeDW4zKdQR2hzgM7DCDiNphqDGznKDMohQXbpY+5DnUs4Nx80
         5LwIsLEL6BIFm9AzgC479GGFR+VuWWps+4WZEBvfIqj6Nbea0+xy39MHlvARt+hPDMc1
         iVNGh6F7uPO7C6+17xOydsTKePyc45KMPUeG17jFmWz4id4dUwLnLnk0N6VU8YtWVrqE
         /Q4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QDpChQMFaEygseW2gBl70FlwjpWjwYMaBg2WFKZnoBw=;
        b=D8hyVDip+8zCeVMgamlXg/I+FZWFghau1yE9/GShWOQnzEfm4rCVZZpLxBKUvWewV6
         oUg2uqYVa6hpgc/E5qi3g9UHMeOUceFscV6/GIn5CaI7D1PjVa5uyHZ0B14FG96j0H+h
         w6fdqslEiOwUf28bsC3WHKmogiA8Bt4nt7lrixEj1CIgc/jTimK+XrZ+ERaYyih8jN3x
         gSXxRhZ61ayW1ht4Ztt4wFfl5ZYE5E+W4JxCMElJ42Z0TO9y5P4S1oIpGlGqr5Qg0Gce
         tErm0Ue2IoHOxJKgXTguZUIe2Ek3JbYPK8fCPTm/RuJFexoeC2MB4lFKQufEmx05U0Nh
         7UtQ==
X-Gm-Message-State: AGi0PuY8GHicHdikhse3ZO3mc/VmDb9xTtysgJmPJIpdLqOvMWmJVoRE
        PMhXzkAUcUTK2wFf4GpTA10=
X-Google-Smtp-Source: APiQypL1Gn2bGyYpiTnqYvge55K/ou17khYaehhIz0j4zPcHVeXztorOBCk3NdBmqPT1C6QhCkFsJA==
X-Received: by 2002:a63:da47:: with SMTP id l7mr10574849pgj.315.1586633406062;
        Sat, 11 Apr 2020 12:30:06 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:804:5c5d:c8b1:1b25:412c:13f9])
        by smtp.gmail.com with ESMTPSA id t85sm4262791pgb.1.2020.04.11.12.30.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 Apr 2020 12:30:05 -0700 (PDT)
From:   MugilRaj <dmugil2000@gmail.com>
Cc:     dmugil2000@gmail.com, mugil2301 <110117057@nitt.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] taging: android: ashmem: Declared const key
Date:   Sun, 12 Apr 2020 00:59:56 +0530
Message-Id: <1586633396-24237-1-git-send-email-dmugil2000@gmail.com>
X-Mailer: git-send-email 2.7.4
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: mugil2301 <110117057@nitt.edu>

Signed-off-by: mugil2301 <110117057@nitt.edu>
---
 drivers/staging/android/ashmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
index 8044510..50f882a 100644
--- a/drivers/staging/android/ashmem.c
+++ b/drivers/staging/android/ashmem.c
@@ -367,7 +367,7 @@ ashmem_vmfile_get_unmapped_area(struct file *file, unsigned long addr,
 
 static int ashmem_mmap(struct file *file, struct vm_area_struct *vma)
 {
-	static struct file_operations vmfile_fops;
+	static const  struct file_operations vmfile_fops;
 	struct ashmem_area *asma = file->private_data;
 	int ret = 0;
 
-- 
2.7.4

