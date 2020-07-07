Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A29C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 20:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2C9F206F6
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 20:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594155229;
	bh=a6F+8rETmwBIMmxJH4RTNXpUL7QMGz1QhbOxV5EqlGo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GC7e7AGuGY3/wFtgoQCTGymUmvutoaRrBTMb+XkKmkXwDp4zfm+IvVoJkmDVZBH4e
	 ugACDsvXajbyrO4wTcmZTvPbwlPHEQwVcWbvODrnvnoPxfA3DI2djKP6iANoaOI+v0
	 xaedrw0fGtWsSEtJQboRprLw3bvkoRbAguOpjAGI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729096AbgGGUxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 16:53:47 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:42524 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729066AbgGGUxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 16:53:43 -0400
Received: by mail-io1-f66.google.com with SMTP id c16so44691943ioi.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 13:53:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xFUJgAyhgciO3qO3NIBe3KpN6uEMK7G2y/DfqZ12aSM=;
        b=onUJOSANubrei0GH3BiC9JHy/5h7SRpko/28wC/+O1d+SyLrGjOLy5Jao772FBr+Zm
         7TOX5c1VNCDUkU+QHQTg/1FzlcBz0wFHZlgspxnbUEbcHElKRA90eFwONcUPpyGFhfCO
         XhN/KFIN+Ayd3mFSgesH3NpCNUYjnK9QGaBoCplp/+6kbG2rfLB/4p/uL7/igwuGfcRY
         fxhryzdjQ+9y2c1AKAKLdvWByDib7l5fY9WUaymTp9RWp3Zs0c5fFOYxzMJMfTLzbbfR
         vyA0t+Tcc6KSE1kw4bpCCZM1xfkd0BbzRxmcshN3W1D7SJkaHJb5Z2lCMbtPXtDDkz90
         XgUg==
X-Gm-Message-State: AOAM531c9RYKR1wLKmXTrzTG2yVIXZ6Z2s1/c7s61+oaAn718ZSVoJno
        kxDQ2KjLGCSVAGZjrtKapQ==
X-Google-Smtp-Source: ABdhPJyq8kA7O7kSGFmYlRDjz854jV0sdtPUolqUylozJ+GIjwkp7dz+iu/YYzPP4T0XLoHQjar6HQ==
X-Received: by 2002:a05:6602:2805:: with SMTP id d5mr33101636ioe.124.1594155222095;
        Tue, 07 Jul 2020 13:53:42 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.254])
        by smtp.googlemail.com with ESMTPSA id y6sm13110712ila.74.2020.07.07.13.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 13:53:41 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Raphael Gault <raphael.gault@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5/5] Documentation: arm64: Document PMU counters access from userspace
Date:   Tue,  7 Jul 2020 14:53:33 -0600
Message-Id: <20200707205333.624938-6-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707205333.624938-1-robh@kernel.org>
References: <20200707205333.624938-1-robh@kernel.org>
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
---
Changes:
  - Convert to rSt
  - Update chained event status
  - Add section for heterogeneous systems
---
 Documentation/arm64/index.rst                 |  1 +
 .../arm64/perf_counter_user_access.rst        | 52 +++++++++++++++++++
 2 files changed, 53 insertions(+)
 create mode 100644 Documentation/arm64/perf_counter_user_access.rst

diff --git a/Documentation/arm64/index.rst b/Documentation/arm64/index.rst
index 09cbb4ed2237..62f45d620180 100644
--- a/Documentation/arm64/index.rst
+++ b/Documentation/arm64/index.rst
@@ -14,6 +14,7 @@ ARM64 Architecture
     hugetlbpage
     legacy_instructions
     memory
+    perf_counter_user_access
     pointer-authentication
     silicon-errata
     sve
diff --git a/Documentation/arm64/perf_counter_user_access.rst b/Documentation/arm64/perf_counter_user_access.rst
new file mode 100644
index 000000000000..afbc7acaae66
--- /dev/null
+++ b/Documentation/arm64/perf_counter_user_access.rst
@@ -0,0 +1,52 @@
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
+Have a look at `tools/perf/arch/arm64/tests/user-events.c`_ for an example. It
+can be run using the perf tool to check that the access to the registers works
+correctly from userspace:
+
+.. code-block:: sh
+
+  perf test -v user
+
+About heterogeneous systems
+---------------------------
+On heterogeneous systems such as big.LITTLE, userspace PMU counter access can
+only be enabled when the tasks are pinned to a homogeneous subset of cores and
+the corresponding PMU instance is opened by specifying the 'type' attribute.
+The use of generic event types is not supported in this case.
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
