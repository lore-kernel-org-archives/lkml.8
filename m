Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CAC4C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 22:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA7442073C
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 22:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584399421;
	bh=KdS4RMI+OlO1mZZ760HpkNw0mD5vL6J8lZuSvxr4g2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ih7VSWxLq+1b55BRmYvbtbu+jWVd99dDkQGRh6Be2tiXr1fsjp3FtwzvcSrnYu41h
	 eCdzPcSbPwGKSCLwGz9lT4I7GupA4RurPacuPRWsD44IvaUvku0NDRxIGo+bttn1Dc
	 uHCgCB9gTmlS1HVwtUn2kSPhuR3HxmQ6BylCoWPc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732927AbgCPW46 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 18:56:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:60134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732901AbgCPW44 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 18:56:56 -0400
Received: from kicinski-fedora-PC1C0HJN.thefacebook.com (unknown [163.114.132.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 848B620724;
        Mon, 16 Mar 2020 22:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584399416;
        bh=KdS4RMI+OlO1mZZ760HpkNw0mD5vL6J8lZuSvxr4g2Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rHnnmF82YVF8pEREsRVlQhzNlvi5A6Y+dsupVocbNclYPaFwCQoRZyadVUaLwcJeF
         JaVTNEPWSAXCQqELThYvXBsX9e3xXHsLuqUVxQuMiCQ/xcse8uOM70JB/rH7GKVMuG
         Pkz9gw+NlccVDJdv/a/2yFhT3+eexZM/FwTi6RDI=
From:   Jakub Kicinski <kuba@kernel.org>
To:     shuah@kernel.org, keescook@chromium.org
Cc:     luto@amacapital.net, wad@chromium.org,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Tim.Bird@sony.com, Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH v3 2/6] kselftest: factor out list manipulation to a helper
Date:   Mon, 16 Mar 2020 15:56:42 -0700
Message-Id: <20200316225647.3129354-3-kuba@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200316225647.3129354-1-kuba@kernel.org>
References: <20200316225647.3129354-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kees suggest to factor out the list append code to a macro,
since following commits need it, which leads to code duplication.

Suggested-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/kselftest_harness.h | 42 ++++++++++++---------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 5336b26506ab..aaf58fffc8f7 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -631,6 +631,29 @@
 	} \
 } while (0); OPTIONAL_HANDLER(_assert)
 
+/* List helpers */
+#define __LIST_APPEND(head, item) \
+{ \
+	/* Circular linked list where only prev is circular. */ \
+	if (head == NULL) { \
+		head = item; \
+		item->next = NULL; \
+		item->prev = item; \
+		return;	\
+	} \
+	if (__constructor_order == _CONSTRUCTOR_ORDER_FORWARD) { \
+		item->next = NULL; \
+		item->prev = head->prev; \
+		item->prev->next = item; \
+		head->prev = item; \
+	} else { \
+		item->next = head; \
+		item->next->prev = item; \
+		item->prev = item; \
+		head = item; \
+	} \
+}
+
 /* Contains all the information for test execution and status checking. */
 struct __test_metadata {
 	const char *name;
@@ -665,24 +688,7 @@ static int __constructor_order;
 static inline void __register_test(struct __test_metadata *t)
 {
 	__test_count++;
-	/* Circular linked list where only prev is circular. */
-	if (__test_list == NULL) {
-		__test_list = t;
-		t->next = NULL;
-		t->prev = t;
-		return;
-	}
-	if (__constructor_order == _CONSTRUCTOR_ORDER_FORWARD) {
-		t->next = NULL;
-		t->prev = __test_list->prev;
-		t->prev->next = t;
-		__test_list->prev = t;
-	} else {
-		t->next = __test_list;
-		t->next->prev = t;
-		t->prev = t;
-		__test_list = t;
-	}
+	__LIST_APPEND(__test_list, t);
 }
 
 static inline int __bail(int for_realz, bool no_print, __u8 step)
-- 
2.24.1

