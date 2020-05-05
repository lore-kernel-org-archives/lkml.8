Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA22C4725E
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 10:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9F0B20721
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 10:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jCg5rc4f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbgEEK12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 06:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728716AbgEEK1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 06:27:21 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97742C061A41
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 03:27:20 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id t11so923661lfe.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 03:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bgXGdUpeDA6S2n2bWfsapxIox2ARona/I5hdI1ZbAMo=;
        b=jCg5rc4fzbUcTEW82gMx4stI32yZ+9/AL2EMw+SxTScb0kgtBp4gy01prld/ovKhlg
         phUMh+Ol9Lsoue6wcRVA1f9S4Mp0nNf9LIyJD0VUiNMN9jjgp68FD4GZcb4/pEHlzZ0g
         BYQvsJx7Kn6Ufa6bJPwUgnVYZ8liUKU3W4dejF5TTBCCSKY7jx22+P2uLRGMRiNz3W9s
         MpX46xaYG/zR/6xFfjjF3xWx7XMXSPz56wxgMrF289Hpp3/TKC3vkhKq2rdMcjRvszH0
         /W1p009a5oG+az6+pK9gkFpq65lLB3lBHgN/H3c9DCYMGdm2Apx5WNVmjhi7OMXfyj04
         gPdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bgXGdUpeDA6S2n2bWfsapxIox2ARona/I5hdI1ZbAMo=;
        b=Op1Hq6VZ9cX61NMgvWnGy2FB7R4MlNtHmfk8DUD0c2ALd/Xb1iEksYqSPLzAz2QBjx
         97kl8lef1CEc6GG+BUI9WkVy42Q/yw9ps81PIiyal4zvxu2+pd3RIDFL2bmzD2QZG7OY
         tRK8BXkq9JpZuzx6AaaI/PXTUoAYe8hIDDR53ZYE/0Qel81bcPw6pl3uMvL44thjF30X
         MTmcFm0psKj43QGgDj/AqVqJGeV/DHeo3K5pEziQALaD0iYvHjTH7d1H7nkQaZ5wDVx9
         q3mv7b5ftcWfzNGZIiqOOsE8d9ZJon0y++65pWWlQjei2ELGa3kfCVFiHv+blro2zAVB
         1v/g==
X-Gm-Message-State: AGi0PuZal0JVxZ0wUQSepTjdTbXJKtyUnv8s+YRP21L0ccswWmaxyKWl
        j/z5zEHSY/ppkniVPaOQLkXyAg==
X-Google-Smtp-Source: APiQypJSHpXephHI+itU620IH4y5WRHndCkK56pPYq/1X0jg21roe+fznpAa9iZ47D7i1WwwUxIP8g==
X-Received: by 2002:a19:5f04:: with SMTP id t4mr1255915lfb.208.1588674439039;
        Tue, 05 May 2020 03:27:19 -0700 (PDT)
Received: from localhost (c-8c28e555.07-21-73746f28.bbcust.telenor.se. [85.229.40.140])
        by smtp.gmail.com with ESMTPSA id g20sm1649058lfj.1.2020.05.05.03.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 03:27:18 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     akpm@linux-foundation.org
Cc:     john.johansen@canonical.com, jmorris@namei.org, serge@hallyn.com,
        tytso@mit.edu, adilger.kernel@dilger.ca,
        gregkh@linuxfoundation.org, brendanhiggins@google.com,
        =linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-security-module@vger.kernel.org, elver@google.com,
        davidgow@google.com, Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v2 3/6] lib: Kconfig.debug: default KUNIT_* fragments to KUNIT_RUN_ALL
Date:   Tue,  5 May 2020 12:27:14 +0200
Message-Id: <20200505102714.8023-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes it easier to enable all KUnit fragments.

Adding 'if !KUNIT_RUN_ALL' so individual test can be turned of if
someone wants that even though KUNIT_RUN_ALL is enabled.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 lib/Kconfig.debug | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 21d9c5f6e7ec..d1a94ff56a87 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2064,8 +2064,9 @@ config TEST_SYSCTL
 	  If unsure, say N.
 
 config SYSCTL_KUNIT_TEST
-	tristate "KUnit test for sysctl"
+	tristate "KUnit test for sysctl" if !KUNIT_RUN_ALL
 	depends on KUNIT
+	default KUNIT_RUN_ALL
 	help
 	  This builds the proc sysctl unit test, which runs on boot.
 	  Tests the API contract and implementation correctness of sysctl.
@@ -2075,8 +2076,9 @@ config SYSCTL_KUNIT_TEST
 	  If unsure, say N.
 
 config LIST_KUNIT_TEST
-	tristate "KUnit Test for Kernel Linked-list structures"
+	tristate "KUnit Test for Kernel Linked-list structures" if !KUNIT_RUN_ALL
 	depends on KUNIT
+	default KUNIT_RUN_ALL
 	help
 	  This builds the linked list KUnit test suite.
 	  It tests that the API and basic functionality of the list_head type
-- 
2.20.1

