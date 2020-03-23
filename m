Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B82FAC54FCF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 01:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D48B2074D
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 01:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="IkAnfVYE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgCWB5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 21:57:48 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45725 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbgCWB5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 21:57:46 -0400
Received: by mail-qk1-f193.google.com with SMTP id c145so13730849qke.12
        for <linux-kernel@vger.kernel.org>; Sun, 22 Mar 2020 18:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NJY0ihWnh3RZuY83D6QpDoF7Tl/RV0ol1+Ik0szRLsc=;
        b=IkAnfVYEOpQOAUGEvyLE2juB/CKhK6XLMxVFnUYj/A+J4o6L1uYJ4tXG5AYNydlxzf
         UO9hnQy6Vyj1oOvOJ/WGR2gDXZ16bCYUVHI2qgp/QgRc/oQefJm+BvHK+qh/k99oqMJQ
         F82pb2PUhPNPybpbAH8seevdTJATx+Kz/+Mi0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NJY0ihWnh3RZuY83D6QpDoF7Tl/RV0ol1+Ik0szRLsc=;
        b=LA4kPkuTNR63Cy46OossgPdDsOyZdT4gk0M6ZBU2kHlTUFeZ3ZfFFuNB5fVyCgm4/v
         NatMQXQRvXGeWsyA1DTSUEYDniaPeH/J5nNuQ2c4zxjgPMuO0fF55ozC5bJixcmXrplU
         IDwTNd1BFKNBq2XwiajHPllhIudveDWC+vwD4y9Fi5iPGvOgP0M7RXtqw8YSIjv/eWav
         sEZZQx6TdOAfeKdqRcral2q/W+AeCvHHicjQnNGfWSVAJUOoD0zncS5roQXN6yNa8yE8
         MvOz9sQ2Yh9gjdWH4RetwCqal5d1NVHcDxSN7fKMADcccz6fjlsX4G5CbnYZb4zqTmzs
         omlw==
X-Gm-Message-State: ANhLgQ0OB+Ug2yf7ewoRPTA8yJY0OkO+kCAz3v+g4V7eQ9/NIYqt39Q6
        4ZYicKG6UDHeIP5RTTRvc/n8ehJhvJE=
X-Google-Smtp-Source: ADFU+vuVETBy0kueh2dy84RYBddE01RCKOLxWsiVzmOylGJSbu2SmdNGPJcKxXFFuAVRwjDi+Fqa5g==
X-Received: by 2002:a37:bc43:: with SMTP id m64mr18280336qkf.287.1584928665421;
        Sun, 22 Mar 2020 18:57:45 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id e66sm10146233qkd.129.2020.03.22.18.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2020 18:57:45 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>, linux-doc@vger.kernel.org
Subject: [PATCH v2 3/4] Documentation: LKMM: Add litmus test for RCU GP guarantee where reader stores
Date:   Sun, 22 Mar 2020 21:57:34 -0400
Message-Id: <20200323015735.236279-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
In-Reply-To: <20200323015735.236279-1-joel@joelfernandes.org>
References: <20200323015735.236279-1-joel@joelfernandes.org>
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
 Documentation/litmus-tests/README             |  5 +++
 .../litmus-tests/rcu/RCU+sync+read.litmus     | 37 +++++++++++++++++++
 2 files changed, 42 insertions(+)
 create mode 100644 Documentation/litmus-tests/rcu/RCU+sync+read.litmus

diff --git a/Documentation/litmus-tests/README b/Documentation/litmus-tests/README
index 84208bc197f2e..79d187f75679d 100644
--- a/Documentation/litmus-tests/README
+++ b/Documentation/litmus-tests/README
@@ -7,3 +7,8 @@ RCU (/rcu directory)
 MP+onceassign+derefonce.litmus
     Demonstrates that rcu_assign_pointer() and rcu_dereference() to
     ensure that an RCU reader will not see pre-initialization garbage.
+
+RCU+sync+read.litmus
+RCU+sync+free.litmus
+    Both the above litmus tests demonstrate the RCU grace period guarantee
+    that an RCU read-side critical section can never span a grace period.
diff --git a/Documentation/litmus-tests/rcu/RCU+sync+read.litmus b/Documentation/litmus-tests/rcu/RCU+sync+read.litmus
new file mode 100644
index 0000000000000..f34176720231d
--- /dev/null
+++ b/Documentation/litmus-tests/rcu/RCU+sync+read.litmus
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
+ * This is one implication of the RCU grace-period guarantee, which says (among
+ * other things) that an RCU read-side critical section cannot span a grace period.
+ *)
+
+{
+int x = 0;
+int y = 0;
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

