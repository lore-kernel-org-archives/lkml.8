Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8CC1C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 04:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B798820702
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 04:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hp5nO+v2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgGGEcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 00:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbgGGEcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 00:32:04 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8615C08C5DF
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 21:32:03 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id d27so12205549ybe.20
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 21:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=bSieeJifIVIrHN3z5di4jeqqr1xXTV3Iv6pZZ8KLoOc=;
        b=Hp5nO+v2HQgAYY+oLVI0jiIkGiZNdqok1IhMoBTc7zoe6wfbeDZSAnVLFURhrC9jqF
         Eto/TUZQqRXxhVZjINsrUlkmGgUpJVbvRRvGeQwnrrI8Yw16n+AZncmIGLpj8tL4LDrU
         WFB9gh2mP9JuEkknna7TQglRdgoF0XVBCf4puEHxBOWEW4VNdgNQHrlij7bXu87zbQoA
         qs3vGVXEbKhz26OJLHt/ETlH+ZAFfpaFvIVWpay41Oa9ORTK9JAmXkXvIHwgh81eqUfB
         MRz29Oga86VLzRhKYxU0NHtLH20M04rRJdDM5CHLSvN6PCoCDFcjYdQ/BKmj9Ga7gBOw
         XR3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=bSieeJifIVIrHN3z5di4jeqqr1xXTV3Iv6pZZ8KLoOc=;
        b=Chk1yNDJZiPKTF5cHxZK9xPVwMUsNXAsjJptrT6r28q5DMm5RXbQPywkgdWYAGoP7U
         xRpjLKlUxdAt1sGnwtKbEEUImZ+ETxflBpbNiPIZWkYvctIyvq9OPjuXvjv/A1FaN2CP
         ia3AqEYTSYQFNgLfiHCfN8IKVdSP/vIgvsg0Vhi0QMpr0zKyhoVXGY0FPPbxew6qFMb8
         7AhVeeZTcm58ioLWcyR8ELbn26X1sq+Q8rLu4xm0a14/WdiDnR6l8bRmTHOXc5w/LNsI
         4HJWAY6SU9dnTtAu/PXELZ5idmYS2OqjGKU9lahp4mTq0EDkL6KEZPzXarY3ScBj5R+9
         qy8g==
X-Gm-Message-State: AOAM532/LNiUm+axgLqbSVDRT/+426V6McWhd+B3826Yu/bfbyLUysyB
        O8jThHscHYtRPoqCWJGxEmok22w3YJUpwA==
X-Google-Smtp-Source: ABdhPJyW2ZGUSk2EaVISeQfvjunyOBHDAXEWrY4Tyhrbj9oNjJRSJGVCeWSH5cytKMNnTkN3wb/fSIefOeUU3A==
X-Received: by 2002:a25:3d5:: with SMTP id 204mr38355148ybd.442.1594096322922;
 Mon, 06 Jul 2020 21:32:02 -0700 (PDT)
Date:   Mon,  6 Jul 2020 21:31:20 -0700
Message-Id: <20200707043119.3016937-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH] Documentation: kunit: Remove references to --defconfig
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>,
        Vitor Massaru Iha <vitor@massaru.org>
Cc:     SeongJae Park <sjpark@amazon.de>, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The --defconfig option in kunit_tool was removed in [1], but the getting
started and kunit_tool documentation still encouraged its use. Update
those documents to reflect that it's no-longer required, and is the
default behaviour if no .kunitconfig is found.

Also update a couple of places where .kunitconfig is still referred to
as kunitconfig (this was changed in [2]).

[1]:
https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/commit/?h=kunit-fixes&id=9bdf64b35117cc10813d24e1842cd8ee40ecbf19
[2]:
https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/commit/?h=kunit-fixes&id=14ee5cfd4512ee3d1e0047d8751450dcc6544070

Signed-off-by: David Gow <davidgow@google.com>
---
 Documentation/dev-tools/kunit/kunit-tool.rst | 17 +++++------------
 Documentation/dev-tools/kunit/start.rst      |  2 +-
 2 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/Documentation/dev-tools/kunit/kunit-tool.rst b/Documentation/dev-tools/kunit/kunit-tool.rst
index 949af2da81e5..29ae2fee8123 100644
--- a/Documentation/dev-tools/kunit/kunit-tool.rst
+++ b/Documentation/dev-tools/kunit/kunit-tool.rst
@@ -19,13 +19,13 @@ compiles the kernel as a standalone Linux executable that can be run like any
 other program directly inside of a host operating system. To be clear, it does
 not require any virtualization support: it is just a regular program.
 
-What is a kunitconfig?
-======================
+What is a .kunitconfig?
+=======================
 
 It's just a defconfig that kunit_tool looks for in the base directory.
 kunit_tool uses it to generate a .config as you might expect. In addition, it
 verifies that the generated .config contains the CONFIG options in the
-kunitconfig; the reason it does this is so that it is easy to be sure that a
+.kunitconfig; the reason it does this is so that it is easy to be sure that a
 CONFIG that enables a test actually ends up in the .config.
 
 How do I use kunit_tool?
@@ -46,16 +46,9 @@ However, you most likely want to use it with the following options:
 - ``--timeout`` sets a maximum amount of time to allow tests to run.
 - ``--jobs`` sets the number of threads to use to build the kernel.
 
-If you just want to use the defconfig that ships with the kernel, you can
-append the ``--defconfig`` flag as well:
-
-.. code-block:: bash
-
-	./tools/testing/kunit/kunit.py run --timeout=30 --jobs=`nproc --all` --defconfig
-
 .. note::
-	This command is particularly helpful for getting started because it
-	just works. No kunitconfig needs to be present.
+	This command will work even without a .kunitconfig file: if no
+        .kunitconfig is present, a default one will be used instead.
 
 For a list of all the flags supported by kunit_tool, you can run:
 
diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
index bb112cf70624..d23385e3e159 100644
--- a/Documentation/dev-tools/kunit/start.rst
+++ b/Documentation/dev-tools/kunit/start.rst
@@ -18,7 +18,7 @@ The wrapper can be run with:
 
 .. code-block:: bash
 
-	./tools/testing/kunit/kunit.py run --defconfig
+	./tools/testing/kunit/kunit.py run
 
 For more information on this wrapper (also called kunit_tool) check out the
 :doc:`kunit-tool` page.
-- 
2.27.0.212.ge8ba1cc988-goog

