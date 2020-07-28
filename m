Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E3DC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA62E206D4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yQ/T/rub";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z6TLcGAx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729609AbgG1M3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 08:29:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34326 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729299AbgG1M3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 08:29:09 -0400
Date:   Tue, 28 Jul 2020 12:29:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595939347;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k+c/cFf7HdBuEHY51YUiB7FeFng8roSM3NNyIgKHNSY=;
        b=yQ/T/rubqHHj0YHyL8ACAVPSXuMR5MONZkufXtOlfFHGucdQsGdwEWLYuPtQaaOIFXdyc9
        fOlxqGoMywwhvJg6199It7gMBJsQwioNiKWpCWueKSdGO0gmkl6+2lbjRdE3xK5uLi9klt
        x90l9QSCMMM1JYUUChHbfJjBkRexEXv/ryoeiEGMkIirptiy/VFYf2SP/hlHNkVuYnt8eH
        evGZk6kHWcMz+OMvMcOlpsd7Y5SZOfCVN6YfPwZGA/ybC6Gp4BAt3f+JTuGcZomCWtH1xe
        XHH0nKwW2BE1QLnfw/5GAOAi51mQa7toobTPFtVq/Yb4bTZSOpA3lZ0wDwmtKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595939347;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k+c/cFf7HdBuEHY51YUiB7FeFng8roSM3NNyIgKHNSY=;
        b=Z6TLcGAxYJPgLI80lnKOCojcQx1vI6UiCkpvqrd+EOwUi0s+ib+R5aXVhbdU6FQ5OBW2dQ
        1WPk5ncwEyANkSBw==
From:   "tip-bot2 for Miaohe Lin" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Remove duplicated tick_nohz_full_enabled() check
Cc:     Miaohe Lin <linmiaohe@huawei.com>, Ingo Molnar <mingo@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1595935075-14223-1-git-send-email-linmiaohe@huawei.com>
References: <1595935075-14223-1-git-send-email-linmiaohe@huawei.com>
MIME-Version: 1.0
Message-ID: <159593934725.4006.6683440940945012306.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     21a6ee14a8f277766618ef07154432b46528113e
Gitweb:        https://git.kernel.org/tip/21a6ee14a8f277766618ef07154432b46528113e
Author:        Miaohe Lin <linmiaohe@huawei.com>
AuthorDate:    Tue, 28 Jul 2020 19:17:55 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 28 Jul 2020 13:27:54 +02:00

sched: Remove duplicated tick_nohz_full_enabled() check

In sched_update_tick_dependency() there's two calls that check
whether nohz_full is enabled: tick_nohz_full_cpu() does it
implicitly, while there's also an explicit call to tick_nohz_full_enabled().

Remove the duplicated, open coded check.

[ mingo: Amended the changelog. ]

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/1595935075-14223-1-git-send-email-linmiaohe@huawei.com
---
 kernel/sched/sched.h | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 9f33c77..296efd3 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1961,12 +1961,7 @@ extern int __init sched_tick_offload_init(void);
  */
 static inline void sched_update_tick_dependency(struct rq *rq)
 {
-	int cpu;
-
-	if (!tick_nohz_full_enabled())
-		return;
-
-	cpu = cpu_of(rq);
+	int cpu = cpu_of(rq);
 
 	if (!tick_nohz_full_cpu(cpu))
 		return;
