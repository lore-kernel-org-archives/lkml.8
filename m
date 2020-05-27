Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD57C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 06:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1752D2075A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 06:35:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="BuYK7QYL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbgE0Gfn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 02:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbgE0Gfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 02:35:42 -0400
Received: from vultr.net.flygoat.com (vultr.net.flygoat.com [IPv6:2001:19f0:6001:3633:5400:2ff:fe8c:553])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10BFC061A0F;
        Tue, 26 May 2020 23:35:42 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2001:da8:20f:4430:250:56ff:fe9a:7470])
        by vultr.net.flygoat.com (Postfix) with ESMTPSA id 2A9A120D16;
        Wed, 27 May 2020 06:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com; s=vultr;
        t=1590561342; bh=hN3UCNC1oAOyNQFrDq068mmAnFijUJCN0J4zaXVDdZo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BuYK7QYL1Uy/bZ4q2M9Kbcg6Uxcyfx9OFRVbKyI6MCVYJDfJei5BisT8IVUX1vdNY
         jhwj6IYNu2qDV4FCVT4Sb74pqOGxjwB8rRapEVBVA65gId93R4BXKBnBq5cEq02mWs
         X45pLMnPIMbGhPFOx+6lmw6jU96J+NB+To203pw4EalDngCSl6AFlPBDxTO8wgZV7r
         PxgiBZdzGmhJt2bGf8byn8Ugwlleeik3PXhbVLrg8i8thgw1kG88vgApVA6TqQTXOA
         rtOjQ5bJBXXK2s7Cz2kwLu7lIBlWR10+xCDrQAxhZ3Ofz2pqp1gKxk21dvnz/mTbC5
         QBZhupk7DOdLg==
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@suse.de>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Fangrui Song <maskray@google.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] MIPS: head.S: Always jump to kernel_entry at head of text
Date:   Wed, 27 May 2020 14:34:32 +0800
Message-Id: <20200527063438.391949-2-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.27.0.rc0
In-Reply-To: <20200527063438.391949-1-jiaxun.yang@flygoat.com>
References: <20200527063438.391949-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Buggy loaders like early version of PMON2000 sometimes ignore
elf_entry and goto start of text directly.

That would help with dealing with these loaders.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/kernel/head.S | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/mips/kernel/head.S b/arch/mips/kernel/head.S
index 3b02ffe46304..c7c2795837e7 100644
--- a/arch/mips/kernel/head.S
+++ b/arch/mips/kernel/head.S
@@ -69,7 +69,6 @@
 
 EXPORT(_stext)
 
-#ifdef CONFIG_BOOT_RAW
 	/*
 	 * Give us a fighting chance of running if execution beings at the
 	 * kernel load address.	 This is needed because this platform does
@@ -77,7 +76,6 @@ EXPORT(_stext)
 	 */
 FEXPORT(__kernel_entry)
 	j	kernel_entry
-#endif /* CONFIG_BOOT_RAW */
 
 	__REF
 
-- 
2.27.0.rc0

