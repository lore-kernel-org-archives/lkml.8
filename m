Return-Path: <SRS0=HPGY=7U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA5DAC433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 08:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D67B20723
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 08:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgFGIDO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 04:03:14 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:43269 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgFGIDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 04:03:14 -0400
Received: from localhost.localdomain (lfbn-gre-1-325-105.w90-112.abo.wanadoo.fr [90.112.45.105])
        (Authenticated sender: alex@ghiti.fr)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 00E37200003;
        Sun,  7 Jun 2020 08:03:05 +0000 (UTC)
From:   Alexandre Ghiti <alex@ghiti.fr>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <Anup.Patel@wdc.com>,
        Atish Patra <Atish.Patra@wdc.com>,
        Zong Li <zong.li@sifive.com>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org
Cc:     Alexandre Ghiti <alex@ghiti.fr>, Anup Patel <anup@brainfault.org>
Subject: [PATCH v5 3/4] powerpc: Move script to check relocations at compile time in scripts/
Date:   Sun,  7 Jun 2020 03:59:48 -0400
Message-Id: <20200607075949.665-4-alex@ghiti.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200607075949.665-1-alex@ghiti.fr>
References: <20200607075949.665-1-alex@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Relocating kernel at runtime is done very early in the boot process, so
it is not convenient to check for relocations there and react in case a
relocation was not expected.

Powerpc architecture has a script that allows to check at compile time
for such unexpected relocations: extract the common logic to scripts/
so that other architectures can take advantage of it.

Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
Reviewed-by: Anup Patel <anup@brainfault.org>
---
 arch/powerpc/tools/relocs_check.sh | 18 ++----------------
 scripts/relocs_check.sh            | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+), 16 deletions(-)
 create mode 100755 scripts/relocs_check.sh

diff --git a/arch/powerpc/tools/relocs_check.sh b/arch/powerpc/tools/relocs_check.sh
index 014e00e74d2b..e367895941ae 100755
--- a/arch/powerpc/tools/relocs_check.sh
+++ b/arch/powerpc/tools/relocs_check.sh
@@ -15,21 +15,8 @@ if [ $# -lt 3 ]; then
 	exit 1
 fi
 
-# Have Kbuild supply the path to objdump and nm so we handle cross compilation.
-objdump="$1"
-nm="$2"
-vmlinux="$3"
-
-# Remove from the bad relocations those that match an undefined weak symbol
-# which will result in an absolute relocation to 0.
-# Weak unresolved symbols are of that form in nm output:
-# "                  w _binary__btf_vmlinux_bin_end"
-undef_weak_symbols=$($nm "$vmlinux" | awk '$1 ~ /w/ { print $2 }')
-
 bad_relocs=$(
-$objdump -R "$vmlinux" |
-	# Only look at relocation lines.
-	grep -E '\<R_' |
+${srctree}/scripts/relocs_check.sh "$@" |
 	# These relocations are okay
 	# On PPC64:
 	#	R_PPC64_RELATIVE, R_PPC64_NONE
@@ -43,8 +30,7 @@ R_PPC_ADDR16_LO
 R_PPC_ADDR16_HI
 R_PPC_ADDR16_HA
 R_PPC_RELATIVE
-R_PPC_NONE' |
-	([ "$undef_weak_symbols" ] && grep -F -w -v "$undef_weak_symbols" || cat)
+R_PPC_NONE'
 )
 
 if [ -z "$bad_relocs" ]; then
diff --git a/scripts/relocs_check.sh b/scripts/relocs_check.sh
new file mode 100755
index 000000000000..137c660499f3
--- /dev/null
+++ b/scripts/relocs_check.sh
@@ -0,0 +1,20 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+# Get a list of all the relocations, remove from it the relocations
+# that are known to be legitimate and return this list to arch specific
+# script that will look for suspicious relocations.
+
+objdump="$1"
+nm="$2"
+vmlinux="$3"
+
+# Remove from the possible bad relocations those that match an undefined
+# weak symbol which will result in an absolute relocation to 0.
+# Weak unresolved symbols are of that form in nm output:
+# "                  w _binary__btf_vmlinux_bin_end"
+undef_weak_symbols=$($nm "$vmlinux" | awk '$1 ~ /w/ { print $2 }')
+
+$objdump -R "$vmlinux" |
+	grep -E '\<R_' |
+	([ "$undef_weak_symbols" ] && grep -F -w -v "$undef_weak_symbols" || cat)
-- 
2.20.1

