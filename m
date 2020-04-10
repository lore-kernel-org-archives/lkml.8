Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50197C2BB85
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 03:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26FC62145D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 03:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586490698;
	bh=8dKXULgc9tL7S6NUGH/SYxbtnWrHjv56lU3vacd03ss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tJCeaTsO5aS2mE5LgEQmYIwLaHk6tWhiESJ7fCr6UCuhx4AAJmZqL1jXYL5VG8DoM
	 r/I37DSh7WpOqpUH1/+gxbjUBXCVBlImYR1+OOXT2cJ3P3XhbRzJ+P6/x9BtOI6t1b
	 sdB5Umzt5+bncrBYSuqPQQaIupvl3mgPeRbuJ7Ro=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729241AbgDJDvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 23:51:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:36770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728558AbgDJDv1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 23:51:27 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50711215A4;
        Fri, 10 Apr 2020 03:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586490688;
        bh=8dKXULgc9tL7S6NUGH/SYxbtnWrHjv56lU3vacd03ss=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r9Ff8koJJC3PLeDqpDAXX9Pp74nZu5ctn3yDVC05WyIAvdsob8rT8S7Q19uWWtulf
         3CI+liqtVVjkdz6y67vWnq3u5zw3tLld+WcSVPfZSCsDuvROlghFdyKGETTEudM45V
         VEce+ZZqHkXSKa+GpS7ENzvABXktKFmIrP/DKenM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 5/8] x86/boot: Use unsigned comparison for addresses
Date:   Thu,  9 Apr 2020 23:51:18 -0400
Message-Id: <20200410035122.10065-5-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200410035122.10065-1-sashal@kernel.org>
References: <20200410035122.10065-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arvind Sankar <nivedita@alum.mit.edu>

[ Upstream commit 81a34892c2c7c809f9c4e22c5ac936ae673fb9a2 ]

The load address is compared with LOAD_PHYSICAL_ADDR using a signed
comparison currently (using jge instruction).

When loading a 64-bit kernel using the new efi32_pe_entry() point added by:

  97aa276579b2 ("efi/x86: Add true mixed mode entry point into .compat section")

using Qemu with -m 3072, the firmware actually loads us above 2Gb,
resulting in a very early crash.

Use the JAE instruction to perform a unsigned comparison instead, as physical
addresses should be considered unsigned.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200301230436.2246909-6-nivedita@alum.mit.edu
Link: https://lore.kernel.org/r/20200308080859.21568-14-ardb@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/boot/compressed/head_32.S | 2 +-
 arch/x86/boot/compressed/head_64.S | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/boot/compressed/head_32.S b/arch/x86/boot/compressed/head_32.S
index 0256064da8da3..0eca7f2087b1f 100644
--- a/arch/x86/boot/compressed/head_32.S
+++ b/arch/x86/boot/compressed/head_32.S
@@ -170,7 +170,7 @@ preferred_addr:
 	notl	%eax
 	andl    %eax, %ebx
 	cmpl	$LOAD_PHYSICAL_ADDR, %ebx
-	jge	1f
+	jae	1f
 #endif
 	movl	$LOAD_PHYSICAL_ADDR, %ebx
 1:
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index b831e24f7168b..ca8151ef3bfa0 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -104,7 +104,7 @@ ENTRY(startup_32)
 	notl	%eax
 	andl	%eax, %ebx
 	cmpl	$LOAD_PHYSICAL_ADDR, %ebx
-	jge	1f
+	jae	1f
 #endif
 	movl	$LOAD_PHYSICAL_ADDR, %ebx
 1:
@@ -337,7 +337,7 @@ preferred_addr:
 	notq	%rax
 	andq	%rax, %rbp
 	cmpq	$LOAD_PHYSICAL_ADDR, %rbp
-	jge	1f
+	jae	1f
 #endif
 	movq	$LOAD_PHYSICAL_ADDR, %rbp
 1:
-- 
2.20.1

