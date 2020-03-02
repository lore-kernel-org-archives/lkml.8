Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4417C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 22:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 771AF24673
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 22:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbgCBWkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 17:40:17 -0500
Received: from ms.lwn.net ([45.79.88.28]:59688 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726755AbgCBWkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 17:40:10 -0500
Received: from meer.lwn.net (localhost [127.0.0.1])
        by ms.lwn.net (Postfix) with ESMTPA id 20EF199C;
        Mon,  2 Mar 2020 22:40:09 +0000 (UTC)
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 2/3] docs: move gcc-plugins to the kbuild manual
Date:   Mon,  2 Mar 2020 15:39:56 -0700
Message-Id: <20200302223957.905473-3-corbet@lwn.net>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200302223957.905473-1-corbet@lwn.net>
References: <20200302223957.905473-1-corbet@lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Information about GCC plugins is relevant to kernel building, so move this
document to the kbuild manual.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/core-api/index.rst                   | 1 -
 Documentation/{core-api => kbuild}/gcc-plugins.rst | 0
 Documentation/kbuild/index.rst                     | 1 +
 MAINTAINERS                                        | 2 +-
 scripts/gcc-plugins/Kconfig                        | 2 +-
 5 files changed, 3 insertions(+), 3 deletions(-)
 rename Documentation/{core-api => kbuild}/gcc-plugins.rst (100%)

diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
index b39dae276b57..9836a0ac09a3 100644
--- a/Documentation/core-api/index.rst
+++ b/Documentation/core-api/index.rst
@@ -102,7 +102,6 @@ Documents that don't fit elsewhere or which have yet to be categorized.
    :maxdepth: 1
 
    librs
-   gcc-plugins
    ioctl
 
 .. only:: subproject and html
diff --git a/Documentation/core-api/gcc-plugins.rst b/Documentation/kbuild/gcc-plugins.rst
similarity index 100%
rename from Documentation/core-api/gcc-plugins.rst
rename to Documentation/kbuild/gcc-plugins.rst
diff --git a/Documentation/kbuild/index.rst b/Documentation/kbuild/index.rst
index 0f144fad99a6..82daf2efcb73 100644
--- a/Documentation/kbuild/index.rst
+++ b/Documentation/kbuild/index.rst
@@ -19,6 +19,7 @@ Kernel Build System
 
     issues
     reproducible-builds
+    gcc-plugins
 
 .. only::  subproject and html
 
diff --git a/MAINTAINERS b/MAINTAINERS
index 38fe2f3f7b6f..f508f6c783d6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6934,7 +6934,7 @@ S:	Maintained
 F:	scripts/gcc-plugins/
 F:	scripts/gcc-plugin.sh
 F:	scripts/Makefile.gcc-plugins
-F:	Documentation/core-api/gcc-plugins.rst
+F:	Documentation/kbuild/gcc-plugins.rst
 
 GASKET DRIVER FRAMEWORK
 M:	Rob Springer <rspringer@google.com>
diff --git a/scripts/gcc-plugins/Kconfig b/scripts/gcc-plugins/Kconfig
index e3569543bdac..f8ca236d6165 100644
--- a/scripts/gcc-plugins/Kconfig
+++ b/scripts/gcc-plugins/Kconfig
@@ -23,7 +23,7 @@ menuconfig GCC_PLUGINS
 	  GCC plugins are loadable modules that provide extra features to the
 	  compiler. They are useful for runtime instrumentation and static analysis.
 
-	  See Documentation/core-api/gcc-plugins.rst for details.
+	  See Documentation/kbuild/gcc-plugins.rst for details.
 
 if GCC_PLUGINS
 
-- 
2.24.1

