Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE811C43446
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 22:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C172E206F4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 22:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gEu3ivm6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgGJWfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 18:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbgGJWez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 18:34:55 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55071C08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 15:34:55 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id cm21so3198340pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 15:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DivSEld72ml8UTqRFMIcUkbiemFCRo0SWplyKdIEijY=;
        b=gEu3ivm6U22TdvJqmNQgrAe8nAYy+fXfTEgDwR6q8Ka1STCVn26RtJ6+OM4ZlOg8wi
         4fHwKZkIWzjd+o5GSNHF3+oipT4/9cjFAYrRtpyUHXJewsRVXd9iJCAcCHXGoNs+7LH3
         WxqsZ74oaU4irPDCSOxWUEtq+g+xNsR38p1XSYbdQllZSkdqiH5CqJKF2Mwnwu0l5qtP
         UyKqYhtz52OuW6o7SkhH5zyESGr3gvBaQgEJDmP7GnHJ0lfv09MHMxRDJjAVV/w3CP6E
         xXTuOXTcMPbcvfpDc5q/0JoUmeTVCyMRoz9IdgllB2OJq+YNiFFkI/19ouCbH4Fn3Z3G
         emgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DivSEld72ml8UTqRFMIcUkbiemFCRo0SWplyKdIEijY=;
        b=b9ZAkcNFhhkVPZ0e6AiHJbTZOKnV1QWsbGMLRCbSfsWuL7A39WY8bfh7dbzhN0q03M
         G46XvERulMYXMC90pNjXwkCLYH9KyTGkFpzBYnrRLjDwbDEcjhuLyMh4eqVdIoqeSDMm
         XPmCUdSBEOiRU7FVrLrtJqC8vuh5QrTymn3bEoCZwWONwEPkC0rx5129mndzkl2Z4ymK
         mHxO0rc6NxBPf1wGXm49YBUwCSj8qi/1DrradGbuSV8H+dfx9IxtsbNvZkAQy7ofI5ZT
         oM8nN/KGzUxrxqi2AqsEFlLEyOI3Y5Ih9YruMSka5CZvfQpnI3gqX2bCh60rW+MvFKUg
         jXnA==
X-Gm-Message-State: AOAM533aFDqlowldpp+6p/aL0bx0tWmTb9jAmVhYOsnbK/iZH6mozRZg
        YJYSfQJXDpjKu3jWvb1B3+QWcrIB
X-Google-Smtp-Source: ABdhPJwanRbTXj44MWF3B5g+7jjskumC6TWofjQjkfc4vi6MUzK7Fijb4NU6xWuzf99l/YXJAb7D9g==
X-Received: by 2002:a17:902:b694:: with SMTP id c20mr61200519pls.123.1594420494803;
        Fri, 10 Jul 2020 15:34:54 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:1000:7a00::1])
        by smtp.gmail.com with ESMTPSA id u128sm6564079pfu.148.2020.07.10.15.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 15:34:54 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, cesarb@cesarb.eti.br,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] mips: Remove compiler check in unroll macro
Date:   Fri, 10 Jul 2020 15:34:41 -0700
Message-Id: <20200710223441.756320-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200709221102.323356-1-cesarb@cesarb.eti.br>
References: <20200709221102.323356-1-cesarb@cesarb.eti.br>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_CC_IS_GCC is undefined when Clang is used, which breaks the build
(see our Travis link below).

Clang 8 was chosen as a minimum version for this check because there
were some improvements around __builtin_constant_p in that release. In
reality, MIPS was not even buildable until clang 9 so that check was not
technically necessary. Just remove all compiler checks and just assume
that we have a working compiler.

Fixes: d4e60453266b ("Restore gcc check in mips asm/unroll.h")
Link: https://travis-ci.com/github/ClangBuiltLinux/continuous-integration/jobs/359642821
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 arch/mips/include/asm/unroll.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/unroll.h b/arch/mips/include/asm/unroll.h
index 49009319ac2c..7dd4a80e05d6 100644
--- a/arch/mips/include/asm/unroll.h
+++ b/arch/mips/include/asm/unroll.h
@@ -25,9 +25,7 @@
 	 * generate reasonable code for the switch statement,	\
 	 * so we skip the sanity check for those compilers.	\
 	 */							\
-	BUILD_BUG_ON((CONFIG_CC_IS_GCC ||			\
-		      CONFIG_CLANG_VERSION >= 80000) &&		\
-		     !__builtin_constant_p(times));		\
+	BUILD_BUG_ON(!__builtin_constant_p(times));		\
 								\
 	switch (times) {					\
 	case 32: fn(__VA_ARGS__); /* fall through */		\

base-commit: aa0c9086b40c17a7ad94425b3b70dd1fdd7497bf
-- 
2.27.0

