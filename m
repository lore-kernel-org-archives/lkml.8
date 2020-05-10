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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB6FAC54E8A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 07:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5FB220731
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 07:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQXUkm96"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbgEJHY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 03:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725810AbgEJHY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 03:24:56 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D62C061A0C;
        Sun, 10 May 2020 00:24:56 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id u22so2549038plq.12;
        Sun, 10 May 2020 00:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3ipSF8Gln9hUnX3oEIlmTY2BJm9mZBVNd2bLwIIKios=;
        b=SQXUkm96BH1+XfWVsXEP+gYzSmbV06SPgxvN8TcWwsw5eajQ3nGYQM9QbkqluOmQRC
         qYA3ta3iQzFuL9zX+ElSxepKCVTEAWWsHnNSAJ5btggTYH/8j61o66d3TJr3p5iGN+Cd
         HUvX5VfhGp2hCP3jFvxFRf1rIfrNIHZcTNvkCDpcv2+w1RF99emLHS9Vg6KO7CVZtkQu
         rKGMZl6foMvlbRixdfo7eBS9ljmNsecRhS046bRrX0fOdt9RzJRY7ho72JFGwUJe3fYD
         Zz+SM4NHWjED0Z+XWnTQTtXkiIquYN423WXE59gsjdr/6aw9rOuzvUfo4qUL59k/efHF
         yJSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3ipSF8Gln9hUnX3oEIlmTY2BJm9mZBVNd2bLwIIKios=;
        b=pu/sOdSE1fNQo4EahK0DWe5CUMUlp7hx6VIIoGhQwyLfsB1iig5qK/dnpDF4FNZQsO
         iXnPuNCMfm8BLh2J6IBM9HJBXatJXTYiircyfQPh5c1tsh0vHyJqV1tsp6YRa1hDJvmW
         A3LeqRcIkgt1kGaglx7Y7FbnV06GblBre5VJuCGH6CzGuBr5o2Q7YfsPCtwLJzxVQeDk
         lVfHUPn9eoOgpidj4mvuUa+FD8k5NTDF5iLTYCOEaq4k3FqV0MNdUKJe28ob0dcNoOpq
         NDMGgWHbgZorzcxBA1KkxZsiZ1vqRcI9aI537vaQSKcxJJm5WjT+JjNneGeuc67V7ZO4
         zgHQ==
X-Gm-Message-State: AGi0PuavsrJmPNiZYerg/o8hbKtvo85hy65Wpdg+oohN3jP0OWFIftWp
        hYWligRtQ+1J6YeP7vrcLrg=
X-Google-Smtp-Source: APiQypJ9CdrJ71LXGKndL+Bv557uNJGpkg/KZuApKztA4QSTLS5Xvdrq53NV6jPxooCMJK3Mngd9mw==
X-Received: by 2002:a17:902:b948:: with SMTP id h8mr9616810pls.309.1589095496252;
        Sun, 10 May 2020 00:24:56 -0700 (PDT)
Received: from [192.168.11.3] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id i18sm6579206pjx.33.2020.05.10.00.24.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 May 2020 00:24:55 -0700 (PDT)
Subject: [PATCH 2/3] Revert "Documentation: LKMM: Move MP+onceassign+derefonce
 to new litmus-tests/rcu/"
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
Message-ID: <f9f6daba-c12d-d22b-414e-276961999fdf@gmail.com>
Date:   Sun, 10 May 2020 16:24:51 +0900
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

From 898051fee51913f5b9bd01cab98beb8944ec50b2 Mon Sep 17 00:00:00 2001
From: Akira Yokosawa <akiyks@gmail.com>
Date: Sun, 10 May 2020 13:43:34 +0900
Subject: [PATCH 2/3] Revert "Documentation: LKMM: Move MP+onceassign+derefonce to new litmus-tests/rcu/"

This reverts commit a5cca3485d9206a9dbbc6f47d2a537e69b53cd82.

MP+onceassign+derefonce.litmus is called out from
tools/memory-model/Documentation/recipes.txt.
It should be in the same directory as the other representative tests
to help readers inspect it.

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
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


