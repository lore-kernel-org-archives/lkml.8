Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC03C433E4
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 00:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7ED3208B3
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 00:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nW9c81cD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgGSA3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 20:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbgGSA3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 20:29:01 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370D1C0619D2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 17:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=F/Dr1NlrrHa9o/NMjBr8owHWHpYMtGHINOmgco5x/Xo=; b=nW9c81cDU9Vwv2XoaDXz8lbMyn
        3Wa4R/dXw6GJqq8r2qR3FDNWStc7F5mvjSzYJ2xaLljW0D9xPDOTBZ9aETPaKOXJmhoDebRRghCid
        QWYdPKlbAbcVpncEjC5Q66xMAkI1xzPZKshuiN8uoheeCsqluzwvIe7wiUPJoSLCVr7O4NaaPVeyJ
        dlbUYx3rxaHKG9zTd2X5KBGvIrOk+od8M1o3TBn5Vw8iFZjn6gQibz4u615q/zk8dncCYkGWfnxMe
        QsWgyw6CyPukdOvNIoFPiBjpc93/R/VpuGCmXt+rh751q+l+OTC/C62lsLItVLwbdX7WpalaBZ9iN
        cCXk5O9g==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jwxCL-0002iR-5r; Sun, 19 Jul 2020 00:28:57 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH] irqchip: irq-bcm2836.h: drop a duplicated word
Date:   Sat, 18 Jul 2020 17:28:53 -0700
Message-Id: <20200719002853.20419-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the repeated word "the" in a comment.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <maz@kernel.org>
---
 include/linux/irqchip/irq-bcm2836.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200717.orig/include/linux/irqchip/irq-bcm2836.h
+++ linux-next-20200717/include/linux/irqchip/irq-bcm2836.h
@@ -30,7 +30,7 @@
  */
 #define LOCAL_MAILBOX_INT_CONTROL0	0x050
 /*
- * The CPU's interrupt status register.  Bits are defined by the the
+ * The CPU's interrupt status register.  Bits are defined by the
  * LOCAL_IRQ_* bits below.
  */
 #define LOCAL_IRQ_PENDING0		0x060
