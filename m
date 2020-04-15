Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0FFC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 21:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6529B20784
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 21:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442248AbgDOVGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 17:06:32 -0400
Received: from mga03.intel.com ([134.134.136.65]:64170 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2442224AbgDOVFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 17:05:31 -0400
IronPort-SDR: jiIgtiYM3WeGGNc0wk1n7TUWtkENP409LXoGjU3HQI5NIFp8az/dalw3bsMiQnQingqIWVBmVy
 Ej7Ye2V+5pYg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 14:05:18 -0700
IronPort-SDR: 7n8pRWt0V1GeJc9ECBQITu9uGiTez3QAZq7Wl8D0+wef+n1oKTjTuiwn6XciFIP7visxU7Khkz
 sHR9mObX3jFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,388,1580803200"; 
   d="scan'208";a="455035542"
Received: from kcaccard-mobl.amr.corp.intel.com (HELO kcaccard-mobl1.jf.intel.com) ([10.209.116.191])
  by fmsmga006.fm.intel.com with ESMTP; 15 Apr 2020 14:05:12 -0700
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     keescook@chromium.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org
Cc:     arjan@linux.intel.com, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com, rick.p.edgecomb@intel.com
Subject: [PATCH 3/9] x86/boot: Allow a "silent" kaslr random byte fetch
Date:   Wed, 15 Apr 2020 14:04:45 -0700
Message-Id: <20200415210452.27436-4-kristen@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415210452.27436-1-kristen@linux.intel.com>
References: <20200415210452.27436-1-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

Under earlyprintk, each RNG call produces a debug report line. When
shuffling hundreds of functions, this is not useful information (each
line is identical and tells us nothing new). Instead, allow for a NULL
"purpose" to suppress the debug reporting.

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
---
 arch/x86/lib/kaslr.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/x86/lib/kaslr.c b/arch/x86/lib/kaslr.c
index a53665116458..2b3eb8c948a3 100644
--- a/arch/x86/lib/kaslr.c
+++ b/arch/x86/lib/kaslr.c
@@ -56,11 +56,14 @@ unsigned long kaslr_get_random_long(const char *purpose)
 	unsigned long raw, random = get_boot_seed();
 	bool use_i8254 = true;
 
-	debug_putstr(purpose);
-	debug_putstr(" KASLR using");
+	if (purpose) {
+		debug_putstr(purpose);
+		debug_putstr(" KASLR using");
+	}
 
 	if (has_cpuflag(X86_FEATURE_RDRAND)) {
-		debug_putstr(" RDRAND");
+		if (purpose)
+			debug_putstr(" RDRAND");
 		if (rdrand_long(&raw)) {
 			random ^= raw;
 			use_i8254 = false;
@@ -68,7 +71,8 @@ unsigned long kaslr_get_random_long(const char *purpose)
 	}
 
 	if (has_cpuflag(X86_FEATURE_TSC)) {
-		debug_putstr(" RDTSC");
+		if (purpose)
+			debug_putstr(" RDTSC");
 		raw = rdtsc();
 
 		random ^= raw;
@@ -76,7 +80,8 @@ unsigned long kaslr_get_random_long(const char *purpose)
 	}
 
 	if (use_i8254) {
-		debug_putstr(" i8254");
+		if (purpose)
+			debug_putstr(" i8254");
 		random ^= i8254();
 	}
 
@@ -86,7 +91,8 @@ unsigned long kaslr_get_random_long(const char *purpose)
 	    : "a" (random), "rm" (mix_const));
 	random += raw;
 
-	debug_putstr("...\n");
+	if (purpose)
+		debug_putstr("...\n");
 
 	return random;
 }
-- 
2.20.1

