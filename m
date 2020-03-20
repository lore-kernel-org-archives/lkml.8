Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1797C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 06:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B002720724
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 06:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="OGS30BXK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgCTG4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 02:56:04 -0400
Received: from mail-qv1-f68.google.com ([209.85.219.68]:44758 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgCTG4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 02:56:03 -0400
Received: by mail-qv1-f68.google.com with SMTP id w5so2418840qvp.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 23:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lZktbxS0i0oIpqeQrOD+jHQIgM5+6wOIwrhIyNa/H6M=;
        b=OGS30BXKvOOsiK6bD9IHOQ/GNBieNsiIIavZuTQRPmaN+dLmHB72W7AG9FSAKiF68g
         QRPpdBrWYryk/9Q4y39ZNGQ9DEhRzN2NNMESkxWC+20ZItrbfMAM4eIWJclNOKm1WtD8
         MbAR5IBjM8/daadm5FSS1NRGtu7/JG+3gQ9w0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lZktbxS0i0oIpqeQrOD+jHQIgM5+6wOIwrhIyNa/H6M=;
        b=KXxLEF13tOFmlx6X2vUXSjs/TydlOXQtm44L5fm7m7fl/nXM3SLIKGrcn6n4+pEEzy
         oC5M98BIfbv22A83+FMkSUA2LVcDBAW5i5kBVV0xoBcjJWdyqp0eckWBJf/1bhS6etmE
         UuZeFZRNsuTZ2MZLWbW/r23Jzq4xMHPEM675+jmoKVOUs8DXXFvBJCz5Ve3DZJWBsZ26
         Yl3emjyssbriP4BxphWR5yDXPYfjFEv+wzXdJk+uSHrpAU6JHSt5dstQAkF8NV/qV6KY
         vaAQMUWNWoAMVhWxrW1k9ZUdCHr5nflPvqDYJcmfd+ras1SZG/rDra1h/h5dPGUheSkL
         L17w==
X-Gm-Message-State: ANhLgQ0IK4kih66G/qPzsnIUGnbgFzPCeOiaYL0h4dNPne8x00zGDxhK
        csZcMCWc98S+BEwpHmUVkLlNzgqBX8A=
X-Google-Smtp-Source: ADFU+vsBfhVA6txgEV2FXFv04i7OnbCf4MVeIQfB2DE8puxWcSZZqD9MC2EXp6EPoVIRkmczAddJfg==
X-Received: by 2002:a0c:eeca:: with SMTP id h10mr6656674qvs.206.1584687361491;
        Thu, 19 Mar 2020 23:56:01 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id m15sm419985qkk.26.2020.03.19.23.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 23:56:01 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>, linux-arch@vger.kernel.org,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Subject: [PATCH 2/3] LKMM: Add litmus test for RCU GP guarantee where reader stores
Date:   Fri, 20 Mar 2020 02:55:51 -0400
Message-Id: <20200320065552.253696-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
In-Reply-To: <20200320065552.253696-1-joel@joelfernandes.org>
References: <20200320065552.253696-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds an example for the important RCU grace period guarantee, which
shows an RCU reader can never span a grace period.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 .../litmus-tests/RCU+sync+read.litmus         | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 tools/memory-model/litmus-tests/RCU+sync+read.litmus

diff --git a/tools/memory-model/litmus-tests/RCU+sync+read.litmus b/tools/memory-model/litmus-tests/RCU+sync+read.litmus
new file mode 100644
index 0000000000000..73557772e2a32
--- /dev/null
+++ b/tools/memory-model/litmus-tests/RCU+sync+read.litmus
@@ -0,0 +1,37 @@
+C RCU+sync+read
+
+(*
+ * Result: Never
+ *
+ * This litmus test demonstrates that after a grace period, an RCU updater always
+ * sees all stores done in prior RCU read-side critical sections. Such
+ * read-side critical sections would have ended before the grace period ended.
+ *
+ * This guarantee also implies, an RCU reader can never span a grace period and
+ * is an important RCU grace period memory ordering guarantee.
+ *)
+
+{
+x = 0;
+y = 0;
+}
+
+P0(int *x, int *y)
+{
+	rcu_read_lock();
+	WRITE_ONCE(*x, 1);
+	WRITE_ONCE(*y, 1);
+	rcu_read_unlock();
+}
+
+P1(int *x, int *y)
+{
+	int r0;
+	int r1;
+
+	r0 = READ_ONCE(*x);
+	synchronize_rcu();
+	r1 = READ_ONCE(*y);
+}
+
+exists (1:r0=1 /\ 1:r1=0)
-- 
2.25.1.696.g5e7596f4ac-goog

