Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2259C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 19:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FC7A207BC
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 19:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="cIXAUZoE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729424AbgGPTjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 15:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728788AbgGPTjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 15:39:20 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C55FC061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 12:39:20 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id n5so5355868pgf.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 12:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=subject:date:message-id:mime-version:content-transfer-encoding:cc
         :from:to;
        bh=jFw/ClOpq5T+sEE+HkoHP8FUQXO2g2TMYTCx3LN9u+U=;
        b=cIXAUZoEl+VbWqI+bWZ6UNd/b6CjlQlebzn7F51ygg732VKsNUyl7DvsnIq/q8CnRD
         MWyO5PEAVK+AkyuS5IIP160Qpqg2RwaJbiuHaOqIGaOUrKwLZjyuK6YPwi3I3c9OqjPX
         uxs4LYz/vya0GQfg8gs6V7ZoR51P/Vj9BNpDc7Q/ocU7sDI+m+K1wqHn6n/tbTWPr2kl
         CJXmyuKlnDiQDAXaXdlljeJaPSGAfOvtQS3iU3y20mg5hEoBJ0exCxREj9zx5TbYnuhl
         21YpvR8/8GOndAJMOSKUAdZD2btafq3qF0kFteV1b9ieb06F9FRiy+fJiW/DOY6PNdcv
         fjNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=jFw/ClOpq5T+sEE+HkoHP8FUQXO2g2TMYTCx3LN9u+U=;
        b=rTXUlwRdVguvENdh+1tQk9L/mIF1gDf+10uyEbF4/yDjhy/LTkb0Xe2bS/ayNP0vi1
         BMIS600FCBV9ykxGrbAHSqALr33nXQio+drzbb7wQkeqzspxJ+QNrmfwfzEXlxjD8rsL
         ylHGSu2PcBfn9x/G8wtGfyf17A0yNA51UFvZ4x1nThSgIgm6iDot/w/WRvknYc1w9z6B
         EJANuxpztcfjsPtA25D3AQaoT9v1sa0oZaN0Bx2l7SpOUZmAOK0eI5GtzNtDjMNzIqvs
         FCXY40Fkq83kqbb72e0SJVS48BaFZMMt0qNwq+4+EChaWhktKDVhofFnK4Ax8rOJBiFR
         xb2Q==
X-Gm-Message-State: AOAM530ekiii3W+dUU8i0dnjkT8Oq7+svmUZD62BIlgmgrFQjpUM/mxn
        K6rg5BuWQIGoGZaM68GqL+muzw==
X-Google-Smtp-Source: ABdhPJzVTejMe5736mG+GTa4x+WLCBZjws2DJXmE8I5MCTTJ/dLjlEKKrmiobrsE6CR38PDoJ0gZig==
X-Received: by 2002:a63:7e55:: with SMTP id o21mr5702707pgn.263.1594928359698;
        Thu, 16 Jul 2020 12:39:19 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id 129sm5351398pfv.161.2020.07.16.12.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 12:39:19 -0700 (PDT)
Subject: [PATCH] powerpc/64: Fix an out of date comment about MMIO ordering
Date:   Thu, 16 Jul 2020 12:38:20 -0700
Message-Id: <20200716193820.1141936-1-palmer@dabbelt.com>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        npiggin@gmail.com, msuchanek@suse.de, tglx@linutronix.de,
        bigeasy@linutronix.de, jniethe5@gmail.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Palmer Dabbelt <palmerdabbelt@google.com>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Will Deacon <willdeacon@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmerdabbelt@google.com>

This primitive has been renamed, but because it was spelled incorrectly in the
first place it must have escaped the fixup patch.  As far as I can tell this
logic is still correct: smp_mb__after_spinlock() uses the default smp_mb()
implementation, which is "sync" rather than "hwsync" but those are the same
(though I'm not that familiar with PowerPC).

Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 arch/powerpc/kernel/entry_64.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index b3c9f15089b6..7b38b4daca93 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -357,7 +357,7 @@ _GLOBAL(_switch)
 	 * kernel/sched/core.c).
 	 *
 	 * Uncacheable stores in the case of involuntary preemption must
-	 * be taken care of. The smp_mb__before_spin_lock() in __schedule()
+	 * be taken care of. The smp_mb__after_spinlock() in __schedule()
 	 * is implemented as hwsync on powerpc, which orders MMIO too. So
 	 * long as there is an hwsync in the context switch path, it will
 	 * be executed on the source CPU after the task has performed
-- 
2.28.0.rc0.105.gf9edc3c819-goog

