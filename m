Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BCCC43461
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 11:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA6D3208B3
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 11:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFL9f+Ru"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbgIFLom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 07:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbgIFLo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 07:44:27 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B23C061573
        for <linux-kernel@vger.kernel.org>; Sun,  6 Sep 2020 04:44:27 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id c2so12814152ljj.12
        for <linux-kernel@vger.kernel.org>; Sun, 06 Sep 2020 04:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wwpbl2l3OHrzIL91Ex4axf5Culwn884/sH5r7StvL0I=;
        b=nFL9f+Ruq/nE1q0Cyj/r8lJyGOgs2H/s8ksZhHmMRgPwU5UFX2B67dJLzwB8AHIC9Q
         ecrb+uUTObtLluKc/ut1fpVcv4Y5p9RnglpeGi82nG+3BBD5w17ZXu9cqrnWVaKhrxEX
         dX4qdTHhadLuocRg6FteHp8+FLf1m/2hKEL2m8naIq3+srH5eTveS0OZC1jzn0FFJrMl
         NVD40V1QakAubQ94WG1DIVUm7+N6HC76w0Nr7pZtudTV5XAMVsoX29OMXlRsK9DmIuwQ
         g2KWGoC0WvEkx3d/FtcFkGhGW0zLGNQXtJ8Qgauxr/YRU9dwUMlfa0MuL8Q9DSXeeGAd
         nCVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wwpbl2l3OHrzIL91Ex4axf5Culwn884/sH5r7StvL0I=;
        b=lLbyxP6X0vtgaDhjRSwehBsYh8JZ+R1asgAhL0wJnZeD4vW4YnH43CKnvsmWwNTL4M
         g6a42DYTKVe/DEnaw0UnNALzfDrjIxSi+5QymGbtk5GfQ95IXwP6M3EXLUHCNEGTJdkF
         l9BSygxFQw+Z6G1NmATERKf6MoXR2gbjuFGbce4wSly4qg3/Ju/TJA5ROvcwrTcN/RQt
         emq7krruti2NlA7Pz3Zoupb47V4gw2YcuAxTnqoie0oqv/QosnicSPxqQu7DUyhN5+aR
         UPoslaYUD8tIgPZKnN+X87w16LoIlHkIMozKkkpWwFtH+tZ+cyyGmVoDRRW7cmkK69TT
         O32Q==
X-Gm-Message-State: AOAM532vJeaVXWkz2DE4DHYyyoNPXGUb6FYXt5bIsS7jobS2XQoVL7/S
        DV7n6hzDnXt27BafH1TfrAS33S/Oyvw=
X-Google-Smtp-Source: ABdhPJxcRambJVutqGscXflSXaM1rGPnz8BaIaQn1d5QOcqcn/CNom+aDwOvTrdCg0requTVsLG/FQ==
X-Received: by 2002:a2e:920f:: with SMTP id k15mr8201163ljg.353.1599392659471;
        Sun, 06 Sep 2020 04:44:19 -0700 (PDT)
Received: from localhost.localdomain (188.147.111.252.nat.umts.dynamic.t-mobile.pl. [188.147.111.252])
        by smtp.gmail.com with ESMTPSA id l14sm1452779lji.99.2020.09.06.04.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2020 04:44:18 -0700 (PDT)
From:   mateusznosek0@gmail.com
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Mateusz Nosek <mateusznosek0@gmail.com>, akpm@linux-foundation.org
Subject: [PATCH] mm/mmu_notifier.c: micro-optimization substitute kzalloc with kmalloc
Date:   Sun,  6 Sep 2020 13:43:21 +0200
Message-Id: <20200906114321.16493-1-mateusznosek0@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mateusz Nosek <mateusznosek0@gmail.com>

Most fields in struct pointed by 'subscriptions' are initialized explicitly
after the allocation. By changing kzalloc to kmalloc the call to memset
is avoided. As the only new code consists of 2 simple memory accesses,
the performance is increased.

Signed-off-by: Mateusz Nosek <mateusznosek0@gmail.com>
---
 mm/mmu_notifier.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
index 4fc918163dd3..190e198dc5be 100644
--- a/mm/mmu_notifier.c
+++ b/mm/mmu_notifier.c
@@ -625,7 +625,7 @@ int __mmu_notifier_register(struct mmu_notifier *subscription,
 		 * know that mm->notifier_subscriptions can't change while we
 		 * hold the write side of the mmap_lock.
 		 */
-		subscriptions = kzalloc(
+		subscriptions = kmalloc(
 			sizeof(struct mmu_notifier_subscriptions), GFP_KERNEL);
 		if (!subscriptions)
 			return -ENOMEM;
@@ -636,6 +636,8 @@ int __mmu_notifier_register(struct mmu_notifier *subscription,
 		subscriptions->itree = RB_ROOT_CACHED;
 		init_waitqueue_head(&subscriptions->wq);
 		INIT_HLIST_HEAD(&subscriptions->deferred_list);
+		subscriptions->active_invalidate_ranges = 0;
+		subscriptions->has_itree = false;
 	}
 
 	ret = mm_take_all_locks(mm);
-- 
2.20.1

