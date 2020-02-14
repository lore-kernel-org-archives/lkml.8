Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C53F7C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 20:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EFC0222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 20:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NI93lBS7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387796AbgBNUsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 15:48:41 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40139 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730428AbgBNUsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 15:48:38 -0500
Received: by mail-wm1-f65.google.com with SMTP id t14so12148666wmi.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 12:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bs4/bf84KxBp5/3poh+gEqXOl2zy3ub1/mKAWorwRIA=;
        b=NI93lBS7foSOICH/i6FnoY1Z5JYyX+EOlYr53ZqS9bz7YRxq1HPVtoNdtH6fEOtdQy
         W2a8rnBp72IOANP6gV3abM2WRAaXb2rtkYd6apcvVhBix2UkkR6jOmqio6k3dvNrA2vM
         QP0X6kiWAWBrkhQBhPLaazQ4ewO0y1oSoUC8NVcoUY3nNSWU924P8WJBkky3HzTl+gZ0
         aKttciIYEo1BLqZ9cdWC653TkY+Uk3MvquTu+dZ9NeAA8KcPGhbh3+t30jYAR7ELxI97
         3t+rgkpzyrMOmt4fQiLVbwvOJ5HwqQQSueCw5gSTG5U6QSRmlx2CgL9Noctb4hbxEwuK
         QxEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bs4/bf84KxBp5/3poh+gEqXOl2zy3ub1/mKAWorwRIA=;
        b=bDk6fZa1wZTeH0Ncy94rRxx9LWCELAAeqFkP6fAPUGA3Lk+wp4YU0/QrXIi9mvqayz
         huqiJ3RRM9p62C1jB1sBUQ0HJZ0qhWC2aCnEFUbrvxdGgyS40tyMm7SVCNo5NBrdmKjk
         jkwnGmOXFJzylNIB/eAPuiVJMgkOQsg0D8s1nC8qFACygMjyp5r+wLcEMZ2E7xg4LPIL
         uXWFmcknOX5tQ1UwKxYr9uHPIbdLRYVn8A6IojIJ//40dXg+y7PujL+tfFmtNAGSfZh1
         StosGa6/zkHmfcQxBbpI1rfcsPojMqUcc80jY/PNP5hHUdsAP/+T4jSWGmKpDKPpZMRM
         VrOw==
X-Gm-Message-State: APjAAAX/6xYPonrbxYng/2yChgQh3NYnI5ND8ZOtFxJwOA8b1v61bfVr
        O3hzPhDr4b1pk0j54AGiJVwrRDAizRYs
X-Google-Smtp-Source: APXvYqxddI/rx1H/gt7+BYJb7sy1tT+1CI0Zml46G1dOyf9pi32VG/CVm3wL/lgpJ4KOEVBi2OQw8g==
X-Received: by 2002:a1c:988c:: with SMTP id a134mr6194261wme.163.1581713316795;
        Fri, 14 Feb 2020 12:48:36 -0800 (PST)
Received: from ninjahost.lan (host-2-102-13-223.as13285.net. [2.102.13.223])
        by smtp.googlemail.com with ESMTPSA id y12sm8660782wmj.6.2020.02.14.12.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 12:48:36 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     boqun.feng@gmail.com, Jules Irenge <jbi.octave@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm@kvack.org (open list:MEMORY MANAGEMENT)
Subject: [PATCH 05/30] mm/compaction: Add missing annotation for compact_lock_irqsave
Date:   Fri, 14 Feb 2020 20:47:16 +0000
Message-Id: <20200214204741.94112-6-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200214204741.94112-1-jbi.octave@gmail.com>
References: <0/30>
 <20200214204741.94112-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse reports a warning at compact_lock_irqsave()

warning: context imbalance in compact_lock_irqsave() - wrong count at exit

The root cause is the missing annotation at compact_lock_irqsave()
Add the missing __acquires(lock) annotation.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 mm/compaction.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/compaction.c b/mm/compaction.c
index 672d3c78c6ab..81190fe22200 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -481,6 +481,7 @@ static bool test_and_set_skip(struct compact_control *cc, struct page *page,
  */
 static bool compact_lock_irqsave(spinlock_t *lock, unsigned long *flags,
 						struct compact_control *cc)
+	__acquires(lock)
 {
 	/* Track if the lock is contended in async mode */
 	if (cc->mode == MIGRATE_ASYNC && !cc->contended) {
-- 
2.24.1

