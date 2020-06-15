Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF1DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D667420738
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592203781;
	bh=SKoWc427u2WQ+ySTNlzuiFg+QyLC8E2OTTYxAW3x/Rw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1A9atTHPxZ+YhvWNFOHgaHuHQNNrO9y0rC2pVPsGfJpNlhsKeqFIQX9omyAU0JEyo
	 lQIyhDZw8HCPnxBDnB2TykIBejRyMtKCYA8hJOIOkAI8h2c0btbKARd+Mq0rdi/KPl
	 Jtf6E/L5MuUoqj+7mK3vbd4Pd6m40o6cn62ZiMvI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728817AbgFOGtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 02:49:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:59792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728380AbgFOGrN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 02:47:13 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD9F720776;
        Mon, 15 Jun 2020 06:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592203631;
        bh=SKoWc427u2WQ+ySTNlzuiFg+QyLC8E2OTTYxAW3x/Rw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=amBYoBlqi2accr0hRky8GNr7DmUOdYvTh73O93Pq48E4J2rHi+p0YP87600m7aA7b
         nrOkw0/gjpJeyWH75iK3U3LY4XeVH+4Bo8D1qPCvai80g5pNAw2wCKMbuGAsliE3YG
         HNNco6l2cMpJW0P510PnWpLQJFrST9440nyo873s=
Received: from mchehab by mail.kernel.org with local (Exim 4.93)
        (envelope-from <mchehab@kernel.org>)
        id 1jkith-009nmX-KT; Mon, 15 Jun 2020 08:47:09 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com
Subject: [PATCH 09/29] kcsan: fix a kernel-doc warning
Date:   Mon, 15 Jun 2020 08:46:48 +0200
Message-Id: <019097f1fe10e38a04b662f1d002ecc0ce8bef8a.1592203542.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1592203542.git.mchehab+huawei@kernel.org>
References: <cover.1592203542.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One of the kernel-doc markups there have two "note" sections:

	./include/linux/kcsan-checks.h:346: warning: duplicate section name 'Note'

While this is not the case here, duplicated sections can cause
build issues on Sphinx. So, let's change the notes section
to use, instead, a list for those 2 notes at the same function.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 include/linux/kcsan-checks.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/linux/kcsan-checks.h b/include/linux/kcsan-checks.h
index 7b0b9c44f5f3..c5f6c1dcf7e3 100644
--- a/include/linux/kcsan-checks.h
+++ b/include/linux/kcsan-checks.h
@@ -337,11 +337,13 @@ static inline void __kcsan_disable_current(void) { }
  *		release_for_reuse(obj);
  *	}
  *
- * Note: ASSERT_EXCLUSIVE_ACCESS_SCOPED(), if applicable, performs more thorough
- * checking if a clear scope where no concurrent accesses are expected exists.
+ * Note:
  *
- * Note: For cases where the object is freed, `KASAN <kasan.html>`_ is a better
- * fit to detect use-after-free bugs.
+ * 1. ASSERT_EXCLUSIVE_ACCESS_SCOPED(), if applicable, performs more thorough
+ *    checking if a clear scope where no concurrent accesses are expected exists.
+ *
+ * 2. For cases where the object is freed, `KASAN <kasan.html>`_ is a better
+ *    fit to detect use-after-free bugs.
  *
  * @var: variable to assert on
  */
-- 
2.26.2

