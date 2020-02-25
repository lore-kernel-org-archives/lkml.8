Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2D6C35E01
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 16:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E9E921744
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 16:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="k1+ezj5+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730966AbgBYQ1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 11:27:23 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:36742 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728981AbgBYQ1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 11:27:23 -0500
Received: by mail-qv1-f67.google.com with SMTP id ff2so5955718qvb.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 08:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=UczzY+rp2tdgdnjm5aLeQ6/QOOsxN43LUoYzAEGH14I=;
        b=k1+ezj5+qh95oBjkG992zOsBdMreTJYZIl9y+oA/Il6YIuVM5UCWD0Oqbho2I8wBSZ
         RrOoqtfzxA9fd86cJZAseh0TytuSAazFovVzoLZzp26+ocbEBAmndk6ymmW7rOCnjOil
         c7ObW3x5LeLQ6Pgz7/0UiHxU7xcy2Fzi4jJbrvZh2hxkGxNbs0rmto5ZSGcflQJkOgQn
         Z86e8jyy9dh8rcKbkNPbgcKuUy12qDT2iEPGh3QIJ01BLHKCu8QCYZge7t4DImQbMroe
         KdR10yWzIKzVKSW4Fs6KeNE21Lnqe5/ZnXmIlGHYMNVYY/f6IcC7Y6vcaeUxUqg2ziHn
         bBAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UczzY+rp2tdgdnjm5aLeQ6/QOOsxN43LUoYzAEGH14I=;
        b=gUVQ5wEKte3vC9fFdCiZOCiRwQuGaNrNCZu9jOVk6/mGCqrZbfKkrb/gWhtn230RoF
         6UBg5zDMpWvf3HSheZ2XajlzN46CEmlibcyYhQrj7CdhfWN5lgvR+VKlCaQHrGLsRJ/q
         NjdsmXhpI4QrXxWOQpWQdB7/no++L5zznKGgdOfEUIUg0kD/WFAIOkZoXH3wSnQBhEt+
         wBTgwg1XARMD5QJim9C1xNusVFiNSU8QSspmWjvAchWi71uVVQ9OeiV/sCy76b4e7abW
         gR3rArechwKmHKNx62VLKPHQHjp07Z7Qm/mLfrG00bQYabyt/OHKQ+nUZ2rcrjwfHWT5
         4ybw==
X-Gm-Message-State: APjAAAWagWdSAtc0x5IRibQ9cJQ9J32QvV8+i/5rX00FbSBkQMWkHKef
        2H/5AQBs/dIm9SMqdsEvKWXz/A==
X-Google-Smtp-Source: APXvYqxjxB1N8+QHBiY+ynKegV/DtLZk8mWmb8XnOiqId3C7KO/w3gasGLnW7YDFQbYdeJZ3o2jQwQ==
X-Received: by 2002:a0c:e4c1:: with SMTP id g1mr52605297qvm.45.1582648042581;
        Tue, 25 Feb 2020 08:27:22 -0800 (PST)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id z34sm7739351qtd.42.2020.02.25.08.27.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Feb 2020 08:27:21 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     tytso@mit.edu
Cc:     elver@google.com, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] char/random: fix data races at timer_rand_state
Date:   Tue, 25 Feb 2020 11:27:04 -0500
Message-Id: <1582648024-13111-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fields in "struct timer_rand_state" could be accessed concurrently.
Lockless plain reads and writes result in data races. Fix them by adding
pairs of READ|WRITE_ONCE(). The data races were reported by KCSAN,

 BUG: KCSAN: data-race in add_timer_randomness / add_timer_randomness

 write to 0xffff9f320a0a01d0 of 8 bytes by interrupt on cpu 22:
  add_timer_randomness+0x100/0x190
  add_timer_randomness at drivers/char/random.c:1152
  add_disk_randomness+0x85/0x280
  scsi_end_request+0x43a/0x4a0
  scsi_io_completion+0xb7/0x7e0
  scsi_finish_command+0x1ed/0x2a0
  scsi_softirq_done+0x1c9/0x1d0
  blk_done_softirq+0x181/0x1d0
  __do_softirq+0xd9/0x57c
  irq_exit+0xa2/0xc0
  do_IRQ+0x8b/0x190
  ret_from_intr+0x0/0x42
  cpuidle_enter_state+0x15e/0x980
  cpuidle_enter+0x69/0xc0
  call_cpuidle+0x23/0x40
  do_idle+0x248/0x280
  cpu_startup_entry+0x1d/0x1f
  start_secondary+0x1b2/0x230
  secondary_startup_64+0xb6/0xc0

 no locks held by swapper/22/0.
 irq event stamp: 32871382
 _raw_spin_unlock_irqrestore+0x53/0x60
 _raw_spin_lock_irqsave+0x21/0x60
 _local_bh_enable+0x21/0x30
 irq_exit+0xa2/0xc0

 read to 0xffff9f320a0a01d0 of 8 bytes by interrupt on cpu 2:
  add_timer_randomness+0xe8/0x190
  add_disk_randomness+0x85/0x280
  scsi_end_request+0x43a/0x4a0
  scsi_io_completion+0xb7/0x7e0
  scsi_finish_command+0x1ed/0x2a0
  scsi_softirq_done+0x1c9/0x1d0
  blk_done_softirq+0x181/0x1d0
  __do_softirq+0xd9/0x57c
  irq_exit+0xa2/0xc0
  do_IRQ+0x8b/0x190
  ret_from_intr+0x0/0x42
  cpuidle_enter_state+0x15e/0x980
  cpuidle_enter+0x69/0xc0
  call_cpuidle+0x23/0x40
  do_idle+0x248/0x280
  cpu_startup_entry+0x1d/0x1f
  start_secondary+0x1b2/0x230
  secondary_startup_64+0xb6/0xc0

 no locks held by swapper/2/0.
 irq event stamp: 37846304
 _raw_spin_unlock_irqrestore+0x53/0x60
 _raw_spin_lock_irqsave+0x21/0x60
 _local_bh_enable+0x21/0x30
 irq_exit+0xa2/0xc0

 Reported by Kernel Concurrency Sanitizer on:
 Hardware name: HP ProLiant BL660c Gen9, BIOS I38 10/17/2018

Signed-off-by: Qian Cai <cai@lca.pw>
---
 drivers/char/random.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index c7f9584de2c8..85cabb17b23f 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1142,14 +1142,14 @@ static void add_timer_randomness(struct timer_rand_state *state, unsigned num)
 	 * We take into account the first, second and third-order deltas
 	 * in order to make our estimate.
 	 */
-	delta = sample.jiffies - state->last_time;
-	state->last_time = sample.jiffies;
+	delta = sample.jiffies - READ_ONCE(state->last_time);
+	WRITE_ONCE(state->last_time, sample.jiffies);
 
-	delta2 = delta - state->last_delta;
-	state->last_delta = delta;
+	delta2 = delta - READ_ONCE(state->last_delta);
+	WRITE_ONCE(state->last_delta, delta);
 
-	delta3 = delta2 - state->last_delta2;
-	state->last_delta2 = delta2;
+	delta3 = delta2 - READ_ONCE(state->last_delta2);
+	WRITE_ONCE(state->last_delta2, delta2);
 
 	if (delta < 0)
 		delta = -delta;
-- 
1.8.3.1

