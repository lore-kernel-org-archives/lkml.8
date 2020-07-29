Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBCBC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 06:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C5B92074B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 06:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tZMAGxMG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbgG2G1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 02:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbgG2G1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 02:27:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CDBC061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 23:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=GGiUP2bVq/JP9FTtUqNBNL3J94yI7DyjZeZtZ4EfQfQ=; b=tZMAGxMGzKmkk0aBD0W6dswI9H
        6QN58eWQjJ4rjNIbGF9Vwtn6uc5MGS5R0FjceugXUy5hnSkTNJU/upS7H717TsDneDmAMM4h5hJ/7
        j2x23JR4oa72C5CTEwwcejQAa5c1w7F1WXUZY80HRtHuld7wdc4f/VknPfNuEHQOFxWKsMsk8LPMa
        kQyA1p+uKSxEJBU/V+dd9KiKvCTlAhtaPOu01JTpRfveV6asfbS6Cfw+HLBr7UEXAPUeihU00Q2jt
        bUvhYtZUDTpwmwWcG2hPOnaU7n83wCMIHw2+gVx+Y7lW3EZaoM7j8tT5qqtTI8tHyXR/deI5stqa1
        fC+A/OPw==;
Received: from 089144218008.atnat0027.highway.a1.net ([89.144.218.8] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k0fYZ-00040z-D5; Wed, 29 Jul 2020 06:27:15 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/7] modules: mark find_symbol static
Date:   Wed, 29 Jul 2020 08:27:06 +0200
Message-Id: <20200729062711.13016-3-hch@lst.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200729062711.13016-1-hch@lst.de>
References: <20200729062711.13016-1-hch@lst.de>
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

