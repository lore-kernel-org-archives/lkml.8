Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A12C0C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 01:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67FB520719
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 01:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594085597;
	bh=UogAco9ta0WJk43bNzsuzyB1AsXk0IHvfcexwJ/oSds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JDLXzQ26X/zrXZ17A0FqGPVRTk2pFB+vkYpVDLZ/dKTOhBv5A+fInoP7CkMxG8gKG
	 N2K2bsLpwEnsacd7yOHOWkUf7pYW8WQ8Feh+YZAXBJHJT5UiMXGE9Vpve1juxdvfXS
	 9o0uupxNnCdKkm0p5vgkQKxt4W+1WGSoJPAtJJtc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgGGBdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 21:33:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:38598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727891AbgGGBdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 21:33:09 -0400
Received: from lenoir.home (lfbn-ncy-1-317-216.w83-196.abo.wanadoo.fr [83.196.152.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D51120719;
        Tue,  7 Jul 2020 01:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594085589;
        bh=UogAco9ta0WJk43bNzsuzyB1AsXk0IHvfcexwJ/oSds=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=USNXXaTR/with0/E2Nmkdm7TIiDdZlwDnkhVSCjw2Q+P6oITf3k+47CgzqW9fwBLk
         QykWevpgGgEbAGePddZ2Hgx/cBx+pYBD+n42I2/9KXtVFt8iZ8Cr3d2NTJ+qsr4OnB
         kjhr5T6YtGjPw3gW+F79vhWD8TUJl6aLTxr569oU=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH 2/9] timer: Add comments about calc_index() ceiling work
Date:   Tue,  7 Jul 2020 03:32:46 +0200
Message-Id: <20200707013253.26770-3-frederic@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200707013253.26770-1-frederic@kernel.org>
References: <20200707013253.26770-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

calc_index() adds 1 unit of the level granularity to the expiry passed
in parameter to ensure that the timer doesn't expire too early. Add a
comment to explain that and the resulting layout in the wheel.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Anna-Maria Gleixner <anna-maria@linutronix.de>
Cc: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/time/timer.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 4c977df3610b..ae1259f67486 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -156,7 +156,8 @@ EXPORT_SYMBOL(jiffies_64);
 
 /*
  * The time start value for each level to select the bucket at enqueue
- * time.
+ * time. We start from the last possible delta of the previous level
+ * so that we can later add an extra LVL_GRAN(n) to n (see calc_index()).
  */
 #define LVL_START(n)	((LVL_SIZE - 1) << (((n) - 1) * LVL_CLK_SHIFT))
 
@@ -489,6 +490,13 @@ static inline void timer_set_idx(struct timer_list *timer, unsigned int idx)
  */
 static inline unsigned calc_index(unsigned expires, unsigned lvl)
 {
+	/*
+	 * Time may have past since the clock last reached an index of
+	 * this @lvl. And that time, below LVL_GRAN(@lvl), is going to
+	 * be substracted from the delta until we reach @expires. To
+	 * fix that we must add one level granularity unit to make sure
+	 * we rather expire late than early. Prefer ceil over floor.
+	 */
 	expires = (expires + LVL_GRAN(lvl)) >> LVL_SHIFT(lvl);
 	return LVL_OFFS(lvl) + (expires & LVL_MASK);
 }
-- 
2.26.2

