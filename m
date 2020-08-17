Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 321B1C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 16:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E27FE20657
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 16:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597682482;
	bh=adrKwjKBYwAGO2tCI25+wx390wp6p3FolWXMxPZgFos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=spN3zNvcNBxes0XTb+Hhy032kSYPUj4ggE0JY43zbJfT9Hl/ir4f+Gcw6wjQhMIQl
	 Xea9UxUgfHZ+Z06aDa7Os/JRiABTSmNWly8CwyuHzO4u1DwMWSZnXXuZ93uuAmnlgD
	 bRlY8REANl4U3VncDDKerJMpir8D1qA4t/2gOkeM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387766AbgHQQlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 12:41:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:45594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388112AbgHQP6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:58:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D424320729;
        Mon, 17 Aug 2020 15:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597679888;
        bh=adrKwjKBYwAGO2tCI25+wx390wp6p3FolWXMxPZgFos=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TnTigaenz1Sq/Edqu8xSRp7CP7Q4C1EUVesOtcQJhokcvrwa/jZ0BpC072QmSbzw+
         HkUsF5fQIaiAGBWnwx+Uo0OgOTbrV0+b9LGtbkW0dHg/Ub88qKdoOEyBXb8H/8Eg97
         RD9tXpmfLPrCIcVgoGQ0/5PTrP1wj5jow1QrzWBg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Helge Deller <deller@gmx.de>
Subject: [PATCH 5.7 369/393] Revert "parisc: Improve interrupt handling in arch_spin_lock_flags()"
Date:   Mon, 17 Aug 2020 17:16:59 +0200
Message-Id: <20200817143837.504116036@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143819.579311991@linuxfoundation.org>
References: <20200817143819.579311991@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Helge Deller <deller@gmx.de>

commit 3d05b8aebc5f10ee3ab129b61100196855dd7249 upstream.

This reverts commit 2772f0efd5bbd5413db3d22e363b779ca0fa5310.
It turns out that we want to implement the spinlock code differently.

Signed-off-by: Helge Deller <deller@gmx.de>
Cc: <stable@vger.kernel.org> # v5.7+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/parisc/include/asm/spinlock.h |   25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

--- a/arch/parisc/include/asm/spinlock.h
+++ b/arch/parisc/include/asm/spinlock.h
@@ -10,34 +10,25 @@
 static inline int arch_spin_is_locked(arch_spinlock_t *x)
 {
 	volatile unsigned int *a = __ldcw_align(x);
-	smp_mb();
 	return *a == 0;
 }
 
-static inline void arch_spin_lock(arch_spinlock_t *x)
-{
-	volatile unsigned int *a;
-
-	a = __ldcw_align(x);
-	while (__ldcw(a) == 0)
-		while (*a == 0)
-			cpu_relax();
-}
+#define arch_spin_lock(lock) arch_spin_lock_flags(lock, 0)
 
 static inline void arch_spin_lock_flags(arch_spinlock_t *x,
 					 unsigned long flags)
 {
 	volatile unsigned int *a;
-	unsigned long flags_dis;
 
 	a = __ldcw_align(x);
-	while (__ldcw(a) == 0) {
-		local_save_flags(flags_dis);
-		local_irq_restore(flags);
+	while (__ldcw(a) == 0)
 		while (*a == 0)
-			cpu_relax();
-		local_irq_restore(flags_dis);
-	}
+			if (flags & PSW_SM_I) {
+				local_irq_enable();
+				cpu_relax();
+				local_irq_disable();
+			} else
+				cpu_relax();
 }
 #define arch_spin_lock_flags arch_spin_lock_flags
 


