Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F77AC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 20:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F31FF21569
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 20:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="fyy3NG0Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729337AbgAWUVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 15:21:00 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38760 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbgAWUU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 15:20:59 -0500
Received: by mail-qt1-f193.google.com with SMTP id c24so3552994qtp.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 12:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VWhgf0oxD0MDf+v6PtICDr/Wa9j8E9ftPNdZpQEn1CY=;
        b=fyy3NG0QF3sT8WoIjZ3RdpwdXMbbVnxAdAbhOWWwcZGZn6kDlghZMgOmtownbr5a/R
         9dd3QJI0jmeKj3gvnwrzs24LfejQcty1Mg4IKdDr3yyXfMv85JzkN9h9h9P57KvdlBNr
         3Y4OQid0KpYFFTsyAexT+tKa6eUz13cK54meBJyymYdqS7mTK1aeNRbX5E2iX2hb/hp5
         YUMQBeDvVxunMFMS2J8szaxobk7uE+NG+RFPLymVSdAfEXVmJqMeFZyTUoOkXfa2qB33
         SS5Tsf48R8udSh8krxncIFYTL06Tsn7zPU4mOBxXvJKBk9kDlYEBdGsqOgk4zYIMCMsh
         3g5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VWhgf0oxD0MDf+v6PtICDr/Wa9j8E9ftPNdZpQEn1CY=;
        b=R09lgPDbYbVqMTgcub6swBGM2mpNT8ZurF7qtzHl+T6/K1GvJODZ37isADLDd/+AGu
         p/2f8X1T9D9/KBAhicVCYBMN/La+qOW2NhBeWRyuG71kH82Ua3vh3xDOKZbcZ/KCEjW2
         Hjh+2d1c2e8nIIxSkFVp/D40qOLKBtMHiKFvrsiAjCBxnGqrZU58DhNVxjpL3sBVb+xa
         EUrpnA/lRPiRKKAWsXctjbBwx+hEtdYRy1mPJhViQ9v0cE0kFyyUS7MnBbtQne+IONoy
         DlaqRlFzji+5bRQQIRCQJE7yub6idRFr5FJ4M3DRkWEELfikQjz6d4hkg+R34WyjPdvo
         mdPg==
X-Gm-Message-State: APjAAAVCRFdTFaErfBNeGXWaE/9i+UFI685O/X+f3PI1kgW6/kHh08AM
        rhGaT7N3C4APXkB7oThQzeNOOA==
X-Google-Smtp-Source: APXvYqwoFh27vtWYsfvrPv9tzLqtRlpmDW8J1E3xTi3UWTqCq4KzyekE7Ja8rVBWKWFK6Bgw4QYjUA==
X-Received: by 2002:ac8:768d:: with SMTP id g13mr18191647qtr.7.1579810858874;
        Thu, 23 Jan 2020 12:20:58 -0800 (PST)
Received: from ovpn-123-97.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id g52sm1649041qta.58.2020.01.23.12.20.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jan 2020 12:20:58 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     peterz@infradead.org
Cc:     will@kernel.org, longman@redhat.com, mingo@redhat.com,
        catalin.marinas@arm.com, clang-built-linux@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH -next v2] arm64/spinlock: fix a -Wunused-function warning
Date:   Thu, 23 Jan 2020 15:20:51 -0500
Message-Id: <20200123202051.8106-1-cai@lca.pw>
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

Fix it by converting vcpu_is_preempted() to a static inline function.

Fixes: f5bfdc8e3947 ("locking/osq: Use optimized spinning loop for arm64")
Signed-off-by: Qian Cai <cai@lca.pw>
---

v2: convert vcpu_is_preempted() to a static inline function.

 arch/arm64/include/asm/spinlock.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/spinlock.h b/arch/arm64/include/asm/spinlock.h
index 102404dc1e13..9083d6992603 100644
--- a/arch/arm64/include/asm/spinlock.h
+++ b/arch/arm64/include/asm/spinlock.h
@@ -18,6 +18,10 @@
  * See:
  * https://lore.kernel.org/lkml/20200110100612.GC2827@hirez.programming.kicks-ass.net
  */
-#define vcpu_is_preempted(cpu)	false
+#define vcpu_is_preempted vcpu_is_preempted
+static inline bool vcpu_is_preempted(int cpu)
+{
+	return false;
+}
 
 #endif /* __ASM_SPINLOCK_H */
-- 
2.21.0 (Apple Git-122.2)

