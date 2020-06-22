Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D24C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 18:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B042A20732
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 18:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VSNzjOCo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730381AbgFVSRI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 14:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730355AbgFVSRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 14:17:04 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8F5C061799
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 11:17:02 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id h95so221837pje.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 11:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rA2WXMqgPYAeqAuK7s/zzGefwkZbfch+R0KvxQ9iJfU=;
        b=VSNzjOCo/0ywmXKgV4GQ/yiHvhW+WvSxetHzcbI+9J9pyZMzQOXBotMwcL1OA4/Ws7
         NcLboXYTqZ2LC8itpaPL8sX7TVp7ckZsfKZL8UpR/MDvbi/3lG4H3QqnAm8UODAkMmqw
         cbr0hY6tyGj2l4YBXUa3dxZdEMNH0jHo14Y3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rA2WXMqgPYAeqAuK7s/zzGefwkZbfch+R0KvxQ9iJfU=;
        b=i1JojVFpHA3DpueF5yVuKS/cP3XeQUj0oTxQn8tSstbLXcdTntEHCRkpL1AEDnc5iV
         ONH8ZOeRyC3Z6GTZLkbnWAQkRstK2Eej76Ow2+fkwXfqaNwiCta+inn1lKLwmktomqtF
         at6xoemif//d1V5px4kvU47/z4YddZPbOV73MGsoUIK6O8wNt5arGXgdvIoqtHBEGMUT
         uI8CAyj1p/6a0A157rgrToSlf6gEa8WHMieX/sK8Bw0aOHI+hxD6kdYxiLloXpTUVjsc
         JVZZLpFBMDtoa/6moZ2rTezURwOfNkyW4Iw/gF3XKl/PtnJQKlDN0+oFH5pvwny9FHP9
         imYw==
X-Gm-Message-State: AOAM530Zen6opeIyewEYXZrWoqSqJcSVcwhhVS3oHZiY/QBOMXEzWx2W
        t05SR0nIm3EOmjfAp2MkuHAw8g==
X-Google-Smtp-Source: ABdhPJwe2wVGocTiHf38yZGYDVPhtrV4HFUMadNy7uTBj3Dv0xSfNvOjzuem+IAa71O97TpoKdMtpQ==
X-Received: by 2002:a17:902:bb95:: with SMTP id m21mr20430230pls.111.1592849822330;
        Mon, 22 Jun 2020 11:17:02 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f14sm187660pjq.36.2020.06.22.11.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 11:16:59 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian@brauner.io>,
        David Gow <davidgow@google.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Bird, Tim" <Tim.Bird@sony.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/8] selftests/harness: Display signed values correctly
Date:   Mon, 22 Jun 2020 11:16:50 -0700
Message-Id: <20200622181651.2795217-8-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200622181651.2795217-1-keescook@chromium.org>
References: <20200622181651.2795217-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since forever the harness output for signed value tests have reported
unsigned values to avoid casting. Instead, actually test the variable
types and perform the correct casts and choose the correct format
specifiers.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/kselftest_harness.h | 42 ++++++++++++++++++---
 1 file changed, 37 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index b519765904a6..ae51b762d120 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -679,17 +679,49 @@
 	if (_metadata->passed && _metadata->step < 255) \
 		_metadata->step++;
 
+#define is_signed_type(var)       (!!(((__typeof__(var))(-1)) < (__typeof__(var))1))
+
 #define __EXPECT(_expected, _expected_str, _seen, _seen_str, _t, _assert) do { \
 	/* Avoid multiple evaluation of the cases */ \
 	__typeof__(_expected) __exp = (_expected); \
 	__typeof__(_seen) __seen = (_seen); \
 	if (_assert) __INC_STEP(_metadata); \
 	if (!(__exp _t __seen)) { \
-		unsigned long long __exp_print = (uintptr_t)__exp; \
-		unsigned long long __seen_print = (uintptr_t)__seen; \
-		__TH_LOG("Expected %s (%llu) %s %s (%llu)", \
-			 _expected_str, __exp_print, #_t, \
-			 _seen_str, __seen_print); \
+		/* Report with actual signedness to avoid weird output. */ \
+		switch (is_signed_type(__exp) * 2 + is_signed_type(__seen)) { \
+		case 0: { \
+			unsigned long long __exp_print = (uintptr_t)__exp; \
+			unsigned long long __seen_print = (uintptr_t)__seen; \
+			__TH_LOG("Expected %s (%llu) %s %s (%llu)", \
+				 _expected_str, __exp_print, #_t, \
+				 _seen_str, __seen_print); \
+			break; \
+			} \
+		case 1: { \
+			unsigned long long __exp_print = (uintptr_t)__exp; \
+			long long __seen_print = (intptr_t)__seen; \
+			__TH_LOG("Expected %s (%llu) %s %s (%lld)", \
+				 _expected_str, __exp_print, #_t, \
+				 _seen_str, __seen_print); \
+			break; \
+			} \
+		case 2: { \
+			long long __exp_print = (intptr_t)__exp; \
+			unsigned long long __seen_print = (uintptr_t)__seen; \
+			__TH_LOG("Expected %s (%lld) %s %s (%llu)", \
+				 _expected_str, __exp_print, #_t, \
+				 _seen_str, __seen_print); \
+			break; \
+			} \
+		case 3: { \
+			long long __exp_print = (intptr_t)__exp; \
+			long long __seen_print = (intptr_t)__seen; \
+			__TH_LOG("Expected %s (%lld) %s %s (%lld)", \
+				 _expected_str, __exp_print, #_t, \
+				 _seen_str, __seen_print); \
+			break; \
+			} \
+		} \
 		_metadata->passed = 0; \
 		/* Ensure the optional handler is triggered */ \
 		_metadata->trigger = 1; \
-- 
2.25.1

