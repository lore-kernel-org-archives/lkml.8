Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51651C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BCEC2077D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:31:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZXihPHNe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbgGAIbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 04:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728853AbgGAIbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 04:31:40 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC65C061755
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 01:31:40 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id j4so20436736wrp.10
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 01:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3Rr7wa1veduLhh9ZAr39E4g8k4FtFNV6OceNUbS0RKk=;
        b=ZXihPHNeTPGzzWIOGigoojdSlhcsbrFPRsnnbGl6OigYd9GoaWgbnix/oEKQn7taaN
         zPlYBmm3sn7OWXXdhIo4FMZMTphWqkpMJBdCkGDgGAZ4NKgVkz+5k74XgzGGAJAT8Imv
         tDxSMfz1GJauZWrBg8laNQHe9JY4WmOuC+oF/AGrmvhDDUfNSlG1S1PcE+JQsEuj5IkN
         XVdeqD+UFy8WJEI5P9PsfVngz/J1wPLTxEXzgaSDOwwsk/fKgSFFijjzDbGMZAXdbqp1
         CklXB/+KZzqQ++VxCKrT7XjO+RnS3HVtP3/bl9Xi0q3gnbifurDjhzXkE0+Bp4GmCNcY
         D/4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Rr7wa1veduLhh9ZAr39E4g8k4FtFNV6OceNUbS0RKk=;
        b=L7LvbIoC+fRhhEqo2ZP1uCsHojy5CQhRTiL6krLXRquljMUUTlW1VCTsCC4yIdMGjQ
         IdtRx45cwzKtAFPWjh5c+CW5Kl4SsBo69qY10TzmQKGjej93Y3vvk0k2AMkmlnYaC3gO
         clp1qmZkHXdP4vIRXYoB+C9FYy08ATpDLQJxs8t2WwhYbJ7BVi0nThyjV1/JiWzU4KMa
         3egc21dSAqJ8CJhiSYIo8dSbgwN548J3eNXPFqnnBCJbvdYXSPfja36Th8j4lgC0OgpB
         NmUdx6eIKyKRLzpSHft6J3oM4WuTa7iHMphitb88yr4ww2aWhbj6CO6vuOHuaD1ofWva
         nkpQ==
X-Gm-Message-State: AOAM5336Z979JG2ADrnE9UhiszFKAyAq4s7XeOSJQP/FQRRAx1CQwwLg
        2LOvbCjmUozGlRK2G6HcWJxl9w==
X-Google-Smtp-Source: ABdhPJxbH5IzrNVO6UVhcdsc5mh8Vf/wclnPhkzfaeEVgosZhzbK1p76bd9VqKpsIqj3ph0bcjVvFw==
X-Received: by 2002:a5d:5642:: with SMTP id j2mr25592998wrw.19.1593592299258;
        Wed, 01 Jul 2020 01:31:39 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id 59sm6717816wrj.37.2020.07.01.01.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 01:31:38 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>
Subject: [PATCH v2 13/30] misc: mic: card: mic_debugfs: Demote function headers from kerneldoc
Date:   Wed,  1 Jul 2020 09:31:01 +0100
Message-Id: <20200701083118.45744-14-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200701083118.45744-1-lee.jones@linaro.org>
References: <20200701083118.45744-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The correct format is not used and no attempt has been made
to document the function arguments.  Makes sense to just demote
the headers back down to simple comments.

Fixes the following W=1 warnings:

 drivers/misc/mic/card/mic_debugfs.c:31: warning: Function parameter or member 's' not described in 'mic_intr_show'
 drivers/misc/mic/card/mic_debugfs.c:31: warning: Function parameter or member 'unused' not described in 'mic_intr_show'
 drivers/misc/mic/card/mic_debugfs.c:53: warning: Function parameter or member 'mdrv' not described in 'mic_create_card_debug_dir'
 drivers/misc/mic/card/mic_debugfs.c:67: warning: Function parameter or member 'mdrv' not described in 'mic_delete_card_debug_dir'

Cc: Sudeep Dutt <sudeep.dutt@intel.com>
Cc: Ashutosh Dixit <ashutosh.dixit@intel.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/misc/mic/card/mic_debugfs.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/mic/card/mic_debugfs.c b/drivers/misc/mic/card/mic_debugfs.c
index b58608829b180..4c326e8f4d993 100644
--- a/drivers/misc/mic/card/mic_debugfs.c
+++ b/drivers/misc/mic/card/mic_debugfs.c
@@ -24,7 +24,7 @@
 /* Debugfs parent dir */
 static struct dentry *mic_dbg;
 
-/**
+/*
  * mic_intr_show - Send interrupts to host.
  */
 static int mic_intr_show(struct seq_file *s, void *unused)
@@ -46,7 +46,7 @@ static int mic_intr_show(struct seq_file *s, void *unused)
 
 DEFINE_SHOW_ATTRIBUTE(mic_intr);
 
-/**
+/*
  * mic_create_card_debug_dir - Initialize MIC debugfs entries.
  */
 void __init mic_create_card_debug_dir(struct mic_driver *mdrv)
@@ -60,7 +60,7 @@ void __init mic_create_card_debug_dir(struct mic_driver *mdrv)
 			    &mic_intr_fops);
 }
 
-/**
+/*
  * mic_delete_card_debug_dir - Uninitialize MIC debugfs entries.
  */
 void mic_delete_card_debug_dir(struct mic_driver *mdrv)
@@ -68,7 +68,7 @@ void mic_delete_card_debug_dir(struct mic_driver *mdrv)
 	debugfs_remove_recursive(mdrv->dbg_dir);
 }
 
-/**
+/*
  * mic_init_card_debugfs - Initialize global debugfs entry.
  */
 void __init mic_init_card_debugfs(void)
@@ -76,7 +76,7 @@ void __init mic_init_card_debugfs(void)
 	mic_dbg = debugfs_create_dir(KBUILD_MODNAME, NULL);
 }
 
-/**
+/*
  * mic_exit_card_debugfs - Uninitialize global debugfs entry
  */
 void mic_exit_card_debugfs(void)
-- 
2.25.1

