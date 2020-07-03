Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E5F1C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 07:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F40B6208B8
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 07:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kdrag0n.dev header.i=@kdrag0n.dev header.b="IiQ+r46F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IhZ0UIQw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbgGCHbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 03:31:53 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:58353 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726033AbgGCHbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 03:31:53 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 1F97CA01;
        Fri,  3 Jul 2020 03:31:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 03 Jul 2020 03:31:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kdrag0n.dev; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=X6Y8xHa3Pibzg
        GUt6oP1ChxLqKHRNC1m6ymqp41msqo=; b=IiQ+r46FntV2KCZKvH0ornfYpVP0q
        GKpmzfS1DeWBEhohuvO2hvUSd1s3TqxUKXhpRMttrZv0ZKwpbph4e8lk0zHsTsGs
        +2rk+Dx+qQob+Y0/Vq2bXfFg6y8Y+W8rypQWQwJceARkRl408BBpdTbNpj8DRjKb
        1HoVGwCYkkKxQ78T26OrflHAnABp85a4GDMn2tWmwjFSqms5HBhThvT/PZx9HzkX
        HqDamFp/i9iDbrkcWy61PcBjsZgpdeGy619k2pOLl5y/cNXK8vOfeW1VeaLYwBo2
        RAlFnSZZEPgK5liFdTBzt6M+R+MEigOfL+yKA94iAEwga9EuIxTG1+IQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=X6Y8xHa3PibzgGUt6oP1ChxLqKHRNC1m6ymqp41msqo=; b=IhZ0UIQw
        q41hlqzw2n3TiwWLhyXUEwYp9TLWGQ7D27YRetO87RGBK/TF7/yvkD21Cn6hxwlx
        1TVRG7+lAkhl669zszKH3yua5SC7FZ+c/IOAwkWASwm5sEPxUq2pzi2VE61avI0A
        G+gwgJ26nCLlnpE8vLzzuwkBCl7QslivSuj6C0+kQHE25yGmuimqys9iyNZagc+S
        wkCjfKvgRY9tVS30FwOcEPrskw1SgoWaIngIew6bodnghGsUyIWJDTxdX5+I9g/r
        EBOkcS3a2pXovPq91qaTcq5+4KoQkpPwWn21eY63Ra2TmdhTHn4UZCYzBS4LWTeN
        mzU2sDAWnbBdrQ==
X-ME-Sender: <xms:597-XhSXil-szFO3GADxAamc156VmpMbTaH9fQaQ63w7qzprDkOmqg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrtdehgdduudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnnhih
    ucfnihhnuceouggrnhhnhieskhgurhgrghdtnhdruggvvheqnecuggftrfgrthhtvghrnh
    ephfduudegudfffeetvdekgeeutdelffejhfduueekteejieegiedvjeeifeevleehnecu
    ffhomhgrihhnpegvughithhorhgtohhnfhhighdrohhrghenucfkphepjeefrddvvdehrd
    egrddufeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepuggrnhhnhieskhgurhgrghdtnhdruggvvh
X-ME-Proxy: <xmx:597-XqxnJBiOYoT2S2L8TgxcQSPfp6SH2-dVF82Ghb2IeSKpZwPf1Q>
    <xmx:597-Xm0Ela4TRC2xk_xkQCzPBzMa36kJYE_PupmvmBeCY6s3X9XSOg>
    <xmx:597-XpA8zBZc8gzz7_I6Et5GG_RAi4bG98F4xcHrwbtF2-u6pqelPA>
    <xmx:597-XrsjOHcGTjIZpZpkYf-1ez5H2_Xj6SPowALnmRUG1Oqn8bfqXg>
Received: from pinwheel.hsd1.wa.comcast.net (c-73-225-4-138.hsd1.wa.comcast.net [73.225.4.138])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5A542328005E;
        Fri,  3 Jul 2020 03:31:50 -0400 (EDT)
From:   Danny Lin <danny@kdrag0n.dev>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Danny Lin <danny@kdrag0n.dev>
Subject: [PATCH v2] editorconfig: Add automatic editor configuration file
Date:   Fri,  3 Jul 2020 00:31:43 -0700
Message-Id: <20200703073143.423557-1-danny@kdrag0n.dev>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <16043769.gqpzGLO8mG@pinwheel>
References: <16043769.gqpzGLO8mG@pinwheel>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EditorConfig is a standard for defining basic editor configuration in
projects. There is support available for 47 code editors as of writing,
including both built-in and extension support. Many notable projects
have adopted the standard already, including zsh, htop, and qemu.

While this isn't a full-fledged C code style specifier, it does set some
basic ground rules that make it more convenient for contributors to use
any editor of their choice and not have to worry about indentation, line
endings, encoding, final newlines, etc. This should make it
significantly easier to conform to the kernel's general code style when
used in combination with clang-format.

For more information, check the official EditorConfig website:
https://editorconfig.org/

Signed-off-by: Danny Lin <danny@kdrag0n.dev>
---
v2:
  - Added rules for most exceptions to the 8-column tab indent style

 .editorconfig                      | 37 ++++++++++++++++++++++++++++++
 .gitignore                         |  1 +
 Documentation/process/4.Coding.rst |  6 +++++
 3 files changed, 44 insertions(+)
 create mode 100644 .editorconfig

diff --git a/.editorconfig b/.editorconfig
new file mode 100644
index 000000000000..ab886ff0f66e
--- /dev/null
+++ b/.editorconfig
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: GPL-2.0
+# Linux kernel EditorConfig file (https://editorconfig.org/)
+
+# Located at the project root
+root = true
+
+# Base settings for most files
+[*]
+charset = utf-8
+end_of_line = lf
+insert_final_newline = true
+
+indent_style = tab
+indent_size = 8
+
+# This avoids introducing too many unnecessary changes in trivial commits
+trim_trailing_whitespace = false
+
+# General 4-space files
+[*.{pl,pm,py,tc,json,tc}]
+indent_style = space
+indent_size = 4
+
+# General 2-space files
+[*.{rb,rst,yaml,cocci,xsl,svg,bconf,clang-format}]
+indent_style = space
+indent_size = 2
+
+# Perf script wrappers
+[tools/perf/scripts/*/bin/*]
+indent_style = space
+indent_size = 4
+
+# Man pages
+[*.{1,2,3,4,5,6,7,8}]
+indent_style = space
+indent_size = 2
diff --git a/.gitignore b/.gitignore
index 87b9dd8a163b..956bcc3c9d76 100644
--- a/.gitignore
+++ b/.gitignore
@@ -89,6 +89,7 @@ modules.order
 #
 !.clang-format
 !.cocciconfig
+!.editorconfig
 !.get_maintainer.ignore
 !.gitattributes
 !.gitignore
diff --git a/Documentation/process/4.Coding.rst b/Documentation/process/4.Coding.rst
index 13dd893c9f88..25b39dc8751d 100644
--- a/Documentation/process/4.Coding.rst
+++ b/Documentation/process/4.Coding.rst
@@ -66,6 +66,12 @@ for aligning variables/macros, for reflowing text and other similar tasks.
 See the file :ref:`Documentation/process/clang-format.rst <clangformat>`
 for more details.
 
+Some basic editor settings, such as indentation and line endings, will be
+set automatically if you are using an editor that is compatible with
+EditorConfig. See the official EditorConfig website for more information:
+
+https://editorconfig.org/
+
 
 Abstraction layers
 ******************
-- 
2.27.0

