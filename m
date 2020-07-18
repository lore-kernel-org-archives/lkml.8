Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FCAC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 06:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E76F2064B
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 06:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="0Ue1NG4N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgGRGLw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 02:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbgGRGLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 02:11:52 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D403CC0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 23:11:51 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id f16so7331005pjt.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 23:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kZ3lYn4N5LTEVuFwwOCCh5bU3lGrvl/lTLunodGrhio=;
        b=0Ue1NG4Nr/0omehRUoC2r7ZxJlFG3ejDOuCBCzdD8GTf1Tr/wsnwyDHf2MRuHZrz+T
         1I5VOw7h6+aAFYdu8ZrM24c3KdItMC+gkKwxXHN9NYh1gnUkGcb8A83/54jPfL8+Qy9C
         y+PvnYm2HSF8AXNAT69YdmEqYSFrDJErji83dMCIq+yv0IAjs9Th9fXIhNsL6miPZVeK
         lwmjg8H5wBaHGy8v6NYfI2k3IfIuQShDBkq60NSDJdeGMNMn86Zmrbd5lr3qH275WlfA
         Uw04HxKp/x3MlBz5msarWEeKgrnQt+Lah0wAd0WkhmV80NXri1h4aZ5R9wTzxTVZE+bl
         WwLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kZ3lYn4N5LTEVuFwwOCCh5bU3lGrvl/lTLunodGrhio=;
        b=em6y2iTyHoc91OMKXPc687VFhmHoNICWN7V1WeKtZeVJdG8PM56IXauv2O6a8NJFnt
         sn+bcYStpXKKp4A4cKjAZ9TzABCQwZ18PyihIPwmpMFzWe7+wbjgE/XWmkAv1FrdUekD
         8nHU98RvHJrK20OyAVgBGK6cDOzcvVtM05JQfNjl4mL70j+xXsvJN4kQucEPR81Toji1
         S++bASj1tpb/1uNskVvvtpeYB/PNNOpKkHtAw0tdqn14hIRO2bR0XnSCK3Y73HUiJmNN
         eDunM9HPqXijnLcrGOosTfTMYH1riwoBfVtfb6lBF8T9ievuVzeU25RQ41d3grzN6Mvg
         l+PA==
X-Gm-Message-State: AOAM530m0sacYtCNhrRgyqW8QUjgMdTij2mtwQBDEGVJIs4W84DcJvfB
        PsJ+U4Y8A3HgbIyu362QE0CYbQ==
X-Google-Smtp-Source: ABdhPJxZnbHGFB6XrO5/kcADMjEZYbDuFFUgm9060g8U2jrHDepRRKH5fmrNUMyz5Dsb27NXy1nK0Q==
X-Received: by 2002:a17:902:be17:: with SMTP id r23mr10294546pls.284.1595052711196;
        Fri, 17 Jul 2020 23:11:51 -0700 (PDT)
Received: from Smcdef-MBP.lan ([103.136.220.66])
        by smtp.gmail.com with ESMTPSA id c188sm9587828pfc.143.2020.07.17.23.11.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Jul 2020 23:11:50 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     peterz@infradead.org, tglx@linutronix.de, mingo@kernel.org,
        bigeasy@linutronix.de, namit@vmware.com
Cc:     linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2] smp: Fix a potential usage of stale nr_cpus
Date:   Sat, 18 Jul 2020 14:11:44 +0800
Message-Id: <20200718061144.56095-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the cmdline of "nr_cpus" is not valid, the @nr_cpu_ids is assigned
a stale value. The nr_cpus is only valid when get_option() return 1. So
check the return value to prevent this.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
changelog in v2:
 1) Rework the commit log.
 2) Rework the return value check.


 kernel/smp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index a5a66fc28f4e..0bc260158047 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -772,8 +772,8 @@ static int __init nrcpus(char *str)
 {
 	int nr_cpus;
 
-	get_option(&str, &nr_cpus);
-	if (nr_cpus > 0 && nr_cpus < nr_cpu_ids)
+	if ((get_option(&str, &nr_cpus) == 1) &&
+	    nr_cpus > 0 && nr_cpus < nr_cpu_ids)
 		nr_cpu_ids = nr_cpus;
 
 	return 0;
-- 
2.11.0

