Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B91C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 18:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDF9520747
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 18:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730383AbgEFSXA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 14:23:00 -0400
Received: from mga17.intel.com ([192.55.52.151]:56488 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729589AbgEFSW7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 14:22:59 -0400
IronPort-SDR: CkL0C40dW3Qie5e9x2+niSsWj6R7i7l+Ut+c+/UHaV8qDuXlJW1bEr0SrxBIXTEL2a2b/aMVmG
 Q3IsdxN/X7wQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2020 11:22:59 -0700
IronPort-SDR: jHEJIQ88DLuQwNUFUiHX3LTAT97MVx27mbbNCop4TdeOX+15ZPDF9BST2kmwMB2bMPF2fRi2sV
 pib/Z1PPKd6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,360,1583222400"; 
   d="scan'208";a="296269303"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 06 May 2020 11:22:59 -0700
Received: from [10.249.228.227] (abudanko-mobl.ccr.corp.intel.com [10.249.228.227])
        by linux.intel.com (Postfix) with ESMTP id 413A258043A;
        Wed,  6 May 2020 11:22:57 -0700 (PDT)
Subject: [PATCH v2 07/11] perf docs: extend stat mode docs with info on
 --ctl-fd[-ack] options
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <d582cc3d-2302-c7e2-70d3-bc7ab6f628c3@linux.intel.com>
Organization: Intel Corp.
Message-ID: <fb7c1fb9-2f6b-eb4b-d256-51253b29b4ac@linux.intel.com>
Date:   Wed, 6 May 2020 21:22:55 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <d582cc3d-2302-c7e2-70d3-bc7ab6f628c3@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Extend perf-stat.txt file with --ctl-fd[-ack] options description.
Document possible usage model introduced by --ctl-fd[-ack] options
by providing example bash shell script.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/Documentation/perf-stat.txt | 40 ++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 3fb5028aef08..19ed53e08294 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -164,6 +164,46 @@ with it.  --append may be used here.  Examples:
      3>results  perf stat --log-fd 3          -- $cmd
      3>>results perf stat --log-fd 3 --append -- $cmd
 
+--ctl-fd::
+--ctl-fd-ack::
+
+Listen on ctl-fd descriptor for command to control measurement ('e': enable events,
+'d': disable events). Optionally send control command completion ('a') to fd-ack
+descriptor to synchronize with the controlling process. Example of bash shell script
+to enable and disable events during measurements:
+
+#!/bin/bash
+
+ctl_dir=/tmp/
+
+ctl_fifo=${ctl_dir}perf_ctl.fifo
+test -p ${ctl_fifo} && unlink ${ctl_fifo}
+mkfifo ${ctl_fifo}
+exec {ctl_fd}<>${ctl_fifo}
+
+ctl_ack_fifo=${ctl_dir}perf_ctl_ack.fifo
+test -p ${ctl_ack_fifo} && unlink ${ctl_ack_fifo}
+mkfifo ${ctl_ack_fifo}
+exec {ctl_fd_ack}<>${ctl_ack_fifo}
+
+perf stat -D -1 -e cpu-cycles -a -I 1000                \
+          --ctl-fd ${ctl_fd} --ctl-fd-ack ${ctl_fd_ack} \
+          -- sleep 30 &
+perf_pid=$!
+
+sleep 5  && echo 'e' >&${ctl_fd} && read -u ${ctl_fd_ack} e1 && echo "enabled(${e1})"
+sleep 10 && echo 'd' >&${ctl_fd} && read -u ${ctl_fd_ack} d1 && echo "disabled(${d1})"
+
+exec {ctl_fd_ack}>&-
+unlink ${ctl_ack_fifo}
+
+exec {ctl_fd}>&-
+unlink ${ctl_fifo}
+
+wait -n ${perf_pid}
+exit $?
+
+
 --pre::
 --post::
 	Pre and post measurement hooks, e.g.:
-- 
2.24.1


