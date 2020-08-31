Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2233C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 16:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B51E20719
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 16:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Q/KxHX6y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbgHaQjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 12:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbgHaQjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 12:39:05 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE2CC061573
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 09:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=G8eF/437C9jV0dUSsiMh0K3uruFA7n5DD7RzaN/0GcE=; b=Q/KxHX6y+a3NJ3++QdycpvjTdD
        y1nBSzxbp5NiJWVwcaFnNa4/4iS+ARevqFwnZ1th+f+ePKDNN9nFBDpUIJCIdGdhaXGkt6WN1oW25
        y65FexJPHjO84DNhnmdC43AeYAo6tNa4c589MTVv30eY1alESXZ9g4xd13Y3ESv35qcL9lv/pXpY6
        cigATetrSEMynxXcsR3W0CsosFLYQhRb2o1DN/ma4TgiQ4gkGst6F0C650Tpjm7Y7zZD7Nidsg3L9
        4B9z/ZZAuk2dzCfb1pSAP/5ikBxh3hBY2aw+O2+d6t/U6XpZ4oBlUeJyn2LBtJMviTcBuxQgOtN1f
        aBLbb2Vw==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kCmph-0007nj-A9; Mon, 31 Aug 2020 16:39:01 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>,
        Michal Simek <michal.simek@xilinx.com>,
        Masahiro Yamada <masahiroy@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2] microblaze: fix kbuild redundant file warning
Message-ID: <4d992aee-8a69-1769-e622-8d6d6e316346@infradead.org>
Date:   Mon, 31 Aug 2020 09:38:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix build warning since this file is already listed in
include/asm-generic/Kbuild.

../scripts/Makefile.asm-generic:25: redundant generic-y found in arch/microblaze/include/asm/Kbuild: hw_irq.h

Fixes: 630f289b7114 ("asm-generic: make more kernel-space headers mandatory")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Michal Simek <monstr@monstr.eu>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>
---
v2: fix the Fixes: commit ID/description

 arch/microblaze/include/asm/Kbuild |    1 -
 1 file changed, 1 deletion(-)

--- linux-next-20200828.orig/arch/microblaze/include/asm/Kbuild
+++ linux-next-20200828/arch/microblaze/include/asm/Kbuild
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 generated-y += syscall_table.h
 generic-y += extable.h
-generic-y += hw_irq.h
 generic-y += kvm_para.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h

