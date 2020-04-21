Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14FEC54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 10:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6F932076C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 10:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbgDUKAs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 06:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726018AbgDUKAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 06:00:43 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA5EC061A0F;
        Tue, 21 Apr 2020 03:00:40 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jQphk-0000PG-Ra; Tue, 21 Apr 2020 12:00:37 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 9F3321C0315;
        Tue, 21 Apr 2020 12:00:29 +0200 (CEST)
Date:   Tue, 21 Apr 2020 10:00:29 -0000
From:   "tip-bot2 for Masahiro Yamada" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/build] x86/boot/build: Add cpustr.h to targets and remove
 clean-files
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200215063241.7437-1-masahiroy@kernel.org>
References: <20200215063241.7437-1-masahiroy@kernel.org>
MIME-Version: 1.0
Message-ID: <158746322913.28353.10745610884854007143.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/build branch of tip:

Commit-ID:     e3c7c1052271260955affbe65c4f328286fbe5fb
Gitweb:        https://git.kernel.org/tip/e3c7c1052271260955affbe65c4f328286fbe5fb
Author:        Masahiro Yamada <masahiroy@kernel.org>
AuthorDate:    Sat, 15 Feb 2020 15:32:41 +09:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 21 Apr 2020 10:17:29 +02:00

x86/boot/build: Add cpustr.h to targets and remove clean-files

Files in $(targets) are always cleaned up. Move the 'targets' assignment
out of the ifdef and remove 'clean-files'.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200215063241.7437-1-masahiroy@kernel.org
---
 arch/x86/boot/Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
index e17be90..02c8d1c 100644
--- a/arch/x86/boot/Makefile
+++ b/arch/x86/boot/Makefile
@@ -57,11 +57,10 @@ $(obj)/cpu.o: $(obj)/cpustr.h
 
 quiet_cmd_cpustr = CPUSTR  $@
       cmd_cpustr = $(obj)/mkcpustr > $@
-targets += cpustr.h
 $(obj)/cpustr.h: $(obj)/mkcpustr FORCE
 	$(call if_changed,cpustr)
 endif
-clean-files += cpustr.h
+targets += cpustr.h
 
 # ---------------------------------------------------------------------------
 
