Return-Path: <SRS0=dnKw=BT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F6B3C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 22:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECF74206D8
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 22:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HroCOc26"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgHIWca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Aug 2020 18:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbgHIWca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 18:32:30 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE4DC061756
        for <linux-kernel@vger.kernel.org>; Sun,  9 Aug 2020 15:32:30 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 128so3895458pgd.5
        for <linux-kernel@vger.kernel.org>; Sun, 09 Aug 2020 15:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QAE9zTHzPJBhKSpqcMtAGO8m5kYOJukFe0G4L2lTSUk=;
        b=HroCOc26m/jnQbTsPGNOvtwuoH257EseBuNJcLkgebSxAxKgKrQoAfL8dlky3qvfMi
         EPjcl8A2kThfWf+tv8e3wASwTJfsZtYqk2+LR9MhV08FbG+580r1A+Jh+UYtvuDdGSlf
         piotfVdie/+f+XO4wnBdMWE1jGjkUU4WYs41UJ74tGPCXx0R0/qnYrQ62w6hyBrirkKs
         Pu0kH9b+lYMAUKFKEcKQPN96uLjr9/Po+8V7Qrjg/OkGPl0RCpD+YuLgVXHr8PpZgYup
         3GMuCSQtTeyPZEem48vHgXTp5gdD5kmmDhuAVKbg9KIBwT4V9yYtb6rxFHMP46ztA8FJ
         B4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QAE9zTHzPJBhKSpqcMtAGO8m5kYOJukFe0G4L2lTSUk=;
        b=qse4zEMY+66RVbftQg1CqIgH6oTM0DsmDcYL2kAnpqxYEwh7TFbz8AAurU5g0mdAkU
         PhnIee3JEgmIEYr/+9Xpqw0Q+oC1KOyv/2RG9Db2X/p+kX4N5vw0wDkNV7+HSy+F8dyX
         6Np0GqGCy5tCXzQh3iaMGJcQO9Ww3VEx6/wrAeMCWQ3/fiS5CxIzNWPgx6QbqDqxQTOH
         VUp8g9SePpcCEhhaonWoTZJU6AUElJ9ipMLR6vJWJv2/6eBTvKDXJN/5ojuzh3fu+epa
         NDDGZDsvxIy0w1WlfTVYgVvOvAUiQaVtvKDLjbZ1u3bv/S83qsyFAKlt34/vENdlDnwH
         LVYA==
X-Gm-Message-State: AOAM530pmZZlq1TaigwboNrdIQBeHUtNLTe0uF5LmeS9HhjLcSYIRMVH
        kLleG8WPPlWddy69OQNh2aM=
X-Google-Smtp-Source: ABdhPJzs5RdLWp71WHCF/ypKYRk4tRVEFKOnH0wqzPlKnl5+dO4jY0ykHbK6Lbh4b0/bgzRWNIJ2UA==
X-Received: by 2002:aa7:9219:: with SMTP id 25mr23073030pfo.4.1597012348619;
        Sun, 09 Aug 2020 15:32:28 -0700 (PDT)
Received: from localhost.localdomain (c-24-16-167-223.hsd1.wa.comcast.net. [24.16.167.223])
        by smtp.gmail.com with ESMTPSA id x8sm20913155pfp.101.2020.08.09.15.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2020 15:32:28 -0700 (PDT)
From:   YourName <argoz1701@gmail.com>
To:     daniel.m.jordan@oracle.com, vbabka@suse.cz
Cc:     walken@google.com, akpm@linux-foundation.org,
        ldufour@linux.ibm.com, arnd@arndb.de, linux-kernel@vger.kernel.org,
        argoz1701@gmail.com
Subject: [PATCH 2/2] kernel: acct.c: Fixed a coding style issue.
Date:   Sun,  9 Aug 2020 15:32:11 -0700
Message-Id: <20200809223211.18209-1-argoz1701@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel <argoz1701@gmail.com>

Fixed a coding style issue.

Signed-off-by: Daniel West <argoz1701@gmail.com>
---
 kernel/acct.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/acct.c b/kernel/acct.c
index b0c5b3a9f5af..d7cc5f917e11 100644
--- a/kernel/acct.c
+++ b/kernel/acct.c
@@ -451,7 +451,7 @@ static void fill_ac(acct_t *ac)
 	do_div(elapsed, AHZ);
 	btime = ktime_get_real_seconds() - elapsed;
 	ac->ac_btime = clamp_t(time64_t, btime, 0, U32_MAX);
-#if ACCT_VERSION==2
+#if ACCT_VERSION == 2
 	ac->ac_ahz = AHZ;
 #endif
 
-- 
2.25.1

