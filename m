Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53EB0C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B484206BE
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l0ql2sn5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388499AbgF3Nvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 09:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388417AbgF3Nva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 09:51:30 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B386C08C5DB
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:51:29 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id r12so20215674wrj.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3Rr7wa1veduLhh9ZAr39E4g8k4FtFNV6OceNUbS0RKk=;
        b=l0ql2sn5FiL9hzSkQ+yI7cAzJkka4RsC7ibUvZkRg88BN0zPoJVj2CCmPhRVJEhMTZ
         ZvqLmbJcCy3t1cMqYZjp5vBNBLBLZAL6f+qmWr/k4xb5m2BwaOqi3jrX9vQ8JIBumN60
         Sj/oB1X6FT9XUFRqZGk3DUe003hWauUxsyLPQqaAx+R3E8GWf28kU5e8iOq2QuiUeNu1
         N35lUJPUUNmq+fYpMdZsUEhZ1SJUgI8i3+FL3Xit6O96cnfeTh9+/o4CNMxkpSGfcKs6
         xexXuKA6fhyFqlmlsLD+5QaIs7CrHlxjcrLfgIQMJrafOsQ5vIAzkkEtDcRDyNXHpyT8
         w4cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Rr7wa1veduLhh9ZAr39E4g8k4FtFNV6OceNUbS0RKk=;
        b=YKhLCiimHiVWx0JqQkvjupMC9tC8KSt0iGV8jFtVV+aRFCcV9LOkAhIzzRqB50oi45
         7i0yhEIJPQiy0mqlWGXQ5hBdjvzaccSpCp8y63sDazzz0w21Ljh1ggAUmNOSy7D9RTm7
         tqaTtCmIt+h8h3N8Dcxe7+YoFIZqjccsYNqL2jiLNZebOmRltQmyuV+0HyP1x/A2Ip+M
         AI5uCPykxaZ8dpWjMSz/4UKvcr8WPPhXjdcFvkNUOQrcEBjvaJFrRdIiAi71GhEpdKCD
         1hOlkZbiy7HxYORfrfqUDY6QLLgbL4CFTOerGdBFEusPRVriyhAiEUAJ7ZZJOAVlPeKx
         n2KQ==
X-Gm-Message-State: AOAM5334sCGH7zX+SLIML0CMe9k/BmfTOZMSQCEBr5WEjRbMcXE8JFJE
        F8MnWhWuo9Z0MBEO1zcMK/oRfw==
X-Google-Smtp-Source: ABdhPJx7RZSCG6MhccQsVv6Y1Q3D48aKEAlqzGQWs/ITBqKeYmpx867Pcfq0L5FYO9K0o9jZk5hI7Q==
X-Received: by 2002:a5d:40cb:: with SMTP id b11mr22580348wrq.263.1593525088326;
        Tue, 30 Jun 2020 06:51:28 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id t4sm3876746wmf.4.2020.06.30.06.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 06:51:27 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>
Subject: [PATCH 13/30] misc: mic: card: mic_debugfs: Demote function headers from kerneldoc
Date:   Tue, 30 Jun 2020 14:50:53 +0100
Message-Id: <20200630135110.2236389-14-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200630135110.2236389-1-lee.jones@linaro.org>
References: <20200630135110.2236389-1-lee.jones@linaro.org>
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

