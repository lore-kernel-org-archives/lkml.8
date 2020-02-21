Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B19F1C35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E78A206EF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbgBUPvv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 10:51:51 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:57477 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728379AbgBUPvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 10:51:51 -0500
Received: from [82.43.126.140] (helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1j5Aag-0002bW-73; Fri, 21 Feb 2020 15:51:46 +0000
From:   Colin King <colin.king@canonical.com>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] lib/test_lockup: fix spelling mistake "iteraions" -> "iterations"
Date:   Fri, 21 Feb 2020 15:51:45 +0000
Message-Id: <20200221155145.79522-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a pr_notice message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 lib/test_lockup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_lockup.c b/lib/test_lockup.c
index f91cd44ad75a..b45afd3ad7cb 100644
--- a/lib/test_lockup.c
+++ b/lib/test_lockup.c
@@ -490,7 +490,7 @@ static int __init test_lockup_init(void)
 		return -EINVAL;
 	}
 
-	pr_notice("START pid=%d time=%u +%u ns cooldown=%u +%u ns iteraions=%u state=%s %s%s%s%s%s%s%s%s%s%s%s\n",
+	pr_notice("START pid=%d time=%u +%u ns cooldown=%u +%u ns iterations=%u state=%s %s%s%s%s%s%s%s%s%s%s%s\n",
 		  main_task->pid, time_secs, time_nsecs,
 		  cooldown_secs, cooldown_nsecs, iterations, state,
 		  all_cpus ? "all_cpus " : "",
-- 
2.25.0

