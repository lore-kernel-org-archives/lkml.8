Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04358C1975A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 22:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3872206EC
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 22:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgCQWSB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 18:18:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56028 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbgCQWSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 18:18:01 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jEKX7-0001CZ-5K; Tue, 17 Mar 2020 23:17:57 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 94A571C2294;
        Tue, 17 Mar 2020 23:17:56 +0100 (CET)
Date:   Tue, 17 Mar 2020 22:17:56 -0000
From:   "tip-bot2 for Hans de Goede" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/kdump] x86/purgatory: Fail the build if purgatory.ro has
 missing symbols
Cc:     Hans de Goede <hdegoede@redhat.com>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200317130841.290418-2-hdegoede@redhat.com>
References: <20200317130841.290418-2-hdegoede@redhat.com>
MIME-Version: 1.0
Message-ID: <158448347626.28353.9586222649550261454.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/kdump branch of tip:

Commit-ID:     e4160b2e4b02377c67f8ecd05786811598f39acd
Gitweb:        https://git.kernel.org/tip/e4160b2e4b02377c67f8ecd05786811598f39acd
Author:        Hans de Goede <hdegoede@redhat.com>
AuthorDate:    Tue, 17 Mar 2020 14:08:41 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 17 Mar 2020 15:59:12 +01:00

x86/purgatory: Fail the build if purgatory.ro has missing symbols

Linking purgatory.ro with -r enables "incremental linking"; this means
no checks for unresolved symbols are done while linking purgatory.ro.

A change to the sha256 code has caused the purgatory in 5.4-rc1 to have
a missing symbol on memzero_explicit(), yet things still happily build.

Add an extra check for unresolved symbols by calling ld without -r
before running bin2c to generate kexec-purgatory.c.

This causes a build of 5.4-rc1 with this patch added to fail as it should:

    CHK     arch/x86/purgatory/purgatory.ro
  ld: arch/x86/purgatory/purgatory.ro: in function `sha256_transform':
  sha256.c:(.text+0x1c0c): undefined reference to `memzero_explicit'
  make[2]: *** [arch/x86/purgatory/Makefile:72:
      arch/x86/purgatory/kexec-purgatory.c] Error 1
  make[1]: *** [scripts/Makefile.build:509: arch/x86/purgatory] Error 2
  make: *** [Makefile:1650: arch/x86] Error 2

Also remove --no-undefined from LDFLAGS_purgatory.ro as that has no
effect.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200317130841.290418-2-hdegoede@redhat.com
---
 arch/x86/purgatory/.gitignore |  1 +
 arch/x86/purgatory/Makefile   | 13 ++++++++++---
 2 files changed, 11 insertions(+), 3 deletions(-)
 create mode 100644 arch/x86/purgatory/.gitignore

diff --git a/arch/x86/purgatory/.gitignore b/arch/x86/purgatory/.gitignore
new file mode 100644
index 0000000..d2be150
--- /dev/null
+++ b/arch/x86/purgatory/.gitignore
@@ -0,0 +1 @@
+purgatory.chk
diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index 9733d1c..54aadbb 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -14,8 +14,12 @@ $(obj)/sha256.o: $(srctree)/lib/crypto/sha256.c FORCE
 
 CFLAGS_sha256.o := -D__DISABLE_EXPORTS
 
-LDFLAGS_purgatory.ro := -e purgatory_start -r --no-undefined -nostdlib -z nodefaultlib
-targets += purgatory.ro
+# When linking purgatory.ro with -r unresolved symbols are not checked,
+# also link a purgatory.chk binary without -r to check for unresolved symbols.
+PURGATORY_LDFLAGS := -e purgatory_start -nostdlib -z nodefaultlib
+LDFLAGS_purgatory.ro := -r $(PURGATORY_LDFLAGS)
+LDFLAGS_purgatory.chk := $(PURGATORY_LDFLAGS)
+targets += purgatory.ro purgatory.chk
 
 # Sanitizer, etc. runtimes are unavailable and cannot be linked here.
 GCOV_PROFILE	:= n
@@ -61,12 +65,15 @@ CFLAGS_string.o			+= $(PURGATORY_CFLAGS)
 $(obj)/purgatory.ro: $(PURGATORY_OBJS) FORCE
 		$(call if_changed,ld)
 
+$(obj)/purgatory.chk: $(obj)/purgatory.ro FORCE
+		$(call if_changed,ld)
+
 targets += kexec-purgatory.c
 
 quiet_cmd_bin2c = BIN2C   $@
       cmd_bin2c = $(objtree)/scripts/bin2c kexec_purgatory < $< > $@
 
-$(obj)/kexec-purgatory.c: $(obj)/purgatory.ro FORCE
+$(obj)/kexec-purgatory.c: $(obj)/purgatory.ro $(obj)/purgatory.chk FORCE
 	$(call if_changed,bin2c)
 
 obj-$(CONFIG_KEXEC_FILE)	+= kexec-purgatory.o
