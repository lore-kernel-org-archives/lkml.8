Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9348C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 09:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA7C62078B
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 09:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="tyhGN7pN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389492AbgEYJbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 05:31:11 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:54974 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388669AbgEYJbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 05:31:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1590399069; x=1621935069;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=5RIuw0YWt7wztmVqYrst4rRMwvbY0VZzmxbBsJMLd3g=;
  b=tyhGN7pNpuK+5gL/ayrNL8dQtPkXW2mdaleBeHBjXGad4yJcaYl6VuXN
   XZtIRrV7FTttaUq+tuyzlnYAGoDoFhZ4kpYkrhDu4khuXF8GJwFKvF/HA
   swKpw91lIGyoDg8zSZ5YdfnRvzDmbCDeby/6xZefAoCOoJrehdeBbQTB6
   8=;
IronPort-SDR: HnKWG6G7fii+WkkxT+jn9KaRsiqXkqiabgaxtX7TszrZsS23R6hikv5W8inkASJ1y6lfYN31kq
 Ww0TrNxFvvXg==
X-IronPort-AV: E=Sophos;i="5.73,432,1583193600"; 
   d="scan'208";a="45715748"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-27fb8269.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 25 May 2020 09:31:06 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-27fb8269.us-east-1.amazon.com (Postfix) with ESMTPS id 5FDDFA04F0;
        Mon, 25 May 2020 09:30:55 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 25 May 2020 09:30:54 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.140) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 25 May 2020 09:30:37 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <Jonathan.Cameron@Huawei.com>,
        <aarcange@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <benh@kernel.crashing.org>, <brendan.d.gregg@gmail.com>,
        <brendanhiggins@google.com>, <cai@lca.pw>,
        <colin.king@canonical.com>, <corbet@lwn.net>, <dwmw@amazon.com>,
        <irogers@google.com>, <jolsa@redhat.com>, <kirill@shutemov.name>,
        <mark.rutland@arm.com>, <mgorman@suse.de>, <minchan@kernel.org>,
        <mingo@redhat.com>, <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <riel@surriel.com>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <sblbir@amazon.com>, <shakeelb@google.com>,
        <shuah@kernel.org>, <sj38.park@gmail.com>, <snu@amazon.de>,
        <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <linux-damon@amazon.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v13 14/15] mm/damon: Add user space selftests
Date:   Mon, 25 May 2020 11:30:22 +0200
Message-ID: <20200525093022.1353-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200525091512.30391-1-sjpark@amazon.com>
References: <20200525091512.30391-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.140]
X-ClientProxiedBy: EX13D01UWA001.ant.amazon.com (10.43.160.60) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit adds a simple user space tests for DAMON.  The tests are
using kselftest framework.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 tools/testing/selftests/damon/Makefile        |   7 +
 .../selftests/damon/_chk_dependency.sh        |  28 ++++
 tools/testing/selftests/damon/_chk_record.py  | 108 ++++++++++++++
 .../testing/selftests/damon/debugfs_attrs.sh  | 139 ++++++++++++++++++
 .../testing/selftests/damon/debugfs_record.sh |  50 +++++++
 5 files changed, 332 insertions(+)
 create mode 100644 tools/testing/selftests/damon/Makefile
 create mode 100644 tools/testing/selftests/damon/_chk_dependency.sh
 create mode 100644 tools/testing/selftests/damon/_chk_record.py
 create mode 100755 tools/testing/selftests/damon/debugfs_attrs.sh
 create mode 100755 tools/testing/selftests/damon/debugfs_record.sh

