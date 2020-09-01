Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A64C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 09:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61786206CD
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 09:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgIAJiu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 05:38:50 -0400
Received: from mga01.intel.com ([192.55.52.88]:45308 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726937AbgIAJio (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 05:38:44 -0400
IronPort-SDR: r2GcuTaCcIYw+lJsS/ceKVq8u0EcCwDpXxHHWwwyk65TdrLGuDaet/voRXOpEnEsdIyDxp1p7Q
 2DYi2mMlPeIQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9730"; a="175181502"
X-IronPort-AV: E=Sophos;i="5.76,378,1592895600"; 
   d="scan'208";a="175181502"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2020 02:38:43 -0700
IronPort-SDR: kQnVVFbP+pMnSAL9f/LjbRaAGjEn7YExfynIkmWCv/JVcirBdeYNUzqIcc54UPvJagcnP0oqop
 RgFEpR3ZIERA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,378,1592895600"; 
   d="scan'208";a="502181189"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.73])
  by fmsmga005.fm.intel.com with ESMTP; 01 Sep 2020 02:38:41 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 3/6] perf tools: Use AsciiDoc formatting for --control option documentation
Date:   Tue,  1 Sep 2020 12:37:55 +0300
Message-Id: <20200901093758.32293-4-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200901093758.32293-1-adrian.hunter@intel.com>
References: <20200901093758.32293-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The --control option does not display well in man pages unless AsciiDoc
formatting is used.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/Documentation/perf-record.txt | 46 ++++++++++++------------
 tools/perf/Documentation/perf-stat.txt   | 46 ++++++++++++------------
 2 files changed, 46 insertions(+), 46 deletions(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 3f72d8e261f3..07c4734f1c7a 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -627,43 +627,43 @@ option. The -e option and this one can be mixed and matched.  Events
 can be grouped using the {} notation.
 endif::HAVE_LIBPFM[]
 
---control fd:ctl-fd[,ack-fd]
+--control=fd:ctl-fd[,ack-fd]::
 Listen on ctl-fd descriptor for command to control measurement ('enable': enable events,
 'disable': disable events). Measurements can be started with events disabled using
 --delay=-1 option. Optionally send control command completion ('ack\n') to ack-fd descriptor
 to synchronize with the controlling process. Example of bash shell script to enable and
 disable events during measurements:
 
-#!/bin/bash
+ #!/bin/bash
 
-ctl_dir=/tmp/
+ ctl_dir=/tmp/
 
-ctl_fifo=${ctl_dir}perf_ctl.fifo
-test -p ${ctl_fifo} && unlink ${ctl_fifo}
-mkfifo ${ctl_fifo}
-exec {ctl_fd}<>${ctl_fifo}
+ ctl_fifo=${ctl_dir}perf_ctl.fifo
+ test -p ${ctl_fifo} && unlink ${ctl_fifo}
+ mkfifo ${ctl_fifo}
+ exec {ctl_fd}<>${ctl_fifo}
 
-ctl_ack_fifo=${ctl_dir}perf_ctl_ack.fifo
-test -p ${ctl_ack_fifo} && unlink ${ctl_ack_fifo}
-mkfifo ${ctl_ack_fifo}
-exec {ctl_fd_ack}<>${ctl_ack_fifo}
+ ctl_ack_fifo=${ctl_dir}perf_ctl_ack.fifo
+ test -p ${ctl_ack_fifo} && unlink ${ctl_ack_fifo}
+ mkfifo ${ctl_ack_fifo}
+ exec {ctl_fd_ack}<>${ctl_ack_fifo}
 
-perf record -D -1 -e cpu-cycles -a               \
-            --control fd:${ctl_fd},${ctl_fd_ack} \
-            -- sleep 30 &
-perf_pid=$!
+ perf record -D -1 -e cpu-cycles -a               \
+             --control fd:${ctl_fd},${ctl_fd_ack} \
+             -- sleep 30 &
+ perf_pid=$!
 
-sleep 5  && echo 'enable' >&${ctl_fd} && read -u ${ctl_fd_ack} e1 && echo "enabled(${e1})"
-sleep 10 && echo 'disable' >&${ctl_fd} && read -u ${ctl_fd_ack} d1 && echo "disabled(${d1})"
+ sleep 5  && echo 'enable' >&${ctl_fd} && read -u ${ctl_fd_ack} e1 && echo "enabled(${e1})"
+ sleep 10 && echo 'disable' >&${ctl_fd} && read -u ${ctl_fd_ack} d1 && echo "disabled(${d1})"
 
-exec {ctl_fd_ack}>&-
-unlink ${ctl_ack_fifo}
+ exec {ctl_fd_ack}>&-
+ unlink ${ctl_ack_fifo}
 
-exec {ctl_fd}>&-
-unlink ${ctl_fifo}
+ exec {ctl_fd}>&-
+ unlink ${ctl_fifo}
 
-wait -n ${perf_pid}
-exit $?
+ wait -n ${perf_pid}
+ exit $?
 
 
 SEE ALSO
diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index c9bfefc051fb..7fb7368cc2d9 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -176,43 +176,43 @@ with it.  --append may be used here.  Examples:
      3>results  perf stat --log-fd 3          -- $cmd
      3>>results perf stat --log-fd 3 --append -- $cmd
 
---control fd:ctl-fd[,ack-fd]
+--control=fd:ctl-fd[,ack-fd]::
 Listen on ctl-fd descriptor for command to control measurement ('enable': enable events,
 'disable': disable events). Measurements can be started with events disabled using
 --delay=-1 option. Optionally send control command completion ('ack\n') to ack-fd descriptor
 to synchronize with the controlling process. Example of bash shell script to enable and
 disable events during measurements:
 
-#!/bin/bash
+ #!/bin/bash
 
-ctl_dir=/tmp/
+ ctl_dir=/tmp/
 
-ctl_fifo=${ctl_dir}perf_ctl.fifo
-test -p ${ctl_fifo} && unlink ${ctl_fifo}
-mkfifo ${ctl_fifo}
-exec {ctl_fd}<>${ctl_fifo}
+ ctl_fifo=${ctl_dir}perf_ctl.fifo
+ test -p ${ctl_fifo} && unlink ${ctl_fifo}
+ mkfifo ${ctl_fifo}
+ exec {ctl_fd}<>${ctl_fifo}
 
-ctl_ack_fifo=${ctl_dir}perf_ctl_ack.fifo
-test -p ${ctl_ack_fifo} && unlink ${ctl_ack_fifo}
-mkfifo ${ctl_ack_fifo}
-exec {ctl_fd_ack}<>${ctl_ack_fifo}
+ ctl_ack_fifo=${ctl_dir}perf_ctl_ack.fifo
+ test -p ${ctl_ack_fifo} && unlink ${ctl_ack_fifo}
+ mkfifo ${ctl_ack_fifo}
+ exec {ctl_fd_ack}<>${ctl_ack_fifo}
 
-perf stat -D -1 -e cpu-cycles -a -I 1000       \
-          --control fd:${ctl_fd},${ctl_fd_ack} \
-          -- sleep 30 &
-perf_pid=$!
+ perf stat -D -1 -e cpu-cycles -a -I 1000       \
+           --control fd:${ctl_fd},${ctl_fd_ack} \
+           -- sleep 30 &
+ perf_pid=$!
 
-sleep 5  && echo 'enable' >&${ctl_fd} && read -u ${ctl_fd_ack} e1 && echo "enabled(${e1})"
-sleep 10 && echo 'disable' >&${ctl_fd} && read -u ${ctl_fd_ack} d1 && echo "disabled(${d1})"
+ sleep 5  && echo 'enable' >&${ctl_fd} && read -u ${ctl_fd_ack} e1 && echo "enabled(${e1})"
+ sleep 10 && echo 'disable' >&${ctl_fd} && read -u ${ctl_fd_ack} d1 && echo "disabled(${d1})"
 
-exec {ctl_fd_ack}>&-
-unlink ${ctl_ack_fifo}
+ exec {ctl_fd_ack}>&-
+ unlink ${ctl_ack_fifo}
 
-exec {ctl_fd}>&-
-unlink ${ctl_fifo}
+ exec {ctl_fd}>&-
+ unlink ${ctl_fifo}
 
-wait -n ${perf_pid}
-exit $?
+ wait -n ${perf_pid}
+ exit $?
 
 
 --pre::
-- 
2.17.1

