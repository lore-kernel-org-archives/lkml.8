Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5649DC18E5B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 16:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F0A920828
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 16:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Kz5wZL0Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbgCIQ4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 12:56:01 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34469 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727291AbgCIQz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 12:55:58 -0400
Received: by mail-pl1-f195.google.com with SMTP id a23so1515928plm.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 09:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pj6YU6fNBmNBvi7LLVQO3JduXJ0KuYFucC7zWHr65Nk=;
        b=Kz5wZL0QX3z5mdgkaCve7q0Sdp+qurClLFPED1kkQIlMvfvq2LXn76XIgAjzv2BpEY
         MrrucAluEYGJaWzqw0x/bEY+HXW5cOFCQV6yO52s5CqPzqQo3rju3sKmt93SqCmFKcUk
         I1huy2XaBPYVifCrA7j6DAcAmH77qVjnS0p5cEvrBH3Sty3QjN39+J3r3XuJVY7cXhOH
         6ZrxOm9Y0AepZ7lC4utyjxbrtMDXlxv5LLkGWJ+ZKXaU2o2VqjVyZYBSjYK0tDGAL2rw
         EuKfQqKzWJwXBXu1rehhNnL0e7pwGHqjlxqC266WSX+3cd+6w0wzfKJaBrU/6LIdprzf
         uxbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pj6YU6fNBmNBvi7LLVQO3JduXJ0KuYFucC7zWHr65Nk=;
        b=n6ngnnP2ufe3965St1EGzTgJV0qum+KNbclICfldNvmwmTrBpRQBg0qvT1XSIPRftX
         Z9YUEvUXx498VOuyaOVLuplBfhSoPOEt/7ohoXfLQ4PFWKdIv2VwmQIBleBNgddgQ/8E
         yc9ZWKqikoPUuvsItHZB4tUp/N5iUYfWd27XRfaLFLGcIz0ivB6UYthIBdJH/pZiIvOl
         OgbzgNnxR20oRPyQbczH8ECW4DfGwoCqPKF+p16EysGqm4/kUcp3RhPLjDYGesmYdvlg
         VXJQs2T59TCK8xU8traNsLzyKNk/gdhSO0y4AYUfvM9g3/ZjiabDjA5vBmmCFD/J96St
         9UbA==
X-Gm-Message-State: ANhLgQ3my1fDUPSh3Xvv+RJM7YGokNRf/xp7FbBBFv9FiZ82EDwU2NUO
        8cK5snU+WW2mCfnB9NrUK+GcAw==
X-Google-Smtp-Source: ADFU+vuFuIvwey8N5BijwFFLtPfOfnzzce9nnU9LlfG84PmcU+RSOSGj4b/pBpPRmjKl+djPHaBMvw==
X-Received: by 2002:a17:90b:194d:: with SMTP id nk13mr256192pjb.144.1583772956753;
        Mon, 09 Mar 2020 09:55:56 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id cm2sm104013pjb.23.2020.03.09.09.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 09:55:56 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v3 3/9] riscv: add ARCH_SUPPORTS_DEBUG_PAGEALLOC support
Date:   Tue, 10 Mar 2020 00:55:38 +0800
Message-Id: <3b6b3c18655b41306e24a96d56abe1f860a6f900.1583772574.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1583772574.git.zong.li@sifive.com>
References: <cover.1583772574.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARCH_SUPPORTS_DEBUG_PAGEALLOC provides a hook to map and unmap
pages for debugging purposes. Implement the __kernel_map_pages
functions to fill the poison pattern.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 arch/riscv/Kconfig       |  3 +++
 arch/riscv/mm/pageattr.c | 13 +++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 71fabb0ffdbe..54437d7662a5 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -133,6 +133,9 @@ config ARCH_SELECT_MEMORY_MODEL
 config ARCH_WANT_GENERAL_HUGETLB
 	def_bool y
 
+config ARCH_SUPPORTS_DEBUG_PAGEALLOC
+	def_bool y
+
 config SYS_SUPPORTS_HUGETLBFS
 	def_bool y
 
diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
index 7be6cd67e2ef..728759eb530a 100644
--- a/arch/riscv/mm/pageattr.c
+++ b/arch/riscv/mm/pageattr.c
@@ -172,3 +172,16 @@ int set_direct_map_default_noflush(struct page *page)
 
 	return walk_page_range(&init_mm, start, end, &pageattr_ops, &masks);
 }
+
+void __kernel_map_pages(struct page *page, int numpages, int enable)
+{
+	if (!debug_pagealloc_enabled())
+		return;
+
+	if (enable)
+		__set_memory((unsigned long)page_address(page), numpages,
+			     __pgprot(_PAGE_PRESENT), __pgprot(0));
+	else
+		__set_memory((unsigned long)page_address(page), numpages,
+			     __pgprot(0), __pgprot(_PAGE_PRESENT));
+}
-- 
2.25.1

