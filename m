Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE9BC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 02:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 100C9206DB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 02:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="eAqEJ2hy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbgC3CeQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 22:34:16 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40102 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729108AbgC3Cdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 22:33:42 -0400
Received: by mail-qk1-f194.google.com with SMTP id l25so17555047qki.7
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 19:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VhRXFX915ZZjf6qHI5PrZD8T8+tPOI/Cg2isptxenk4=;
        b=eAqEJ2hyTMW80nl2AFCJp8deCuE81RBBTLR7Vl6BziuMKTXwko1qIyEOcelWccQQkl
         O5/4QbRDcxFSa30uXFamCDL0znuq14BuHKIBCF9g0pIf/GCsLfXA1UF2HikN7r+Yka5t
         f1hMLlRKNr/Ngcmd9WJd2kkyL8wzZaz0204+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VhRXFX915ZZjf6qHI5PrZD8T8+tPOI/Cg2isptxenk4=;
        b=tatfhXS7WVWRyKnIY701F8P98u78SeyQw02un91x68fn6aA+GjmTYs9B/AYe8DqPL3
         ItwG+i+7RnuCnxMSk3rQiNbH001o6MxcksmrqssDIX3PmQKe2T4dCwpj60fxjMAosNFk
         9QPs4jGefYMKEmF/Y8D2OqGNh0UNSd5OEY5STxywYkOSNUSiL+A+RfczyrdDAwNhY8bA
         zIyhBOWy6ncbZmDYHAf0l3EdtxfobCr+eHNrIWUOa7+CkltC/+Bdminypivk+e7wmtVG
         P2u0l2a4GQHzvaD6vGJwQPpCAfhEuHihHCvQUS/JJHDmO1l+Iw3ECKwdqY3OhacLoHNo
         9+NA==
X-Gm-Message-State: ANhLgQ3Oo1uxtCdWCPBiCsMST6hA3No8lxXeFeVjGZcjlvKE1srdctCK
        wHkp2ySKljptjRNj/cZ6FRz8v5c6Qug=
X-Google-Smtp-Source: ADFU+vvqvHDIo+I+fVPksGXLy4Vwf61hpGLUBlvFZuL8EfaZx88zhM/5jOyQn340v+Wi0oZQiZ1hBw==
X-Received: by 2002:a37:87c7:: with SMTP id j190mr9957429qkd.66.1585535619052;
        Sun, 29 Mar 2020 19:33:39 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id q15sm10030625qtj.83.2020.03.29.19.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 19:33:38 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>, linux-mm@kvack.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: [PATCH 08/18] rcu/tree: Clarify emergency path comment better
Date:   Sun, 29 Mar 2020 22:32:38 -0400
Message-Id: <20200330023248.164994-9-joel@joelfernandes.org>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
In-Reply-To: <20200330023248.164994-1-joel@joelfernandes.org>
References: <20200330023248.164994-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clarify emergency path comment better in kfree_rcu().

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 95d1f5e20d5ec..8dfa4b32e4d00 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2924,9 +2924,10 @@ static void kfree_rcu_work(struct work_struct *work)
 	}
 
 	/*
-	 * vmalloc() pointers end up here also emergency case. It can
-	 * happen under low memory condition when an allocation gets
-	 * failed, so the "bulk" path can not be temporary maintained.
+	 * We can end up here either with 1) vmalloc() pointers or 2) were low
+	 * on memory and could not allocate a bulk array. It can happen under
+	 * low memory condition when an allocation gets failed, so the "bulk"
+	 * path can not be temporarly used.
 	 */
 	for (; head; head = next) {
 		unsigned long offset = (unsigned long)head->func;
-- 
2.26.0.rc2.310.g2932bb562d-goog

