Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A657BC54FCE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 22:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8321020BED
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 22:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbgCXWcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 18:32:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46363 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728227AbgCXWcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 18:32:19 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGs5m-0006rc-U3; Tue, 24 Mar 2020 23:32:15 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 955F41C0451;
        Tue, 24 Mar 2020 23:32:14 +0100 (CET)
Date:   Tue, 24 Mar 2020 22:32:14 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] crypto: Convert to new CPU match macros
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200320131510.700250889@linutronix.de>
References: <20200320131510.700250889@linutronix.de>
MIME-Version: 1.0
Message-ID: <158508913426.28353.15383060459839740948.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     f30cfacad1ee948c821a82e63b28958b92bf8c6c
Gitweb:        https://git.kernel.org/tip/f30cfacad1ee948c821a82e63b28958b92bf8c6c
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 20 Mar 2020 14:14:05 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 24 Mar 2020 21:36:06 +01:00

crypto: Convert to new CPU match macros

The new macro set has a consistent namespace and uses C99 initializers
instead of the grufty C89 ones.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://lkml.kernel.org/r/20200320131510.700250889@linutronix.de
---
 arch/x86/crypto/aesni-intel_glue.c         | 2 +-
 arch/x86/crypto/crc32-pclmul_glue.c        | 2 +-
 arch/x86/crypto/crc32c-intel_glue.c        | 2 +-
 arch/x86/crypto/crct10dif-pclmul_glue.c    | 2 +-
 arch/x86/crypto/ghash-clmulni-intel_glue.c | 2 +-
 drivers/crypto/padlock-aes.c               | 2 +-
 drivers/crypto/padlock-sha.c               | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/crypto/aesni-intel_glue.c b/arch/x86/crypto/aesni-intel_glue.c
index bbbebbd..75b6ea2 100644
--- a/arch/x86/crypto/aesni-intel_glue.c
+++ b/arch/x86/crypto/aesni-intel_glue.c
@@ -1064,7 +1064,7 @@ static struct aead_alg aesni_aeads[0];
 static struct simd_aead_alg *aesni_simd_aeads[ARRAY_SIZE(aesni_aeads)];
 
 static const struct x86_cpu_id aesni_cpu_id[] = {
-	X86_FEATURE_MATCH(X86_FEATURE_AES),
+	X86_MATCH_FEATURE(X86_FEATURE_AES, NULL),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, aesni_cpu_id);
diff --git a/arch/x86/crypto/crc32-pclmul_glue.c b/arch/x86/crypto/crc32-pclmul_glue.c
index 418bd88..7c4c7b2 100644
--- a/arch/x86/crypto/crc32-pclmul_glue.c
+++ b/arch/x86/crypto/crc32-pclmul_glue.c
@@ -170,7 +170,7 @@ static struct shash_alg alg = {
 };
 
 static const struct x86_cpu_id crc32pclmul_cpu_id[] = {
-	X86_FEATURE_MATCH(X86_FEATURE_PCLMULQDQ),
+	X86_MATCH_FEATURE(X86_FEATURE_PCLMULQDQ, NULL),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, crc32pclmul_cpu_id);
diff --git a/arch/x86/crypto/crc32c-intel_glue.c b/arch/x86/crypto/crc32c-intel_glue.c
index c20d1b8..d2d069b 100644
--- a/arch/x86/crypto/crc32c-intel_glue.c
+++ b/arch/x86/crypto/crc32c-intel_glue.c
@@ -221,7 +221,7 @@ static struct shash_alg alg = {
 };
 
 static const struct x86_cpu_id crc32c_cpu_id[] = {
-	X86_FEATURE_MATCH(X86_FEATURE_XMM4_2),
+	X86_MATCH_FEATURE(X86_FEATURE_XMM4_2, NULL),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, crc32c_cpu_id);
diff --git a/arch/x86/crypto/crct10dif-pclmul_glue.c b/arch/x86/crypto/crct10dif-pclmul_glue.c
index 3c81e15..71291d5 100644
--- a/arch/x86/crypto/crct10dif-pclmul_glue.c
+++ b/arch/x86/crypto/crct10dif-pclmul_glue.c
@@ -114,7 +114,7 @@ static struct shash_alg alg = {
 };
 
 static const struct x86_cpu_id crct10dif_cpu_id[] = {
-	X86_FEATURE_MATCH(X86_FEATURE_PCLMULQDQ),
+	X86_MATCH_FEATURE(X86_FEATURE_PCLMULQDQ, NULL),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, crct10dif_cpu_id);
diff --git a/arch/x86/crypto/ghash-clmulni-intel_glue.c b/arch/x86/crypto/ghash-clmulni-intel_glue.c
index a4b7285..1f1a95f 100644
--- a/arch/x86/crypto/ghash-clmulni-intel_glue.c
+++ b/arch/x86/crypto/ghash-clmulni-intel_glue.c
@@ -313,7 +313,7 @@ static struct ahash_alg ghash_async_alg = {
 };
 
 static const struct x86_cpu_id pcmul_cpu_id[] = {
-	X86_FEATURE_MATCH(X86_FEATURE_PCLMULQDQ), /* Pickle-Mickle-Duck */
+	X86_MATCH_FEATURE(X86_FEATURE_PCLMULQDQ, NULL), /* Pickle-Mickle-Duck */
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, pcmul_cpu_id);
diff --git a/drivers/crypto/padlock-aes.c b/drivers/crypto/padlock-aes.c
index 594d6b1..62c6fe8 100644
--- a/drivers/crypto/padlock-aes.c
+++ b/drivers/crypto/padlock-aes.c
@@ -474,7 +474,7 @@ static struct skcipher_alg cbc_aes_alg = {
 };
 
 static const struct x86_cpu_id padlock_cpu_id[] = {
-	X86_FEATURE_MATCH(X86_FEATURE_XCRYPT),
+	X86_MATCH_FEATURE(X86_FEATURE_XCRYPT, NULL),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, padlock_cpu_id);
diff --git a/drivers/crypto/padlock-sha.c b/drivers/crypto/padlock-sha.c
index c826abe..a697a4a 100644
--- a/drivers/crypto/padlock-sha.c
+++ b/drivers/crypto/padlock-sha.c
@@ -490,7 +490,7 @@ static struct shash_alg sha256_alg_nano = {
 };
 
 static const struct x86_cpu_id padlock_sha_ids[] = {
-	X86_FEATURE_MATCH(X86_FEATURE_PHE),
+	X86_MATCH_FEATURE(X86_FEATURE_PHE, NULL),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, padlock_sha_ids);
