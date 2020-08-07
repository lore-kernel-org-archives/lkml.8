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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6295C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 07:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81077221E5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 07:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNiMpaQy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbgHGHqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 03:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgHGHqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 03:46:32 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1939C061574;
        Fri,  7 Aug 2020 00:46:31 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id j187so929967qke.11;
        Fri, 07 Aug 2020 00:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fS23gDoCare77kv4LOOXMDgyVp8QUxLSpKSPVO13MxU=;
        b=GNiMpaQyiLlVoG55EXCrM9JGm3ak/XEFO8B8eIojrbv+FrBYsV+XwbHWXNB8G0HS3t
         t3UCrToZtdt4U/Ta9gRh6ITBdsEN1EKDsobpdQTGb0KuSMw70Oc+e88DkkFiU+8ZPAvW
         N0Ebx/7s1H2vT/lcWOvke3AiPUOkTPQih5au/ehFsBacGeuvXpRiv6eatysDWzCCA9Jy
         ZDg7t2m4NBDdS2BRrCTsdOeXrl4L8Sbl367rOQccN1pPxpJ9cpBljiL/Qevu32N9fH3G
         iynlTHMQyF4ZmeIn3G8OfeYJw6WNfr6gI7uKMpkhP3zthW3zh67Xz9LnJmiIzXG/8op/
         36Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fS23gDoCare77kv4LOOXMDgyVp8QUxLSpKSPVO13MxU=;
        b=M/bWeIEX3vW0Ses25CBip/J9I3WcyQKdVT9QXXGgZ1NYKnTO6UUM48OjJl3vehv/ea
         a+X0JiCo5+OPDZxqBmZwCJy2S4TVfto+1AR5+isa7ChtzPAw5+ZSx4Wddi6r+x2zSJSu
         wjO/Q1U7EKz4hjLeTdTwRIC8ySqdVO8sLwfxTrcvAoO5Vw1G/thvcueOZcf2dOYNqVty
         XrKU0m13RIF8y2rI56w+4Pqsiueo7yFTatD9fD53XbQ1pAGwARgWOJq59jp9INxdfSyW
         aB5Ih+ZpypE+xHQDQkjgQ8QNrJu0Wdri9uSZmcRQBQVIevxvVAHT+6N/flEZLXk5ttZ9
         8T8A==
X-Gm-Message-State: AOAM532uGUKJxfqshAfqS3Z/q6re0hPN4F+n4i2zhd9/lsz8vYlOkjzh
        Tgc+HpsXFUZxTmFe88EhRxQ=
X-Google-Smtp-Source: ABdhPJxB0RgTEYZw2HLf8d6b6Fg+DZsm4OjKRgm71HCenKvXnJzJk1MqSuVCdoPtFfFAfEc3z1UNrg==
X-Received: by 2002:a37:9c89:: with SMTP id f131mr11663534qke.283.1596786391055;
        Fri, 07 Aug 2020 00:46:31 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id h144sm6218259qke.83.2020.08.07.00.46.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Aug 2020 00:46:30 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 38E4927C0054;
        Fri,  7 Aug 2020 03:46:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 07 Aug 2020 03:46:30 -0400
X-ME-Sender: <xms:1gYtX2pKK6fWMZ6t4Tn1rq9ObdNZSm0OS_UIS6vbe6akpdf6HGSXAg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrkedugdduvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedvveetfefgiedutedtfeevvddvleekjeeuffffleeguefhhfejteekieeu
    ueelnecukfhppeduudegrdekhedrudektddrvdduheenucevlhhushhtvghrufhiiigvpe
    ejnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhp
    vghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnpe
    epfhhigihmvgdrnhgrmhgvsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:1gYtX0oH-N98OSs90-Rau1hstaRueJrD6PCKi5Ih_zj84Zi42TxCrA>
    <xmx:1gYtX7Puvw4kQkBll0Qkoj5Dpkw8RaRfDkzDgsstgrO2WyNM4957xg>
    <xmx:1gYtX17gFESHqHMKwr_mD3M8gfrDx2jMpEv-hf_Pw6-epgrN9nMBeQ>
    <xmx:1gYtX42P2PuaIwSULjXwiMax_cNyWXtoZvbjiLfRsgMLzWmA6Z-viA>
Received: from localhost (unknown [114.85.180.215])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5BC15306005F;
        Fri,  7 Aug 2020 03:46:27 -0400 (EDT)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC v7 17/19] Revert "locking/lockdep/selftests: Fix mixed read-write ABBA tests"
Date:   Fri,  7 Aug 2020 15:42:36 +0800
Message-Id: <20200807074238.1632519-18-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200807074238.1632519-1-boqun.feng@gmail.com>
References: <20200807074238.1632519-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit d82fed75294229abc9d757f08a4817febae6c4f4.

Since we now could handle mixed read-write deadlock detection well, the
self tests could be detected as expected, no need to use this
work-around.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 lib/locking-selftest.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index 76c314ab4f03..4264cf4b60bb 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -2273,14 +2273,6 @@ void locking_selftest(void)
 	print_testname("mixed read-lock/lock-write ABBA");
 	pr_cont("             |");
 	dotest(rlock_ABBA1, FAILURE, LOCKTYPE_RWLOCK);
-#ifdef CONFIG_PROVE_LOCKING
-	/*
-	 * Lockdep does indeed fail here, but there's nothing we can do about
-	 * that now.  Don't kill lockdep for it.
-	 */
-	unexpected_testcase_failures--;
-#endif
-
 	pr_cont("             |");
 	dotest(rwsem_ABBA1, FAILURE, LOCKTYPE_RWSEM);
 
-- 
2.28.0

