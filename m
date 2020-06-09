Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D32B9C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 12:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A11AC207C3
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 12:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HNwpo35N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729284AbgFIMhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 08:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbgFIMhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 08:37:54 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E36C05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 05:37:53 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id r7so21149727wro.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 05:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=OaLLq0Ise/Ixh68mcw0GTtKNxRwGdk2haUjNF3bqKfI=;
        b=HNwpo35N2nLW7/U1Bt8WFCrfrSTqRec8P6IWjwqygMhGrq65UWmhQCvCimW7FOwAwg
         K+u8ZdHRg5rIVdj2lfc0RwHdgQKvCpTJJCm1liZr9j9iw+KpWqO3u9u3E7Gw0e3xqDNL
         oyTOWZboTgIfyROMTxeOfqkv7VtMQpdkHh1IHrGBR/DM7MHGoquk3peHUZWo7Yd27bSA
         NFRAodi7s3Jb6xkL3EZDIpOBbLTGDaHzH1Kqg7ja6DODbQMobmoVxS9Q0Q6LmoIRtY4+
         ZYokzYFuj8VkghXEwlNwUoCvdQoV6Gtok2TccfsUS+APVrrF90v3Sfry2/X/++ZThoay
         uEiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OaLLq0Ise/Ixh68mcw0GTtKNxRwGdk2haUjNF3bqKfI=;
        b=lOrOrOV+zVyhA2DZT+8kzPGViZQB9Wrd6Ja2gyKmZuGqYwGRcFoQuRGkeqajehgQpI
         vDT/LucNYCclWRf/F2Y0k5GOVdrwvoeZoc45VCcyjlw5OTdvWInbAgDqL2j/GggZiuJK
         58LVH7WLrf5pBbwmWMbwsjjkuPoEATGU2uDfhenvuXNjG8+MUve8XOpSiVujKz3QEUNo
         tb/hl57ISML4gGK3iyrm51pglbPCZJ4edrP8t9TyF22haGDEULlFnIIy3qHK+XfLeyd4
         TLTJFewbGwIrfCPcWYHXl0uPSJcN0XLGNgiI21SVSW/unPij0MpgTzcAEmxsp5mcQtiH
         1w0A==
X-Gm-Message-State: AOAM532nmf48VVgC6XhXPRSuUelmelkem+fZlOldsDgiWKZzbha9wzwt
        Kq63+TSVicHtfvZ0asDUg39owg==
X-Google-Smtp-Source: ABdhPJwTaFo/vYfA1kqIdHzPagyq68k4h9FO813pZUImWX9Ozn9wns6HdyANurVh6IZNeslWIgDQvQ==
X-Received: by 2002:a05:6000:90:: with SMTP id m16mr4339504wrx.191.1591706271903;
        Tue, 09 Jun 2020 05:37:51 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:85b0:e991:18d8:84fd])
        by smtp.gmail.com with ESMTPSA id w15sm2793199wmk.30.2020.06.09.05.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 05:37:50 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org, iwtbavbm@gmail.com
Cc:     valentin.schneider@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2] sched/fair: fix nohz next idle balance
Date:   Tue,  9 Jun 2020 14:37:48 +0200
Message-Id: <20200609123748.18636-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With commit:
  'b7031a02ec75 ("sched/fair: Add NOHZ_STATS_KICK")'
rebalance_domains of the local cfs_rq happens before others idle cpus have
updated nohz.next_balance and its value is overwritten.

Move the update of nohz.next_balance for other idles cpus before balancing
and updating the next_balance of local cfs_rq.

Also, the nohz.next_balance is now updated only if all idle cpus got a
chance to rebalance their domains and the idle balance has not been aborted
because of new activities on the CPU. In case of need_resched, the idle
load balance will be kick the next jiffie in order to address remaining
ilb.

Reported-by: Peng Liu <iwtbavbm@gmail.com>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---

- Changes v2:
  - use jiffies instead of incrementing nohz.next_balance to be sure of the
    value. The change slipped out of the previous version.

 kernel/sched/fair.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0ed04d2a8959..832164d441dd 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10017,7 +10017,12 @@ static void kick_ilb(unsigned int flags)
 {
 	int ilb_cpu;
 
-	nohz.next_balance++;
+	/*
+	 * Increase nohz.next_balance only when if full ilb is triggered but
+	 * not if we only update stats.
+	 */
+	if (flags & NOHZ_BALANCE_KICK)
+		nohz.next_balance = jiffies+1;
 
 	ilb_cpu = find_new_ilb();
 
@@ -10338,6 +10343,14 @@ static bool _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
 		}
 	}
 
+	/*
+	 * next_balance will be updated only when there is a need.
+	 * When the CPU is attached to null domain for ex, it will not be
+	 * updated.
+	 */
+	if (likely(update_next_balance))
+		nohz.next_balance = next_balance;
+
 	/* Newly idle CPU doesn't need an update */
 	if (idle != CPU_NEWLY_IDLE) {
 		update_blocked_averages(this_cpu);
@@ -10358,14 +10371,6 @@ static bool _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
 	if (has_blocked_load)
 		WRITE_ONCE(nohz.has_blocked, 1);
 
-	/*
-	 * next_balance will be updated only when there is a need.
-	 * When the CPU is attached to null domain for ex, it will not be
-	 * updated.
-	 */
-	if (likely(update_next_balance))
-		nohz.next_balance = next_balance;
-
 	return ret;
 }
 
-- 
2.17.1

