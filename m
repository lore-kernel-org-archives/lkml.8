Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFFEC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 09:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15F4B206F7
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 09:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codeblueprint-co-uk.20150623.gappssmtp.com header.i=@codeblueprint-co-uk.20150623.gappssmtp.com header.b="JeDpPAtu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbgDGJyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 05:54:24 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38553 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728143AbgDGJyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 05:54:23 -0400
Received: by mail-wm1-f68.google.com with SMTP id f20so1139216wmh.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 02:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeblueprint-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=8/bdQL/GmPPxSd9AJZqtaufR2ST8hYg8tzUWt1zLb48=;
        b=JeDpPAtufPkXqiPpvE1eHc7+VencpjO1K8RLp7VOkYOnbizQAqNmBqpX6SLW6rhYHy
         ceXIGZJskMf/nWZcL4RDcmgqx+DG2+R1Isy5Dm+cD4l0bUiAME3mGQXxQfDB8uNlinkF
         YPuLM8DAQqjLJcrjW70Jq1jtROQ1qHVFOZ8Idb7eaIHbV+j/B9zHbIBuCKZtELI/xHzc
         DQHqFIB1etUTTF4UwsN1QkTqkh1R/sxCiX8mqYbwTLUMzEo5mx8r9hR8cpHtkPBRzZ6M
         n4qGATH/lnV1UqtQvST+KJVNnKkvomYd/iPg3RiFHuv7rFXKb5dBG9gZN3kSqg7kOqVk
         ha8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8/bdQL/GmPPxSd9AJZqtaufR2ST8hYg8tzUWt1zLb48=;
        b=KcAuVFPLiYneChqRko7PUqy54LteLVwqVfkdi9KVhjxHhjEEnqT3LAhFS2Xd6Ks6Kt
         oboaSNbodN+SI7ty39+neoIarou4B4jBRE4GqDFOK2QXWzFwyQ6eXJae/DyI/53YpVQK
         G8JOhjk4KUPg3uU982BPIs7S9GJYiF/rrEP+KHPN437EXH1Y0M4L47fWoBAu1EBxOJ4y
         DMIhxbUFDnlBgT+6B+gr7LPzJOawlgMQkrt2BkSkyOX20+wJYH0CeO9/OJj2Y4QEbdWQ
         bywMRTBGkvfS5ru36a6iHQYia9BUfhSwAZFKVrYnn1cCMNduxX1vdSZt0gm3n6tt0x2o
         ktlQ==
X-Gm-Message-State: AGi0PubU/Fym1I2Icddq/eo5PiOdS1m2uoGXBS4xsOSj72WfeIzurfU7
        xB9zPrlNRNG6fFqbtuAQd+Fr2Q==
X-Google-Smtp-Source: APiQypI+HFqQl1kgTxDgY5zvNo5sadaklQK60WPZtGE9G2DqDhArmyObDdOTxgfZCBXkDWVgChAM6A==
X-Received: by 2002:a7b:c343:: with SMTP id l3mr1602706wmj.38.1586253261817;
        Tue, 07 Apr 2020 02:54:21 -0700 (PDT)
Received: from localhost (bcde70f4.skybroadband.com. [188.222.112.244])
        by smtp.gmail.com with ESMTPSA id n11sm33168582wrg.72.2020.04.07.02.54.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Apr 2020 02:54:21 -0700 (PDT)
From:   Matt Fleming <matt@codeblueprint.co.uk>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Wagner <wagi@monom.org>,
        Matt Fleming <matt@codeblueprint.co.uk>
Subject: [PATCH RT] signal: Prevent double-free of user struct
Date:   Tue,  7 Apr 2020 10:54:13 +0100
Message-Id: <20200407095413.30039-1-matt@codeblueprint.co.uk>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The way user struct reference counting works changed significantly with,

  fda31c50292a ("signal: avoid double atomic counter increments for user accounting")

Now user structs are only freed once the last pending signal is
dequeued. Make sigqueue_free_current() follow this new convention to
avoid freeing the user struct multiple times and triggering this
warning:

 refcount_t: underflow; use-after-free.
 WARNING: CPU: 0 PID: 6794 at lib/refcount.c:288 refcount_dec_not_one+0x45/0x50
 Call Trace:
  refcount_dec_and_lock_irqsave+0x16/0x60
  free_uid+0x31/0xa0
  ? schedule_hrtimeout_range_clock+0x104/0x110
  __dequeue_signal+0x17c/0x190
  dequeue_signal+0x5a/0x1b0
  do_sigtimedwait+0x208/0x250
  __x64_sys_rt_sigtimedwait+0x6f/0xd0
  do_syscall_64+0x72/0x200
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Signed-off-by: Matt Fleming <matt@codeblueprint.co.uk>
Reported-by: Daniel Wagner <wagi@monom.org>
---
 kernel/signal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 267fce07df5d..3651483bd4d8 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -494,8 +494,8 @@ static void sigqueue_free_current(struct sigqueue *q)
 
 	up = q->user;
 	if (rt_prio(current->normal_prio) && !put_task_cache(current, q)) {
-		atomic_dec(&up->sigpending);
-		free_uid(up);
+		if (atomic_dec_and_test(&up->sigpending))
+			free_uid(up);
 	} else
 		  __sigqueue_free(q);
 }
-- 
2.16.4

