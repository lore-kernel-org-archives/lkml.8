Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA051C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 06:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAF2B2074B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 06:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nAYwGuB1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgG2G1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 02:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbgG2G1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 02:27:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447F0C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 23:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=bGuOkLNWGQ9LxT3B//lrGZur5LQfmYsPpu4EyjGJMyo=; b=nAYwGuB1LtHnqvggPILgzURxwP
        L9HtQxb33I5kEkN7Hf0NGgo0Sfbs2xBfMPh1m/m8jZTOMixhZ5GYIbQPKrny469RZdgTrELFolgNM
        3BuGGwDjMgrIwcHyylAbgwYCnekc4emwbh6q++8n0rpTOXg8s0APznoRnCf0AaaWF97IcX9XzDs+T
        DV1ZF9gmM2Vkzdf1mYTzoAKUOLEyoAIxSuhqireOMuT6KVURktuPPUKvwRu48Lg/1rb1tYKzX4Nfi
        2xySack/kh2U2dK3gGppYqOccB6UFqdssq7v2HkKonF3u96ebr6NRI2op34InTMKflHyERLnocwQw
        y2iTTooA==;
Received: from 089144218008.atnat0027.highway.a1.net ([89.144.218.8] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k0fYb-000415-1C; Wed, 29 Jul 2020 06:27:17 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/7] modules: mark each_symbol_section static
Date:   Wed, 29 Jul 2020 08:27:07 +0200
Message-Id: <20200729062711.13016-4-hch@lst.de>
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

