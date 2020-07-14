Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D94C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 12:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45D3821D79
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 12:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H701flhh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbgGNMcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 08:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728234AbgGNMcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 08:32:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBFCC061794;
        Tue, 14 Jul 2020 05:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=mJrdBgQpUS2E8ZU9OhPctyoTZb0a1wZwaSFfhF40f0Q=; b=H701flhhnzsJ9Bu3C1iWy6fI6Y
        kZY3iuqWwcZ2A9cLjx4B132P7MJaVnSEHKFjAKtILWYZFSGjmenkk5FjMkjevKN9duwrPk19uSrLw
        mkazPJMU9Ttftc92rZ3ELhiCp17bya7+FTnle2sF0Qa6ItHraQp74AWPRU424MgKXxuolBQNhXPt9
        EWLEQYjxA/EtzHQo2xMGam2gQVlqgdFcKTDIDYtn2OCILRWW/gSdOxfbtLGnlhCL5l8oPunzaBYNp
        GqiiN3HuEfKysp2xCJTcPX+ZU+gOvFpDp5lMEns924K6dPAENiDAsQrmpQEilPzS+oIvDvP70JWI3
        5BhXTW8g==;
Received: from [2001:4bb8:188:5f50:c70:4a89:bc61:2] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvK6T-00026F-2o; Tue, 14 Jul 2020 12:32:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/10] sh: unexport register_trapped_io and match_trapped_io_handler
Date:   Tue, 14 Jul 2020 14:18:53 +0200
Message-Id: <20200714121856.955680-8-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200714121856.955680-1-hch@lst.de>
References: <20200714121856.955680-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both functions are only used by compiled in core code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/sh/kernel/io_trapped.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/sh/kernel/io_trapped.c b/arch/sh/kernel/io_trapped.c
index 037aab2708b7ac..004ad0130b1038 100644
--- a/arch/sh/kernel/io_trapped.c
+++ b/arch/sh/kernel/io_trapped.c
@@ -102,7 +102,6 @@ int register_trapped_io(struct trapped_io *tiop)
 	pr_warn("unable to install trapped io filter\n");
 	return -1;
 }
-EXPORT_SYMBOL_GPL(register_trapped_io);
 
 void __iomem *match_trapped_io_handler(struct list_head *list,
 				       unsigned long offset,
@@ -131,7 +130,6 @@ void __iomem *match_trapped_io_handler(struct list_head *list,
 	spin_unlock_irqrestore(&trapped_lock, flags);
 	return NULL;
 }
-EXPORT_SYMBOL_GPL(match_trapped_io_handler);
 
 static struct trapped_io *lookup_tiop(unsigned long address)
 {
-- 
2.26.2

