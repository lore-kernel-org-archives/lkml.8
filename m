Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2ACBC47076
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 21:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0BB220769
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 21:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b8hsGFNN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731376AbgELVho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 17:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728313AbgELVhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 17:37:43 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AACC9C061A0C;
        Tue, 12 May 2020 14:37:43 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id k19so5961400pll.9;
        Tue, 12 May 2020 14:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HBKl1IEq6aSLeUtrs84rAP60Nkas7Hhs0/6ts2ndPIE=;
        b=b8hsGFNNy6T8rDX+dxp89Z+mzsagO3j66K1smZnfcPXTTiDpoS6wD/p5tsCF01YCse
         j77LIo/LV1dryQdFbHJ/ldxzfgL+r9tbM9tFbvsU1upacLQUBWxL1axsAbGwNGRp3pFp
         mOCKSCMCCr8IaoKleG6QxX73NgO1oaZohB5KzkiIe805pH5bQiICS4l0Ozeearf93STz
         wZNL/29fND8pC6AGWINUE0P4rK6SVT7ICHbiFvgQ4MPTF+ayhy/Fm8BHxqbhGSAN3gbC
         7Zu5bd5cERelN/VthWs5uFgxvbTuksT1yjpqlpABfg46BSyaXZg4iP/+QJ1bDHi2U0dw
         yRIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HBKl1IEq6aSLeUtrs84rAP60Nkas7Hhs0/6ts2ndPIE=;
        b=gcwY++obCDXFASx4CrvR68WdwP3Nt6GoJyM3e5nZfsFQVczBk1Zi46AKLzLuXRspD2
         Mksz9pZtalTn6wuQCZhWvpARdPFhazaudGtu2sfX9jcpu98gRusHNDKzFHSb4Z09x53S
         GZdYcq4Q4BHswkkuNEX4p2UfZFLZeGwn51JZ1Y1zMr7U7tF5wHlawos9vBh8BjogAwtk
         RHq0CTtRztZRkAVg3NVC5tOwEabSrrnOjq8ZsHViNx/0H4W75hE0+/zDzSlXjbsF9x8I
         +tKh5PE+4lteAPFdIi8LQ5xxWVvwI0SaY5TtXytfst57uNVmC7uP7eAxfx+cJaJ/2qic
         TMNg==
X-Gm-Message-State: AGi0PuakzqIRlUcPR2HUj8NzBrv8BkbOitYIqazTQAVxYu1BhmpTQZZP
        jIm2P1H9feqqyQwdEH1H9uI=
X-Google-Smtp-Source: APiQypJ0KtLoXIHNfVPSLg8ecyEpimch5or5b6Icmxzugu4CLNFeA/LCgaX8oR9fr80lT3WifDJtig==
X-Received: by 2002:a17:902:9049:: with SMTP id w9mr22130839plz.27.1589319463256;
        Tue, 12 May 2020 14:37:43 -0700 (PDT)
Received: from [192.168.11.3] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id m14sm11321427pgk.56.2020.05.12.14.37.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2020 14:37:42 -0700 (PDT)
Subject: [PATCH RESEND 2/4] Revert "Documentation: LKMM: Move
 MP+onceassign+derefonce to new litmus-tests/rcu/"
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Daniel Lustig <dlustig@nvidia.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>
References: <20200323015735.236279-1-joel@joelfernandes.org>
 <7809dbfa-7a76-8663-799a-908c4ead8d30@gmail.com>
 <21e1ba24-22d0-8083-770c-53d320ba5420@gmail.com>
 <fd7e7c6f-fda1-7f2b-19f3-a09b73b10de8@gmail.com>
 <CAEXW_YSjo2hgvg-FN_MR7FVEcp-7gH17jb0-262k+ydSuuDjuQ@mail.gmail.com>
 <20200512163022.GI2869@paulmck-ThinkPad-P72>
 <09a8f418-0a46-87ea-dbdb-a43efc66476c@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <619b1870-35ad-78e5-e938-e0308a61b80e@gmail.com>
Date:   Wed, 13 May 2020 06:37:38 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <09a8f418-0a46-87ea-dbdb-a43efc66476c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From dec86a9f1a947ae01d8b66b4f5d9b431fb2a55b5 Mon Sep 17 00:00:00 2001
From: Akira Yokosawa <akiyks@gmail.com>
Date: Sun, 10 May 2020 13:43:34 +0900
Subject: [PATCH RESEND 2/4] Revert "Documentation: LKMM: Move MP+onceassign+derefonce to new litmus-tests/rcu/"

This reverts commit a5cca3485d9206a9dbbc6f47d2a537e69b53cd82.

MP+onceassign+derefonce.litmus is called out from
tools/memory-model/Documentation/recipes.txt.
It should be in the same directory as the other representative tests
to help readers inspect it.

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Acked-by: Andrea Parri <parri.andrea@gmail.com>
Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 Documentation/litmus-tests/README                              | 3 ---
 .../memory-model/litmus-tests}/MP+onceassign+derefonce.litmus  | 0
 tools/memory-model/litmus-tests/README                         | 3 +++
 3 files changed, 3 insertions(+), 3 deletions(-)
 rename {Documentation/litmus-tests/rcu => tools/memory-model/litmus-tests}/MP+onceassign+derefonce.litmus (100%)

diff --git a/Documentation/litmus-tests/README b/Documentation/litmus-tests/README
index 79d187f75679..c4307ea9f996 100644
--- a/Documentation/litmus-tests/README
+++ b/Documentation/litmus-tests/README
@@ -4,9 +4,6 @@ LITMUS TESTS
 
 RCU (/rcu directory)
 --------------------
-MP+onceassign+derefonce.litmus
-    Demonstrates that rcu_assign_pointer() and rcu_dereference() to
-    ensure that an RCU reader will not see pre-initialization garbage.
 
 RCU+sync+read.litmus
 RCU+sync+free.litmus
diff --git a/Documentation/litmus-tests/rcu/MP+onceassign+derefonce.litmus b/tools/memory-model/litmus-tests/MP+onceassign+derefonce.litmus
similarity index 100%
rename from Documentation/litmus-tests/rcu/MP+onceassign+derefonce.litmus
rename to tools/memory-model/litmus-tests/MP+onceassign+derefonce.litmus
diff --git a/tools/memory-model/litmus-tests/README b/tools/memory-model/litmus-tests/README
index 79e1b1ed4929..681f9067fa9e 100644
--- a/tools/memory-model/litmus-tests/README
+++ b/tools/memory-model/litmus-tests/README
@@ -63,6 +63,9 @@ LB+poonceonces.litmus
 	As above, but with store-release replaced with WRITE_ONCE()
 	and load-acquire replaced with READ_ONCE().
 
+MP+onceassign+derefonce.litmus
+	As below, but with rcu_assign_pointer() and an rcu_dereference().
+
 MP+polockmbonce+poacquiresilsil.litmus
 	Protect the access with a lock and an smp_mb__after_spinlock()
 	in one process, and use an acquire load followed by a pair of
-- 
2.17.1


