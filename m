Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6DF3C54E8A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 07:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85BC220731
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 07:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JWpEgB5X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbgEJH26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 03:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgEJH25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 03:28:57 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA24C061A0C;
        Sun, 10 May 2020 00:28:57 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id a4so2996373pgc.0;
        Sun, 10 May 2020 00:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=thdeKBpE5waOs0Cn1rN+DeVJFAkWJi3N1KGywh2VHl0=;
        b=JWpEgB5X6znJ6reYx5p61WDTcKSLGCGgC+zhzPhsRixngH9n+2E6FrHLG580PmWpiC
         0Y6Uvzgo1Ry+Oler/CU7CFdynHiUkuTt5qyKtYKqnWJawu/MgDiNNVTEmxHALjHYQCQW
         guW9GhiyV/O6b062jL9NeAhG7e0mO5dNU3O/so5KgX8OsLhhKHhy75w03oX0ss/GKRqx
         7lp19JqX08qWsB2RjH2zqQoXP3l79AmVmS0bMx8C5cxpkcfQRUP/wPGZqCoqe3Qk1Hcj
         euhkJIRKmE/okxVzJbzSvSMKD6XIZASoEC+sxUXoCAwCTP5mWYkrZIvt6dMnFFJLuGD4
         TqzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=thdeKBpE5waOs0Cn1rN+DeVJFAkWJi3N1KGywh2VHl0=;
        b=kRdTj8txEdzxfRBs7Sj0EgOFOBQ0J73zTNG8I+8aw5LAeOi4B46r7yhucayYL+3V7L
         le8I/vCWeOn7slBcr7DCe2I532w6afjtmltyS4BWrPOeUVl+PDoz0oerBjtbhsGfYHp6
         Mo2CdNlhH/uSNQ7LHYTYhkGeDU0RNAlzGZGROJgR4XCF90bnZ6bGMoEVm1WL4SQwGf5P
         +LF+K40KKJ67RLJ0tjNFdPHLTMd5q4GTCTfE5m6AxBKWwbpycL9Sg85hIBEftDWgYXEn
         1/3Drvpl5rb9I5pn1M7atYWB4wOHmcXvCgmc4RZxnVOLuU/PxGzzPzZFziYITG4PaIDo
         14hA==
X-Gm-Message-State: AGi0PuY0JC9LMhiwLwrOelbTnmY3C1RJkfzpYlUPvccyCpCcfcanzoLu
        8x5opPruvOLRl8eZaWcmckM=
X-Google-Smtp-Source: APiQypJ3TmYsuUjSVjRzx0ym+tma6Gda8lh1685JEq+r0WAvQyz1dI0V0afS4IiGcUbXBIPdL2Dt/A==
X-Received: by 2002:a63:c842:: with SMTP id l2mr9647026pgi.221.1589095737328;
        Sun, 10 May 2020 00:28:57 -0700 (PDT)
Received: from [192.168.11.3] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id u188sm6227665pfu.33.2020.05.10.00.28.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 May 2020 00:28:56 -0700 (PDT)
Subject: [PATCH 3/3] Documentation/litmus-tests: Merge atomic's README into
 top-level one
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, vpillai@digitalocean.com,
        Jonathan Corbet <corbet@lwn.net>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Daniel Lustig <dlustig@nvidia.com>, linux-doc@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
References: <20200323015735.236279-1-joel@joelfernandes.org>
 <7809dbfa-7a76-8663-799a-908c4ead8d30@gmail.com>
 <21e1ba24-22d0-8083-770c-53d320ba5420@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <ee593aed-018b-7bd9-d841-72b1d038bd27@gmail.com>
Date:   Sun, 10 May 2020 16:28:52 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <21e1ba24-22d0-8083-770c-53d320ba5420@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From 1aa2c25f0ad16382a5bc597cdbdcc817645e01cd Mon Sep 17 00:00:00 2001
From: Akira Yokosawa <akiyks@gmail.com>
Date: Sun, 10 May 2020 15:12:57 +0900
Subject: [PATCH 3/3] Documentation/litmus-tests: Merge atomic's README into top-level one

Where Documentation/litmus-tests/README lists RCU litmus tests,
Documentation/litmus-tests/atomic/README lists atomic litmus tests.
For symmetry, merge the latter into former, with some context
adjustment in the introduction.

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
---
 Documentation/litmus-tests/README        | 19 +++++++++++++++++++
 Documentation/litmus-tests/atomic/README | 16 ----------------
 2 files changed, 19 insertions(+), 16 deletions(-)
 delete mode 100644 Documentation/litmus-tests/atomic/README

diff --git a/Documentation/litmus-tests/README b/Documentation/litmus-tests/README
index c4307ea9f996..ac0b270b456c 100644
--- a/Documentation/litmus-tests/README
+++ b/Documentation/litmus-tests/README
@@ -2,6 +2,25 @@
 LITMUS TESTS
 ============
 
+Each subdirectory contains litmus tests that are typical to describe the
+semantics of respective kernel APIs.
+For more information about how to "run" a litmus test or how to generate
+a kernel test module based on a litmus test, please see
+tools/memory-model/README.
+
+
+atomic (/atomic derectory)
+--------------------------
+
+Atomic-RMW+mb__after_atomic-is-stronger-than-acquire.litmus
+    Test that an atomic RMW followed by a smp_mb__after_atomic() is
+    stronger than a normal acquire: both the read and write parts of
+    the RMW are ordered before the subsequential memory accesses.
+
+Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus
+    Test that atomic_set() cannot break the atomicity of atomic RMWs.
+
+
 RCU (/rcu directory)
 --------------------
 
diff --git a/Documentation/litmus-tests/atomic/README b/Documentation/litmus-tests/atomic/README
deleted file mode 100644
index 714cf93816ea..000000000000
--- a/Documentation/litmus-tests/atomic/README
+++ /dev/null
@@ -1,16 +0,0 @@
-This directory contains litmus tests that are typical to describe the semantics
-of our atomic APIs. For more information about how to "run" a litmus test or
-how to generate a kernel test module based on a litmus test, please see
-tools/memory-model/README.
-
-============
-LITMUS TESTS
-============
-
-Atomic-RMW+mb__after_atomic-is-stronger-than-acquire
-	Test that an atomic RMW followed by a smp_mb__after_atomic() is
-	stronger than a normal acquire: both the read and write parts of
-	the RMW are ordered before the subsequential memory accesses.
-
-Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus
-	Test that atomic_set() cannot break the atomicity of atomic RMWs.
-- 
2.17.1


