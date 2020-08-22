Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 986E2C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 03:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F71220720
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 03:01:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="tgClPK1v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgHVDBH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 23:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbgHVDBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 23:01:06 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26787C061573
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 20:01:06 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 128so1882679pgd.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 20:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mVZTkPEJAbkMow8+xSsw2M+mjtxCxRp1/VEzRBh0XoQ=;
        b=tgClPK1vh0K3u15mv1CBJw21tL1i51GLP87zdtXJOaFZVMDaAMeky+19RtOvezDxT1
         vV7xxzI2xnmnKc84MxnkuBe1cD/P/mHTr0IY5nJZyXE6JSiQ3yOBzjZAvcYa7XNwQG/U
         61Hn45r5sNMi7eUcpZS0MnP7tUUUjb6REQLK7wookfhJ/46QX5n2qsc4vKbtGSexm0wO
         tAuSYqrIIgURjpmyfGj365DdRXaM1DfwUI3I1Z1pcP6sgI//HOUtRIKPW63lwUtAShFP
         oGrTW+1kvOaeUQckCCFEOYgTUXm433Fer1HIez6ShmwLLXh6etFow97e4WSxKjGty0Hg
         Xt4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mVZTkPEJAbkMow8+xSsw2M+mjtxCxRp1/VEzRBh0XoQ=;
        b=KdVT0JnXxdva4xxOLvPhGRmjOhCfFXPcJMFf6eOM/kQCYsBhDd8H7QrVTcVLsopTV2
         5f6qHTgoLAbQlbQvAWkrKfn+aPPSujjYLaa37p4AGy101gHDTyQTjAgujYBsEIWk3Dor
         sF0q5yEio5Hd8l6TmtfZE6BzQ4asw9nRYMhsHf8BzX2657NwznL4Bz4rGzQguz5/DnYB
         lIGLasTGPx9A1NRzM6uHT6hkg+QeVRlsyvIm54AtFXTNk0LpHngxvfP5u3y1H0ohrppw
         FRHyWMQnqIxKN202HxD3ZDLSTHtoBGQ6iIfrLjvFtLePOVvUHzV3szSk/JL0CsaYCt3W
         6KVg==
X-Gm-Message-State: AOAM530dGcdGoTp6FYZar3cho1KdK1lOYUU7Lm8ob5TJdH8ZGzvlXFao
        XuRHzH8FfN5usfZ49gyyK8lVIA==
X-Google-Smtp-Source: ABdhPJzpU43H0DVz9h9ne02oLWY21Hw/UbNCS8CHzZJvX8l5JZ2mON9CoGuhTc57qSaVH5B+sBe8jQ==
X-Received: by 2002:a65:669a:: with SMTP id b26mr4198698pgw.418.1598065265567;
        Fri, 21 Aug 2020 20:01:05 -0700 (PDT)
Received: from localhost.localdomain ([103.136.221.72])
        by smtp.gmail.com with ESMTPSA id y1sm4257416pfr.207.2020.08.21.20.01.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Aug 2020 20:01:05 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, mhiramat@kernel.org, songliubraving@fb.com
Cc:     linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v2] kprobes: Fix kill kprobe which has been marked as gone
Date:   Sat, 22 Aug 2020 11:00:55 +0800
Message-Id: <20200822030055.32383-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a kprobe is marked as gone, we should not kill it again. Otherwise,
we can disarm the kprobe more than once. In that case, the statistics
of kprobe_ftrace_enabled can unbalance which can lead to that kprobe
do not work.

Fixes: e8386a0cb22f ("kprobes: support probing module __exit function")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Co-developed-by: Chengming Zhou <zhouchengming@bytedance.com>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
---
changelogs in v2:
 1. Add a WARN_ON_ONCE in the kill_kprobe() to catch incorrect use of it.
 2. Update 'Fixes' tag in the commmit log.

 kernel/kprobes.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index d36e2b017588..9348b0c36ae0 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2143,6 +2143,9 @@ static void kill_kprobe(struct kprobe *p)
 
 	lockdep_assert_held(&kprobe_mutex);
 
+	if (WARN_ON_ONCE(kprobe_gone(p)))
+		return;
+
 	p->flags |= KPROBE_FLAG_GONE;
 	if (kprobe_aggrprobe(p)) {
 		/*
@@ -2422,7 +2425,10 @@ static int kprobes_module_callback(struct notifier_block *nb,
 	mutex_lock(&kprobe_mutex);
 	for (i = 0; i < KPROBE_TABLE_SIZE; i++) {
 		head = &kprobe_table[i];
-		hlist_for_each_entry(p, head, hlist)
+		hlist_for_each_entry(p, head, hlist) {
+			if (kprobe_gone(p))
+				continue;
+
 			if (within_module_init((unsigned long)p->addr, mod) ||
 			    (checkcore &&
 			     within_module_core((unsigned long)p->addr, mod))) {
@@ -2439,6 +2445,7 @@ static int kprobes_module_callback(struct notifier_block *nb,
 				 */
 				kill_kprobe(p);
 			}
+		}
 	}
 	if (val == MODULE_STATE_GOING)
 		remove_module_kprobe_blacklist(mod);
-- 
2.11.0

