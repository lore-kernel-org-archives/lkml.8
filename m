Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F7AC433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 16:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA2F32067C
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 16:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=unikie-com.20150623.gappssmtp.com header.i=@unikie-com.20150623.gappssmtp.com header.b="rxEzj0rz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728505AbgIBQ1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 12:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbgIBQ0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 12:26:44 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A7BC061245
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 09:26:43 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id e11so6681601ljn.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 09:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unikie-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Da01bO+sIUe8sEz8rENVmrJBnaMlRbIayPJ8UcNmInk=;
        b=rxEzj0rzUuZpcyXm/Zt6f4Ldf2lrh1nLFS2GUUGlQmye0U49XOX8FjNVQh1POqWmRj
         hbFoGHzjeEYp9r13TVeA6nYWlAcQkTn7gO+OPP4jfNhjTIHQHRAwRw9d+n3xEp4WSPaB
         +EoVs+cZTKI4z5QJG6tu/n+f7JN9F5hIOL7bDOFJoFm1YY65e4Tbx+RcoIPELyN2TUaw
         sDn+Li7l9QJPIEYa0p92t+MUytZKKetajbG+k/AhzuwhOeJ+ytatA13ctDsdX0Hn+01j
         S5q1zpgIxANgZyJuQTvwTPExU72X8CY3rh9JqQdSdm2Vr9bji9ovpfXMVVQTHTtVsTFe
         q2Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Da01bO+sIUe8sEz8rENVmrJBnaMlRbIayPJ8UcNmInk=;
        b=P0P/iZhHRsYgUbsCWIe6JZiE+rD69JUiszF3O8dhGUpNSd1I/LY9pB51Jw8QfNg8+R
         Ekd9KX3DdLFDTO/OJBeHliOLGNoO+JA0qDBxx/vRamLcfIHyi3KiOvAIQa+OQI4Cb+GO
         x1M5xy9YnIi8lzGYeqvvDfd/3dV4dW6tMSsD63I8H5gMKo3g2Zhs9aNFKhO24fYas63V
         +xQRYpfzzAzr/GgPhjBXEJNwW9FqlM1YTniQf89QASr3EGaUtNItdS7s83fl0foP0YGA
         uaHqfAE5/PJcJrHzrKYHRe4vGWo9Gb88IVVhShu+tGxW7i+L5KzlYdP2lXktyCw2KIER
         aMuw==
X-Gm-Message-State: AOAM530Gj9TE+Sb8YyMpw95huO/fN/RD3BHhg71SpJHKf4hr5KJHS8bY
        vzgxELxKbEbyDM0QeGHIGY9MQA==
X-Google-Smtp-Source: ABdhPJxqYL8WOkN/LSqpZ8A4YRk9Gg9qr0O1fklPNoDNI7R4X34XHy1ANiz52SMpvqQCca1V53YmaQ==
X-Received: by 2002:a2e:9810:: with SMTP id a16mr3317459ljj.157.1599064001884;
        Wed, 02 Sep 2020 09:26:41 -0700 (PDT)
Received: from localhost.localdomain ([109.204.235.119])
        by smtp.googlemail.com with ESMTPSA id y24sm1191887lfg.75.2020.09.02.09.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 09:26:41 -0700 (PDT)
From:   John Mathew <john.mathew@unikie.com>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, corbet@lwn.net, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, tsbogend@alpha.franken.de,
        lukas.bulwahn@gmail.com, x86@kernel.org,
        linux-mips@vger.kernel.org, tglx@linutronix.de,
        willy@infradead.org, valentin.schneider@arm.com,
        John Mathew <john.mathew@unikie.com>
Subject: [RFC PATCH v8 1/3] docs: scheduler: Restructure scheduler documentation.
Date:   Wed,  2 Sep 2020 19:26:29 +0300
Message-Id: <20200902162632.10271-2-john.mathew@unikie.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200902162632.10271-1-john.mathew@unikie.com>
References: <20200902162632.10271-1-john.mathew@unikie.com>
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
 Documentation/scheduler/arch-specific.rst   | 12 +++++++++
 Documentation/scheduler/index.rst           | 30 +++++++++++----------
 Documentation/scheduler/overview.rst        |  5 ++++
 Documentation/scheduler/sched-debugging.rst | 14 ++++++++++
 Documentation/scheduler/sched-features.rst  | 25 +++++++++++++++++
 5 files changed, 72 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/scheduler/arch-specific.rst
 create mode 100644 Documentation/scheduler/overview.rst
 create mode 100644 Documentation/scheduler/sched-debugging.rst
 create mode 100644 Documentation/scheduler/sched-features.rst

diff --git a/Documentation/scheduler/arch-specific.rst b/Documentation/scheduler/arch-specific.rst
new file mode 100644
index 000000000000..3e5af3a0695e
--- /dev/null
+++ b/Documentation/scheduler/arch-specific.rst
@@ -0,0 +1,12 @@
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
+
diff --git a/Documentation/scheduler/index.rst b/Documentation/scheduler/index.rst
index 88900aabdbf7..6e88a070c503 100644
--- a/Documentation/scheduler/index.rst
+++ b/Documentation/scheduler/index.rst
@@ -1,24 +1,26 @@
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
+
+    Table of contents
+
+.. toctree::
+    :maxdepth: 2
 
-    completion
-    sched-arch
-    sched-bwc
-    sched-deadline
+    overview
     sched-design-CFS
-    sched-domains
-    sched-capacity
-    sched-energy
-    sched-nice-design
-    sched-rt-group
-    sched-stats
-
-    text_files
+    sched-features
+    arch-specific
+    sched-debugging
 
 .. only::  subproject and html
 
diff --git a/Documentation/scheduler/overview.rst b/Documentation/scheduler/overview.rst
new file mode 100644
index 000000000000..a1d2d26629eb
--- /dev/null
+++ b/Documentation/scheduler/overview.rst
@@ -0,0 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+====================
+Scheduler overview
+====================
\ No newline at end of file
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
index 000000000000..8eb90e86e489
--- /dev/null
+++ b/Documentation/scheduler/sched-features.rst
@@ -0,0 +1,25 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Scheduler Features
+===================
+
+.. class:: toc-title
+
+	Table of contents
+
+.. toctree::
+   :maxdepth: 1
+
+   completion
+   sched-arch
+   sched-bwc
+   sched-deadline
+   sched-domains
+   sched-capacity
+   sched-energy
+   sched-nice-design
+   sched-rt-group
+   sched-stats
+
+   text_files
+
-- 
2.17.1

