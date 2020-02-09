Return-Path: <SRS0=6uoK=35=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 125DDC2BA83
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 22:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6E8820661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 22:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J1ZOEB5b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbgBIWu5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 17:50:57 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36795 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbgBIWu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 17:50:56 -0500
Received: by mail-wr1-f68.google.com with SMTP id z3so5268787wru.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Feb 2020 14:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CPuCWNsZLynY/8uFxUcnECr6O6LkTQMF9t6qMtFWYDU=;
        b=J1ZOEB5biT4kkyZclM31pWHGklevKfL0MrPOCXMmRSYtmMzuctDi1jVaHzKMoTLKfv
         5tBM+VkREzsealfmAsvruLLyfL9zJ6lmmILcvkQoRIk6WK1s11ZmoVy0BKvO1dup2Dbe
         bAv8GnurCjUKaaJ1u4rhMsD9NClesm3kSLxlhTvnj0IzZVsm4XKw4JweoDu7IYC1P9IY
         zcYouocs0Hgxor+xyZqhLHmcqKeG21HN3rV0pYjjTgtEWkkSkfpHMX0/s8NZLHe6Bvzz
         9h5fdYgS0M/64Abjs0DiAJ0/OeQlTGL+7JX7qKcFkFcGfIJWPR4LPohCelgvHlRliC9z
         5J+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CPuCWNsZLynY/8uFxUcnECr6O6LkTQMF9t6qMtFWYDU=;
        b=PoOTNJs24Uqfy0ol53rba0vLChvEgpBobocv6xNqcJ1FHU7NwGQ/cB/e7wcVkm4xnl
         4dins5p/+HV1OVsA5N5UeOo+Q/zlG/b69G5gToA9vPCCffIN+c6uUHnjnhBgwK1q4uOy
         G24GsHiA6tjIaLUS+AScTUccA9WaOIAguhhu0Fx0pO0XRMCuQoCwEZM1Ges5np6+jGNz
         QPiIqppDEZD+VoXg/dvRGXzSa7zTlKpA4O50mmn+IzNGIwVnK5h6aq1Hv93OuYhhZGmJ
         Qx1RBBrv5wH+h+G1jJUFQQl1+T7KGCdYFPs72cgRJAo5E6yvi0Jf6lPOVgyPktlB50Ia
         hSoA==
X-Gm-Message-State: APjAAAWyQ+Dk0zgVnBtC5O6hvm+jUShWKFF3EXB4z4Itgm5dOkSDSISO
        o3RQzfrB4uu1nBS4hy7BzOq6FxBuqTT9
X-Google-Smtp-Source: APXvYqxeENj65KjSvLVKErDubsElF5I1lTK/LbSO1WrTN3V+5xpNKYHdbos6kyNd3HhlE2OFq9tBEw==
X-Received: by 2002:adf:dc8d:: with SMTP id r13mr13418050wrj.357.1581288654550;
        Sun, 09 Feb 2020 14:50:54 -0800 (PST)
Received: from ninjahost.lan (host-2-102-13-223.as13285.net. [2.102.13.223])
        by smtp.googlemail.com with ESMTPSA id y6sm13643987wrl.17.2020.02.09.14.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 14:50:54 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     boqun.feng@gmail.com
Cc:     dvhart@infradead.org, peterz@infradead.org, mingo@redhat.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Jules Irenge <jbi.octave@gmail.com>
Subject: [PATCH 11/11] futex: Add missing annotation for futex_wait_queue_me()
Date:   Sun,  9 Feb 2020 22:50:42 +0000
Message-Id: <bf54651bbf0b2168ca86c53e899be1c8a245d933.1581282103.git.jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1581282103.git.jbi.octave@gmail.com>
References: <0/11> <cover.1581282103.git.jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse reports a warning at futex_wait_queue_me()

warning: context imbalance in futex_wait_queue_me() - unexpected unlock

The root cause is a missing annotation at futex_wait_queue_me()

Add the missing annotation  __releases(&hb->lock)

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 kernel/futex.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/futex.c b/kernel/futex.c
index 5263cce46c06..16c6c40dbd68 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -2679,6 +2679,7 @@ static int fixup_owner(u32 __user *uaddr, struct futex_q *q, int locked)
  */
 static void futex_wait_queue_me(struct futex_hash_bucket *hb, struct futex_q *q,
 				struct hrtimer_sleeper *timeout)
+	__releases(&hb->lock)
 {
 	/*
 	 * The task state is guaranteed to be set before another task can
-- 
2.24.1

