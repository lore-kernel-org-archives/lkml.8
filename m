Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF4BC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 15:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A9AC20658
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 15:03:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dbr3n6KV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgHMPDX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 11:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgHMPDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 11:03:22 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B76AC061757
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 08:03:22 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id u20so2963544pfn.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 08:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=flRsMXdeBdSKDUxyg/InWWvpY3aQexhxVV4OIDx99vs=;
        b=Dbr3n6KVHhPfrH6D/xgVwc0ZnBCYg2fepf9NzWSgU2YUZ/WIX1cBD4/LRctqOwpSsd
         5/BK4ix3zDKoUMwo/wymFWreZQzGQdMlS6cMXTj5P4IELrn7orS9r8sCLvep/PkxRtuG
         0cJ5JsZKP6csY4Y/KSmEgLHXE4E8Q9G6FnADD1Mks7tE+ceLi9GvGdSEGcMDFodJvfeA
         hwsdZFkdQ1T5k2l3jSogthX5RX9vbFUzHXJsOASwICUxPeY4kXvdt4Zhsq2IWG2Xln+X
         4S+c4bcUcZVwnv2Tsw4R8acV9PmXqDaHDy/JQMNaTKilye9fBatceD5ofUyMaoRkbZxV
         XFqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=flRsMXdeBdSKDUxyg/InWWvpY3aQexhxVV4OIDx99vs=;
        b=L8SGag882L/XFB02Us9R2N89b3aItKUajsgGG2zbErXsOSguJ+a95jge8rrG5TUbqv
         J5Xb155x7Rm8kLXd/Ef5oeXyt3iuiqTxvU8J3BndWG6xo5o+AY/bU16qq2LaL6Di4Vn4
         PTYS2+GBj2Y5RZ7ZCNqzJkB414R2ETPs0+l67k4FGHdw72w4tTXAd+leb+MPicqk51af
         W+VXEzGU1kgMCcqdQhd7p+6jgtuA6aE3xHpY3X2LDGqFT00QwuMImxRLCu2ANmEq8kio
         Btz2Y8a72bf7KTkOvRu0jv2p+iN6hBNOse4mc5w5nBI6db7nrGJRXnM3F4r6jn74/3KH
         VhCg==
X-Gm-Message-State: AOAM5317b1561dBq/hRV964Jrr3BvGPbygqIxnXlT990zU4k+IO44fzy
        9pDY+sqEqWvx8ZZRrxgxpLE=
X-Google-Smtp-Source: ABdhPJz+jpFmpvy0W8eSDKTICGGE/6Qr6w9pWwBx8Kh48qmYx1tvObLODlR6Tmc2n5GPTLFbXBDIVQ==
X-Received: by 2002:a65:52c3:: with SMTP id z3mr4105322pgp.417.1597331002054;
        Thu, 13 Aug 2020 08:03:22 -0700 (PDT)
Received: from builder-PowerEdge-R730xd.mioffice.cn ([209.9.72.212])
        by smtp.gmail.com with ESMTPSA id x6sm6241114pfd.53.2020.08.13.08.03.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Aug 2020 08:03:21 -0700 (PDT)
From:   Qianli Zhao <zhaoqianligood@gmail.com>
To:     tglx@linutronix.de, john.stultz@linaro.org, sboyd@kernel.org
Cc:     linux-kernel@vger.kernel.org, zhaoqianli@xiaomi.com
Subject: [PATCH v2] timer: Mask illegal set of flags in do_init_timer()
Date:   Thu, 13 Aug 2020 23:03:14 +0800
Message-Id: <9d79a8aa4eb56713af7379f99f062dedabcde140.1597326756.git.zhaoqianli@xiaomi.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qianli Zhao <zhaoqianli@xiaomi.com>

do_init_timer() can specify flags of timer_list,
only TIMER_DEFFERABLE, TIMER_PINNED, TIMER_IRQSAFE are legal
do a sanity check, mask and warning illegal set of flags

Signed-off-by: Qianli Zhao <zhaoqianli@xiaomi.com>
---
V2:
- update changelog
- mask and warning illegal set
---
 include/linux/timer.h | 1 +
 kernel/time/timer.c   | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/include/linux/timer.h b/include/linux/timer.h
index 07910ae..d10bc7e 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -67,6 +67,7 @@ struct timer_list {
 #define TIMER_DEFERRABLE	0x00080000
 #define TIMER_PINNED		0x00100000
 #define TIMER_IRQSAFE		0x00200000
+#define TIMER_INIT_FLAGS	(TIMER_DEFERRABLE | TIMER_PINNED | TIMER_IRQSAFE)
 #define TIMER_ARRAYSHIFT	22
 #define TIMER_ARRAYMASK		0xFFC00000
 
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 026ac01..f7398ab 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -789,6 +789,8 @@ static void do_init_timer(struct timer_list *timer,
 {
 	timer->entry.pprev = NULL;
 	timer->function = func;
+	if (WARN_ON(flags & ~TIMER_INIT_FLAGS))
+		flags &= TIMER_INIT_FLAGS;
 	timer->flags = flags | raw_smp_processor_id();
 	lockdep_init_map(&timer->lockdep_map, name, key, 0);
 }
-- 
2.7.4

