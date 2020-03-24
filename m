Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED872C41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6A2D2073E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585064250;
	bh=NCj3N5oBB6pG2895MeRz7pky+XQDlDn73NrS+bYc6AM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qt2mUz3wgbqyAsiPZTsHIlNS+ozttaRQqbeaVv5De1p7Oik872Kg7aRhJwTQDAPkb
	 WzhNoOf64k38v1W9QAd1fOZEW95lbTtJDkK5xMLXR4HQT/RbzihAh0xuXE7FLv3WW0
	 yHJjPgakPxX8D2dLN6J1WFfLtxMAck7PaQ87jMDM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbgCXPh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 11:37:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:60152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728554AbgCXPhU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 11:37:20 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A02B9208C3;
        Tue, 24 Mar 2020 15:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585064240;
        bh=NCj3N5oBB6pG2895MeRz7pky+XQDlDn73NrS+bYc6AM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qr1GKvJaUyzDriW0KJU1HKC2q0FydemPOrJKXOPr5JKPucn0IzLnr3tNvkXG4/viU
         Utvi7LQHj9CsXJmlKMv/38ntVIUYwpRK5Dwr8UqXIIhyOffTODRpZPdtgLTshQwmb0
         5yPgVBZGdMhl8GIjxKYAl5Nf/2eRzb9jWXyEiFpM=
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
Subject: [RFC PATCH 12/21] list: Poison ->next pointer for non-RCU deletion of 'hlist_nulls_node'
Date:   Tue, 24 Mar 2020 15:36:34 +0000
Message-Id: <20200324153643.15527-13-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200324153643.15527-1-will@kernel.org>
References: <20200324153643.15527-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hlist_nulls_del() is used for non-RCU deletion of an 'hlist_nulls_node'
and so we can safely poison the ->next pointer without having to worry
about concurrent readers, just like we do for other non-RCU list
deletion primitives

Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 include/linux/list_nulls.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/list_nulls.h b/include/linux/list_nulls.h
index fd154ceb5b0d..48f33ae16381 100644
--- a/include/linux/list_nulls.h
+++ b/include/linux/list_nulls.h
@@ -99,6 +99,7 @@ static inline void __hlist_nulls_del(struct hlist_nulls_node *n)
 static inline void hlist_nulls_del(struct hlist_nulls_node *n)
 {
 	__hlist_nulls_del(n);
+	n->next = LIST_POISON1;
 	n->pprev = LIST_POISON2;
 }
 
-- 
2.20.1

