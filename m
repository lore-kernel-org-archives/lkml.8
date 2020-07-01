Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB89C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CB1E207CD
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HYhH5D4i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729141AbgGAIdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 04:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728858AbgGAIbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 04:31:42 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A87C061755
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 01:31:41 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id r12so22822432wrj.13
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 01:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qqN6XxuBV4Jc4c7/xcuhasc+YhoMkS+syDgxfhyrVnI=;
        b=HYhH5D4iYKvqfOcEZozIXbZK+3GUFjQvEt9oTG0zyZplKyq3KFireZ7yKQJR9prio5
         m8kt9h93baqc+9situIhiciE/ochx21mTwPCscD1ytzEqFdeQCKFBK0Y2yNYmvYVQfXt
         yUkIWS/zHIVRCNh9vxRI5Pq00TXoX7HLq8hJUs2cSeQ8sCZN/oUclHAtCTFHYG7TQa0V
         cWs57a6DrY9cUFoReNqJWSDX3wfiLdAAMhCy7rFnrqGot2/hIvnGJcXWwoNf06ncU2Ct
         YA8t+aD+R9P7H+/QpwiSaHINEc4g9rJTITMBcqnRvATjQ3Frth/hSFXWKlGu+zyR4wQU
         /XkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qqN6XxuBV4Jc4c7/xcuhasc+YhoMkS+syDgxfhyrVnI=;
        b=FCV4Bt4hsBoky6v+sMZbBE5Ek7xUUgcX/yr65uFPXTi2BbBQiq039rhsX7O85mERST
         AkzE3IvBb+f/bEUQ3Sxq31DcWWS3lrlWCDOU8CKdpEFyoqz9ZbA9shdibaGCdkU6WoA2
         Gtcrmkcq9XGXHBHyApy/dC9wqe8WlXnoaXxcovN8YE5tA9SS8IJUlxVNfcrhMnOiLjEB
         1whs9mtzLcXGkXuFnKxI54TJOlv0tpx9PXnlrogfd7i243/ShDGOnjhdbL9Z0wwhw3Al
         oPMM1VEsjYzXubHEZEq6PrpZFFH9v9Hpk9qO9WG/f2i2+ZSSdgDdqHezlu6+GLVXiIV2
         e6Eg==
X-Gm-Message-State: AOAM531mGoS+jLuK/v8qf1gW9EyZ3V6n9HbSUhh36W3O93qdQIJ6r6F+
        22R15+JgS4QoEAfNHEFH4CPWWJvoWxw=
X-Google-Smtp-Source: ABdhPJwFyytyHe6Fg/Zzb9Dm+c+uudMotSOlxn7CNoD2NPieFAechx3QO9ukci0nDDTXMezmZJ1YHA==
X-Received: by 2002:adf:e90d:: with SMTP id f13mr24287781wrm.146.1593592300331;
        Wed, 01 Jul 2020 01:31:40 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id 59sm6717816wrj.37.2020.07.01.01.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 01:31:39 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>
Subject: [PATCH v2 14/30] misc: mic: host: mic_debugfs: Demote function headers from kerneldoc
Date:   Wed,  1 Jul 2020 09:31:02 +0100
Message-Id: <20200701083118.45744-15-lee.jones@linaro.org>
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

