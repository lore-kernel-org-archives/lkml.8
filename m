Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55408C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 00:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 334872073E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 00:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kdrag0n.dev header.i=@kdrag0n.dev header.b="QmHrRP93";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QVHDchzg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgGCAP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 20:15:59 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:41887 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725937AbgGCAP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 20:15:58 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 16A715C01B3;
        Thu,  2 Jul 2020 20:15:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 02 Jul 2020 20:15:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kdrag0n.dev; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=wrs3v8MjlP7Q7VWVUBiPauQHIj
        P2v+W5WpNE+Fx1jr0=; b=QmHrRP93lCvRfYB7/Ss2D39q/EzHksHTyIAuRohyJf
        n5Q17uqzFO/aWUetejLkqnBpLvt62nGVQL5fjeblGY7+tcAwMWTbQJIBC6A1x+jg
        FM+It5HzgO83yToQn/PjmDOd98jKrIE7J8/RmRytDsCFN7W25Rz9rLtwHOGjzfQM
        RvvmUAWWNXWg479JBlZWUjKMYxbQlvr7zvEG/H/4BJ10V/Pyx+ZMQ84y80l5gR9D
        sUf0q9bPQIj5Y9rz/0cuq9vjHFMiM4XkKZzffq8OEev+rzTaxEaio1E1ySPZigJn
        aiIlGYZ8DAjCl0/6zr0ump5lAyRiPo0G+oLeI1Tykofw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=wrs3v8MjlP7Q7VWVU
        BiPauQHIjP2v+W5WpNE+Fx1jr0=; b=QVHDchzg74wDWP4YCGPYs5Fxn2XiIT1yO
        947bOR8nv1Mvop38V7TMdOPS6tZM5pGXLFgw5Q/hV20GjdMN6Qdyzs4P9F83CDKK
        LMDnszsx1JQyDAB1t5LeLqUsLToN/T8PCot747fsOkVN+q3H1wJy12+78YriQcc+
        hJdMdP5XYqs9O45I6ZhNXTMSGqb1HF2UZuZ2U5kJ8tHQfD4fuQshmmef5Z5nnh9s
        RTLSl0dv1kYic0O8dZTpmk6mWv3ohaLlkJjwyiOzWzn4kHt/U4UEnljd/RIb+HTD
        HHAypE2DhDamFrf9zyc03z/VNUh2CljS5vTqQN6UXfHszTyGhRpcQ==
X-ME-Sender: <xms:vHj-XqbHIDFdiAK_mOfTvZDoWoM5fvO3sRpjDxOq4NGrTW3yD6MIaQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrtdehgdeftdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepffgrnhhnhicunfhi
    nhcuoegurghnnhihsehkughrrghgtdhnrdguvghvqeenucggtffrrghtthgvrhhnpeekke
    efkeelgfetvdekvedtffefudetveeuheefhfeikeevveetgeekhffgueegheenucffohhm
    rghinhepvgguihhtohhrtghonhhfihhgrdhorhhgnecukfhppeejfedrvddvhedrgedrud
    efkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegu
    rghnnhihsehkughrrghgtdhnrdguvghv
X-ME-Proxy: <xmx:vHj-XtZBUqcWob6eWc_0dKR_RHSmsNEsmKk2qYL-Ar0sMAF8ryS87w>
    <xmx:vHj-Xk-k1GFwWrCtGeG7UmeiByiBPqw7ZDSd-n5jyLRPpI8Xbh2n2Q>
    <xmx:vHj-Xspb4PLUdS5IMZn5E9PF3zPRPZEry-9MDODRc2BC57X4NAaKVw>
    <xmx:vXj-XsUFcQkRVU35ARyemv4DzSGHBOxMFlGr5LlH_fQGND94kQ946Q>
Received: from pinwheel.hsd1.wa.comcast.net (c-73-225-4-138.hsd1.wa.comcast.net [73.225.4.138])
        by mail.messagingengine.com (Postfix) with ESMTPA id A4F6A3280059;
        Thu,  2 Jul 2020 20:15:55 -0400 (EDT)
From:   Danny Lin <danny@kdrag0n.dev>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Danny Lin <danny@kdrag0n.dev>
Subject: [PATCH] editorconfig: Add automatic editor configuration file
Date:   Thu,  2 Jul 2020 17:12:12 -0700
Message-Id: <20200703001212.207565-1-danny@kdrag0n.dev>
X-Mailer: git-send-email 2.27.0
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
 .editorconfig                      | 16 ++++++++++++++++
 .gitignore                         |  1 +
 Documentation/process/4.Coding.rst |  6 ++++++
 3 files changed, 23 insertions(+)
 create mode 100644 .editorconfig

diff --git a/.editorconfig b/.editorconfig
new file mode 100644
index 000000000000..580d2e90d855
--- /dev/null
+++ b/.editorconfig
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0
+# Linux kernel EditorConfig file (https://editorconfig.org/)
+
+# Located at the project root
+root = true
+
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
index 13dd893c9f88..c5c46bcafdad 100644
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

