Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA10FC38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89B43216FD
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=unikie-com.20150623.gappssmtp.com header.i=@unikie-com.20150623.gappssmtp.com header.b="yTt+H+bk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbgEGSGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 14:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726515AbgEGSGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 14:06:15 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD456C05BD09
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 11:06:14 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id a4so5266823lfh.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 11:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unikie-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cftDsj6KL8i0ele2DpxcgTrxsQlYO091MF3gCFeL+aQ=;
        b=yTt+H+bkJynKnfmdp1Z2iJbB0LxhTMM/ZKMiSJowXShxF9cArwiTE1cLQoZj9YRe52
         K3WRYBjsHauBJORb2rI79txHZ0oQI4QKQ8Wp6LshYtGCmEPPzwQLjF5YUaX4zpM/zzIJ
         9s3QYyBLuE8UqmoIBXGe/54pNctABtHeThQfpz2Co9WfEVMB1Zo/mQyDtyv53hiRt2Ur
         VQWBjZeglu1oeiCjv95wGavI4fbQr8Mscdfkrmuoh00JqBfzTOdQPC8JG1fpQvZwolj2
         MfumjM85yvCpyfWSq4z74YjfVUD0sKgc6TGkKxe9aQgElDhw4FTASoQU4agHbRsKToVA
         YVFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cftDsj6KL8i0ele2DpxcgTrxsQlYO091MF3gCFeL+aQ=;
        b=jPTsiz+kJyYg50lV4C9up2QDy4xjZL/44Rs+/G0usixEr6vE8tWAFWj96VU2g50nKA
         zJ0THjOqcPWLdx/2f+pQJNJ2NGSLfdl6+333RCqa0bVxIaAB8IF9oVRjDYqUfprV3SZl
         o+5uPNsft6mriCsui2VXeVBCr1gDod+KLHfn1wVYUEoUKwF47r0pQIhavXQJsCHmJBRD
         qkXoETm/gGhnsjAeG41mR5zhfztwvG/Qn67ZkTvKQDQa9Z5bDQwptnoWZMaw8x5exKM1
         y5GUA0ZBh53kLOiz4eO7WPcX0b4VvExP1SS+y9uoncHqZwtxVjh9fK5fxC4kfT4yxEZp
         rHrA==
X-Gm-Message-State: AGi0PuY7XeAqidFaDO6RNOtcGE++u1kR6ui1Q3OPiCWj4rYtMwitQYPy
        H53C1HhHj84kxQ92nLiufSDRXQ==
X-Google-Smtp-Source: APiQypLXRmZBR/8ZYONjY5Vn2vslB/E9Ob6zIUcn9rNcIQ7QBb/KkQ4BPmJkrjxmbzNFxLNGmkvtzg==
X-Received: by 2002:ac2:5b5e:: with SMTP id i30mr4314698lfp.161.1588874773057;
        Thu, 07 May 2020 11:06:13 -0700 (PDT)
Received: from localhost.localdomain (84-253-205-124.bb.dnainternet.fi. [84.253.205.124])
        by smtp.googlemail.com with ESMTPSA id w21sm3715392lji.26.2020.05.07.11.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 11:06:11 -0700 (PDT)
From:   John Mathew <john.mathew@unikie.com>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, corbet@lwn.net, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, tsbogend@alpha.franken.de,
        lukas.bulwahn@gmail.com, x86@kernel.org,
        linux-mips@vger.kernel.org, tglx@linutronix.de,
        mostafa.chamanara@basemark.com, rdunlap@infradead.org,
        John Mathew <john.mathew@unikie.com>
Subject: [RFC PATCH v3 1/3] docs: scheduler: Restructure scheduler documentation.
Date:   Thu,  7 May 2020 21:05:51 +0300
Message-Id: <20200507180553.9993-2-john.mathew@unikie.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200507180553.9993-1-john.mathew@unikie.com>
References: <20200507180553.9993-1-john.mathew@unikie.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new sections to enable addition of new documentation on
the scheduler. Existing documentation is moved under the related
new sections. The sections are
  - overview
  - sched-features
  - arch-specific.rst
  - sched-debugging.rst

