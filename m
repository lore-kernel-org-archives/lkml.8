Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14849C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 16:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD09921D7E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 16:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="ITGRhoN8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbgAWQaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 11:30:00 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35681 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727523AbgAWQ37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 11:29:59 -0500
Received: by mail-qk1-f195.google.com with SMTP id z76so4040695qka.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 08:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vnD7CtKsIUMQZngJBgz/z3z7LZDuTlk1mfUMotJq4ls=;
        b=ITGRhoN8U017VrzMlBw/yrJX8jmgO/FLsQjjj5XEofW+pB8tFjk8wmXr3GwdIMO95/
         TdbtO3PIJ8YnZ2nopdVCMK6Ajh4BMIljNe2MEnw/uHTiwJfiLrFUbyGT/2t6KpFSOkpX
         vfn1n7ptNReviQswLnoPORqii+ccWPX1hrXG9+lrEjDGgnz9ODkEYgRkHFexhcsK48HQ
         URC+C4PUMHEE1no+vyeTkSKzn6uIzycEMlQEpJTgmXu/9V/SUv5ogYGDOJGV9PLlw65+
         bOcVPkI4ecRkzi1FpoqIPVnWw4a1SibDgHBDR+PGF12A3huLUWFgnWWS5KNq61gMQELm
         Ps3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vnD7CtKsIUMQZngJBgz/z3z7LZDuTlk1mfUMotJq4ls=;
        b=YEgWFFurj1gG304zu7t2mTy1/iclYLATKK5rghB1DLtbBGV0Cs0fyVWRGlPMe5+9wE
         h4H2Z0pzjykFQgH3C6zWoqOsYM6GnJ9XsnibTVFIb6fEyXoO9hoqNUiT/mE+5ReyJBxp
         V21YYuYB9lIG7PtMqRP8TDYXR+gLyg5eVsu6DKLmDwLK2pdLHnPWSHPfKwgmUDokGJWz
         HSTZ/wLIkRt8xYRaY6JemqIhMD9go191Q2N1kQbWIyj2X4dbAXIVYVqx5fxY26/mgJEM
         43X/IzGVteIDS4ipuX0c9ik3L2UD8EN3fIC4zIDXITH6CxQNKOq03s+946un0s9Gmj3B
         WJDA==
X-Gm-Message-State: APjAAAWEQHX+GnQlkqB5lsU01p8bkeofyPgBAGs0jJKYI0ZOwuXyApQk
        /Nhf37hnFHL4Ong6W413J6D6Ag==
X-Google-Smtp-Source: APXvYqwu8j+jB7xvMUwGV0+Vmf+pKoO72oLwOCLj8Yu+pN4KpMhRP/GPYpj7h2IQFwCZYa3ugyl0xg==
X-Received: by 2002:a05:620a:134f:: with SMTP id c15mr16463418qkl.115.1579796998789;
        Thu, 23 Jan 2020 08:29:58 -0800 (PST)
Received: from ovpn-123-97.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id k135sm1121731qke.6.2020.01.23.08.29.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jan 2020 08:29:57 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     peterz@infradead.org
Cc:     will@kernel.org, longman@redhat.com, mingo@redhat.com,
        catalin.marinas@arm.com, clang-built-linux@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH -next] arm64/spinlock: fix a -Wunused-function warning
Date:   Thu, 23 Jan 2020 11:29:45 -0500
Message-Id: <20200123162945.7705-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit f5bfdc8e3947 ("locking/osq: Use optimized spinning loop for
arm64") introduced a warning from Clang because vcpu_is_preempted() is
compiled away,

kernel/locking/osq_lock.c:25:19: warning: unused function 'node_cpu'
[-Wunused-function]
static inline int node_cpu(struct optimistic_spin_node *node)
                  ^
1 warning generated.

Since vcpu_is_preempted() had already been defined in
include/linux/sched.h as false, just comment out the redundant macro, so
it can still be served for the documentation purpose.

Fixes: f5bfdc8e3947 ("locking/osq: Use optimized spinning loop for arm64")
Signed-off-by: Qian Cai <cai@lca.pw>
---
 arch/arm64/include/asm/spinlock.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/spinlock.h b/arch/arm64/include/asm/spinlock.h
index 102404dc1e13..b05f82e8ba19 100644
--- a/arch/arm64/include/asm/spinlock.h
+++ b/arch/arm64/include/asm/spinlock.h
@@ -17,7 +17,8 @@
  *
  * See:
  * https://lore.kernel.org/lkml/20200110100612.GC2827@hirez.programming.kicks-ass.net
+ *
+ * #define vcpu_is_preempted(cpu)	false
  */
-#define vcpu_is_preempted(cpu)	false
 
 #endif /* __ASM_SPINLOCK_H */
-- 
2.21.0 (Apple Git-122.2)