diff --git a/tools/testing/selftests/damon/Makefile b/tools/testing/selftests/damon/Makefile
new file mode 100644
index 000000000000..cfd5393a4639
--- /dev/null
+++ b/tools/testing/selftests/damon/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+# Makefile for damon selftests
+
+TEST_FILES = _chk_dependency.sh _chk_record_file.py
+TEST_PROGS = debugfs_attrs.sh debugfs_record.sh
+
+include ../lib.mk
diff --git a/tools/testing/selftests/damon/_chk_dependency.sh b/tools/testing/selftests/damon/_chk_dependency.sh
new file mode 100644
index 000000000000..814dcadd5e96
--- /dev/null
+++ b/tools/testing/selftests/damon/_chk_dependency.sh
@@ -0,0 +1,28 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
+DBGFS=/sys/kernel/debug/damon
+
+if [ $EUID -ne 0 ];
+then
+	echo "Run as root"
+	exit $ksft_skip
+fi
+
+if [ ! -d $DBGFS ]
+then
+	echo "$DBGFS not found"
+	exit $ksft_skip
+fi
+
+for f in attrs record pids monitor_on
+do
+	if [ ! -f "$DBGFS/$f" ]
+	then
+		echo "$f not found"
+		exit 1
+	fi
+done
diff --git a/tools/testing/selftests/damon/_chk_record.py b/tools/testing/selftests/damon/_chk_record.py
new file mode 100644
index 000000000000..5cfcf4161404
--- /dev/null
+++ b/tools/testing/selftests/damon/_chk_record.py
@@ -0,0 +1,108 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+"Check whether the DAMON record file is valid"
+
+import argparse
+import struct
+import sys
+
+fmt_version = 0
+
+def set_fmt_version(f):
+    global fmt_version
+
+    mark = f.read(16)
+    if mark == b'damon_recfmt_ver':
+        fmt_version = struct.unpack('i', f.read(4))[0]
+    else:
+        fmt_version = 0
+        f.seek(0)
+    return fmt_version
+
+def read_pid(f):
+    if fmt_version == 0:
+        pid = struct.unpack('L', f.read(8))[0]
+    else:
+        pid = struct.unpack('i', f.read(4))[0]
+def err_percent(val, expected):
+    return abs(val - expected) / expected * 100
+
+def chk_task_info(f):
+    pid = read_pid(f)
+    nr_regions = struct.unpack('I', f.read(4))[0]
+
+    if nr_regions > max_nr_regions:
+        print('too many regions: %d > %d' % (nr_regions, max_nr_regions))
+        exit(1)
+
+    nr_gaps = 0
+    eaddr = 0
+    for r in range(nr_regions):
+        saddr = struct.unpack('L', f.read(8))[0]
+        if eaddr and saddr != eaddr:
+            nr_gaps += 1
+        eaddr = struct.unpack('L', f.read(8))[0]
+        nr_accesses = struct.unpack('I', f.read(4))[0]
+
+        if saddr >= eaddr:
+            print('wrong region [%d,%d)' % (saddr, eaddr))
+            exit(1)
+
+        max_nr_accesses = aint / sint
+        if nr_accesses > max_nr_accesses:
+            if err_percent(nr_accesses, max_nr_accesses) > 15:
+                print('too high nr_access: expected %d but %d' %
+                        (max_nr_accesses, nr_accesses))
+                exit(1)
+    if nr_gaps != 2:
+        print('number of gaps are not two but %d' % nr_gaps)
+        exit(1)
+
+def parse_time_us(bindat):
+    sec = struct.unpack('l', bindat[0:8])[0]
+    nsec = struct.unpack('l', bindat[8:16])[0]
+    return (sec * 1000000000 + nsec) / 1000
+
+def main():
+    global sint
+    global aint
+    global min_nr
+    global max_nr_regions
+
+    parser = argparse.ArgumentParser()
+    parser.add_argument('file', metavar='<file>',
+            help='path to the record file')
+    parser.add_argument('--attrs', metavar='<attrs>',
+            default='5000 100000 1000000 10 1000',
+            help='content of debugfs attrs file')
+    args = parser.parse_args()
+    file_path = args.file
+    attrs = [int(x) for x in args.attrs.split()]
+    sint, aint, rint, min_nr, max_nr_regions = attrs
+
+    with open(file_path, 'rb') as f:
+        set_fmt_version(f)
+        last_aggr_time = None
+        while True:
+            timebin = f.read(16)
+            if len(timebin) != 16:
+                break
+
+            now = parse_time_us(timebin)
+            if not last_aggr_time:
+                last_aggr_time = now
+            else:
+                error = err_percent(now - last_aggr_time, aint)
+                if error > 15:
+                    print('wrong aggr interval: expected %d, but %d' %
+                            (aint, now - last_aggr_time))
+                    exit(1)
+                last_aggr_time = now
+
+            nr_tasks = struct.unpack('I', f.read(4))[0]
+            for t in range(nr_tasks):
+                chk_task_info(f)
+
+if __name__ == '__main__':
+    main()
diff --git a/tools/testing/selftests/damon/debugfs_attrs.sh b/tools/testing/selftests/damon/debugfs_attrs.sh
new file mode 100755
index 000000000000..d5188b0f71b1
--- /dev/null
+++ b/tools/testing/selftests/damon/debugfs_attrs.sh
@@ -0,0 +1,139 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+source ./_chk_dependency.sh
+
+# Test attrs file
+file="$DBGFS/attrs"
+
+ORIG_CONTENT=$(cat $file)
+
+echo 1 2 3 4 5 > $file
+if [ $? -ne 0 ]
+then
+	echo "$file write failed"
+	echo $ORIG_CONTENT > $file
+	exit 1
+fi
+
+echo 1 2 3 4 > $file
+if [ $? -eq 0 ]
+then
+	echo "$file write success (should failed)"
+	echo $ORIG_CONTENT > $file
+	exit 1
+fi
+
+CONTENT=$(cat $file)
+if [ "$CONTENT" != "1 2 3 4 5" ]
+then
+	echo "$file not written"
+	echo $ORIG_CONTENT > $file
+	exit 1
+fi
+
+echo $ORIG_CONTENT > $file
+
+# Test record file
+file="$DBGFS/record"
+
+ORIG_CONTENT=$(cat $file)
+
+echo "4242 foo.bar" > $file
+if [ $? -ne 0 ]
+then
+	echo "$file writing sane input failed"
+	echo $ORIG_CONTENT > $file
+	exit 1
+fi
+
+echo abc 2 3 > $file
+if [ $? -eq 0 ]
+then
+	echo "$file writing insane input 1 success (should failed)"
+	echo $ORIG_CONTENT > $file
+	exit 1
+fi
+
+echo 123 > $file
+if [ $? -eq 0 ]
+then
+	echo "$file writing insane input 2 success (should failed)"
+	echo $ORIG_CONTENT > $file
+	exit 1
+fi
+
+CONTENT=$(cat $file)
+if [ "$CONTENT" != "4242 foo.bar" ]
+then
+	echo "$file not written"
+	echo $ORIG_CONTENT > $file
+	exit 1
+fi
+
+echo "0 null" > $file
+if [ $? -ne 0 ]
+then
+	echo "$file disabling write fail"
+	echo $ORIG_CONTENT > $file
+	exit 1
+fi
+
+CONTENT=$(cat $file)
+if [ "$CONTENT" != "0 null" ]
+then
+	echo "$file not disabled"
+	echo $ORIG_CONTENT > $file
+	exit 1
+fi
+
+echo "4242 foo.bar" > $file
+if [ $? -ne 0 ]
+then
+	echo "$file writing sane data again fail"
+	echo $ORIG_CONTENT > $file
+	exit 1
+fi
+
+echo $ORIG_CONTENT > $file
+
+# Test pids file
+file="$DBGFS/pids"
+
+ORIG_CONTENT=$(cat $file)
+
+echo "1 2 3 4" > $file
+if [ $? -ne 0 ]
+then
+	echo "$file write fail"
+	echo $ORIG_CONTENT > $file
+	exit 1
+fi
+
+echo "1 2 abc 4" > $file
+if [ $? -ne 0 ]
+then
+	echo "$file write fail"
+	echo $ORIG_CONTENT > $file
+	exit 1
+fi
+
+echo abc 2 3 > $file
+if [ $? -eq 0 ]
+then
+	echo "$file write success (should failed)"
+	echo $ORIG_CONTENT > $file
+	exit 1
+fi
+
+CONTENT=$(cat $file)
+if [ "$CONTENT" != "1 2" ]
+then
+	echo "$file not written"
+	echo $ORIG_CONTENT > $file
+	exit 1
+fi
+
+echo $ORIG_CONTENT > $file
+
+echo "PASS"
diff --git a/tools/testing/selftests/damon/debugfs_record.sh b/tools/testing/selftests/damon/debugfs_record.sh
new file mode 100755
index 000000000000..fa9e07eea258
--- /dev/null
+++ b/tools/testing/selftests/damon/debugfs_record.sh
@@ -0,0 +1,50 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+source ./_chk_dependency.sh
+
+restore_attrs()
+{
+	echo $ORIG_ATTRS > $DBGFS/attrs
+	echo $ORIG_PIDS > $DBGFS/pids
+	echo $ORIG_RECORD > $DBGFS/record
+}
+
+ORIG_ATTRS=$(cat $DBGFS/attrs)
+ORIG_PIDS=$(cat $DBGFS/pids)
+ORIG_RECORD=$(cat $DBGFS/record)
+
+rfile=$pwd/damon.data
+
+rm -f $rfile
+ATTRS="5000 100000 1000000 10 1000"
+echo $ATTRS > $DBGFS/attrs
+echo 4096 $rfile > $DBGFS/record
+sleep 5 &
+echo $(pidof sleep) > $DBGFS/pids
+echo on > $DBGFS/monitor_on
+sleep 0.5
+killall sleep
+echo off > $DBGFS/monitor_on
+
+sync
+
+if [ ! -f $rfile ]
+then
+	echo "record file not made"
+	restore_attrs
+
+	exit 1
+fi
+
+python3 ./_chk_record.py $rfile --attrs "$ATTRS"
+if [ $? -ne 0 ]
+then
+	echo "record file is wrong"
+	restore_attrs
+	exit 1
+fi
+
+rm -f $rfile
+restore_attrs
+echo "PASS"
-- 
2.17.1

