Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50735C2D0EC
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 00:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2330D20936
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 00:20:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DYmz1TVu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgDKAUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 20:20:09 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40935 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbgDKAUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 20:20:09 -0400
Received: by mail-wr1-f66.google.com with SMTP id s8so4057424wrt.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 17:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jhB68JClm4ABNZd4Z27jP8/6G2WhcvtBBYeVzUWPHVQ=;
        b=DYmz1TVuw/S48WtTV+IrgdIHkZmq6hbN9JYZTJkmWAWJYvPBx9v7PrhC5g2/T8Bvhe
         q53ArkOW6QTJ8macxb4w7tcPB0SX98y84krnFtpIMHwEpKP4tjyXexp72xPsXhr8bJiQ
         VzQZl7rPAaxMD/aIU4M5pJzcX13BKchfjOF36iNZWOssYrXxWD8tMXdvI/BORvntDiot
         uGjtXTUfIlinLsUq+ha2GrveL9WE4v6qnjXFtzN1q2FEDyy2xWbXPrhc6AOgqgpySVhp
         4M8HIkrRR8JhUOjhFce+/rNnHaRjaqcLQ9D+ybT1zClvgwIwFwekl2duOp1llTcT3zC1
         TZYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jhB68JClm4ABNZd4Z27jP8/6G2WhcvtBBYeVzUWPHVQ=;
        b=jg2RmnpGhyOpPKc3XNaaqxIwoDmnASGRvCnt70UGzIqXXSgIRr6+1AG+pgUwcQoVPh
         TexmYeo11X4qDFLFvSOstoDOXwr/KZXo0bw6BuFWTvLQ4ATpzqT79vRS6ocHtarrRmf+
         klPue1aCPG5o8r7r7vyy2WIszPaS2cKVdZd28aXzn9Mp0qUOdK7cU2LMufRcm6sxWUy1
         gJjbpwiznqATjEMN+/55qwJZVrsmGi57YPF8JylFKQoir1DsvawoCr3kHFmFKOBWMB91
         xdHDNM10wfQUkb1/o6tcInw+o8H2biBZlEhdZf457fSAirtTNi3o7yyWRigY8PqeB1FK
         PSyw==
X-Gm-Message-State: AGi0PuaQzPKQewMt9xwOsmbYgsd3UhCzPw7FiO1JaB6AcDQfOIqjLU72
        8gi5qwxuB6gLcuH37mwmM3L/jRFZpQ==
X-Google-Smtp-Source: APiQypI3Koa4lb8I756i/148Kqv+HFg+EOte7BIcKkMCL6jzuKrikGEab+xgxrOKJ6QW/NcAvkalYA==
X-Received: by 2002:a5d:4145:: with SMTP id c5mr6880676wrq.362.1586564407358;
        Fri, 10 Apr 2020 17:20:07 -0700 (PDT)
Received: from ninjahost.lan (host-2-102-14-153.as13285.net. [2.102.14.153])
        by smtp.gmail.com with ESMTPSA id b191sm5091594wmd.39.2020.04.10.17.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 17:20:06 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     boqun.feng@gmail.com, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        dm-devel@redhat.com (maintainer:DEVICE-MAPPER (LVM))
Subject: [PATCH 1/9] dm snapshot: Add missing annotation for dm_exception_table_lock() and dm_exception_table_unlock()
Date:   Sat, 11 Apr 2020 01:19:25 +0100
Message-Id: <20200411001933.10072-2-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200411001933.10072-1-jbi.octave@gmail.com>
References: <0/9>
 <20200411001933.10072-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse reports warnings at dm_exception_table_lock()
and dm_exception_table_unlock()

warning: context imbalance in dm_exception_table_lock()
	- wrong count at exit
warning: context imbalance in dm_exception_table_unlock()
	- unexpected unlock

The root cause is the missing annotation at dm_exception_table_lock()
and dm_exception_table_unlock()

Add the missing __acquires(lock->complete_slot) annotation
Add the missing __acquires(lock->pending_slot) annotation
Add the missing __releases(lock->pending_slot) annotation
Add the missing __releases(lock->complete_slot) annotation

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 drivers/md/dm-snap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/md/dm-snap.c b/drivers/md/dm-snap.c
index 6b11a266299f..1831dd28de5c 100644
--- a/drivers/md/dm-snap.c
+++ b/drivers/md/dm-snap.c
@@ -640,12 +640,16 @@ static void dm_exception_table_lock_init(struct dm_snapshot *s, chunk_t chunk,
 }
 
 static void dm_exception_table_lock(struct dm_exception_table_lock *lock)
+	__acquires(lock->complete_slot)
+	__acquires(lock->pending_slot)
 {
 	hlist_bl_lock(lock->complete_slot);
 	hlist_bl_lock(lock->pending_slot);
 }
 
 static void dm_exception_table_unlock(struct dm_exception_table_lock *lock)
+	__releases(lock->pending_slot)
+	__releases(lock->complete_slot)
 {
 	hlist_bl_unlock(lock->pending_slot);
 	hlist_bl_unlock(lock->complete_slot);
-- 
2.24.1

