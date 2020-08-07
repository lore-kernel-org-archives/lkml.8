Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52892C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 07:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D355221E5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 07:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0NcNhoM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgHGHqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 03:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbgHGHqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 03:46:50 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E49C061574;
        Fri,  7 Aug 2020 00:46:50 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id 2so932220qkf.10;
        Fri, 07 Aug 2020 00:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e2dWfZoxJWBHNcD2Np+CST7+CSWtDbu52bWnk3EvzQ0=;
        b=j0NcNhoMepGwjKtVhk2xdYhPkiZRGOgmviLDb/QngRHurKNZyR1wOHH6QRggob2U9o
         iSS8jM71HvDmvL+b/LktDl+2GsjKYGH33RZukCSf6soCGabkSAigs59ilP6c3fNCwIVi
         /E7bj8Ew+adihamTc/F+j4O+H/3dLvueW0PyZIkVVDqOf1W8UbfDhYNAtWA1c9iQDFPE
         21AnTaUg8KFrErj+6mZtBVBtmM92vHrpmv9/bRJ+842IwOR/DyIZ0U03eXfd4qmgayUD
         0Uka7Wurr1lbIQEbfFuEXoVZ0pKn5umf9ykcvvXM/0WnfkhN6s0keL2AGvhi0PUY5Hce
         uz/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e2dWfZoxJWBHNcD2Np+CST7+CSWtDbu52bWnk3EvzQ0=;
        b=BsUyTMRvaG+ag8mYUx8892ZRilLP2cisdN1cr2GHgfdLVjLd03aPRUj7v4IPPUN7DO
         mR9d9csBitk8R239uaaWTocriplIbMYsgMOM+RoXpJvL0epTiXQqHH/f1rv9qVSbGltT
         5gzrWPFzy7407EAuVoEiLv0mxY1Qehp2k974FfVTGZs18SohcgSQRMnunxhIKQx3McBZ
         /EKGXKfJoMpi+n7QuQ+nGgmntxfRIpNS3gRDCx0bkpFPCcI+KKziOe9Ed4duuueH/duQ
         n6PeEKwGYvJnrAIjh2TEceE1f6ZkeCDagkiP2IyXxQsbBNWpZTrv8sCeaTXXg6JlgkoS
         jGJw==
X-Gm-Message-State: AOAM530cEY5VioIIP9Re1CJg6CIl1/72rdWlkKbZA3J5PlS+iUoejO0U
        PQf9y+6vqfyJjSsgSIUYi9Y=
X-Google-Smtp-Source: ABdhPJxn06QjJuVcqHCWj0+qm0Z09tRW0DxTvTzT87RNcATlwxQAl5SgxnnDmnZLVfjw254HZkkwRA==
X-Received: by 2002:a37:8405:: with SMTP id g5mr5754391qkd.286.1596786409268;
        Fri, 07 Aug 2020 00:46:49 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id y14sm7169878qtc.84.2020.08.07.00.46.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Aug 2020 00:46:48 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 6253B27C0054;
        Fri,  7 Aug 2020 03:46:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 07 Aug 2020 03:46:48 -0400
X-ME-Sender: <xms:6AYtX_FPeScM-435-ObQGmJo8BBhepnUxiKj907zoQuRbt68dJZvnQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrkedugdduvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedvveetfefgiedutedtfeevvddvleekjeeuffffleeguefhhfejteekieeu
    ueelnecukfhppeduudegrdekhedrudektddrvdduheenucevlhhushhtvghrufhiiigvpe
    eknecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhp
    vghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnpe
    epfhhigihmvgdrnhgrmhgvsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:6AYtX8Wrm8SZALLznT8KSgT7sPF4xVEz643e9F9ReLV_TBsnI7mV6g>
    <xmx:6AYtXxJ5l7mfZD9vBS6UqubGEX423dPyA1IapqngZPR7TiaeriLCeA>
    <xmx:6AYtX9EkwJkkqXNE4-9LeiSDxvsm2HQ4per288Fcl5qK7iT-bgIArA>
    <xmx:6AYtX7w7T9zjiXMfEnWeXJuvGuaqXmdNiYP6J16RDR-XcATDBfc-4A>
Received: from localhost (unknown [114.85.180.215])
        by mail.messagingengine.com (Postfix) with ESMTPA id 62B183280063;
        Fri,  7 Aug 2020 03:46:46 -0400 (EDT)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC v7 18/19] locking/selftest: Add test cases for queued_read_lock()
