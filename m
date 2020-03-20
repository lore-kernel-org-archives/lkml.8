Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0AC2C4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 06:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C196120724
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 06:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="M8wPPWkw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgCTG4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 02:56:02 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38952 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbgCTG4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 02:56:02 -0400
Received: by mail-qk1-f195.google.com with SMTP id t17so5843219qkm.6
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 23:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H7qI0J6UdPPMxMo89bJspgFfE6kReY5LFKqgcFnVjEE=;
        b=M8wPPWkw74OJ30O2RObg0NV3Uqad/cBAquf9jWLlhnwkQWlKMsX15vW5/llQc7ZVma
         kPOuv5pWfIfh9QqyZlJXrNJB4Ux8KA/twWx2iH39XKFkgXxG/T5IhWKyDHPbqnw2gSVe
         p1+JNPzVnbVxNJz2extJx7+1rarPEomTnUDRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H7qI0J6UdPPMxMo89bJspgFfE6kReY5LFKqgcFnVjEE=;
        b=km14IFrqBA86KWesjFjuJbPR1Ctyv2wvXZOmt1marn8bOu6VJSP0oYnzPA/U5EHYHu
         eBMeqoqUNmKvKzexL51PeFmuUEotiQ11/aU6mJUsfTwxgWshwmAED7a3FlfHBtr4Nq1E
         6+LmpIcO9h8Bl0v4sqBrznmbePS8fKYqgvq96goFZ/FZcUcqjANThHP6ciWEzJeH5WYp
         bNPtteBeaLy8zB6l+y0kmRI0c8wfztkfJ5PuHSQSlZXVW5+G9iZ/KpQuKYipFtZiCq3Y
         aGQ4HNyxCkimF7INiGp23EwDNxQNgLt4FJLMJT9CjmoS1kYOT6u8q8p3Exv5O2zlGsE5
         6F7Q==
X-Gm-Message-State: ANhLgQ0oBBbwyNeo6HiuRECI3Nop9ZWZYvB+heR68zwgjRV3ZMOxihSl
        uFp5tdtT4LknF9eQuklao4yaGJZnZE0=
X-Google-Smtp-Source: ADFU+vvbBbRAvpvItKU3CDLenRkmMnn64zsTki3i6k9ySmu292eqsPkuvXJtQLwlXVDMfaaK0W5jlQ==
X-Received: by 2002:a37:6556:: with SMTP id z83mr6558870qkb.381.1584687360401;
        Thu, 19 Mar 2020 23:56:00 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id m15sm419985qkk.26.2020.03.19.23.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 23:55:59 -0700 (PDT)
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
Subject: [PATCH 1/3] LKMM: Add litmus test for RCU GP guarantee where updater frees object
Date:   Fri, 20 Mar 2020 02:55:50 -0400
Message-Id: <20200320065552.253696-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
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
 .../litmus-tests/RCU+sync+free.litmus         | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 tools/memory-model/litmus-tests/RCU+sync+free.litmus

diff --git a/tools/memory-model/litmus-tests/RCU+sync+free.litmus b/tools/memory-model/litmus-tests/RCU+sync+free.litmus
new file mode 100644
index 0000000000000..c4682502dd296
--- /dev/null
+++ b/tools/memory-model/litmus-tests/RCU+sync+free.litmus
@@ -0,0 +1,40 @@
+C RCU+sync+free
+
+(*
+ * Result: Never
+ *
+ * This litmus test demonstrates that an RCU reader can never see a write after
+ * the grace period, if it saw writes that happen before the grace period. This
+ * is a typical pattern of RCU usage, where the write before the grace period
+ * assigns a pointer, and the writes after destroy the object that the pointer
+ * points to.
+ *
+ * This guarantee also implies, an RCU reader can never span a grace period and
+ * is an important RCU grace period memory ordering guarantee.
+ *)
+
+{
+x = 1;
+y = x;
+z = 1;
+}
+
+P0(int *x, int *z, int **y)
+{
+	int r0;
+	int r1;
+
+	rcu_read_lock();
+	r0 = rcu_dereference(*y);
+	r1 = READ_ONCE(*r0);
+	rcu_read_unlock();
+}
+
+P1(int *x, int *z, int **y)
+{
+	rcu_assign_pointer(*y, z);
+	synchronize_rcu();
+	WRITE_ONCE(*x, 0);
+}
+
+exists (0:r0=x /\ 0:r1=0)
-- 
2.25.1.696.g5e7596f4ac-goog

