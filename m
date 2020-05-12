Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 705D7C2D0FB
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 21:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CAC720747
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 21:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJQkdNA/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731429AbgELVjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 17:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729646AbgELVjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 17:39:13 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66459C061A0C;
        Tue, 12 May 2020 14:39:13 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id l12so6776412pgr.10;
        Tue, 12 May 2020 14:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HyK43tfuo+QGZbEC4deEKxgiv6iV0m2ya0qSqKqAJ3Y=;
        b=hJQkdNA/h0Z2/CW+og490xBYWsoGiKpS5zv7m8MFiH/E+mdbzj0lbFaAW7yL0NrwiW
         /ddQpsJyevWtaL+eygrIUhcJlPoJbqvKLYSPGTBabBwmXSBAHAJv32uR/p4ChM7xAqvM
         P9kv5n34T0loteo+trVSCQ4qLVEOL0mNw6xnza5ho5uwElhTJaWLx+eTIvbRAwP5OK5m
         jNPTUs1qq5MONgWxbt/LgQYdUVTzvpJFiOjWwqlGbP+Ii8fQh6BX2ry6IYQ/cpiXDRqs
         uMiTJItf1jYi9qCZ+FQchvKoBus11EQq2Y5veVdUmUpQ7hIsduErgS9AZOmKPs8z5Xep
         0Y6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HyK43tfuo+QGZbEC4deEKxgiv6iV0m2ya0qSqKqAJ3Y=;
        b=tnkWu3/OxM8H3hOIvt9oi2dasaQ43n6OiaaqrTdr2tla0UrmTJAjT9n3Mgw31KyUvc
         q9HV3CLW+e1Y1JcuDQWvgb2MZbqUG0QAssqoh6oC+rckIselVWNfvMWiQvVt1GYEOIgX
         1bCpgWmOKcyKTOXUYA4RAan9Ik09UhOpH42fY67MtQj/bdo+gYzKJTjmHNx0pX0u7n8C
         hsUrGxs3AawWvUIexSBxxMDlr34a21T5yKC4EtdbLD2CzGNF8Jfk8mjUMtUqauPXXlPs
         vsR/H1IriqhIMl5+LX5LdX47KdoqixQztnxlyiys2cGbJaQ7HPpccCSqTk17ROHs4JnG
         OECA==
X-Gm-Message-State: AGi0PuZgzeFjumbqo2HsAZyesyKDDpb6EzYfvlECDTLol0KGq/EZLYIj
        O1+cC6egIorq/S0MI2+C54Tl0LcE
X-Google-Smtp-Source: APiQypLyntx8EGBJacRvgm7IGFso4KBY35yEQ77fTYe06WCVyrwwQxLlkKXckFIKjmPl1mohB6Dqbg==
X-Received: by 2002:a63:1054:: with SMTP id 20mr19155904pgq.79.1589319552771;
        Tue, 12 May 2020 14:39:12 -0700 (PDT)
Received: from [192.168.11.3] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id gv24sm13584271pjb.6.2020.05.12.14.39.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2020 14:39:12 -0700 (PDT)
Subject: [PATCH RESEND 3/4] Documentation/litmus-tests: Merge atomic's README
 into top-level one
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
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
References: <20200323015735.236279-1-joel@joelfernandes.org>
 <7809dbfa-7a76-8663-799a-908c4ead8d30@gmail.com>
 <21e1ba24-22d0-8083-770c-53d320ba5420@gmail.com>
 <fd7e7c6f-fda1-7f2b-19f3-a09b73b10de8@gmail.com>
 <CAEXW_YSjo2hgvg-FN_MR7FVEcp-7gH17jb0-262k+ydSuuDjuQ@mail.gmail.com>
 <20200512163022.GI2869@paulmck-ThinkPad-P72>
 <09a8f418-0a46-87ea-dbdb-a43efc66476c@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <6d162e69-5d2f-1fbf-1588-ab19c30e7311@gmail.com>
Date:   Wed, 13 May 2020 06:39:03 +0900
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

From 96fa6680e3b990633ecbb6d11acf03a161b790bd Mon Sep 17 00:00:00 2001
From: Akira Yokosawa <akiyks@gmail.com>
Date: Sun, 10 May 2020 15:12:57 +0900
Subject: [PATCH RESEND 3/4] Documentation/litmus-tests: Merge atomic's README into top-level one

Where Documentation/litmus-tests/README lists RCU litmus tests,
Documentation/litmus-tests/atomic/README lists atomic litmus tests.
For symmetry, merge the latter into former, with some context
adjustment in the introduction.

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Acked-by: Andrea Parri <parri.andrea@gmail.com>
Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>
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


