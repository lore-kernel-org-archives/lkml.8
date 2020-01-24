Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC42C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDBBD2075D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579859632;
	bh=BUju0Wx30sPMwP56BcCcBb6OikCck+XYZB+oJtZUH1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UdG9dkp71rCVj8avAyrKP3BG7oEgoPR7ls3maxdZRp0fw6zdh6YbpBM792zDLpieI
	 K6bEHDKWeWouRis7QrK1PfuP+C0odlOWJu5uvx+1iPBVjndeMjnZ8dH7TVmp+O/Qqw
	 4O1UTBa8WLsHCZx6M4G0olxHIb0RuuxqwTuubdKk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388156AbgAXJxv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:53:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:56632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730133AbgAXJxt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:53:49 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E89E4222C2;
        Fri, 24 Jan 2020 09:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579859628;
        bh=BUju0Wx30sPMwP56BcCcBb6OikCck+XYZB+oJtZUH1s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yCtDdAEjcggSpKgqswO7332x2cUEubq2hAcJGeH8Y8sPiu9N5duDacctsAuyqh7DL
         FU2r8fU+d5CNgfG7L/5sjkRnsJw9izXxBPhWhL8W+oGwJQznr91Ywx7tG+opfQNMr8
         D1ZvnYuwDYsIVkBkpY5L0KoRDVsQ3Kdvl6pmIDFM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 137/343] nios2: ksyms: Add missing symbol exports
Date:   Fri, 24 Jan 2020 10:29:15 +0100
Message-Id: <20200124092937.992719222@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124092919.490687572@linuxfoundation.org>
References: <20200124092919.490687572@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

[ Upstream commit 0f8ed994575429d6042cf5d7ef70081c94091587 ]

Building nios2:allmodconfig fails as follows (each symbol is only listed
once).

ERROR: "__ashldi3" [drivers/md/dm-writecache.ko] undefined!
ERROR: "__ashrdi3" [fs/xfs/xfs.ko] undefined!
ERROR: "__ucmpdi2" [drivers/media/i2c/adv7842.ko] undefined!
ERROR: "__lshrdi3" [drivers/md/dm-zoned.ko] undefined!
ERROR: "flush_icache_range" [drivers/misc/lkdtm/lkdtm.ko] undefined!
ERROR: "empty_zero_page" [drivers/md/dm-mod.ko] undefined!

The problem is seen with gcc 7.3.0.

Export the missing symbols.

Fixes: 2fc8483fdcde ("nios2: Build infrastructure")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Ley Foon Tan <ley.foon.tan@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/nios2/kernel/nios2_ksyms.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/nios2/kernel/nios2_ksyms.c b/arch/nios2/kernel/nios2_ksyms.c
index bf2f55d10a4d8..4e704046a150c 100644
--- a/arch/nios2/kernel/nios2_ksyms.c
+++ b/arch/nios2/kernel/nios2_ksyms.c
@@ -9,12 +9,20 @@
 #include <linux/export.h>
 #include <linux/string.h>
 
+#include <asm/cacheflush.h>
+#include <asm/pgtable.h>
+
 /* string functions */
 
 EXPORT_SYMBOL(memcpy);
 EXPORT_SYMBOL(memset);
 EXPORT_SYMBOL(memmove);
 
+/* memory management */
+
+EXPORT_SYMBOL(empty_zero_page);
+EXPORT_SYMBOL(flush_icache_range);
+
 /*
  * libgcc functions - functions that are used internally by the
  * compiler...  (prototypes are not correct though, but that
@@ -31,3 +39,7 @@ DECLARE_EXPORT(__udivsi3);
 DECLARE_EXPORT(__umoddi3);
 DECLARE_EXPORT(__umodsi3);
 DECLARE_EXPORT(__muldi3);
+DECLARE_EXPORT(__ucmpdi2);
+DECLARE_EXPORT(__lshrdi3);
+DECLARE_EXPORT(__ashldi3);
+DECLARE_EXPORT(__ashrdi3);
-- 
2.20.1



