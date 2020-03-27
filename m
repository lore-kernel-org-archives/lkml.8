Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59222C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 08:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26DCA2076A
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 08:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgC0IvY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 04:51:24 -0400
Received: from mga12.intel.com ([192.55.52.136]:7905 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbgC0IvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 04:51:24 -0400
IronPort-SDR: 6j5esvUHKvAeZ9Y/F2PE3wWx0/fceg6c2p5zW2UMgIpYkt6WbULsN3iqeHtou/ji+KkFG99Cg5
 PL73eqACkU6g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2020 01:51:13 -0700
IronPort-SDR: sHY7cypbDlo4NkayDasK7CNx7hNSrEQ+DMzJqLeqeEloVp3EGy2WHUheQrKRHiLG+nA1kXWwUY
 jVNp+Pig/8dA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,311,1580803200"; 
   d="scan'208";a="282786147"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 27 Mar 2020 01:51:12 -0700
Received: from [10.249.36.56] (abudanko-mobl.ccr.corp.intel.com [10.249.36.56])
        by linux.intel.com (Postfix) with ESMTP id C248B580479;
        Fri, 27 Mar 2020 01:51:09 -0700 (PDT)
Subject: [PATCH v1 8/8] perf docs: extend record mode docs with info on
 --ctl-fd[-ack] options
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <825a5132-b58d-c0b6-b050-5a6040386ec7@linux.intel.com>
Organization: Intel Corp.
Message-ID: <7ed99d49-8274-17ae-8792-6ae0a5f040e3@linux.intel.com>
Date:   Fri, 27 Mar 2020 11:51:08 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <825a5132-b58d-c0b6-b050-5a6040386ec7@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Extend perf-record.txt file with --ctl-fd[-ack] options description.
Document possible usage model introduced by --ctl-fd[-ack] options
by providing example bash shell script.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/Documentation/perf-record.txt | 37 ++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 7f4db7592467..939e8eb864fe 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -587,6 +587,43 @@ Make a copy of /proc/kcore and place it into a directory with the perf data file
 Limit the sample data max size, <size> is expected to be a number with
 appended unit character - B/K/M/G
 
+--ctl-fd::
+--ctl-fd-ack::
+Listen on ctl-fd descriptor for command to control measurement ('r': resume,
+'p': pause). Optionally send control command completion ('a') to fd-ack descriptor
+to synchronize with the controlling process. Example of bash shell script
+to resume and pause measurements:
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
+perf record -D -1 -e cpu-cycles -a                        \
+            --ctl-fd ${ctl_fd} --ctl-fd-ack ${ctl_fd_ack} \
+            -- sleep 30 &
+perf_pid=$!
+
+sleep 5  && echo 'r' >&${ctl_fd} && read -u ${ctl_fd_ack} r1 && echo "resumed(${r1})"
+sleep 10 && echo 'p' >&${ctl_fd} && read -u ${ctl_fd_ack} p1 && echo "paused(${p1})"
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
 SEE ALSO
 --------
 linkperf:perf-stat[1], linkperf:perf-list[1], linkperf:perf-intel-pt[1]
-- 
2.24.1

