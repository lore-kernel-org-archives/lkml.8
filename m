Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0635AC2D0E7
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 01:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCFDB20757
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 01:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YjMkp/aE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbgC3BZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 21:25:15 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56253 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728470AbgC3BZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 21:25:12 -0400
Received: by mail-wm1-f67.google.com with SMTP id r16so298110wmg.5
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 18:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NAZ/EvfI698xE822Hbx/zffuhB7jddf4RnbK84/Pvys=;
        b=YjMkp/aEewC+Rdoc5lMigOXs09la/xhMMHhTVtnqpJkS9BVUJ5cHWjixLCgm1oT3pc
         u4+NF6cHnYvDDhRZARJilBYg6Te3ByREBGciPMR1CZsC+aZqc8waQOtfUqL7PAsSemgh
         nR8ghJZTlxbmXQXDqNGNtewt3SKa6A6Vk+7ShWPS1rNf5MlW8yWyK2fsh0bmmbu9bpzo
         zxKyJ6gzhGIxXTOQLq2FcpaGJfiFM+rQRUbyj4CnRuOKKDIMv3t1wlCRELy08eW//pKI
         GdLyffE5dGy4/Pa3cN/3sJ7L2FJz0sku9gz1Y4IvfGy/Exzij5Xhq2qHuq6/3SGAEtrY
         +qHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NAZ/EvfI698xE822Hbx/zffuhB7jddf4RnbK84/Pvys=;
        b=tKZHCocE29/UD2IKeE4UnRejolgSOC0UGTnmqsBeNUeVci8/F6Ix1l5DkNh+81o8et
         jDCoI0PZ/nvxO3jSZltTk5cPv11M0zE4hACW8/7Denh66IpV0TWoZx8hP2We1/8qoQJ9
         lFQ8JPbXstqrvdD86LNDE83Uu7/w4Wl0paXtfC+ahmoJnnfHFZPMRA6byeXtNDpBvx9l
         IaCKJJvK0lUAIkA4+o8q3qYorO+Jx4PpzEPr2BZrzhSC9q134v1DIngEtT2fH5oea5g0
         ZhldHn5hYdypiLoheAFf8Md7VdUdqZ2OFqMH0tAIXcrUjRQRPM7lLwKuczD2/bIaUI9O
         Nutg==
X-Gm-Message-State: ANhLgQ0Q4o44Nhf0Jtx2EyebI0lq2/JOpmQ2R+Q4hc19ReDxm5ynldqA
        DnDzZ53+fPIjrHkv1Kdc5n52wdGNIDmw
X-Google-Smtp-Source: ADFU+vv9dAWCW/X2em/b51q1Gx2bvOi2dNvQl2ZZeByTGRDNZLUaOe+AhYqlc/NAQvrFu5sxloPRog==
X-Received: by 2002:a1c:6885:: with SMTP id d127mr10655536wmc.33.1585531508775;
        Sun, 29 Mar 2020 18:25:08 -0700 (PDT)
Received: from earth.lan (host-92-23-85-227.as13285.net. [92.23.85.227])
        by smtp.gmail.com with ESMTPSA id f12sm18679545wmh.4.2020.03.29.18.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 18:25:08 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     julia.lawall@lip6.fr, boqun.feng@gmail.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Subject: [PATCH v2 4/4] locking/rtmutex: Remove Comparison to bool
Date:   Mon, 30 Mar 2020 02:24:50 +0100
Message-Id: <20200330012450.312155-5-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200330012450.312155-1-jbi.octave@gmail.com>
References: <0/4>
 <20200330012450.312155-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coccinelle reports a warning inside __sched rt_mutex_slowunlock()

WARNING: Comparison to bool

To fix this,
a comparison (==) of a bool type function result to value true
together with the value are removed.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
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

