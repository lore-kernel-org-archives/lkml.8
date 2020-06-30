Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A84C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38E8220702
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qDMd25o0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388648AbgF3NxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 09:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388423AbgF3Nvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 09:51:31 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3137C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:51:30 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id h5so20266821wrc.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qqN6XxuBV4Jc4c7/xcuhasc+YhoMkS+syDgxfhyrVnI=;
        b=qDMd25o04PnMrI7s5/XLbUKoJJaCs5QElcqGQC8Ps8VWTX5SlIPD7ntW4ahpr3/mv+
         xsRPeqJb51zpw6iUma6WOquB3Z3GX+eD1Drx+fID9HNPEiGiXt9ATD2SiirAeqDpXYTW
         V+WDzYlfBStA7UnKW8JXWUzQwlxdkaqvONzpzQpz52QlwpfeCF051bjArWwerpLIN2hP
         vQdq92UzPHPJYLL58KgKipIQdJXZ2Y1Ytz9Cz3nZzY9Rsmg61xI1urRdKyCcipKQ1Zjk
         DLeNOcZVV9uFyOWckmjAQSaELmCkOH9gUPYhfNqw92wm1SRXgj5Xr74P/FyBj+mPsET+
         y8pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qqN6XxuBV4Jc4c7/xcuhasc+YhoMkS+syDgxfhyrVnI=;
        b=ipj50kwriGepQbw6/4hZBu4PdtjMk72kXEpawa3aV6PhCJ4pcJoEZfcvvolK52JAg0
         IRbRRVzpwPQ9goOB6jqC2vkrTRPSzlAMLT/F8/MloL9ma37Z6V0nAmu6JLE+FoYbYywQ
         biXl557noqtk6aRcAUSPR0LXXNFwUJ5xUbGZBlGXLZ6dHAWyBFrD1s77PYmFrS4L8U+h
         BrBiydOqMasAGZzYdq/qjEbp1j1wl5oevgFzmrH4tWR5kK8umanFXbdeclh/2J/6+jMg
         B+oXp76EbA5L+tKlYkz0VRTKv0xarClzrPS3o667HTf93ialysbztFgbGeib32C54mg1
         HNhw==
X-Gm-Message-State: AOAM533kI1jFTNpubk/o8HfRdbf49pwc1VCwYTNzDLlTKycy2ebiqWk8
        VdZDPqlSPGL1u3ihrN18BECSTQ==
X-Google-Smtp-Source: ABdhPJxBCPH1g9KzdqS9IQ654MY2nJGCfEf2EBKfgxw48PUsFnr727YH5gZI9bH2YoaczlXd24j1uQ==
X-Received: by 2002:adf:db4d:: with SMTP id f13mr21659776wrj.336.1593525089539;
        Tue, 30 Jun 2020 06:51:29 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id t4sm3876746wmf.4.2020.06.30.06.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 06:51:28 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>
Subject: [PATCH 14/30] misc: mic: host: mic_debugfs: Demote function headers from kerneldoc
Date:   Tue, 30 Jun 2020 14:50:54 +0100
Message-Id: <20200630135110.2236389-15-lee.jones@linaro.org>
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

 drivers/misc/mic/host/mic_debugfs.c:108: warning: Function parameter or member 'mdev' not described in 'mic_create_debug_dir'
 drivers/misc/mic/host/mic_debugfs.c:131: warning: Function parameter or member 'mdev' not described in 'mic_delete_debug_dir'

Cc: Sudeep Dutt <sudeep.dutt@intel.com>
Cc: Ashutosh Dixit <ashutosh.dixit@intel.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/misc/mic/host/mic_debugfs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/mic/host/mic_debugfs.c b/drivers/misc/mic/host/mic_debugfs.c
index ab0db7a2ac8c2..ffda740e20d56 100644
--- a/drivers/misc/mic/host/mic_debugfs.c
+++ b/drivers/misc/mic/host/mic_debugfs.c
@@ -101,7 +101,7 @@ static int mic_msi_irq_info_show(struct seq_file *s, void *pos)
 
 DEFINE_SHOW_ATTRIBUTE(mic_msi_irq_info);
 
-/**
+/*
  * mic_create_debug_dir - Initialize MIC debugfs entries.
  */
 void mic_create_debug_dir(struct mic_device *mdev)
@@ -124,7 +124,7 @@ void mic_create_debug_dir(struct mic_device *mdev)
 			    &mic_msi_irq_info_fops);
 }
 
-/**
+/*
  * mic_delete_debug_dir - Uninitialize MIC debugfs entries.
  */
 void mic_delete_debug_dir(struct mic_device *mdev)
@@ -132,7 +132,7 @@ void mic_delete_debug_dir(struct mic_device *mdev)
 	debugfs_remove_recursive(mdev->dbg_dir);
 }
 
-/**
+/*
  * mic_init_debugfs - Initialize global debugfs entry.
  */
 void __init mic_init_debugfs(void)
@@ -140,7 +140,7 @@ void __init mic_init_debugfs(void)
 	mic_dbg = debugfs_create_dir(KBUILD_MODNAME, NULL);
 }
 
-/**
+/*
  * mic_exit_debugfs - Uninitialize global debugfs entry
  */
 void mic_exit_debugfs(void)
-- 
2.25.1

