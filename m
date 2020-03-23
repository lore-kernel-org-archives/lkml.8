Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47860C1975A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 01:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E9B820722
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 01:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="gs956uTh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgCWB5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 21:57:45 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43883 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbgCWB5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 21:57:44 -0400
Received: by mail-qt1-f196.google.com with SMTP id a5so3251949qtw.10
        for <linux-kernel@vger.kernel.org>; Sun, 22 Mar 2020 18:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Sh3ZQXA8/fcOyDAMpc+/YELK5mbWwAuzgrwXdRovqek=;
        b=gs956uThpOltmLqXIt+nbE6Rhd0UEn0Ql4aR97Sadj6fmyYgxDFKl5q0OnMA0As6Y2
         om2Ms+zMVB53ikwKASnQLtWL8thktq+a43aCcCVn63aCzaGCoW/Ldc8384u/p7fGFpHm
         tdo13KND88UkOwMF33F8znWrk3CgJ+gxz9C/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Sh3ZQXA8/fcOyDAMpc+/YELK5mbWwAuzgrwXdRovqek=;
        b=m4DknqFrknXnaoxKnLd/V+TDut5zlwip7KFF9zedCNNSAj1KoiRR/O8jVkUM9oe2tV
         Lx1td4lIzBlSOAwgDRu34cSBniNymQExS8lJZAIuKQh5DmHgRNevIH0EMXaqd0AfoczB
         mvOwqhEvBfVlwBTK/YdpKh6qC2nXEB2WeMbGzzxdhs9OhKPRCOr/0gA05P66md5ROHyg
         slysx7yljOEExpPH0NHDhaleaKgqcP1f8EWAFammjQsGfFGmVDbV3cAHLva8y7ckktay
         kTzIGpGNlWMJe1/go84LCeOMKFeT6CnS+Z+bUkIMu5Aa7vQw/2t6dTsYMLrfuF+lqBsF
         1nwg==
X-Gm-Message-State: ANhLgQ0OnwdNhNqZlrCjtu2af340dbT0V3RVFwFhxSEopmKBs7Eihj+D
        jI3ZmibGAUW/nhZaOun5kU/++XrIuOk=
X-Google-Smtp-Source: ADFU+vttwBXstjGSt67NWuAcSW4ytpix/Zaxhp/bLD8Z3vcH09O+jTp5grPQNOP1R2gYu15wDLhhrg==
X-Received: by 2002:ac8:5159:: with SMTP id h25mr19800618qtn.165.1584928661954;
        Sun, 22 Mar 2020 18:57:41 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id e66sm10146233qkd.129.2020.03.22.18.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2020 18:57:41 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        vpillai@digitalocean.com, Jonathan Corbet <corbet@lwn.net>,
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
Subject: [PATCH v2 1/4] Documentation: LKMM: Move MP+onceassign+derefonce to new litmus-tests/rcu/
Date:   Sun, 22 Mar 2020 21:57:32 -0400
Message-Id: <20200323015735.236279-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move MP+onceassign+derefonce to the new Documentation/litmus-tests/rcu/
directory.

More RCU-related litmus tests would be added here.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

---
Cc: vpillai@digitalocean.com

 Documentation/litmus-tests/README                        | 9 +++++++++
 .../litmus-tests/rcu}/MP+onceassign+derefonce.litmus     | 0
 tools/memory-model/litmus-tests/README                   | 3 ---
 3 files changed, 9 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/litmus-tests/README
 rename {tools/memory-model/litmus-tests => Documentation/litmus-tests/rcu}/MP+onceassign+derefonce.litmus (100%)

diff --git a/Documentation/litmus-tests/README b/Documentation/litmus-tests/README
new file mode 100644
index 0000000000000..84208bc197f2e
--- /dev/null
+++ b/Documentation/litmus-tests/README
@@ -0,0 +1,9 @@
+============
+LITMUS TESTS
+============
+
+RCU (/rcu directory)
+--------------------
+MP+onceassign+derefonce.litmus
+    Demonstrates that rcu_assign_pointer() and rcu_dereference() to
+    ensure that an RCU reader will not see pre-initialization garbage.
diff --git a/tools/memory-model/litmus-tests/MP+onceassign+derefonce.litmus b/Documentation/litmus-tests/rcu/MP+onceassign+derefonce.litmus
similarity index 100%
rename from tools/memory-model/litmus-tests/MP+onceassign+derefonce.litmus
rename to Documentation/litmus-tests/rcu/MP+onceassign+derefonce.litmus
diff --git a/tools/memory-model/litmus-tests/README b/tools/memory-model/litmus-tests/README
index 681f9067fa9ed..79e1b1ed4929a 100644
--- a/tools/memory-model/litmus-tests/README
+++ b/tools/memory-model/litmus-tests/README
@@ -63,9 +63,6 @@ LB+poonceonces.litmus
 	As above, but with store-release replaced with WRITE_ONCE()
 	and load-acquire replaced with READ_ONCE().
 
-MP+onceassign+derefonce.litmus
-	As below, but with rcu_assign_pointer() and an rcu_dereference().
-
 MP+polockmbonce+poacquiresilsil.litmus
 	Protect the access with a lock and an smp_mb__after_spinlock()
 	in one process, and use an acquire load followed by a pair of
-- 
2.25.1.696.g5e7596f4ac-goog
