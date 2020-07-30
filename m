Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA1EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 06:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECD4920656
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 06:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uppmGrPF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbgG3GLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 02:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728670AbgG3GKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 02:10:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1770BC061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 23:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=GGiUP2bVq/JP9FTtUqNBNL3J94yI7DyjZeZtZ4EfQfQ=; b=uppmGrPF4xsvgm9wggWDs0wEPO
        +Rhf5794DXq9nHrgXdPftxW6VFivsrcVGh9/v6xa/kKnWedJT5YSlNRO/OJcgEtISHv9MK/YIgmu/
        mDJjvrgmwUJsgXt7tmkDt0pyXdoG4GpQyFN+6KQrZ5435kV5/0MWjOWTTe8YqBBl3gieoKEL80NK1
        TyZz7josALf/17YAsQe4rW/dd/zIOopV8EEKNMV8iQhsJGGxpNDOXQItXIXjItSOZnRfva49wHHhX
        6ncKOnW9kUy0KflAJd5+s613HjxvXrS1e5Tf9c0LPHlB7wjen/4T5ON+puObfxLCyJoyJ3SObMjWg
        UpCi7ZdA==;
Received: from 138.57.168.109.cust.ip.kpnqwest.it ([109.168.57.138] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k11ly-0007UO-Pn; Thu, 30 Jul 2020 06:10:35 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/8] modules: mark find_symbol static
Date:   Thu, 30 Jul 2020 08:10:21 +0200
Message-Id: <20200730061027.29472-3-hch@lst.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200730061027.29472-1-hch@lst.de>
References: <20200730061027.29472-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

find_symbol is only used in module.c.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/module.h | 11 -----------
 kernel/module.c        |  3 +--
 2 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index f1fdbeef2153a8..90bdc362be3681 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -590,17 +590,6 @@ struct symsearch {
 	bool unused;
 };
 
-/*
- * Search for an exported symbol by name.
- *
- * Must be called with module_mutex held or preemption disabled.
- */
-const struct kernel_symbol *find_symbol(const char *name,
-					struct module **owner,
-					const s32 **crc,
-					bool gplok,
-					bool warn);
-
 /*
  * Walk the exported symbol table
  *
diff --git a/kernel/module.c b/kernel/module.c
index 17d64dae756c80..84da96a6d8241c 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -585,7 +585,7 @@ static bool find_exported_symbol_in_section(const struct symsearch *syms,
 
 /* Find an exported symbol and return it, along with, (optional) crc and
  * (optional) module which owns it.  Needs preempt disabled or module_mutex. */
-const struct kernel_symbol *find_symbol(const char *name,
+static const struct kernel_symbol *find_symbol(const char *name,
 					struct module **owner,
 					const s32 **crc,
 					bool gplok,
@@ -608,7 +608,6 @@ const struct kernel_symbol *find_symbol(const char *name,
 	pr_debug("Failed to find symbol %s\n", name);
 	return NULL;
 }
-EXPORT_SYMBOL_GPL(find_symbol);
 
 /*
  * Search for module by name: must hold module_mutex (or preempt disabled
-- 
2.27.0

