Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A90C2BAEE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51D0920788
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585064226;
	bh=tpwxeWGxCRW2edSpkeAxy800Wtnff4M8NvYgHsczp9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E7iEXnoldXoNosjuGGzz9iqzy/K0ZJluEk/XY5dliANt4RVikigyafd+pXaQQildG
	 39lMycJzrjb+BdlKpUhLOXNoN8oZ2eRd6zBJYJ2j2s0W4vX9VrPk4chI69IB7dUmww
	 kMYwRX5IO+ib9JbhNzVn4xSMBA8Kaunq3MdQrLtg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbgCXPhF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 11:37:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:59660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727216AbgCXPhD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 11:37:03 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D131208C3;
        Tue, 24 Mar 2020 15:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585064223;
        bh=tpwxeWGxCRW2edSpkeAxy800Wtnff4M8NvYgHsczp9I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GyC+w6VY0uSmE3ApXjwUpwX5/upSsRk4J8nsl07WC3p5tqV2i8jPvEAuKAlK6VLOA
         6h8GgVtcwHzQNW0BOcMkN5/RquTjZm8tEQE+LAKF/f/euL8+wROPI3BYs1MoQnllOt
         1IdzcQkQe3HLHySmnXBvNborGuNtuj9/B5bZ0U5g=
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
Subject: [RFC PATCH 05/21] list: Comment missing WRITE_ONCE() in __list_del()
Date:   Tue, 24 Mar 2020 15:36:27 +0000
Message-Id: <20200324153643.15527-6-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200324153643.15527-1-will@kernel.org>
References: <20200324153643.15527-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although __list_del() is called from the RCU list implementation, it
omits WRITE_ONCE() when updating the 'prev' pointer for the 'next' node.
This is reasonable because concurrent RCU readers only access the 'next'
pointers.

Although it's obvious after reading the code, add a comment.

Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 include/linux/list.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/list.h b/include/linux/list.h
index 4d9f5f9ed1a8..ec1f780d1449 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -109,6 +109,7 @@ static inline void list_add_tail(struct list_head *new, struct list_head *head)
  */
 static inline void __list_del(struct list_head * prev, struct list_head * next)
 {
+	/* RCU readers don't read the 'prev' pointer */
 	next->prev = prev;
 	WRITE_ONCE(prev->next, next);
 }
-- 
2.20.1

