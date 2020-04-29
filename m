Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B922C83007
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 23:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 654592082E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 23:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbgD2XYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 19:24:39 -0400
Received: from 6.mo7.mail-out.ovh.net ([188.165.39.218]:55106 "EHLO
        6.mo7.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726929AbgD2XYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 19:24:39 -0400
Received: from player693.ha.ovh.net (unknown [10.108.57.38])
        by mo7.mail-out.ovh.net (Postfix) with ESMTP id CC179160976
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 22:58:25 +0200 (CEST)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player693.ha.ovh.net (Postfix) with ESMTPSA id 025B411DB2FC6;
        Wed, 29 Apr 2020 20:58:15 +0000 (UTC)
From:   Stephen Kitt <steve@sk2.org>
To:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Stephen Kitt <steve@sk2.org>
Subject: [PATCH v2 1/2] docs: sysctl/kernel: document ftrace entries
Date:   Wed, 29 Apr 2020 22:57:56 +0200
Message-Id: <20200429205757.8677-1-steve@sk2.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 16893283679029906821
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrieefgdduheegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucggtffrrghtthgvrhhnpeetgedugfelkeeikeetgeegteevfeeufeetuefgudeiiedthfehtdeffeekvdeffeenucfkpheptddrtddrtddrtddpkedvrdeihedrvdehrddvtddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrieelfedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehsthgvvhgvsehskhdvrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on the ftrace documentation, the tp_printk boot parameter
documentation, and the implementation in kernel/trace/trace.c.

Signed-off-by: Stephen Kitt <steve@sk2.org>
---
Changes since v2:
  - spelling and grammar fixes in ftrace_dump_on_oops ("outputing it"
    -> "outputting them")
  - "and::" in a single line in tracepoint_printk

Documentation/admin-guide/sysctl/kernel.rst | 48 +++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 82bfd5892663..b1ad4c86274d 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -265,6 +265,27 @@ domain names are in general different. For a detailed discussion
 see the ``hostname(1)`` man page.
 
 
+ftrace_dump_on_oops
+===================
+
+Determines whether ``ftrace_dump()`` should be called on an oops (or
+kernel panic). This will output the contents of the ftrace buffers to
+the console.  This is very useful for capturing traces that lead to
+crashes and outputting them to a serial console.
+
+= ===================================================
+0 Disabled (default).
+1 Dump buffers of all CPUs.
+2 Dump the buffer of the CPU that triggered the oops.
+= ===================================================
+
+
+ftrace_enabled, stack_tracer_enabled
+====================================
+
+See :doc:`/trace/ftrace`.
+
+
 hardlockup_all_cpu_backtrace
 ============================
 
@@ -1191,6 +1212,33 @@ If a value outside of this range is written to ``threads-max`` an
 ``EINVAL`` error occurs.
 
 
+traceoff_on_warning
+===================
+
+When set, disables tracing (see :doc:`/trace/ftrace`) when a
+``WARN()`` is hit.
+
+
+tracepoint_printk
+=================
+
+When tracepoints are sent to printk() (enabled by the ``tp_printk``
+boot parameter), this entry provides runtime control::
+
+    echo 0 > /proc/sys/kernel/tracepoint_printk
+
+will stop tracepoints from being sent to printk(), and::
+
+    echo 1 > /proc/sys/kernel/tracepoint_printk
+
+will send them to printk() again.
+
+This only works if the kernel was booted with ``tp_printk`` enabled.
+
+See :doc:`/admin-guide/kernel-parameters` and
+:doc:`/trace/boottime-trace`.
+
+
 unknown_nmi_panic
 =================
 
-- 
2.20.1

