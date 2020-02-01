Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F80C33CB7
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 00:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7E5920722
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 00:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HcbyFkcu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgBAAEv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 19:04:51 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35072 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbgBAAEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 19:04:50 -0500
Received: by mail-wm1-f66.google.com with SMTP id b17so10735166wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 16:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A+cR9uVxyvC6kcqjxC2C+5dqUA2dibMuqlzRwuHl68M=;
        b=HcbyFkcucDZmkPWAR52hDaHHOY1wD5hFCji6Knb0wsxjAc0M/MQ2iSJ9M/w0bs8LBy
         KgpySraS9xnoq68otf+F8cvOp2qXG/9xiapIDuMbb6jBySk9Lg9kCfGDDosbiXnmnXeO
         vkMymcH1cgq2Ty5ASU86yRQOsW+8DUgIJH9ZYQYpt+wzXCRPeoa1sHk1rlCiyb7GEHWF
         oNAjgejeUoF8oSPvNaqq8kx0SMiNeXwlMoJ3IzTfPvGFpiI2o9rrUXK1NPtK9RX/rUbR
         mQc8mQc94Zs15AM5OLwYhEL6f2Y8qWJK56G7+oqeZJy5jr0ZpokE3bqfafPJnDUu5KEM
         i/ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A+cR9uVxyvC6kcqjxC2C+5dqUA2dibMuqlzRwuHl68M=;
        b=oxIutbgM0liRHAr6OUsUGc1T3i30sYw5BSVCfyUzZ+tbj3XsC30CHEpN4oqeNnMrIG
         y/HoBE7JKV246WN0VK9JPd9zd5TOFMtQoDI9gedJpby38zaOo2cuhlVP5tMr2mEJ2MT2
         NY8R68VhP6rGn9e9k8mJ+8Zg3X3Z7sUBQz6ySV99cjArytJNf7zsRhox8WW5s8lKty2J
         b8XJNTPvJqED9q/STWTq6ll2AVwtqC5us2oWPzf8T100tbTOJDpetqwCkTB2RQQ7zqWr
         RJ3aTUtZzkHaVmPtyCy6vNAATH+YWnosWm8iiwc0tpghSKZ7DiQBgqF/DnG8xI72A+1/
         G2pA==
X-Gm-Message-State: APjAAAVokQ3Rm4TrU+ACi9RKLm5DXL1r3bOy+m8gvalib5p64DU0A31L
        GpcI3CbTOGRQiH4G+/XUXjriFgvzTw==
X-Google-Smtp-Source: APXvYqxJAkC2fwohtY+9fxz6Evqcr19Mg9j0ZXR5hzKCwJZXuFVxWa4ZZMKw6W0zuwz6y78VkQLzqA==
X-Received: by 2002:a1c:f407:: with SMTP id z7mr14091450wma.72.1580515488065;
        Fri, 31 Jan 2020 16:04:48 -0800 (PST)
Received: from ninjahost.lan (host-2-102-13-223.as13285.net. [2.102.13.223])
        by smtp.googlemail.com with ESMTPSA id n10sm13694048wrt.14.2020.01.31.16.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 16:04:47 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        dvhart@infradead.org, peterz@infradead.org, mingo@redhat.com,
        Jules Irenge <jbi.octave@gmail.com>
Subject: [PATCH 3/3] futex: Add missing annotation for fixup_pi_state_owner()
Date:   Sat,  1 Feb 2020 00:04:16 +0000
Message-Id: <20200201000416.91900-4-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200201000416.91900-1-jbi.octave@gmail.com>
References: <0/3>
 <20200201000416.91900-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse reports a warning at fixup_pi_state_owner()

warning: context imbalance in fixup_pi_state_owner() - unexpected unlock

The root cause is a missing annotation of fixup_pi_state_owner().

Add the missing __must_hold(q->lock_ptr) annotation

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 kernel/futex.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/futex.c b/kernel/futex.c
index 93e7510a5b36..5263cce46c06 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -2440,6 +2440,7 @@ static void unqueue_me_pi(struct futex_q *q)
 
 static int fixup_pi_state_owner(u32 __user *uaddr, struct futex_q *q,
 				struct task_struct *argowner)
+	__must_hold(q->lock_ptr)
 {
 	struct futex_pi_state *pi_state = q->pi_state;
 	u32 uval, uninitialized_var(curval), newval;
-- 
2.24.1

