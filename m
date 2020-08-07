Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADAA1C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 03:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96E792086A
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 03:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i+GEGg+4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgHGDce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 23:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbgHGDcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 23:32:33 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3EEC061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 20:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=eUnkdaHloTyV6ZCpL9hfXxXifoTN9ZSTYhQr+KYbcDM=; b=i+GEGg+4reEhFPVZe7EDGKG6j1
        cMKPZf6h+Ge5eVT80QqmruweUWZ/lXb+njsVLXFA5Z4iVnnIPZBenE6jZyA2tSDYS4YYgX5rR5ouC
        ODbSrDwxiNNDH0atV4cMfMXgY+Sjwpww3F2TfdxRMxmc5R8XU2OHAUcoDzQDXNhIFCILfNUrNUCT1
        OBPKtuvGtUvzvTfkvKbwood9s7k4nUnoTywe8oEO6zuASWKk2Y2wxhYwQGeNJAMvA1vHZPixETyXK
        pSdfRlZNDFc+/gTf8EbJ6kiTZWVbNhBwx38bVhsIX4Me6g4gPbzVRRXc+6yECnSy4KJYDw3uA6wQg
        uf6E1uvQ==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k3t7P-0006nx-34; Fri, 07 Aug 2020 03:32:31 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [PATCH] kernel: printk: delete repeated words in comments
Date:   Thu,  6 Aug 2020 20:32:27 -0700
Message-Id: <20200807033227.8349-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop repeated words "the" in kernel/printk/.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 kernel/printk/printk.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20200806.orig/kernel/printk/printk.c
+++ linux-next-20200806/kernel/printk/printk.c
@@ -2461,7 +2461,7 @@ void console_unlock(void)
 	 *
 	 * console_trylock() is not able to detect the preemptive
 	 * context reliably. Therefore the value must be stored before
-	 * and cleared after the the "again" goto label.
+	 * and cleared after the "again" goto label.
 	 */
 	do_cond_resched = console_may_schedule;
 again:
@@ -3374,7 +3374,7 @@ EXPORT_SYMBOL_GPL(kmsg_dump_get_line);
  * @len: length of line placed into buffer
  *
  * Start at the end of the kmsg buffer and fill the provided buffer
- * with as many of the the *youngest* kmsg records that fit into it.
+ * with as many of the *youngest* kmsg records that fit into it.
  * If the buffer is large enough, all available kmsg records will be
  * copied with a single call.
  *
