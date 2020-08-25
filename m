Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8166BC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 22:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F5862075F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 22:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="fOK1Krh7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbgHYW0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 18:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbgHYW0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 18:26:02 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9F6C061755
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 15:26:01 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id s29so51954qtc.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 15:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=FW2LrTzzEQgbMzq3tJHO9RKBRPjxertl4+WTZokfJYo=;
        b=fOK1Krh7WNbRfwoDQK+/SD0jQQyr0PSMvwUQCD6tAzCs+A3rB/iQPEEGpJBUn9yRkl
         avnu+n5QnU9pInub5wiqGm/9g2/+lQm4GD55/GcD211tA9+DHFmBlQAk+XTr3Lqe65Sx
         Juae8uK5syhRfAapQbT5aqIWxTK+7rdDCch0/70gxF1BBfCk6o3tkfpku50rWqc3PqQa
         F6ELQkeluiUnEBjW+X/PZSkYC2zLwK+c+GXoFCxS6LvmWPAQ7p53cJ9OLMDQvNhJtqzV
         2DmrzSdWEbZbpyu9FpZ6VEE8THXZZLckNDIvcFgmSETKsbz5gDBcyD9R1Id2w3RP+dMD
         3RfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=FW2LrTzzEQgbMzq3tJHO9RKBRPjxertl4+WTZokfJYo=;
        b=lEuoT6NhnhfgzHNqJY3RzhL9iOLGRCbt/Z1h8fYttj2ipGED9d389mGHBqoEXG5794
         paettLVXQZspF9Ga+Q8hl/LGKsvit7OZZSzOQgB+k95gQcNuc9HNPEaInlPLi23LvcpH
         rJdlWIj/BWHXHkN9NpMquZ5DT+mIjr7b4neVTEBdpkOQi1bGZGD22yZH7L9b1pVNun9Z
         dvSD3vZyrDjJDcaDbm011ow3nVKtp1JIcFtAS0oltorQo1IvMHnC+Koah8HWmnIph0T3
         yJmzrPexYIWLR2ibKw6TBZaPoWltqGMpL0IJkQ825VqYDUSaRiuwCMCS/hzICvGH3wg5
         KnLA==
X-Gm-Message-State: AOAM533pKZtSvtIGiTSn/Ke4nGE5M9hLKwEprBdWfKDLrYWwlsyT4K5U
        aATqttlly1E33ZNzPILwaI7z6QE3XiP2qYfWgDk=
X-Google-Smtp-Source: ABdhPJxjEG9J8LsOt3eGnk+oh0vR4LuJImhCl2b2a7k2KSxcCkF/a/1kJo9E1rkfUUX8pr1WRtNDi/fWecByGG+g12M=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:a05:6214:1086:: with SMTP id
 o6mr11029155qvr.41.1598394359323; Tue, 25 Aug 2020 15:25:59 -0700 (PDT)
Date:   Tue, 25 Aug 2020 15:25:51 -0700
Message-Id: <20200825222552.3113760-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH] Documentation: add minimum clang/llvm version
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Theodore Ts'o" <tytso@mit.edu>, Kees Cook <keescook@chromium.org>,
        Will Deacon <will@kernel.org>, Borislav Petkov <bp@suse.de>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        clang-built-linux@googlegroups.com, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on a vote at the LLVM BoF at Plumbers 2020, we decided to start
small, supporting just one formal upstream release of LLVM for now.

We can probably widen the support window of supported versions over
time.  Also, note that LLVM's release process is different than GCC's.
GCC tends to have 1 major release per year while releasing minor updates
to the past 3 major versions.  LLVM tends to support one major release
and one minor release every six months.

Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Note to reviewers: working remote, I'm having trouble testing/verifying
that I have the RST links wired up correctly; I would appreciate it if
someone is able to `make htmldocs` and check
Documentation/output/process/changes.html properly links to
Documentation/output/kbuild/llvm.html.

 Documentation/kbuild/llvm.rst     |  2 ++
 Documentation/process/changes.rst | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/Documentation/kbuild/llvm.rst b/Documentation/kbuild/llvm.rst
index 2aac50b97921..70ec6e9a183b 100644
--- a/Documentation/kbuild/llvm.rst
+++ b/Documentation/kbuild/llvm.rst
@@ -1,3 +1,5 @@
+.. _kbuild_llvm:
+
 ==============================
 Building Linux with Clang/LLVM
 ==============================
diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
index ee741763a3fc..6c580ef9f2a3 100644
--- a/Documentation/process/changes.rst
+++ b/Documentation/process/changes.rst
@@ -30,6 +30,7 @@ you probably needn't concern yourself with pcmciautils.
         Program        Minimal version       Command to check the version
 ====================== ===============  ========================================
 GNU C                  4.9              gcc --version
+Clang/LLVM (optional)  10.0.1           clang --version
 GNU make               3.81             make --version
 binutils               2.23             ld -v
 flex                   2.5.35           flex --version
@@ -68,6 +69,15 @@ GCC
 The gcc version requirements may vary depending on the type of CPU in your
 computer.
 
+Clang/LLVM (optional)
+---------------------
+
+The latest formal release of clang and LLVM utils (according to
+`releases.llvm.org <https://releases.llvm.org>`_) are supported for building
+kernels. Older releases aren't gauranteed to work, and we may drop workarounds
+from the kernel that were used to support older versions. Please see additional
+docs on :ref:`Building Linux with Clang/LLVM <kbuild_llvm>`.
+
 Make
 ----
 
-- 
2.28.0.297.g1956fa8f8d-goog

