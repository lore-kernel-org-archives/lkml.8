Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 255DDC4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 13:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F04C820776
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 13:17:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbgCTNRB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 09:17:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35742 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727338AbgCTNQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 09:16:37 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jFHVr-0004AS-12
        for linux-kernel@vger.kernel.org; Fri, 20 Mar 2020 14:16:35 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id E84441039FC
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 14:16:28 +0100 (CET)
Message-Id: <20200320131510.700250889@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 20 Mar 2020 14:14:05 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Gross <mgross@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-edac@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org
Subject: [patch 20/22] crypto: Convert to new CPU match macros
References: <20200320131345.635023594@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new macro set has a consistent namespace and uses C99 initializers
instead of the grufty C89 ones.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org
---
 arch/x86/crypto/aesni-intel_glue.c         |    2 +-
 arch/x86/crypto/crc32-pclmul_glue.c        |    2 +-
 arch/x86/crypto/crc32c-intel_glue.c        |    2 +-
 arch/x86/crypto/crct10dif-pclmul_glue.c    |    2 +-
 arch/x86/crypto/ghash-clmulni-intel_glue.c |    2 +-
 drivers/crypto/padlock-aes.c               |    2 +-
 drivers/crypto/padlock-sha.c               |    2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

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
--- a/arch/x86/crypto/ghash-clmulni-intel_glue.c
+++ b/arch/x86/crypto/ghash-clmulni-intel_glue.c
@@ -313,7 +313,7 @@ static struct ahash_alg ghash_async_alg
 };
 
 static const struct x86_cpu_id pcmul_cpu_id[] = {
-	X86_FEATURE_MATCH(X86_FEATURE_PCLMULQDQ), /* Pickle-Mickle-Duck */
+	X86_MATCH_FEATURE(X86_FEATURE_PCLMULQDQ, NULL), /* Pickle-Mickle-Duck */
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, pcmul_cpu_id);
--- a/drivers/crypto/padlock-aes.c
+++ b/drivers/crypto/padlock-aes.c
@@ -474,7 +474,7 @@ static struct skcipher_alg cbc_aes_alg =
 };
 
 static const struct x86_cpu_id padlock_cpu_id[] = {
-	X86_FEATURE_MATCH(X86_FEATURE_XCRYPT),
+	X86_MATCH_FEATURE(X86_FEATURE_XCRYPT, NULL),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, padlock_cpu_id);
--- a/drivers/crypto/padlock-sha.c
+++ b/drivers/crypto/padlock-sha.c
@@ -490,7 +490,7 @@ static struct shash_alg sha256_alg_nano
 };
 
 static const struct x86_cpu_id padlock_sha_ids[] = {
-	X86_FEATURE_MATCH(X86_FEATURE_PHE),
+	X86_MATCH_FEATURE(X86_FEATURE_PHE, NULL),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, padlock_sha_ids);

