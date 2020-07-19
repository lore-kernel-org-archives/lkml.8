Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00339C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 12:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D035C207DD
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 12:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Ydea2avL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgGSMXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 08:23:55 -0400
Received: from m12-12.163.com ([220.181.12.12]:44173 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726021AbgGSMXz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 08:23:55 -0400
X-Greylist: delayed 2708 seconds by postgrey-1.27 at vger.kernel.org; Sun, 19 Jul 2020 08:23:51 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=euji8
        3kgaRZ1o5ZfGEIqaM5nKxpg0EB9wV1jv0YgH7w=; b=Ydea2avLlvl0mS1ydElyA
        r0Jxm0kC2nwrW9KyJUvcGqu9lulRCwcC3G/tBELk1Iahkaxw7UI61SwR3NnMso4H
        9X0bD+0kAiG8V5wyGD83ruW43ASvYtUk9oEko0biMWUyVCfent+XY8NBB+ydSiUT
        CiQ+IexfPbfw5hTMf550F8=
Received: from localhost.localdomain (unknown [125.82.8.121])
        by smtp8 (Coremail) with SMTP id DMCowAA3NS1iJRRfAc7rEg--.39456S4;
        Sun, 19 Jul 2020 18:50:14 +0800 (CST)
From:   Hu Haowen <xianfengting221@163.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org
Cc:     tglx@linutronix.de, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, notify@kernel.org,
        Hu Haowen <xianfengting221@163.com>
Subject: [PATCH] x86/perf: Fix a typo
Date:   Sun, 19 Jul 2020 18:50:07 +0800
Message-Id: <20200719105007.57649-1-xianfengting221@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DMCowAA3NS1iJRRfAc7rEg--.39456S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7JrWxJry5XFWkGFWUtFyfXrb_yoWxAFg_A3
        W8JayDZr1Fy3s2q395uay5t3Z3A3yFvw45Gr4fAFyUt345t3W5CFyUWwsak345WF9xZrWI
        yFZ3KFyYqw13ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRNFAp7UUUUU==
X-Originating-IP: [125.82.8.121]
X-CM-SenderInfo: h0ld0wxhqj3xtqjsjii6rwjhhfrp/xtbBDwBZAFPAMoZQfAABsc
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The word "Zhoaxin" is incorrect and the right one is "Zhaoxin".

Signed-off-by: Hu Haowen <xianfengting221@163.com>
---
 arch/x86/events/zhaoxin/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/zhaoxin/core.c b/arch/x86/events/zhaoxin/core.c
index 898fa1ae9ceb..e68827e604ad 100644
--- a/arch/x86/events/zhaoxin/core.c
+++ b/arch/x86/events/zhaoxin/core.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Zhoaxin PMU; like Intel Architectural PerfMon-v2
+ * Zhaoxin PMU; like Intel Architectural PerfMon-v2
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-- 
2.25.1


