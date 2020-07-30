Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1AF3C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 06:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B11A320578
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 06:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gxdZvpKd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbgG3GLM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 02:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbgG3GKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 02:10:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18D5C0619D2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 23:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=kyDnkIZfiYc5HdpHKygOWGKf//8LSrRaf0oSdcv2LvI=; b=gxdZvpKd/lKAvmXRruzM9/nq6i
        WQSWgWC1Y03n1F38oxAGewQpNuk8uvmETqa24NmmumvPaVZCKzO6eG+8JkImSVu3JyWTZZIuGSqHW
        9bFR7ldCXzQ0EW4s2bDaoOn6KuGRADZP82u8orVOJ3SvBdorfmeKAlPmwIa+OR7D1V86b+dNti8Ws
        upJyxcjwxCVqwb5g/cinEzdsCNa3lwxpaFr0824RrNou5YG/eqtY3jqkZZhdMCkGcEfH4jkuE25Nl
        zy+H7/KH7xu0NMkQpB4CoVec86qk/CNAbCN7+Ur3aQITdHgv0PLW2UwN7A/1bwYPqyI6yPTyHYs6t
        +22QCOGA==;
Received: from 138.57.168.109.cust.ip.kpnqwest.it ([109.168.57.138] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k11lx-0007UG-5D; Thu, 30 Jul 2020 06:10:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/8] modules: mark ref_module static
Date:   Thu, 30 Jul 2020 08:10:20 +0200
Message-Id: <20200730061027.29472-2-hch@lst.de>
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

ref_module isn't used anywhere outside of module.c.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/module.h | 1 -
 kernel/module.c        | 6 ++----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 2e6670860d275f..f1fdbeef2153a8 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -657,7 +657,6 @@ static inline void __module_get(struct module *module)
 #define symbol_put_addr(p) do { } while (0)
 
 #endif /* CONFIG_MODULE_UNLOAD */
-int ref_module(struct module *a, struct module *b);
 
 /* This is a #define so the string doesn't get put in every .o file */
 #define module_name(mod)			\
diff --git a/kernel/module.c b/kernel/module.c
index aa183c9ac0a256..17d64dae756c80 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -869,7 +869,7 @@ static int add_module_usage(struct module *a, struct module *b)
 }
 
 /* Module a uses b: caller needs module_mutex() */
-int ref_module(struct module *a, struct module *b)
+static int ref_module(struct module *a, struct module *b)
 {
 	int err;
 
@@ -888,7 +888,6 @@ int ref_module(struct module *a, struct module *b)
 	}
 	return 0;
 }
-EXPORT_SYMBOL_GPL(ref_module);
 
 /* Clear the unload stuff of the module. */
 static void module_unload_free(struct module *mod)
@@ -1169,11 +1168,10 @@ static inline void module_unload_free(struct module *mod)
 {
 }
 
-int ref_module(struct module *a, struct module *b)
+static int ref_module(struct module *a, struct module *b)
 {
 	return strong_try_module_get(b);
 }
-EXPORT_SYMBOL_GPL(ref_module);
 
 static inline int module_unload_init(struct module *mod)
 {
-- 
2.27.0

