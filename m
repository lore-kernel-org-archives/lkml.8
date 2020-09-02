Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A14BC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CF52208C7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="fXFPwlL5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WKrEjAcS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbgIBSGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 14:06:48 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:51949 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727881AbgIBSGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 14:06:35 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 496145C019E;
        Wed,  2 Sep 2020 14:06:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 02 Sep 2020 14:06:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm1; bh=ITRQskCpKb2rU
        yJNQp9somjEBq9yHU8r9R8TpD8Y4Pk=; b=fXFPwlL5k+gkNJiXxZ5ClVHlaUVGi
        gtfCPgn2MBp0mOe9Lu6IIkTsODzkQJcg8V7fL2CM0BBuWGynbWG4rXsGwlbFGz8e
        G/HGDh7CERpIhH1kpx2TJkCw4Tag6GNVAT42nLSOPhLqeQnrH1HmIyiu/4/gVu/2
        jUDd66Zevo8pGJ1x1lkRpoWlxKhzupkBSzsVW1jDsNmaXefRxOlXcli3LxFHvLcT
        7QdJ1l7ppTNte3t+q40IFB+N3Gmkzux+mzLJo0y3ZSeeR+EThGHekPClLml+q6x0
        q0x1dqMVNXk4JxYezuYe0/3X0xgMFeBS1jh2K+uU7WEaHdtmG4HOWVSnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=ITRQskCpKb2rUyJNQp9somjEBq9yHU8r9R8TpD8Y4Pk=; b=WKrEjAcS
        JqCI2RSIGYdxYwrLtNgf+P3JV9iETBJZslPss8x7KdAGK4Ru448SDdqEUheYqou8
        Ik+8M+bYu1q7VdeM1zGFSIcoCiVtbbD809s9klTZmY9PKIJbYo4BtRb6hDwlnqmf
        sf7FAHDiA53lcxA6IuuuXMavHIxBjd0Qni1AzwswRz86Pe9XCBdsF97bn8YW2Mbj
        J8eAaNYisgzhkr/r9K3npLgYIBMHWKIHO2DNCED7FimVEi0Q3s6HKFzKsBzkfTOW
        qp9285W7mlITOYW67O22Y5nq05vT9Ic+cSn5yuawSD/StIi1k3v8msMX+TG/RnoD
        cQU29CoZjKcJ5A==
X-ME-Sender: <xms:J99PX2PsE8cAS4CsBuD6FEqKMo6O6kDlyq8bYHehBxUnI05BKF3M0Q>
    <xme:J99PX0-0Frdzkz_h1eqaTlJPbU37sysCK7LVvzZoeI2oFosaCX8ILnXaCNgHbhlrv
    PbD5iv5KuYov3e8Jw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudefledguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpegkihcu
    jggrnhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeduhf
    ffveektdduhfdutdfgtdekkedvhfetuedufedtgffgvdevleehheevjefgtdenucfkphep
    uddvrdegiedruddtiedrudeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpeiiihdrhigrnhesshgvnhhtrdgtohhm
X-ME-Proxy: <xmx:J99PX9QX3gzIe9wA9tZYpujfpnBkoizyMsH0t9RgyIHcAyVWyYEDcw>
    <xmx:J99PX2sJTBhf-W3EjyFZ1uAReqz8jjmtzbffqqVQYoa_JtKZ4F0fHg>
    <xmx:J99PX-fovV33Fr8KmpZJbyOMeJONQg9l5_dM2d7ZrP8UybX-kDAYEA>
    <xmx:KN9PX0vwYfDOHIGRqdjRGLZStFP8PLbb4v-yQXhFe361VpX49RoWng>
Received: from nvrsysarch6.NVidia.COM (unknown [12.46.106.164])
        by mail.messagingengine.com (Postfix) with ESMTPA id E685730600B4;
        Wed,  2 Sep 2020 14:06:30 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     linux-mm@kvack.org, Roman Gushchin <guro@fb.com>
Cc:     Rik van Riel <riel@surriel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Nellans <dnellans@nvidia.com>,
        linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>
Subject: [RFC PATCH 01/16] mm: add pagechain container for storing multiple pages.
Date:   Wed,  2 Sep 2020 14:06:13 -0400
Message-Id: <20200902180628.4052244-2-zi.yan@sent.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200902180628.4052244-1-zi.yan@sent.com>
References: <20200902180628.4052244-1-zi.yan@sent.com>
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

When depositing page table pages for 1GB THPs, we need 512 PTE pages +
1 PMD page. Instead of counting and depositing 513 pages, we can use the
PMD page as a leader page and chain the rest 512 PTE pages with ->lru.
This, however, prevents us depositing PMD pages with ->lru, which is
currently used by depositing PTE pages for 2MB THPs. So add a new
pagechain container for PMD pages.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 include/linux/pagechain.h | 73 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 include/linux/pagechain.h

diff --git a/include/linux/pagechain.h b/include/linux/pagechain.h
new file mode 100644
index 000000000000..be536142b413
--- /dev/null
+++ b/include/linux/pagechain.h
@@ -0,0 +1,73 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * include/linux/pagechain.h
+ *
+ * In many places it is efficient to batch an operation up against multiple
+ * pages. A pagechain is a multipage container which is used for that.
+ */
+
+#ifndef _LINUX_PAGECHAIN_H
+#define _LINUX_PAGECHAIN_H
+
+#include <linux/slab.h>
+
+/* 14 pointers + two long's align the pagechain structure to a power of two */
+#define PAGECHAIN_SIZE	13
+
+struct page;
+
+struct pagechain {
+	struct list_head list;
+	unsigned int nr;
+	struct page *pages[PAGECHAIN_SIZE];
+};
+
+static inline void pagechain_init(struct pagechain *pchain)
+{
+	pchain->nr = 0;
+	INIT_LIST_HEAD(&pchain->list);
+}
+
+static inline void pagechain_reinit(struct pagechain *pchain)
+{
+	pchain->nr = 0;
+}
+
+static inline unsigned int pagechain_count(struct pagechain *pchain)
+{
+	return pchain->nr;
+}
+
+static inline unsigned int pagechain_space(struct pagechain *pchain)
+{
+	return PAGECHAIN_SIZE - pchain->nr;
+}
+
+static inline bool pagechain_empty(struct pagechain *pchain)
+{
+	return pchain->nr == 0;
+}
+
+/*
+ * Add a page to a pagechain.  Returns the number of slots still available.
+ */
+static inline unsigned int pagechain_deposit(struct pagechain *pchain, struct page *page)
+{
+	VM_BUG_ON(!pagechain_space(pchain));
+	pchain->pages[pchain->nr++] = page;
+	return pagechain_space(pchain);
+}
+
+static inline struct page *pagechain_withdraw(struct pagechain *pchain)
+{
+	if (!pagechain_count(pchain))
+		return NULL;
+	return pchain->pages[--pchain->nr];
+}
+
+void __init pagechain_cache_init(void);
+struct pagechain *pagechain_alloc(void);
+void pagechain_free(struct pagechain *pchain);
+
+#endif /* _LINUX_PAGECHAIN_H */
+
-- 
2.28.0

