Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4033EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10B47206E2
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592948231;
	bh=oBazYu09aB3tqGIxo5bEWHnnBU3hUjJG3fpmeQrJgQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hrQXkwLgF38FINSM/7U/uAb9UdNrW0BBYS3/HHwnSwh/+mceMCeznffYt9QHB036R
	 fKGW75M6dCaid/tZYHmu8XaChJ0G4i2AV/qWeSehYuInkSFk/rkMe1yaX8r1FT//zY
	 gF9DWpc/1s5wENt7sPevCiAKQU5Jn9HX+Dm+bsYI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389217AbgFWVhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:37:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:50312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388375AbgFWUJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:09:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A8042078A;
        Tue, 23 Jun 2020 20:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592942955;
        bh=oBazYu09aB3tqGIxo5bEWHnnBU3hUjJG3fpmeQrJgQ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kBypUGIP8NvxB9b5T59t7N/eEdLw1/VvtLbdNKYU2gEslqgX+EP5GN7XJFNcupMM8
         MGqYqMDKHoDbBmnYfLnAaLtQnnQorq1KgjC/3Gmcd6Bgkddui+U3Mg7W72SeO4qsZ1
         NEkXSB2+xs8OS0eJ5toL33BqqvErpBvJTxqB5CKk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>,
        Wolfram Sang <wsa@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 171/477] i2c: pxa: fix i2c_pxa_scream_blue_murder() debug output
Date:   Tue, 23 Jun 2020 21:52:48 +0200
Message-Id: <20200623195415.669195436@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195407.572062007@linuxfoundation.org>
References: <20200623195407.572062007@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell King <rmk+kernel@armlinux.org.uk>

[ Upstream commit 88b73ee7ca4c90baf136ed5a8377fc5a9b73ac08 ]

The IRQ log output is supposed to appear on a single line.  However,
commit 3a2dc1677b60 ("i2c: pxa: Update debug function to dump more info
on error") resulted in it being printed one-entry-per-line, which is
excessively long.

Fixing this is not a trivial matter; using pr_cont() doesn't work as
the previous dev_dbg() may not have been compiled in, or may be
dynamic.

Since the rest of this function output is at error level, and is also
debug output, promote this to error level as well to avoid this
problem.

Reduce the number of always zero prefix digits to save screen real-
estate.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-pxa.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index 30a6e07212a42..f537a37ac1d52 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -311,11 +311,10 @@ static void i2c_pxa_scream_blue_murder(struct pxa_i2c *i2c, const char *why)
 	dev_err(dev, "IBMR: %08x IDBR: %08x ICR: %08x ISR: %08x\n",
 		readl(_IBMR(i2c)), readl(_IDBR(i2c)), readl(_ICR(i2c)),
 		readl(_ISR(i2c)));
-	dev_dbg(dev, "log: ");
+	dev_err(dev, "log:");
 	for (i = 0; i < i2c->irqlogidx; i++)
-		pr_debug("[%08x:%08x] ", i2c->isrlog[i], i2c->icrlog[i]);
-
-	pr_debug("\n");
+		pr_cont(" [%03x:%05x]", i2c->isrlog[i], i2c->icrlog[i]);
+	pr_cont("\n");
 }
 
 #else /* ifdef DEBUG */
-- 
2.25.1



