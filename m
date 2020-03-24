Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 977D1C41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 716E42145D
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585064242;
	bh=kCyXQDXBIacIOUUlvhRJP7/5AucaMFFeuDD1X4ZYGzU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Q4aeVbuIictN4fVRQ89A0pb7Grd5bEoJZFgbbAprtv2e44nFerdN0JHXlu/Po3VBQ
	 DqkTIEbXDkPkzwZBbQmigDr5jhOVrwrZXBgVYAp1tA5ccmSb/MOOTkqrmofVxvY5Sq
	 25PVquHbCs3jJnNrp7WeorRHrgkbCCt5sbdZI/oo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbgCXPhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 11:37:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:59912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728461AbgCXPhL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 11:37:11 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABAE920788;
        Tue, 24 Mar 2020 15:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585064230;
        bh=kCyXQDXBIacIOUUlvhRJP7/5AucaMFFeuDD1X4ZYGzU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GrgxtSjO4ZBVgDGYO3uktGvMiyQriu3pRSakNzRBQWUfKNtpnF7oU0G8scgd12GVg
         A3FpQschv588Hn7cxGwCHRRLAkzViGpNxQzO0scK0UflIVu19AJaokpPr3RpHjk5aH
         ArP86APbCECHDZzC7+xj2K9YPxpHKirHDN8CeVkc=
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
Subject: [RFC PATCH 08/21] Revert "list: Use WRITE_ONCE() when initializing list_head structures"
Date:   Tue, 24 Mar 2020 15:36:30 +0000
Message-Id: <20200324153643.15527-9-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200324153643.15527-1-will@kernel.org>
References: <20200324153643.15527-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 2f073848c3cc8aff2655ab7c46d8c0de90cf4e50.

There is no need to use WRITE_ONCE() to initialise a non-RCU 'list_head'.

Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 include/linux/list.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/list.h b/include/linux/list.h
index c7331c259792..b86a3f9465d4 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -32,7 +32,7 @@
  */
 static inline void INIT_LIST_HEAD(struct list_head *list)
 {
-	WRITE_ONCE(list->next, list);
+	list->next = list;
 	list->prev = list;
 }
 
-- 
2.20.1

