Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFCD2C54FCF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A49B2080C
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585064233;
	bh=E5Moj5+y/0jzpIXcSSmKlyGx50dCga0UNXCRHKQpICA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ihOP1kkRXweLL8U6za22Estv98HA+csgQLtNjMYHiMDroMqMvL0iKFe7zjtKHTMyb
	 +MI5dhYIUxp8A/PCs/jnlEIauVMwyrP4Xo1psnt1z5QYxZWB6tIdUfbA/O8oSZF4M/
	 hHpG9cWvUb6idCr47Vwy3h7jYZ5NRLWHLvaT+eWI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbgCXPhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 11:37:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:59840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727980AbgCXPhI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 11:37:08 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4410920714;
        Tue, 24 Mar 2020 15:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585064228;
        bh=E5Moj5+y/0jzpIXcSSmKlyGx50dCga0UNXCRHKQpICA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K0XCoPBmOAuAnOLhnFxsmrVj3APUzwevP3MHRSPvNOqQpOQk4SlUvqzt5tZ9yQBaw
         cVUtxXlQLwN2SlAd2f9tuZGU90i0Rf+WYVcKWIwMhwoO+ksYJWGR7UZcms1SXzoTfd
         ET4KxQiaQRXLzCGEWqkXM5HVoq9uxtwAjemJraF4=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>, Eric Dumazet <edumazet@google.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Maddie Stone <maddiestone@google.com>,
        Marco Elver <elver@google.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com,
        kernel-hardening@lists.openwall.com
Subject: [RFC PATCH 07/21] Revert "list: Use WRITE_ONCE() when adding to lists and hlists"
Date:   Tue, 24 Mar 2020 15:36:29 +0000
Message-Id: <20200324153643.15527-8-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200324153643.15527-1-will@kernel.org>
References: <20200324153643.15527-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 1c97be677f72b3c338312aecd36d8fff20322f32.

There is no need to use WRITE_ONCE() for the non-RCU list and hlist
implementations.

Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 include/linux/list.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/list.h b/include/linux/list.h
index ec1f780d1449..c7331c259792 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -70,7 +70,7 @@ static inline void __list_add(struct list_head *new,
 	next->prev = new;
 	new->next = next;
 	new->prev = prev;
-	WRITE_ONCE(prev->next, new);
+	prev->next = new;
 }
 
 /**
@@ -843,7 +843,7 @@ static inline void hlist_add_head(struct hlist_node *n, struct hlist_head *h)
 	n->next = first;
 	if (first)
 		first->pprev = &n->next;
-	WRITE_ONCE(h->first, n);
+	h->first = n;
 	n->pprev = &h->first;
 }
 
@@ -858,7 +858,7 @@ static inline void hlist_add_before(struct hlist_node *n,
 	n->pprev = next->pprev;
 	n->next = next;
 	next->pprev = &n->next;
-	WRITE_ONCE(*(n->pprev), n);
+	*(n->pprev) = n;
 }
 
 /**
-- 
2.20.1

