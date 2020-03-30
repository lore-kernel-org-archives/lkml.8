Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A20C2D0ED
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 02:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CD452078B
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 02:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="e/QROEfb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729280AbgC3CeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 22:34:01 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33105 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729211AbgC3Cdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 22:33:49 -0400
Received: by mail-qt1-f195.google.com with SMTP id c14so13969411qtp.0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 19:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nfe8DrKWUp4DznQJ7QwjX25sDztlI0Q1Kzc2EbjhIfI=;
        b=e/QROEfb5RGTR9IB9T4I6da+BeTQWc1g0g4Y4IB6QTSmalMQrHGbXLRXYVq0YbVzhs
         tP2sTlESNLvrtJivJplrhzgd3CeNe5CxFhf+jkbqQ4hFWDiT7AJDlWveUX3cErsFRXs6
         BxPFwUArDnqMXIc2Ozny0JZzGurm8NA5J/8uE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nfe8DrKWUp4DznQJ7QwjX25sDztlI0Q1Kzc2EbjhIfI=;
        b=KcviISCiq31y5bGFTS++unH0cfrQ1zHE6l1Im16MEQPsCnh8DkQL+9n1S6JNKzWKg3
         wSDpV7RaZrLiqEhm28D2jokOsRw01UmmSiSyh/g5qbhFPQ1gTjBaG+mq9o8/iPVuaUQw
         2zHKvJjBpIO6ljAMGxQoNujesuSNw3Ph1CuWRPRCCqN/s1iGUiAl8e8i72Fmc9vctLvk
         pSFz9vRkTzsoY9qeJ79JHw/xkrgNBe5gaW50xrt6RIbr1XGW9e6k1aWQ8UXJRLPAgTos
         cHQOZjhCLSdNJxzh1aTLjVuBPlEdekZGSHUM3WmgMW6uF8cTooh52edaY09QOAbVZEYt
         xcZA==
X-Gm-Message-State: ANhLgQ11wvDN0GUYqvuSY0XUqr/QKBa+tF5jXLjP0AlaSInSqHYV1vhb
        NFU4npSZzxSXnl19WGt5oWYXfC0gDO4=
X-Google-Smtp-Source: ADFU+vte8V+MFLpGv25SbcL8/a36+3V3dZDn+RHDRlNYMBkkicXPxgyi30CKdwoHh7ULy/2SwK0YqQ==
X-Received: by 2002:ac8:922:: with SMTP id t31mr9208234qth.95.1585535628345;
        Sun, 29 Mar 2020 19:33:48 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id q15sm10030625qtj.83.2020.03.29.19.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 19:33:48 -0700 (PDT)
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
Subject: [PATCH 17/18] rcu/tree: Simplify is_vmalloc_addr expression
Date:   Sun, 29 Mar 2020 22:32:47 -0400
Message-Id: <20200330023248.164994-18-joel@joelfernandes.org>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
In-Reply-To: <20200330023248.164994-1-joel@joelfernandes.org>
References: <20200330023248.164994-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No code change, small refactor.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 56c9e102a901d..311d216c7faa7 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3104,7 +3104,7 @@ kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
 		return false;
 
 	lockdep_assert_held(&krcp->lock);
-	idx = !is_vmalloc_addr(ptr) ? 0:1;
+	idx = !!is_vmalloc_addr(ptr);
 
 	/* Check if a new block is required. */
 	if (!krcp->bkvhead[idx] ||
-- 
2.26.0.rc2.310.g2932bb562d-goog

