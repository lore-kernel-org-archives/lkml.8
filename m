Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7DDFC1975A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 01:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF94720732
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 01:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="OUqCP+XT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgCWB5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 21:57:47 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:36583 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbgCWB5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 21:57:46 -0400
Received: by mail-qv1-f67.google.com with SMTP id z13so6438989qvw.3
        for <linux-kernel@vger.kernel.org>; Sun, 22 Mar 2020 18:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CPTNBS3Fi1p/gJitdrGM7rlktRgoXOE8J7X5+PPOovI=;
        b=OUqCP+XTeWIkHEUTQ6MHdonPY/cGSi2e/kfYesyOU3ynrutAH8Q4VfxvKw0tUXIA/b
         h8un8v0SlSrOn9Yg6Yhn1DVmJnVOF3dXuHkCd44v1WwL8eUeaN7FcJVa12o6V3kZ6T+2
         EOvZv9JCEPxbjA2/e+eFrjr6gYlBsufneUQBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CPTNBS3Fi1p/gJitdrGM7rlktRgoXOE8J7X5+PPOovI=;
        b=mQQUmldJEBGle3lwZePshYpzhYXnHdLkTImTUVxkfSNwYZxDTfzZnmmVKCfl09Yyxn
         jtQwmLFkc+lEXI3KcS+6Qx3MriJnwQxaTyES0enUNJ35bljdSXVtAMw11qX//AfC05fG
         IffFFfsJxQx1+weqv/lLs2gl+gQWbxnx519Hu27tsQm2QhD6outAoigO+lBtqg2yhw5P
         bPcMvltNqE5Wg3mGPS3DA3Az6OQ4ymYq9koaN7OqS5f14k2ytU5K/VwrKXIRH4Qc//jj
         fAQVOESN/1CSX62tuOZkcClEC9WXLKYb2Ia6CNfRjp0NytIZ/W0z4neyBc8goLqcww6m
         snpQ==
X-Gm-Message-State: ANhLgQ3vbywwAU/nqbDSqN/naJsFWF8b8SycMJMwWeyQzjD6j77TNwgn
        FCbAxg9pZr7kNLuuPsfS+oU8mbfG4M8=
X-Google-Smtp-Source: ADFU+vurS72m7f6mnjBTHvHJyTIsKVlVQ4eL+s7Pv5ptJP29NDfgUt3p4H6dsIh7t5UoIZdzRhVTpQ==
X-Received: by 2002:a0c:f849:: with SMTP id g9mr6774944qvo.108.1584928664464;
        Sun, 22 Mar 2020 18:57:44 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id e66sm10146233qkd.129.2020.03.22.18.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2020 18:57:44 -0700 (PDT)
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
Subject: [PATCH v2 2/4] Documentation: LKMM: Add litmus test for RCU GP guarantee where updater frees object
Date:   Sun, 22 Mar 2020 21:57:33 -0400
Message-Id: <20200323015735.236279-2-joel@joelfernandes.org>
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
 .../litmus-tests/rcu/RCU+sync+free.litmus     | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/litmus-tests/rcu/RCU+sync+free.litmus

diff --git a/Documentation/litmus-tests/rcu/RCU+sync+free.litmus b/Documentation/litmus-tests/rcu/RCU+sync+free.litmus
new file mode 100644
index 0000000000000..4ee67e12f513a
--- /dev/null
+++ b/Documentation/litmus-tests/rcu/RCU+sync+free.litmus
@@ -0,0 +1,42 @@
+C RCU+sync+free
+
+(*
+ * Result: Never
+ *
+ * This litmus test demonstrates that an RCU reader can never see a write that
+ * follows a grace period, if it did not see writes that precede that grace
+ * period.
+ *
+ * This is a typical pattern of RCU usage, where the write before the grace
+ * period assigns a pointer, and the writes following the grace period destroy
+ * the object that the pointer used to point to.
+ *
+ * This is one implication of the RCU grace-period guarantee, which says (among
+ * other things) that an RCU read-side critical section cannot span a grace period.
+ *)
+
+{
+int x = 1;
+int *y = &x;
+int z = 1;
+}
+
+P0(int *x, int *z, int **y)
+{
+	int *r0;
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

