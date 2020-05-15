Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB95BC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 21:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C6C020709
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 21:34:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgEOVen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 17:34:43 -0400
Received: from 16.mo7.mail-out.ovh.net ([46.105.72.216]:53444 "EHLO
        16.mo7.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbgEOVen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 17:34:43 -0400
Received: from player738.ha.ovh.net (unknown [10.108.42.82])
        by mo7.mail-out.ovh.net (Postfix) with ESMTP id D540D164512
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 23:26:40 +0200 (CEST)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player738.ha.ovh.net (Postfix) with ESMTPSA id 923521286A113;
        Fri, 15 May 2020 21:26:35 +0000 (UTC)
From:   Stephen Kitt <steve@sk2.org>
To:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Stephen Kitt <steve@sk2.org>
Subject: [PATCH v2] docs: sysctl/kernel: document unaligned controls
Date:   Fri, 15 May 2020 23:24:44 +0200
Message-Id: <20200515212443.5012-1-steve@sk2.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 653021949153856901
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrleekgdduheelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffogggtgfesthekredtredtjeenucfhrhhomhepufhtvghphhgvnhcumfhithhtuceoshhtvghvvgesshhkvddrohhrgheqnecuggftrfgrthhtvghrnhepieektefhtdffgfefveehudejvdeileefffdvtdefgeffffehudekudeuhedvledunecukfhppedtrddtrddtrddtpdekvddrieehrddvhedrvddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejfeekrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This documents ignore-unaligned-usertrap, unaligned-dump-stack, and
unaligned-trap, based on arch/arc/kernel/unaligned.c,
arch/ia64/kernel/unaligned.c, and arch/parisc/kernel/unaligned.c.

While we're at it, integrate unaligned-memory-access.txt into the docs
tree.

Signed-off-by: Stephen Kitt <steve@sk2.org>
---
Changes since v1:
  - move unaligned-memory-access.txt to process/
  - removed UTF-8 apostrophe from the commit message

 Documentation/admin-guide/sysctl/kernel.rst   | 51 +++++++++++++++++++
 Documentation/process/index.rst               |  1 +
 .../unaligned-memory-access.rst}              |  0
 3 files changed, 52 insertions(+)
 rename Documentation/{unaligned-memory-access.txt => process/unaligned-memory-access.rst} (100%)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index eb6bc9cc0318..4bb4d55f20ff 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -402,6 +402,25 @@ Controls whether the panic kmsg data should be reported to Hyper-V.
 = =========================================================
 
 
+ignore-unaligned-usertrap
+=========================
+
+On architectures where unaligned accesses cause traps, and where this
+feature is supported (``CONFIG_SYSCTL_ARCH_UNALIGN_NO_WARN``;
+currently, ``arc`` and ``ia64``), controls whether all unaligned traps
+are logged.
+
+= =============================================================
+0 Log all unaligned accesses.
+1 Only warn the first time a process traps. This is the default
+  setting.
+= =============================================================
+
+See also `unaligned-trap`_ and `unaligned-dump-stack`_. On ``ia64``,
+this allows system administrators to override the
+``IA64_THREAD_UAC_NOPRINT`` ``prctl`` and avoid logs being flooded.
+
+
 kexec_load_disabled
 ===================
 
@@ -1252,6 +1271,38 @@ See :doc:`/admin-guide/kernel-parameters` and
 :doc:`/trace/boottime-trace`.
 
 
+.. _unaligned-dump-stack:
+
+unaligned-dump-stack (ia64)
+===========================
+
+When logging unaligned accesses, controls whether the stack is
+dumped.
+
+= ===================================================
+0 Do not dump the stack. This is the default setting.
+1 Dump the stack.
+= ===================================================
+
+See also `ignore-unaligned-usertrap`_.
+
+
+unaligned-trap
+==============
+
+On architectures where unaligned accesses cause traps, and where this
+feature is supported (``CONFIG_SYSCTL_ARCH_UNALIGN_ALLOW``; currently,
+``arc`` and ``parisc``), controls whether unaligned traps are caught
+and emulated (instead of failing).
+
+= ========================================================
+0 Do not emulate unaligned accesses.
+1 Emulate unaligned accesses. This is the default setting.
+= ========================================================
+
+See also `ignore-unaligned-usertrap`_.
+
+
 unknown_nmi_panic
 =================
 
diff --git a/Documentation/process/index.rst b/Documentation/process/index.rst
index 6399d92f0b21..f07c9250c3ac 100644
--- a/Documentation/process/index.rst
+++ b/Documentation/process/index.rst
@@ -61,6 +61,7 @@ lack of a better place.
    botching-up-ioctls
    clang-format
    ../riscv/patch-acceptance
+   unaligned-memory-access
 
 .. only::  subproject and html
 
diff --git a/Documentation/unaligned-memory-access.txt b/Documentation/process/unaligned-memory-access.rst
similarity index 100%
rename from Documentation/unaligned-memory-access.txt
rename to Documentation/process/unaligned-memory-access.rst

base-commit: 56b62540782bfde459acc8eb15b949eaf151c881
-- 
2.20.1

