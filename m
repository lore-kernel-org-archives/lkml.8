Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2608AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 06:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 059D420656
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 06:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AEMpqOBl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbgG3GKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 02:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728729AbgG3GKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 02:10:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E07AC061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 23:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=vlvUX1lb6861V9hgJhYvVNi0Y3oElohqk62tnd3ychE=; b=AEMpqOBlOEDmOb22MZ8TR3g88A
        eKHCcJ7xjmDT1KHTmEAmKyF92w1+v7KOGJNtowiKSR5OOVq31FhF0YzrHXae7m02D3PFhw11RMtFt
        z1nZ3jbrGHUo8gf40E0bxR0m3OO+zOgs5T1VmMQZuv9lyge+L1Ko0YbWtGs34Yki2fHBdPlWEFXDC
        BAe4+gR2NZyX5PgbUXrlOxE3nrzHJ1q/+z8t6PVk/ODMRxHX5UsScitSNQZBoxL3tUnhueN/mGOtx
        DSlIUx68B060b3fYYJb4do1UztwakO2Cekar69e4836Yh+CDOY2nq0oFbLTYE/rFGZR4OqbcS1uYR
        zZPE5P/Q==;
Received: from 138.57.168.109.cust.ip.kpnqwest.it ([109.168.57.138] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k11m3-0007Uy-Qk; Thu, 30 Jul 2020 06:10:40 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 6/8] modules: rename the licence field in struct symsearch to license
Date:   Thu, 30 Jul 2020 08:10:25 +0200
Message-Id: <20200730061027.29472-7-hch@lst.de>
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

Use the same spelling variant as the rest of the file.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/module.h | 2 +-
 kernel/module.c        | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index b79219eed83c56..be04ba2f881daa 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -586,7 +586,7 @@ struct symsearch {
 		NOT_GPL_ONLY,
 		GPL_ONLY,
 		WILL_BE_GPL_ONLY,
-	} licence;
+	} license;
 	bool unused;
 };
 
diff --git a/kernel/module.c b/kernel/module.c
index 54e853c7212f72..a0df783a8a6e5b 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -504,9 +504,9 @@ static bool check_exported_symbol(const struct symsearch *syms,
 	struct find_symbol_arg *fsa = data;
 
 	if (!fsa->gplok) {
-		if (syms->licence == GPL_ONLY)
+		if (syms->license == GPL_ONLY)
 			return false;
-		if (syms->licence == WILL_BE_GPL_ONLY && fsa->warn) {
+		if (syms->license == WILL_BE_GPL_ONLY && fsa->warn) {
 			pr_warn("Symbol %s is being used by a non-GPL module, "
 				"which will not be allowed in the future\n",
 				fsa->name);
-- 
2.27.0

