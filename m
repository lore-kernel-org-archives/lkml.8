Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49FA8C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 10:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D825214DB
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 10:02:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=unikie-com.20150623.gappssmtp.com header.i=@unikie-com.20150623.gappssmtp.com header.b="17Zg3Wpo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732216AbgDAKCx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 06:02:53 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45361 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732183AbgDAKCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 06:02:52 -0400
Received: by mail-lj1-f196.google.com with SMTP id t17so25154638ljc.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 03:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unikie-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AaFao30w/2kIvZw9/s29i3Jz2nxOQX8V+ssYL6KtF3U=;
        b=17Zg3Wpouk9v5/Ehq3zgR62jsJKFeQ+fPaUc2Y++MpsQmdXkTm8RcYK2RySZ9NPHYV
         HNiNbcDkZJD9/yNlzXN+EnEZJI2B4JySIc7zphD1V67dTLMs7do/s14X16DvRAk4XLhM
         /XFrCsfmdipp0lzr5e4q9l9ROCJVxje1D1HwHLP/9RrAhuy4tX2xlcyNVReQeSs9NYcO
         17DiqDI4rX4O6uUzUMDZ5NbNjdh+5j5bHqOHT8Vmc2AepTb1jaipKjZ6AUNgr6oMzg58
         vQtVnBavMRB+TH8dit7v8YEn+iGBvEBrXWOcCeNbzNJ4XSgFlTAKx+zwchk6iahJkr8P
         A8wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AaFao30w/2kIvZw9/s29i3Jz2nxOQX8V+ssYL6KtF3U=;
        b=kmNx5yGz+KQAh/kH+s6HSRyInSk5GzmmHvhkaSqHv7/rsg54Cx529DE6/yx4pUCa7F
         hZ3wwmxF/HPUFTUYtsteDjXkc1Vki6CH0cntgBUT3+ZMRXtXJT5MriTKO2R7C90nfDXJ
         Yi9Xig3iYTLlPdi83v/8kYT3PC1Q0SjtXQgfWdamhFkLgDmhxt31/aj/oafcVPl7lZdC
         AXETP4Tl51+PLS7Cmel2mB6gAa/Q//3Lgb1AgrV4e6VYXSSLeyhjxBcF+kqQGwDUpzOC
         RXZ2O2EeQmhKJkQsBrG3t2G8grC4NNaaCAARMIU/UmhS8AfYQiFvdlIRXDzAaFikbLEB
         fkaA==
X-Gm-Message-State: AGi0PuYL09xVCHrlTKF4xMD/R/dN5MnTw8/nre99vfWbDHSDyeaM9yOT
        n44ZJQx24DXaAN3KrI9hLUQ7wA==
X-Google-Smtp-Source: APiQypLZl4DJFpCLnjmydDcHgDNB1XXhq0SYDjt1QtuF+kJ9RDVV+rM+eNjDgm482JKA7kO3qf3b+A==
X-Received: by 2002:a2e:9912:: with SMTP id v18mr8656454lji.199.1585735369897;
        Wed, 01 Apr 2020 03:02:49 -0700 (PDT)
Received: from localhost.localdomain (dyvyn9m99j8s7-9xsphjt-4.rev.dnainternet.fi. [2001:14bb:440:beab:bd3f:1fbf:f66f:618f])
        by smtp.googlemail.com with ESMTPSA id n14sm862986ljm.104.2020.04.01.03.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 03:02:49 -0700 (PDT)
From:   John Mathew <john.mathew@unikie.com>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, corbet@lwn.net, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, tsbogend@alpha.franken.de,
        lukas.bulwahn@gmail.com, x86@kernel.org,
        linux-mips@vger.kernel.org, tglx@linutronix.de,
        mostafa.chamanara@basemark.com,
        John Mathew <john.mathew@unikie.com>
Subject: [RFC PATCH 1/3] docs: scheduler: Restructure scheduler documentation.
Date:   Wed,  1 Apr 2020 13:00:27 +0300
Message-Id: <20200401100029.1445-2-john.mathew@unikie.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200401100029.1445-1-john.mathew@unikie.com>
References: <20200401100029.1445-1-john.mathew@unikie.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new sections to enable addition of new documentation on
the scheduler. Existing documentation is moved under the related
new sections. The sections are
  - overview
  - cfs-sched-overview
  - sched-features
  - arch-specific.rst
  - sched-debugging.rst

Suggested-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: John Mathew <john.mathew@unikie.com>
---
 Documentation/scheduler/arch-specific.rst     | 11 +++++++
 .../scheduler/cfs-sched-overview.rst          | 15 ++++++++++
 Documentation/scheduler/index.rst             | 29 ++++++++++---------
 Documentation/scheduler/overview.rst          |  5 ++++
 Documentation/scheduler/sched-debugging.rst   | 14 +++++++++
 Documentation/scheduler/sched-features.rst    | 20 +++++++++++++
 6 files changed, 81 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/scheduler/arch-specific.rst
 create mode 100644 Documentation/scheduler/cfs-sched-overview.rst
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
diff --git a/Documentation/scheduler/cfs-sched-overview.rst b/Documentation/scheduler/cfs-sched-overview.rst
new file mode 100644
index 000000000000..44dac92d9462
--- /dev/null
+++ b/Documentation/scheduler/cfs-sched-overview.rst
@@ -0,0 +1,15 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+CFS
+====
+
+This documentation describes the linux CFS scheduler.
+
+.. class:: toc-title
+
+	   Table of contents
+
+.. toctree::
+   :maxdepth: 2
+
+   sched-design-CFS
diff --git a/Documentation/scheduler/index.rst b/Documentation/scheduler/index.rst
index 69074e5de9c4..83c718d05b9d 100644
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
+
 
+.. class:: toc-title
 
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
+	   Table of contents
+
+.. toctree::
+    :maxdepth: 2
 
-    text_files
+    overview
+    cfs-sched-overview
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