Suggested-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: John Mathew <john.mathew@unikie.com>
---
 Documentation/scheduler/arch-specific.rst   | 11 ++++++++
 Documentation/scheduler/index.rst           | 29 ++++++++++++---------
 Documentation/scheduler/overview.rst        |  5 ++++
 Documentation/scheduler/sched-debugging.rst | 14 ++++++++++
 Documentation/scheduler/sched-features.rst  | 20 ++++++++++++++
 5 files changed, 66 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/scheduler/arch-specific.rst
 create mode 100644 Documentation/scheduler/overview.rst
 create mode 100644 Documentation/scheduler/sched-debugging.rst
 create mode 100644 Documentation/scheduler/sched-features.rst

diff --git a/Documentation/scheduler/arch-specific.rst b/Documentation/scheduler/arch-specific.rst
new file mode 100644
index 000000000000..c9c34863d994
--- /dev/null
+++ b/Documentation/scheduler/arch-specific.rst
@@ -0,0 +1,11 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Architecture Specific Scheduler Implementation Differences
+==========================================================
+
+.. class:: toc-title
+
+	   Table of contents
+
+.. toctree::
+   :maxdepth: 2
diff --git a/Documentation/scheduler/index.rst b/Documentation/scheduler/index.rst
index 69074e5de9c4..ede1a30a6894 100644
--- a/Documentation/scheduler/index.rst
+++ b/Documentation/scheduler/index.rst
@@ -1,23 +1,26 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
 ===============
 Linux Scheduler
 ===============
 
-.. toctree::
-    :maxdepth: 1
+This documentation outlines the Linux kernel scheduler with its concepts,
+details about the scheduler design and its data structures and architecture
+specific implementation differences.
 
 
-    completion
-    sched-arch
-    sched-bwc
-    sched-deadline
-    sched-design-CFS
-    sched-domains
-    sched-energy
-    sched-nice-design
-    sched-rt-group
-    sched-stats
+.. class:: toc-title
+
+	   Table of contents
 
-    text_files
+.. toctree::
+    :maxdepth: 2
+
+    overview
+    sched-design-CFS
+    sched-features
+    arch-specific.rst
+    sched-debugging.rst
 
 .. only::  subproject and html
 
diff --git a/Documentation/scheduler/overview.rst b/Documentation/scheduler/overview.rst
new file mode 100644
index 000000000000..aee16feefc61
--- /dev/null
+++ b/Documentation/scheduler/overview.rst
@@ -0,0 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+====================
+Scheduler overview
+====================
diff --git a/Documentation/scheduler/sched-debugging.rst b/Documentation/scheduler/sched-debugging.rst
new file mode 100644
index 000000000000..e332069f99d6
--- /dev/null
+++ b/Documentation/scheduler/sched-debugging.rst
@@ -0,0 +1,14 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Scheduler Debugging Interface
+==============================
+
+.. class:: toc-title
+
+	   Table of contents
+
+.. toctree::
+   :maxdepth: 2
+
+   sched-stats
+   text_files
diff --git a/Documentation/scheduler/sched-features.rst b/Documentation/scheduler/sched-features.rst
new file mode 100644
index 000000000000..1afbd9cc8d52
--- /dev/null
+++ b/Documentation/scheduler/sched-features.rst
@@ -0,0 +1,20 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Scheduler Features
+=====================
+
+.. class:: toc-title
+
+	   Table of contents
+
+.. toctree::
+   :maxdepth: 2
+
+   sched-arch
+   sched-bwc
+   sched-deadline
+   sched-domains
+   sched-energy
+   sched-nice-design
+   sched-rt-group
+   completion
-- 
2.17.1

