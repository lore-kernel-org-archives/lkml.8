Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A671BC2D0E5
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 21:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DB11206F2
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 21:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqpKq27S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbgC0VYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 17:24:20 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44458 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbgC0VYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 17:24:19 -0400
Received: by mail-wr1-f68.google.com with SMTP id m17so13194115wrw.11
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 14:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5BquKrGylR+F/TAd06QUGk5Bi631SaEukwkZX6gMl/s=;
        b=jqpKq27SO0OBC3HYUmEm41cVVCj6r7pfGSj85YdYLwpZKowSXNQ7JTIFygdqnA1y9S
         WsOZzKvp0NXGskryByOC2HdRJmNUl53WDCU8U9l039oeVh5mtFG6kOQGwJbCCba4UqMX
         Vh90OYtDVdtwsTVZ1WgBS1tYgP108NGfuxA3MtY7wAPDcCxcC5I/WeKx8A8BjUdYMttt
         stdn9ny/ZFMvrtAMeu0JpyZf/vg0k/txuXEHcQY33u7TF075T5mAtyuSvCzzfb3NpH3m
         9GEeMBZJW5l8Alw/4BAMZBfIpRFSt+Si4mdku8c016HaxKRv1tqF7q9TR1ljAqE6T/0m
         8hOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5BquKrGylR+F/TAd06QUGk5Bi631SaEukwkZX6gMl/s=;
        b=njzaryTTa6pEQTFaj2L2y8DQ3WaeuoReMLI/GjA44gqfHi+rj1cmy1oKfKqgKLwtcU
         kndu7chOH5eczV5lOAaGNzu0vJ3Yo/+sL79P5akzct1Sndm0zdfga3X5AOtJPq6v46Zm
         eff56fi6kAYelYofvh4DA/uWS9zJWsZj4ErjbwerckBaSJbF8IvIPpdlG7+4ixvR51s0
         QBNibYbsqniwc2C8Twbcl9rhMXpaPpVIpJko+IOsuPrT7ZJsWZtE6omTFilTkF0nKG1T
         gFv4rr4Jcggwto7beHzU0VvYt8+HfngE4687G658Asv6E7oAa183LZCjgJ7wQgkrmBEM
         hmew==
X-Gm-Message-State: ANhLgQ0QdAqg7rT68aeVxra9E3hsB0LJqOTVN86GLNXRiHtiYR6gHSdG
        4a28NJGyEQJs52t5KvRDrA==
X-Google-Smtp-Source: ADFU+vttP9W0NYotqfkyOrfhBp/rJCOqewoHleJ275S1h+AMLOL2otXkyqhlSNMg12rcNPWhuIbAJQ==
X-Received: by 2002:a5d:4fcf:: with SMTP id h15mr1498961wrw.262.1585344256023;
        Fri, 27 Mar 2020 14:24:16 -0700 (PDT)
Received: from ninjahost.lan (host-92-23-82-35.as13285.net. [92.23.82.35])
        by smtp.gmail.com with ESMTPSA id h132sm10215141wmf.18.2020.03.27.14.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 14:24:15 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     julia.lawall@lip6.fr
Cc:     boqun.feng@gmail.com, Jules Irenge <jbi.octave@example.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org (open list:LOCKING PRIMITIVES)
Subject: [PATCH 01/10] locking/rtmutex: Remove Comparison to bool
Date:   Fri, 27 Mar 2020 21:23:48 +0000
Message-Id: <20200327212358.5752-2-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200327212358.5752-1-jbi.octave@gmail.com>
References: <0/10>
 <20200327212358.5752-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jules Irenge <jbi.octave@example.com>

Coccinelle reports a warning inside rt_mutex_slowunlock()

WARNING: Comparison to bool

To fix this, the comparison to bool is removed
This not only fixes the issue but also removes the unnecessary comparison.

Remove comparison to bool

Signed-off-by: Jules Irenge <jbi.octave@example.com>
---
 kernel/locking/rtmutex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 851bbb10819d..7289e7b26be4 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1378,7 +1378,7 @@ static bool __sched rt_mutex_slowunlock(struct rt_mutex *lock,
 	 */
 	while (!rt_mutex_has_waiters(lock)) {
 		/* Drops lock->wait_lock ! */
-		if (unlock_rt_mutex_safe(lock, flags) == true)
+		if (unlock_rt_mutex_safe(lock, flags))
 			return false;
 		/* Relock the rtmutex and try again */
 		raw_spin_lock_irqsave(&lock->wait_lock, flags);
-- 
2.25.1

