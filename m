Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B2BC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 20:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E5F82075B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 20:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598648213;
	bh=Zw0NZ9Tb0m1B4iozwIcZtqtMiYimMg0M5UjK9JfytvY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=furAjjeA+wYb0eAkvkaVfCqrknTgDXrZh94HW+mpPLgy24KIHnwxxJ0bFwOYoSywg
	 XZA/SAoZwzeKrvukyhHyKhEQe96mTD6mutrdL4YdSIwgWjC+v9LybpZuJlVBrfripH
	 AsukiFtTJzhvkucbuWWvV2y1borNl2QLe+sY8Rkw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgH1U4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 16:56:52 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:45346 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbgH1U4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 16:56:38 -0400
Received: by mail-io1-f67.google.com with SMTP id u126so372690iod.12
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 13:56:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SPPit0voQ5iZSd9YAtw226cZcfg7JS5J3IK/RTi0Ep0=;
        b=H8qufMu8LzVpblFCIHk9waMRiQQSJsS/lDlFbQAMZq9wwi9rW7WZyAwqLHIIxBYMZq
         xwe3xbK6xB2UdCVXYBIgb51b9VH7r47HnLXAq7omZCIsRAhJzYXdb1F/GNX5pZ96lHK8
         iggIQtmjCzORuWaEYVoeS3iQe7aa8120guNYZFDOYi2uB3aA764J2JPtHOgeksvDT+jI
         VkKgGxf1JY+sSZh0SlcG9fsFj+OUpN32EfrKWnSjDJTgtaUzwQao7YkcozME/DN70RM+
         M6mc0lazDZS6SM+DeoUzoJGKSrwkB3YKrppeF/U30Kq5J3ReP9lVftaXRkthulanADd3
         wdLQ==
X-Gm-Message-State: AOAM531oDBPA9XIDolyfZQH2A2vjKd4vMSQCwtY9vC3GbXWDXRDHKZp5
        5zq8gVchSeE7Gw1fZnOhsw==
X-Google-Smtp-Source: ABdhPJxGE//0ch0OeIJ3iCU5ppOP/gNk2+Us34HvXEIVF5FOBzzDSi3p47JGIg1qyyoy2rzpb2YStQ==
X-Received: by 2002:a6b:4e0a:: with SMTP id c10mr447635iob.89.1598648197017;
        Fri, 28 Aug 2020 13:56:37 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.249])
        by smtp.googlemail.com with ESMTPSA id l203sm147089ioa.31.2020.08.28.13.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 13:56:36 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Raphael Gault <raphael.gault@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ian Rogers <irogers@google.com>, honnappa.nagarahalli@arm.com
Subject: [PATCH v2 8/9] Documentation: arm64: Document PMU counters access from userspace
Date:   Fri, 28 Aug 2020 14:56:13 -0600
Message-Id: <20200828205614.3391252-9-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200828205614.3391252-1-robh@kernel.org>
References: <20200828205614.3391252-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Raphael Gault <raphael.gault@arm.com>

Add a documentation file to describe the access to the pmu hardware
counters from userspace

Signed-off-by: Raphael Gault <raphael.gault@arm.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
  - Update links to test examples

Changes from Raphael's v4:
  - Convert to rSt
  - Update chained event status
  - Add section for heterogeneous systems
---
 Documentation/arm64/index.rst                 |  1 +
 .../arm64/perf_counter_user_access.rst        | 56 +++++++++++++++++++
 2 files changed, 57 insertions(+)
 create mode 100644 Documentation/arm64/perf_counter_user_access.rst

diff --git a/Documentation/arm64/index.rst b/Documentation/arm64/index.rst
index d9665d83c53a..c712a08e7627 100644
--- a/Documentation/arm64/index.rst
+++ b/Documentation/arm64/index.rst
@@ -15,6 +15,7 @@ ARM64 Architecture
     legacy_instructions
     memory
     perf
+    perf_counter_user_access
     pointer-authentication
     silicon-errata
     sve
diff --git a/Documentation/arm64/perf_counter_user_access.rst b/Documentation/arm64/perf_counter_user_access.rst
new file mode 100644
index 000000000000..e49e141f10cc
--- /dev/null
+++ b/Documentation/arm64/perf_counter_user_access.rst
@@ -0,0 +1,56 @@
+=============================================
+Access to PMU hardware counter from userspace
+=============================================
+
+Overview
+--------
+The perf userspace tool relies on the PMU to monitor events. It offers an
+abstraction layer over the hardware counters since the underlying
+implementation is cpu-dependent.
+Arm64 allows userspace tools to have access to the registers storing the
+hardware counters' values directly.
+
+This targets specifically self-monitoring tasks in order to reduce the overhead
+by directly accessing the registers without having to go through the kernel.
+
+How-to
+------
+The focus is set on the armv8 pmuv3 which makes sure that the access to the pmu
+registers is enabled and that the userspace has access to the relevant
+information in order to use them.
+
+In order to have access to the hardware counter it is necessary to open the event
+using the perf tool interface: the sys_perf_event_open syscall returns a fd which
+can subsequently be used with the mmap syscall in order to retrieve a page of
+memory containing information about the event.
+The PMU driver uses this page to expose to the user the hardware counter's
+index and other necessary data. Using this index enables the user to access the
+PMU registers using the `mrs` instruction.
+
+The userspace access is supported in libperf using the perf_evsel__mmap()
+and perf_evsel__read() functions. See `tools/lib/perf/tests/test-evsel.c`_ for
+an example.
+
+About heterogeneous systems
+---------------------------
+On heterogeneous systems such as big.LITTLE, userspace PMU counter access can
+only be enabled when the tasks are pinned to a homogeneous subset of cores and
+the corresponding PMU instance is opened by specifying the 'type' attribute.
+The use of generic event types is not supported in this case.
+
+Have a look at `tools/perf/arch/arm64/tests/user-events.c`_ for an example. It
+can be run using the perf tool to check that the access to the registers works
+correctly from userspace:
+
+.. code-block:: sh
+
+  perf test -v user
+
+About chained events
+--------------------
+Chained events are not supported in userspace. If a 64-bit counter is requested,
+userspace access will only be enabled if the underlying counter is 64-bit.
+
+.. Links
+.. _tools/perf/arch/arm64/tests/user-events.c:
+   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/tools/perf/arch/arm64/tests/user-events.c
-- 
2.25.1

