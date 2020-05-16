Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5697C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 12:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4613620657
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 12:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=upsuper.org header.i=@upsuper.org header.b="k1jxtJnA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hMFSyP8F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbgEPMQD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 08:16:03 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:40491 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726206AbgEPMQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 08:16:02 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id DEB64756;
        Sat, 16 May 2020 08:16:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sat, 16 May 2020 08:16:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=upsuper.org; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=Zt/FWJRlMEXVjtEvqt6xhwcFyg
        knWVGvxWfMOv1GivE=; b=k1jxtJnA2hB8vmS7P+FDvnAqfOEzBlMDb/Q6tiQ2oL
        NHaROONVRuCctqsqeRTGRpLtvjngEo/VtutkHZlpQaX6l/I0GcM6kwXRc5HSeNsM
        I1IpUmFKircg2GvKPA3ZGWBBIwQ5MmrWwy+h207VgYRpkuohXVByAdCHbtthGQYx
        qUXB9OpSU24SqnSMFSvkg4FzUpEnil+4lsaxAQm6z0bRp3ufc1s6COW3qmBPhDMV
        xzwDgrDZorPIZIUq8MmEdwQiSbL7VcmIXjLlI2pBWzwCZinXeXMcd4VUPg6DHLtA
        6XTOyGKlx6EJxzqbQV6NDKYbrVD6hGZowy4+j8Td6PiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=Zt/FWJRlMEXVjtEvq
        t6xhwcFygknWVGvxWfMOv1GivE=; b=hMFSyP8FwTAoYMBYv11r0qIKuxz/C16ou
        WUzKrPUo0XMwDN677BJA4xJOnSqDRpyTyL0g15o1yCqSnvTTq7L6tF0spdAP+Mzx
        i8/0hXeF3Ugp6IwSW3QRqt17xdAv+NWWrrl2LV8OEVceGuccUVdaz4RNiAJbN06m
        ks7nJxIYpVLCNcrCrIfMg+wxNPFpEU20XvS+fbhJ70Tp5VgmwGvoh740smLqAeGc
        5MIR1tNm50m6EM/Qm5Q63AB8qUqG/D6DCG59MFXyidQK9fiUdFNcXv35ygfW7R8f
        NhU/yfKjGZTSB6Gi+TLARaY7mLvEReCQJXwUQ4s4iQGF1G4azWRyQ==
X-ME-Sender: <xms:gdm_XtgGASzIVN-WdZWKWtgSqSrszCwNXzMlHUmvh-ITctVsWtq3GQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddttddghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepighiughorhhnucfsuhgrnhcuoehmvgesuhhpshhuphgvrhdrohhr
    gheqnecuggftrfgrthhtvghrnhepuedukeejfeeludfggfdtffetiefgueefudeuudeuue
    etledtkedtgfffjefhheeunecukfhppedukedtrdduhedtrdeijedrvdehudenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmvgesuhhpshhuph
    gvrhdrohhrgh
X-ME-Proxy: <xmx:gdm_XiAWrI-GO9y36Vvb1XZe6_PEuMaaeVHisyaeUg1oMCLZmQ_xtw>
    <xmx:gdm_XtGDBuU3blK4tQYxNpCqjbiFDrNCDAU4CyclEM5rCao5cK19_w>
    <xmx:gdm_XiRSw2Vtmv9WWzeUvndfB7xEdZRWPH6Ax8pRN_DqmoKb3YA3GA>
    <xmx:gdm_XvvsUOm-4yykf5JX2hfAng4zrasLg4FL2nX7102zdc35EL7umg>
Received: from localhost.localdomain (180-150-67-251.b49643.syd.nbn.aussiebb.net [180.150.67.251])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2A2013280064;
        Sat, 16 May 2020 08:15:59 -0400 (EDT)
From:   Xidorn Quan <me@upsuper.org>
To:     linux-kernel@vger.kernel.org
Cc:     Balbir Singh <bsingharora@gmail.com>, Xidorn Quan <me@upsuper.org>
Subject: [PATCH] taskstats: set version field for tgid exit
Date:   Sat, 16 May 2020 22:15:35 +1000
Message-Id: <20200516121535.387997-1-me@upsuper.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, an aggregated taskstats struct for task group exit does not
have its version field set. This patch fixes it.

Signed-off-by: Xidorn Quan <me@upsuper.org>
---
Users of taskstats may expect that version of the struct is always set
up properly, so that they can check whether it's supported.
---
 kernel/taskstats.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/taskstats.c b/kernel/taskstats.c
index e2ac0e37c4ae..c646b27f18ac 100644
--- a/kernel/taskstats.c
+++ b/kernel/taskstats.c
@@ -258,18 +258,21 @@ static int fill_stats_for_tgid(pid_t tgid, struct taskstats *stats)
 static void fill_tgid_exit(struct task_struct *tsk)
 {
 	unsigned long flags;
+	struct taskstats *stats;
 
 	spin_lock_irqsave(&tsk->sighand->siglock, flags);
-	if (!tsk->signal->stats)
+	stats = tsk->signal->stats;
+	if (!stats)
 		goto ret;
 
 	/*
 	 * Each accounting subsystem calls its functions here to
 	 * accumalate its per-task stats for tsk, into the per-tgid structure
 	 *
-	 *	per-task-foo(tsk->signal->stats, tsk);
+	 *	per-task-foo(stats, tsk);
 	 */
-	delayacct_add_tsk(tsk->signal->stats, tsk);
+	delayacct_add_tsk(stats, tsk);
+	stats->version = TASKSTATS_VERSION;
 ret:
 	spin_unlock_irqrestore(&tsk->sighand->siglock, flags);
 	return;
-- 
2.25.1