Date:   Fri,  7 Aug 2020 15:42:37 +0800
Message-Id: <20200807074238.1632519-19-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200807074238.1632519-1-boqun.feng@gmail.com>
References: <20200807074238.1632519-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add two self test cases for the following case:

	P0:			P1:			P2:

				<in irq handler>
	spin_lock_irq(&slock)	read_lock(&rwlock)
							write_lock_irq(&rwlock)
	read_lock(&rwlock)	spin_lock(&slock)

, which is a deadlock, as the read_lock() on P0 cannot get the lock
because of the fairness.

	P0:			P1:			P2:

	<in irq handler>
	spin_lock(&slock)	read_lock(&rwlock)
							write_lock(&rwlock)
	read_lock(&rwlock)	spin_lock_irq(&slock)

, which is not a deadlock, as the read_lock() on P0 can get the lock
because it could use the unfair fastpass.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 lib/locking-selftest.c | 104 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index 4264cf4b60bb..17f8f6f37165 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -2201,6 +2201,108 @@ static void ww_tests(void)
 	pr_cont("\n");
 }
 
+
+/*
+ * <in hardirq handler>
+ * read_lock(&A);
+ *			<hardirq disable>
+ *			spin_lock(&B);
+ * spin_lock(&B);
+ *			read_lock(&A);
+ *
+ * is a deadlock.
+ */
+static void queued_read_lock_hardirq_RE_Er(void)
+{
+	HARDIRQ_ENTER();
+	read_lock(&rwlock_A);
+	LOCK(B);
+	UNLOCK(B);
+	read_unlock(&rwlock_A);
+	HARDIRQ_EXIT();
+
+	HARDIRQ_DISABLE();
+	LOCK(B);
+	read_lock(&rwlock_A);
+	read_unlock(&rwlock_A);
+	UNLOCK(B);
+	HARDIRQ_ENABLE();
+}
+
+/*
+ * <in hardirq handler>
+ * spin_lock(&B);
+ *			<hardirq disable>
+ *			read_lock(&A);
+ * read_lock(&A);
+ *			spin_lock(&B);
+ *
+ * is not a deadlock.
+ */
+static void queued_read_lock_hardirq_ER_rE(void)
+{
+	HARDIRQ_ENTER();
+	LOCK(B);
+	read_lock(&rwlock_A);
+	read_unlock(&rwlock_A);
+	UNLOCK(B);
+	HARDIRQ_EXIT();
+
+	HARDIRQ_DISABLE();
+	read_lock(&rwlock_A);
+	LOCK(B);
+	UNLOCK(B);
+	read_unlock(&rwlock_A);
+	HARDIRQ_ENABLE();
+}
+
+/*
+ * <hardirq disable>
+ * spin_lock(&B);
+ *			read_lock(&A);
+ *			<in hardirq handler>
+ *			spin_lock(&B);
+ * read_lock(&A);
+ *
+ * is a deadlock. Because the two read_lock()s are both non-recursive readers.
+ */
+static void queued_read_lock_hardirq_inversion(void)
+{
+
+	HARDIRQ_ENTER();
+	LOCK(B);
+	UNLOCK(B);
+	HARDIRQ_EXIT();
+
+	HARDIRQ_DISABLE();
+	LOCK(B);
+	read_lock(&rwlock_A);
+	read_unlock(&rwlock_A);
+	UNLOCK(B);
+	HARDIRQ_ENABLE();
+
+	read_lock(&rwlock_A);
+	read_unlock(&rwlock_A);
+}
+
+static void queued_read_lock_tests(void)
+{
+	printk("  --------------------------------------------------------------------------\n");
+	printk("  | queued read lock tests |\n");
+	printk("  ---------------------------\n");
+	print_testname("hardirq read-lock/lock-read");
+	dotest(queued_read_lock_hardirq_RE_Er, FAILURE, LOCKTYPE_RWLOCK);
+	pr_cont("\n");
+
+	print_testname("hardirq lock-read/read-lock");
+	dotest(queued_read_lock_hardirq_ER_rE, SUCCESS, LOCKTYPE_RWLOCK);
+	pr_cont("\n");
+
+	print_testname("hardirq inversion");
+	dotest(queued_read_lock_hardirq_inversion, FAILURE, LOCKTYPE_RWLOCK);
+	pr_cont("\n");
+}
+
 void locking_selftest(void)
 {
 	/*
@@ -2318,6 +2420,8 @@ void locking_selftest(void)
 	/*
 	 * queued_read_lock() specific test cases can be put here
 	 */
+	if (IS_ENABLED(CONFIG_QUEUED_RWLOCKS))
+		queued_read_lock_tests();
 
 	if (unexpected_testcase_failures) {
 		printk("-----------------------------------------------------------------\n");
-- 
2.28.0

