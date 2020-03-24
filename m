Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A58FFC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F30D20714
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585064308;
	bh=ri9KQLLR3eoXLGocQosIf3Ei29WyRhQ2wVoDTxEb0QY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R911F7Y8ry+qzhQo+fxi5VeTlwGo60+doCMm3ysbT3cBSm7FSyhE+1+EbQZ9Tmrgo
	 3zxLzXXEnARkOXyAbzyxv5EKKa5w73ICXioBZsLKbycQMOE2uYj362GLbec7PyZ5aG
	 DqTUo2ogbNCS6KZzOSG8avu4xzHJksne4vvYqxHs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbgCXPi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 11:38:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:60414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728657AbgCXPha (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 11:37:30 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 557A2208C3;
        Tue, 24 Mar 2020 15:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585064250;
        bh=ri9KQLLR3eoXLGocQosIf3Ei29WyRhQ2wVoDTxEb0QY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=okUik8tknQQ138Vj56YnBrEna4Dkp2mzticYyUdqn/jqnjmdfi8iA1WSYHvaE+ElE
         l0BMIexjkb1rt+rQl32RdJoYUc6XzslCr4Wct3AMllOZiubhJCtT52wo9hMR1A5OD6
         XSZYQ4u2Ra6hhjPYtbysNwwxxh7mpvHPJE4nYEL0=
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
Subject: [RFC PATCH 16/21] list_bl: Extend integrity checking in deletion routines
Date:   Tue, 24 Mar 2020 15:36:38 +0000
Message-Id: <20200324153643.15527-17-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200324153643.15527-1-will@kernel.org>
References: <20200324153643.15527-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although deleting an entry from an 'hlist_bl' optionally checks that the
node being removed is unlocked before subsequently removing it and
poisoning its pointers, we don't actually check for the poison values
like we do for other list implementations.

Add poison checks to __hlist_bl_del_valid() so that we can catch list
corruption without relying on a later fault.

Cc: Kees Cook <keescook@chromium.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 include/linux/list_bl.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/linux/list_bl.h b/include/linux/list_bl.h
index f48d8acb15b4..0839c4f43e6d 100644
--- a/include/linux/list_bl.h
+++ b/include/linux/list_bl.h
@@ -48,7 +48,15 @@ static inline bool __hlist_bl_add_head_valid(struct hlist_bl_head *h,
 static inline bool __hlist_bl_del_valid(struct hlist_bl_node *n)
 {
 	unsigned long nlock = (unsigned long)n & LIST_BL_LOCKMASK;
-	return !CHECK_DATA_CORRUPTION(nlock, "hlist_bl_del_valid: node locked");
+
+	return !(CHECK_DATA_CORRUPTION(nlock,
+			"hlist_bl_del_valid: node locked") ||
+		 CHECK_DATA_CORRUPTION(n->next == LIST_POISON1,
+			"hlist_bl_del corruption, %px->next is LIST_POISON1 (%px)\n",
+			n, LIST_POISON1) ||
+		 CHECK_DATA_CORRUPTION(n->pprev == LIST_POISON2,
+			"hlist_bl_del corruption, %px->pprev is LIST_POISON2 (%px)\n",
+			n, LIST_POISON2));
 }
 #else
 static inline bool __hlist_bl_add_head_valid(struct hlist_bl_head *h,
-- 
2.20.1

