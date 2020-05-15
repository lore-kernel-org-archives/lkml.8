Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9873C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 16:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBB672070A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 16:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgEOQNN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 12:13:13 -0400
Received: from 8.mo3.mail-out.ovh.net ([87.98.172.249]:49924 "EHLO
        8.mo3.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgEOQNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 12:13:12 -0400
Received: from player168.ha.ovh.net (unknown [10.108.35.13])
        by mo3.mail-out.ovh.net (Postfix) with ESMTP id EA731250E96
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 18:04:23 +0200 (CEST)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player168.ha.ovh.net (Postfix) with ESMTPSA id 285AB1262277F;
        Fri, 15 May 2020 16:04:19 +0000 (UTC)
From:   Stephen Kitt <steve@sk2.org>
To:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Stephen Kitt <steve@sk2.org>
Subject: [PATCH] docs: sysctl/kernel: document unaligned controls
Date:   Fri, 15 May 2020 18:04:06 +0200
Message-Id: <20200515160406.8649-1-steve@sk2.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 13656884397983419781
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrleekgdelfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucggtffrrghtthgvrhhnpeeikeethfdtfffgfeevhedujedvieelfeffvddtfeegffffhedukeduueehvdeludenucfkpheptddrtddrtddrtddpkedvrdeihedrvdehrddvtddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrudeikedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehsthgvvhgvsehskhdvrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This documents ignore-unaligned-usertrap, unaligned-dump-stack, and
unaligned-trap, based on arch/arc/kernel/unaligned.c,
arch/ia64/kernel/unaligned.c, and arch/parisc/kernel/unaligned.c.

While we’re at it, integrate unaligned-memory-access.txt into the docs
tree.

Signed-off-by: Stephen Kitt <steve@sk2.org>
---
 Documentation/admin-guide/sysctl/kernel.rst   | 51 +++++++++++++++++++
 Documentation/index.rst                       |  1 +
 ...access.txt => unaligned-memory-access.rst} |  0
 3 files changed, 52 insertions(+)
 rename Documentation/{unaligned-memory-access.txt => unaligned-memory-access.rst} (100%)

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
 
diff --git a/Documentation/index.rst b/Documentation/index.rst
index 9599c0f3eea8..17c38d899572 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -143,6 +143,7 @@ Architecture-agnostic documentation
    :maxdepth: 2
 
    asm-annotations
+   unaligned-memory-access
 
 Architecture-specific documentation
 -----------------------------------
diff --git a/Documentation/unaligned-memory-access.txt b/Documentation/unaligned-memory-access.rst
similarity index 100%
rename from Documentation/unaligned-memory-access.txt
rename to Documentation/unaligned-memory-access.rst

base-commit: 56b62540782bfde459acc8eb15b949eaf151c881
-- 
2.20.1

