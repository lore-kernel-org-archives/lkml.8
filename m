Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F9CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 17:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D7E9206D7
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 17:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="RnLGiJ5T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729894AbgFORxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 13:53:20 -0400
Received: from mail.skyhub.de ([5.9.137.197]:40844 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729124AbgFORxU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 13:53:20 -0400
Received: from zn.tnic (p200300ec2f063c00329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:3c00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5EA7B1EC030F;
        Mon, 15 Jun 2020 19:53:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1592243599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=S3O+QH4+12YuTGu+ImlSy838Q/+PfjN18A1LC76leQ0=;
        b=RnLGiJ5TZ0mg81hAYnu5smsiVxg6BeGZtItDhR7JZ3Vog219pAcBZ+KuYnSR4sKsUoJaJL
        VA4o7C3YmWAgIHBqk4gb2GV3JHKg1clf+woLNwAy4Ccb0+ERiwk6FH1XejBxdVjYEwUYgK
        ALP2DCO7jaNbzVmF4uX4MAdB82g+xn4=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/alternatives: Add pr_fmt() to debug macros
Date:   Mon, 15 Jun 2020 19:53:15 +0200
Message-Id: <20200615175315.17301-1-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

... in order to have debug output prefixed with the pr_fmt text "SMP
alternatives:" which allows easy grepping:

  $ dmesg | grep "SMP alternatives"
  [    0.167783] SMP alternatives: alt table ffffffff8272c780, -> ffffffff8272fd6e
  [    0.168620] SMP alternatives: feat: 3*32+16, old: (x86_64_start_kernel+0x37/0x73 \
		  (ffffffff826093f7) len: 5), repl: (ffffffff8272fd6e, len: 5), pad: 0
  [    0.170103] SMP alternatives: ffffffff826093f7: old_insn: e8 54 a8 da fe
  [    0.171184] SMP alternatives: ffffffff8272fd6e: rpl_insn: e8 cd 3e c8 fe
  ...

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/alternative.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 8fd39ff74a49..9e7dc37a8627 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -53,7 +53,7 @@ __setup("noreplace-smp", setup_noreplace_smp);
 #define DPRINTK(fmt, args...)						\
 do {									\
 	if (debug_alternative)						\
-		printk(KERN_DEBUG "%s: " fmt "\n", __func__, ##args);	\
+		printk(KERN_DEBUG pr_fmt(fmt) "\n", ##args);		\
 } while (0)
 
 #define DUMP_BYTES(buf, len, fmt, args...)				\
@@ -64,7 +64,7 @@ do {									\
 		if (!(len))						\
 			break;						\
 									\
-		printk(KERN_DEBUG fmt, ##args);				\
+		printk(KERN_DEBUG pr_fmt(fmt), ##args);			\
 		for (j = 0; j < (len) - 1; j++)				\
 			printk(KERN_CONT "%02hhx ", buf[j]);		\
 		printk(KERN_CONT "%02hhx\n", buf[j]);			\
-- 
2.21.0

