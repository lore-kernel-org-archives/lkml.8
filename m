Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DD2C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4877220EDD
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g6gZ1A4W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729270AbgGNSab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 14:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729256AbgGNSa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:30:26 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5630DC061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 11:30:26 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id q17so7363777pls.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 11:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=W+8q1daBddAXvOtBFXAsV/dQeLyDputz9vwjDvvFrCo=;
        b=g6gZ1A4WuOIoYr8rxcyDj1SdE42QcHNevJm1VxLwaCiSS2uhXIbMQj4fbdrcNwyzHk
         KnvFuRPRUDe5Yf+Rh2mFTJTuON6B+mzDyipBnRMnXk3yrjPC9OfA6/+sq/1SZ4MYJwSq
         78eMkxt7DiIedoW1NofxUFgnmjqqoXHpk5SPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=W+8q1daBddAXvOtBFXAsV/dQeLyDputz9vwjDvvFrCo=;
        b=DdYBWjmmd+GBbLIAU5xqGiiY+iLa0yjouXAhKyYH+FL2O0L4qVIgYMtHW/7v1yLZxZ
         Ujli73JAIu22N/KjwaXkqRE/uD4TLBUyJdLeVpzolNc1337g70nM2Cb2AJ2Q3tcZw2Xl
         P2a2/Y0aYE6WEFRfcnbGAbgr/U/2NAWwtwTsxNw4ndK5V2njWgQpBrmsyppAM5d9Priv
         9xzE6C2i3kWpqnesj138ECMdxhnSXp8nJCzO1UGbEaiqhFrKZ72360VKOEaRdi1CChkn
         jcqPS2RjMONkfTQ5D6eXNhX6zbZ4DHsfIgeife/W036B1nKapI++0Pko0haHpuf7opzq
         eqCA==
X-Gm-Message-State: AOAM531cFMQRFOajFbCzZiB1e2QzCFdFELW1/HLcJb6uWGVAQ3CGCWFm
        JXOv5Dnr/h6RzhTOqYfVLN/k/Q==
X-Google-Smtp-Source: ABdhPJya+EiWFEJrlE0qPDf2Gq7NOZdjqmit6Y9e6eKWmO2lnvPlzplAV/n+sFRa/06ifs0zFz25Lg==
X-Received: by 2002:a17:90a:ce0c:: with SMTP id f12mr6190895pju.19.1594751425748;
        Tue, 14 Jul 2020 11:30:25 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e195sm17091209pfh.218.2020.07.14.11.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 11:30:24 -0700 (PDT)
Date:   Tue, 14 Jul 2020 11:30:23 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Ralph Campbell <rcampbell@nvidia.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/harness: Limit step counter reporting
Message-ID: <202007141129.54335CEAC6@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the selftest "step" counter grew beyond 255, non-fatal warnings
were being emitted, which is noisy and pointless. There are selftests
with more than 255 steps (especially those in loops, etc). Instead,
just cap "steps" to 254 and do not report the saturation.

Reported-by: Ralph Campbell <rcampbell@nvidia.com>
Tested-by: Ralph Campbell <rcampbell@nvidia.com>
Fixes: 9847d24af95c ("selftests/harness: Refactor XFAIL into SKIP")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/kselftest_harness.h | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 935029d4fb21..4f78e4805633 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -680,7 +680,8 @@
 			__bail(_assert, _metadata->no_print, _metadata->step))
 
 #define __INC_STEP(_metadata) \
-	if (_metadata->passed && _metadata->step < 255) \
+	/* Keep "step" below 255 (which is used for "SKIP" reporting). */	\
+	if (_metadata->passed && _metadata->step < 253) \
 		_metadata->step++;
 
 #define is_signed_type(var)       (!!(((__typeof__(var))(-1)) < (__typeof__(var))1))
@@ -976,12 +977,6 @@ void __run_test(struct __fixture_metadata *f,
 		t->passed = 0;
 	} else if (t->pid == 0) {
 		t->fn(t, variant);
-		/* Make sure step doesn't get lost in reporting */
-		if (t->step >= 255) {
-			ksft_print_msg("Too many test steps (%u)!?\n", t->step);
-			t->step = 254;
-		}
-		/* Use 255 for SKIP */
 		if (t->skip)
 			_exit(255);
 		/* Pass is exit 0 */
-- 
2.25.1


-- 
Kees Cook
