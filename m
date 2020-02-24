Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14DDDC35673
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 01:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAAF420675
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 01:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFO+GTQR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbgBXBvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 20:51:17 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55526 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbgBXBvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 20:51:17 -0500
Received: by mail-wm1-f68.google.com with SMTP id q9so7352368wmj.5
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2020 17:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nfdAonBHBDdIO56FXt/6K3IvqAFG9q35tqL/Ax7yCLk=;
        b=FFO+GTQRYzvhCR/T9+OWH1M/t3DTcKoSYbe3tNNlO+4/iYItgFWLssom6rF8Xp9YL8
         FxIOs3ucAdHWJObclb57laiH68CJjjRonzGzNSWiCQ/ESHEqfnKpwxZFfjpEupFud1Gh
         ScWU0ls2v0O4nQQImaNXlT+NkoNmtJKDBODogXyRBkFgjkWET9G11A95E8WFvbabMkKT
         9rXEO9BXZPJFODc7CEd8pXl1KQuU8Kb3GqpOCwqpN8BcPH7Xx+UPCD5KKsaTfES7j0mA
         UeBHMq2Ab5fM0AceBfL3d0nyb19eoV8z4Uv4Tl07m86GL4c8Ymptqshgij9ep3Wd8xjI
         UgoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nfdAonBHBDdIO56FXt/6K3IvqAFG9q35tqL/Ax7yCLk=;
        b=WAnxqJkfNtmrYkwhBjG3Ak316INrzTIoizCacvD5YfKlOfdtNfxr/V1DELs4ES7uIf
         ZIwPEEbweUQO2MKxEZHpq08kfSlU5KMlEJZj9C/lenZK0N8k7Uyi+lWcWX490DLfmNjY
         7HLl12CArM7KQnyJfsMkyI+qHR2L+wifrIJKsho5RGGeSGCf/lIZUignuh0fC8YDTBn8
         ScI5blUi5KilLt9xjYzbnGFEyv2qngKksOOlHln/fp5XqyVkAWlJXCyWz60OTUHZyyPB
         ydHq6QGNuYJPG3nrrixxMTVfi9DAtJKiO471shB9arG1UUOfHy+081zt51RQ3sHNQtJz
         lO0Q==
X-Gm-Message-State: APjAAAWa4pRf28K3vzdhNvpSF0mTItXh9xybse8pAs12tYMms3tT6Wsy
        yk4MvldMHKmcVE0t1b14VA==
X-Google-Smtp-Source: APXvYqxJAxUIP1L7ykTRvXbpONm2cH/HKZWVO+UYiPkZXblqP/FothfdvA4k9N0h6ME4NC2QJV/tMA==
X-Received: by 2002:a05:600c:114d:: with SMTP id z13mr18633181wmz.105.1582509074914;
        Sun, 23 Feb 2020 17:51:14 -0800 (PST)
Received: from ninjahub.lan (host-2-102-13-223.as13285.net. [2.102.13.223])
        by smtp.googlemail.com with ESMTPSA id q6sm9528128wrf.67.2020.02.23.17.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2020 17:51:14 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     boqun.feng@gmail.com
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.co,
        dave.jiang@intel.com, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org, yi.zhang@redhat.com,
        Jules Irenge <jbi.octave@gmail.com>
Subject: [PATCH v2] dax: Add missing annotations for dax_read_lock() and dax_read_unlock()
Date:   Mon, 24 Feb 2020 01:50:49 +0000
Message-Id: <20200224015049.57556-1-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse reports warnings at dax_read_lock() and dax_read_unlock()

warning: context imbalance in dax_read_lock() - wrong count at exit
warning: context imbalance in dax_read_unlock() - unexpected unlock

The root cause is the missing annotations at dax_read_lock()
	and dax_read_unlock()

Add the missing __acquires(&dax_srcu) annotation to dax_read_lock()
Add the missing __releases(&dax_srcu) annotation to dax_read_unlock()

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
Changes since V1
Correct commit log typing mistakes

 drivers/dax/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 26a654dbc69a..f872a2fb98d4 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -28,13 +28,13 @@ static struct super_block *dax_superblock __read_mostly;
 static struct hlist_head dax_host_list[DAX_HASH_SIZE];
 static DEFINE_SPINLOCK(dax_host_lock);
 
-int dax_read_lock(void)
+int dax_read_lock(void) __acquires(&dax_srcu)
 {
 	return srcu_read_lock(&dax_srcu);
 }
 EXPORT_SYMBOL_GPL(dax_read_lock);
 
-void dax_read_unlock(int id)
+void dax_read_unlock(int id) __releases(&dax_srcu)
 {
 	srcu_read_unlock(&dax_srcu, id);
 }
-- 
2.24.1

