Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	GAPPY_SUBJECT,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F4C1C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 07:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 707A221744
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 07:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H43nUh+7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbgHGHp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 03:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgHGHp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 03:45:27 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F31C061574;
        Fri,  7 Aug 2020 00:45:27 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id 6so682721qtt.0;
        Fri, 07 Aug 2020 00:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FG0FROUYaTe04KGNWr02FTBUT0DIequTKC7GJACiEKg=;
        b=H43nUh+7aOSwklc6p2JAHdd34OneCTSPLY/7L9Y8wGHoAcIDBGOjYhJ8XKuwkxJvGa
         MUTl8ms7pkc1TFpk/oGgQG+LYD4ZVozHbRL74dyB5H13LmF7sM6M5CdQ8CqNnTQWxFuX
         PEiA5Jm2Qst4VFKoFjsHfm1hMG59wnz7GkXSDbhwAF08LJIIzo8rfBU177rX+RGgvH9k
         +jE1C25PG/7pHCZTEQeIheWKvq7wDWoCgmg+dpBRrA7J4yVjMxtHD+A6Fqy0/iVMvw+y
         k9It4L88/Lt7QtqAXjnbfjpD7Hu33+BdfZRm3iG3xeNy5mpIQA5v4IEoJcA7nyFmSRo8
         cO+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FG0FROUYaTe04KGNWr02FTBUT0DIequTKC7GJACiEKg=;
        b=Yls5kfFJ3Xor7GSxwCSZxu+X3lNwFsmGa85kRyrXeS7p3lBHTbKpEOK7oZL6xYBB0w
         hYeJGTkqxUU2genklKpjyBT07e1+4HMC+wAWktm8QCYHJUrMwk3dZ5hyDzTw/tggA0MY
         1YTTK80X1SL+i8Ku/3v95hiAjT2fp0lMv8X0JhL4y4F2ZxnBvqcAN8nkDGqQXJ5Qq/i4
         UgILtuJe88W0EExfU9qi8TbbQAj7cusf5JM/rdqatjri9nI/QsIvb36lvPUwYVxF/nAD
         w6f7ZIZIVFWHm3+tCfQpBJLH474uIsE5fVRgTR+xn0bEalq0FlOI7Z77fdHM30rVXIhV
         Xkxw==
X-Gm-Message-State: AOAM532J7Tj5CUgcJRPEZ9omjkGtSwe0cx0X9Dn/lUUsZUBUf1Huh62z
        z865mzMHc/R2l70O+36Qd9o=
X-Google-Smtp-Source: ABdhPJz38zy/UDoNvStSCutKJD1Z/C4QM+PGrMKxPdAgZnEJuQn8I58C4Cl/rTUbx+MUKwk+tti14g==
X-Received: by 2002:ac8:130a:: with SMTP id e10mr13423866qtj.38.1596786326319;
        Fri, 07 Aug 2020 00:45:26 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id r48sm7497073qtr.17.2020.08.07.00.45.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Aug 2020 00:45:25 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 6F81727C0054;
        Fri,  7 Aug 2020 03:45:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 07 Aug 2020 03:45:25 -0400
X-ME-Sender: <xms:lQYtX0j3uAFZEdvfO98sv23DArUlo9FIkvWBF8DjxKOMPLdVO8hJRQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrkedugdduvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedvveetfefgiedutedtfeevvddvleekjeeuffffleeguefhhfejteekieeu
    ueelnecukfhppeduudegrdekhedrudektddrvdduheenucevlhhushhtvghrufhiiigvpe
    efnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhp
    vghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnpe
    epfhhigihmvgdrnhgrmhgvsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:lQYtX9AVQpju_P_8Re8PbxF2IFCYjMZ00gfoNODiHlbZYG2-BBAn_g>
    <xmx:lQYtX8GB3KbJd62m0ycwagkCzRrmzZnPGap5WLq7gi1Rj962iltn7Q>
    <xmx:lQYtX1QRRmkZSLqbBhwSXJr0ABQQcHJhX1113Pa5QjdO2tC11k053w>
    <xmx:lQYtXzsV3IsP89qEtPccjHWxrb0C1hs3gi6IUsUrhopejF7zLHfpGw>
Received: from localhost (unknown [114.85.180.215])
        by mail.messagingengine.com (Postfix) with ESMTPA id 57BCD30600A3;
        Fri,  7 Aug 2020 03:45:23 -0400 (EDT)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC v7 13/19] lockdep/selftest: Add a R-L/L-W test case specific to chain cache behavior
Date:   Fri,  7 Aug 2020 15:42:32 +0800
Message-Id: <20200807074238.1632519-14-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200807074238.1632519-1-boqun.feng@gmail.com>
References: <20200807074238.1632519-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As our chain cache doesn't differ read/write locks, so even we can
detect a read-lock/lock-write deadlock in check_noncircular(), we can
still be fooled if a read-lock/lock-read case(which is not a deadlock)
comes first.

So introduce this test case to test specific to the chain cache behavior
on detecting recursive read lock related deadlocks.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 lib/locking-selftest.c | 47 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index caadc4dd3368..002d1ec09852 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -396,6 +396,49 @@ static void rwsem_ABBA1(void)
 	MU(Y1); // should fail
 }
 
+/*
+ * read_lock(A)
+ * spin_lock(B)
+ *		spin_lock(B)
+ *		write_lock(A)
+ *
+ * This test case is aimed at poking whether the chain cache prevents us from
+ * detecting a read-lock/lock-write deadlock: if the chain cache doesn't differ
+ * read/write locks, the following case may happen
+ *
+ * 	{ read_lock(A)->lock(B) dependency exists }
+ *
+ * 	P0:
+ * 	lock(B);
+ * 	read_lock(A);
+ *
+ *	{ Not a deadlock, B -> A is added in the chain cache }
+ *
+ *	P1:
+ *	lock(B);
+ *	write_lock(A);
+ *
+ *	{ B->A found in chain cache, not reported as a deadlock }
+ *
+ */
+static void rlock_chaincache_ABBA1(void)
+{
+	RL(X1);
+	L(Y1);
+	U(Y1);
+	RU(X1);
+
+	L(Y1);
+	RL(X1);
+	RU(X1);
+	U(Y1);
+
+	L(Y1);
+	WL(X1);
+	WU(X1);
+	U(Y1); // should fail
+}
+
 /*
  * read_lock(A)
  * spin_lock(B)
@@ -2062,6 +2105,10 @@ void locking_selftest(void)
 	pr_cont("             |");
 	dotest(rwsem_ABBA3, FAILURE, LOCKTYPE_RWSEM);
 
+	print_testname("chain cached mixed R-L/L-W ABBA");
+	pr_cont("             |");
+	dotest(rlock_chaincache_ABBA1, FAILURE, LOCKTYPE_RWLOCK);
+
 	printk("  --------------------------------------------------------------------------\n");
 
 	/*
-- 
2.28.0

