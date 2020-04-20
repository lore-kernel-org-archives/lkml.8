Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A84C54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 15:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4682F20B1F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 15:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Z+Qm7CKb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbgDTPjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 11:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728141AbgDTPjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 11:39:01 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54F4C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 08:39:00 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id l78so11041541qke.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 08:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JpNyrgYA3htIrh6HLUo7S277cNsWy/y7XkRP9BSrmKw=;
        b=Z+Qm7CKbnveSdWAianHpq6Bk2bpgcq5soPc6fqFHZTx3M/ZyajEzvaenc8O78XePsY
         9vEGI1DNJCHpUQ6V4h5GSZqlnAvWAQ9VoRm1XH8EqdRHbtkvZlZcBsUoh/k6jTplBa5Y
         0PZd7SpzMiDsMRhFZt6FJcjS3uReRzZzJvQzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JpNyrgYA3htIrh6HLUo7S277cNsWy/y7XkRP9BSrmKw=;
        b=aNB/BQGd84id3x22c1YrhfBggtn7uMtmt+epY4mhY3KtR1BN5f+xdnzfGmZcvrvNaK
         QGqz7u/2BfgMYKu8Le0MB1+LeWjzs79e/r+X8CKjVW3Eleoh1r2dqXCpSxoEWl6EquSQ
         9LNikEYdXQlXT8jkB9poYiKanK42uIcZSQNu60Gm8EG9BnNAjN5j/0vFvCuQLQoaTpOA
         mEXm0dOpP2Q6ABsj/7RtlV6P0iM39gQoVBzhpfWs184SboXN6FJCRHAHm9M85hjH5B/D
         Tp3lRLyv6wTb8l/rRcUw5X7RTMyiFNLWqrteUjsklO8PvUtjOsNL5zFfquGKP6ww1W2x
         OcrQ==
X-Gm-Message-State: AGi0PuYBgTlJHBbIAOPADn7SwzREu4h6SsJ5gv2+cjw9Bwi5mFt1Puu1
        xviXnnTRiwSofdUKPZxHHGq43b4ou7k=
X-Google-Smtp-Source: APiQypKol63JouAeuLb5mpFMkJV3JzptwhczDOkelPwwxN3CvMFjljQ6nMPEmrwwoF+UMXOJZvTl0A==
X-Received: by 2002:a37:2e43:: with SMTP id u64mr16111512qkh.386.1587397139590;
        Mon, 20 Apr 2020 08:38:59 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id v16sm765453qkf.80.2020.04.20.08.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 08:38:59 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH rcu/dev -fixes 2/4] rcu/tree: Skip entry into the page allocator for PREEMPT_RT
Date:   Mon, 20 Apr 2020 11:38:35 -0400
Message-Id: <20200420153837.194532-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
In-Reply-To: <20200420153837.194532-1-joel@joelfernandes.org>
References: <20200420153837.194532-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To keep kfree_rcu() path working on raw non-preemptible sections,
prevent the optional entry into the allocator as it uses sleeping locks.
In fact, even if the caller of kfree_rcu() is preemptible, this path
still is not, as krcp->lock is a raw spinlock as done in previous
patches. With additional page pre-allocation in the works, hitting this
return is going to be much less likely soon so just prevent it for now
so that PREEMPT_RT does not break. Note that page allocation here is an
optimization and skipping it still makes kfree_rcu() work.

Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Co-developed-by: Uladzislau Rezki <urezki@gmail.com>
Signed-off-by: Uladzislau Rezki <urezki@gmail.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index cf68d3d9f5b81..cd61649e1b001 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3092,6 +3092,18 @@ kfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp,
 		if (!bnode) {
 			WARN_ON_ONCE(sizeof(struct kfree_rcu_bulk_data) > PAGE_SIZE);
 
+			/*
+			 * To keep this path working on raw non-preemptible
+			 * sections, prevent the optional entry into the
+			 * allocator as it uses sleeping locks. In fact, even
+			 * if the caller of kfree_rcu() is preemptible, this
+			 * path still is not, as krcp->lock is a raw spinlock.
+			 * With additional page pre-allocation in the works,
+			 * hitting this return is going to be much less likely.
+			 */
+			if (IS_ENABLED(CONFIG_PREEMPT_RT))
+				return false;
+
 			bnode = (struct kfree_rcu_bulk_data *)
 				__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
 		}
-- 
2.26.1.301.g55bc3eb7cb9-goog

