Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 073CDC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 19:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C24CD20756
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 19:28:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rcWMKzQG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730096AbgFOT2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 15:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729647AbgFOT2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 15:28:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88540C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 12:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=bxE5+wON8aWjefwp90f/TBXJRL9rZflW6Zz1LiSTctg=; b=rcWMKzQGHlNqR5M2sEeGUmyDoU
        VswsHnC5ifQ16KXix+iGOqNqCN60tXZ4nvGwPwpPJ89w48hBUIBiAYjXB469YtsPH25Q31wWTEsEE
        UYCXmF20TbUtEyuug+7hUNwrRAsUBvQOA6vHXEExfLu++14dcSFX1TOPtv4nBThGtK5IMtKTXRaD2
        6KBs8VLwONVRHiDlT9MEfrybG2i8KtlxKvvWTSw0O7dsfxGadWu7KeVlofL9gixx9TFMkTYCim1vt
        y4JzqujjHe9fWJxUD6OPLou/xPMOG2O2vxi0j0ikt4uinkhpUNtw6iHBdYGq8Fb5f31zTXnFRysAN
        qZB6sNbw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jkum6-0007P2-QJ; Mon, 15 Jun 2020 19:28:06 +0000
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Byungchul Park <byungchul.park@lge.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] kernel/rcu/tree.c: fix kernel-doc warnings
Message-ID: <6b6af324-1c81-5b8d-bfc1-e800e9792172@infradead.org>
Date:   Mon, 15 Jun 2020 12:28:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix kernel-doc warnings:

../kernel/rcu/tree.c:959: warning: Excess function parameter 'irq' description in 'rcu_nmi_enter'
../kernel/rcu/tree.c:3006: warning: Function parameter or member 'count' not described in 'kfree_rcu_cpu'

Fixes: cf7614e13c8f ("rcu: Refactor rcu_{nmi,irq}_{enter,exit}()")
Fixes: 9154244c1ab6 ("rcu/tree: Add a shrinker to prevent OOM due to kfree_rcu() batching")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Byungchul Park <byungchul.park@lge.com>
Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
---
Note: The first Fixes: commit ID might be incorrect.

 kernel/rcu/tree.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- linux-next-20200615.orig/kernel/rcu/tree.c
+++ linux-next-20200615/kernel/rcu/tree.c
@@ -944,7 +944,6 @@ void __rcu_irq_enter_check_tick(void)
 
 /**
  * rcu_nmi_enter - inform RCU of entry to NMI context
- * @irq: Is this call from rcu_irq_enter?
  *
  * If the CPU was idle from RCU's viewpoint, update rdp->dynticks and
  * rdp->dynticks_nmi_nesting to let the RCU grace-period handling know
@@ -2986,6 +2985,7 @@ struct kfree_rcu_cpu_work {
  * @monitor_work: Promote @head to @head_free after KFREE_DRAIN_JIFFIES
  * @monitor_todo: Tracks whether a @monitor_work delayed work is pending
  * @initialized: The @lock and @rcu_work fields have been initialized
+ * @count: Number of objects for which GP not started
  *
  * This is a per-CPU structure.  The reason that it is not included in
  * the rcu_data structure is to permit this code to be extracted from
@@ -3001,7 +3001,6 @@ struct kfree_rcu_cpu {
 	struct delayed_work monitor_work;
 	bool monitor_todo;
 	bool initialized;
-	// Number of objects for which GP not started
 	int count;
 };
 


