Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17601C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 06:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E35C52088E
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 06:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NEaE42su"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgGEGMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 02:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbgGEGMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 02:12:38 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD31C08C5DF
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jul 2020 23:12:38 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id mn17so2144237pjb.4
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jul 2020 23:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OZzsxmLpal9LTjS6QimvxdwVWVZQo7ewuu92tmSkSEM=;
        b=NEaE42suoMG6ZDKlb2zks2hev0bjNVC22CHG5tz/AXRLVd6ati8EXXjPjszVuoztVz
         gzkRK2bg/hQ0ox2IXt7OIlweA60JlAHqzrAWzDf/QsuWpyIkSm4PkO/cVsOCimZrSZNS
         yKjJGoxVg09mZppo3eWFwRJAyVXh+fQlfiwko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OZzsxmLpal9LTjS6QimvxdwVWVZQo7ewuu92tmSkSEM=;
        b=LulpwLcwuybt2nq9FZ8Hgj7fXwcFGayGjDJ0YmBrHuk/U1y9TJmC2zNDZwIjxXY+dc
         8IP5zAFEMT2BdT+OCGbb/u6/4cNEalgJ4kdCi+g0GV+QSC9YMYP1VogH9Yb2vIv1Dswp
         PxD3C4OqJ4qn9H3R8SOatEWRDBZfLLQ0y5sTaD0X0B9Ebjb8iK4oYMkmVzyC7ULCEk9b
         tIpZFZwmri6skUsFf81Nvs5THjdmXJOLC4Krypdx4HjooKy1+g5BesM3nGtrxkRiQqAO
         Jb6MDNwBZC7VsSwqYgwIKjxvZ9+kv25BXttVgcwTQiNlgZQiz18VXYGntjoaJ/47SHzz
         57Hw==
X-Gm-Message-State: AOAM532/zBKdjUndIfb8y1tA8nheq5P6j3Ypqxh96vuQLzw+3LdgVRi6
        xXKhg2qghSgkOuvjGEF1IJVTPg==
X-Google-Smtp-Source: ABdhPJxYU+9no/GAQsZ2SUruyg8rI3uRDDgkYyoxepJnOl5HAOJAu0LUTlJALyhd3hG8h6GiUnRacQ==
X-Received: by 2002:a17:902:8d89:: with SMTP id v9mr36013600plo.191.1593929558470;
        Sat, 04 Jul 2020 23:12:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o1sm15174098pjf.17.2020.07.04.23.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2020 23:12:37 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Keno Fischer <keno@juliacomputing.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] selftests/harness: Clean up kern-doc for fixtures
Date:   Sat,  4 Jul 2020 23:12:30 -0700
Message-Id: <20200705061232.4151319-2-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200705061232.4151319-1-keescook@chromium.org>
References: <20200705061232.4151319-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The FIXTURE*() macro kern-doc examples had the wrong names for the C code
examples associated with them. Fix those and clarify that FIXTURE_DATA()
usage should be avoided.

Cc: Shuah Khan <shuah@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>
Fixes: 74bc7c97fa88 ("kselftest: add fixture variants")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/kselftest_harness.h | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index c9f03ef93338..7f32a7099a81 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -195,8 +195,9 @@
  *
  * .. code-block:: c
  *
- *     FIXTURE_DATA(datatype name)
+ *     FIXTURE_DATA(datatype_name)
  *
+ * Almost always, you want just FIXTURE() instead (see below).
  * This call may be used when the type of the fixture data
  * is needed.  In general, this should not be needed unless
  * the *self* is being passed to a helper directly.
@@ -211,7 +212,7 @@
  *
  * .. code-block:: c
  *
- *     FIXTURE(datatype name) {
+ *     FIXTURE(fixture_name) {
  *       type property1;
  *       ...
  *     };
@@ -238,7 +239,7 @@
  *
  * .. code-block:: c
  *
- *     FIXTURE_SETUP(fixture name) { implementation }
+ *     FIXTURE_SETUP(fixture_name) { implementation }
  *
  * Populates the required "setup" function for a fixture.  An instance of the
  * datatype defined with FIXTURE_DATA() will be exposed as *self* for the
@@ -264,7 +265,7 @@
  *
  * .. code-block:: c
  *
- *     FIXTURE_TEARDOWN(fixture name) { implementation }
+ *     FIXTURE_TEARDOWN(fixture_name) { implementation }
  *
  * Populates the required "teardown" function for a fixture.  An instance of the
  * datatype defined with FIXTURE_DATA() will be exposed as *self* for the
@@ -285,7 +286,7 @@
  *
  * .. code-block:: c
  *
- *     FIXTURE_VARIANT(datatype name) {
+ *     FIXTURE_VARIANT(fixture_name) {
  *       type property1;
  *       ...
  *     };
@@ -305,8 +306,8 @@
  *
  * .. code-block:: c
  *
- *     FIXTURE_ADD(datatype name) {
- *       .property1 = val1;
+ *     FIXTURE_VARIANT_ADD(fixture_name, variant_name) {
+ *       .property1 = val1,
  *       ...
  *     };
  *
-- 
2.25.1

