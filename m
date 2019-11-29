Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DATE_IN_PAST_96_XX,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D52C8C43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2357206F6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:44:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbgC1QoL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 12:44:11 -0400
Received: from mx.sdf.org ([205.166.94.20]:49836 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727957AbgC1QoH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 12:44:07 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 02SGhPA6013630
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Sat, 28 Mar 2020 16:43:26 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 02SGhPfO016133;
        Sat, 28 Mar 2020 16:43:25 GMT
Message-Id: <202003281643.02SGhPfO016133@sdf.org>
From:   George Spelvin <lkml@sdf.org>
Date:   Fri, 29 Nov 2019 18:57:36 -0500
Subject: [RFC PATCH v1 48/50] arch/arm/kernel/process.c: Use
 get_random_max32() for sigpage_addr()
To:     linux-kernel@vger.kernel.org, lkml@sdf.org
Cc:     Nathan Lynch <nathan_lynch@mentor.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Which is faster and less biased than get_random_int() % range

Signed-off-by: George Spelvin <lkml@sdf.org>
Cc: Nathan Lynch <nathan_lynch@mentor.com>
Cc: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm/kernel/process.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 46e478fb5ea20..9f2556be33505 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -391,7 +391,7 @@ static unsigned long sigpage_addr(const struct mm_struct *mm,
 
 	slots = ((last - first) >> PAGE_SHIFT) + 1;
 
-	offset = get_random_int() % slots;
+	offset = get_random_max32(slots);
 
 	addr = first + (offset << PAGE_SHIFT);
 
-- 
2.26.0

