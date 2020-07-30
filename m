Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B30C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 06:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45CBC208A9
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 06:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dLvMGyxs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbgG3GKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 02:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgG3GKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 02:10:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E897C0619D2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 23:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=bGuOkLNWGQ9LxT3B//lrGZur5LQfmYsPpu4EyjGJMyo=; b=dLvMGyxsfes/Jk6F2a0+rxFfNd
        ZKt+nGGoSQ3bNhLC61WMDBAIakv6sw8YEfvbr7Y1aKv7MEwaeBw3HWJGscNLFjcQpbsXQwoH4x0x/
        3mFKAAaFgAfccRLXQLEq2Wl4QO5m0uhniUwXxaRiBw1AIpbAvFTfU3BHbvKq0FXVbgGN2wWRWS84x
        YNPQueEIQuC5RcJEbItHyQho+LcDOTeA4X4DWsBti9n+dXAISVWxZSdHg2ti2OzoLN7jV38rxAjCw
        vTozX5PQ7lu8sV+2hYyOSoWhsENOTTfmfNT/Skr1rj26ntkfKUU15aoQfrU5WjZ97fnFKLuqm6Hdi
        1gQWri0w==;
Received: from 138.57.168.109.cust.ip.kpnqwest.it ([109.168.57.138] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k11m0-0007UU-6s; Thu, 30 Jul 2020 06:10:36 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/8] modules: mark each_symbol_section static
Date:   Thu, 30 Jul 2020 08:10:22 +0200
Message-Id: <20200730061027.29472-4-hch@lst.de>
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

each_symbol_section is only used inside of module.c.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/module.h | 9 ---------
 kernel/module.c        | 3 +--
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 90bdc362be3681..b79219eed83c56 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -590,15 +590,6 @@ struct symsearch {
 	bool unused;
 };
 
-/*
- * Walk the exported symbol table
- *
- * Must be called with module_mutex held or preemption disabled.
- */
-bool each_symbol_section(bool (*fn)(const struct symsearch *arr,
-				    struct module *owner,
-				    void *data), void *data);
-
 /* Returns 0 and fills in value, defined and namebuf, or -ERANGE if
    symnum out of range. */
 int module_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
diff --git a/kernel/module.c b/kernel/module.c
index 84da96a6d8241c..feeaa9629eb179 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -422,7 +422,7 @@ static bool each_symbol_in_section(const struct symsearch *arr,
 }
 
 /* Returns true as soon as fn returns true, otherwise false. */
-bool each_symbol_section(bool (*fn)(const struct symsearch *arr,
+static bool each_symbol_section(bool (*fn)(const struct symsearch *arr,
 				    struct module *owner,
 				    void *data),
 			 void *data)
@@ -484,7 +484,6 @@ bool each_symbol_section(bool (*fn)(const struct symsearch *arr,
 	}
 	return false;
 }
-EXPORT_SYMBOL_GPL(each_symbol_section);
 
 struct find_symbol_arg {
 	/* Input */
-- 
2.27.0

