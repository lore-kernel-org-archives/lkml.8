Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F93C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 10:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D659D2083E
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 10:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="AFGYf5Vs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgHaKs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 06:48:56 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:58921 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbgHaKss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 06:48:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1598870926; x=1630406926;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=eFQ5FjEXjCcRqP315OtcZTEl8DRR0ETd5Jfrqerv8aI=;
  b=AFGYf5VsYcdNz+i1BHOK3eYlficxh54SZFIm4fQni9OKY0lEPoKEuW91
   YRVkdNwzhU1yCLENXEx1A+ssDT8UsOQqcWGDC/Rvymz23KWpUsB/WLS/i
   zSH2AZYdQLV5gLbdEjTcRa4XmU0v+eExongyeA0b6n2HT82GmwfGPPetT
   4=;
X-IronPort-AV: E=Sophos;i="5.76,375,1592870400"; 
   d="scan'208";a="52524448"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-22cc717f.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 31 Aug 2020 10:48:42 +0000
Received: from EX13D31EUB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-22cc717f.us-west-2.amazon.com (Postfix) with ESMTPS id 3672DA1E23;
        Mon, 31 Aug 2020 10:48:39 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.160.100) by
 EX13D31EUB001.ant.amazon.com (10.43.166.210) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 31 Aug 2020 10:48:21 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <Jonathan.Cameron@Huawei.com>,
        <aarcange@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <benh@kernel.crashing.org>, <brendan.d.gregg@gmail.com>,
        <brendanhiggins@google.com>, <cai@lca.pw>,
        <colin.king@canonical.com>, <corbet@lwn.net>, <david@redhat.com>,
        <dwmw@amazon.com>, <fan.du@intel.com>, <foersleo@amazon.de>,
        <gthelen@google.com>, <irogers@google.com>, <jolsa@redhat.com>,
        <kirill@shutemov.name>, <mark.rutland@arm.com>, <mgorman@suse.de>,
        <minchan@kernel.org>, <mingo@redhat.com>, <namhyung@kernel.org>,
        <peterz@infradead.org>, <rdunlap@infradead.org>,
        <riel@surriel.com>, <rientjes@google.com>, <rostedt@goodmis.org>,
        <rppt@kernel.org>, <sblbir@amazon.com>, <shakeelb@google.com>,
        <shuah@kernel.org>, <sj38.park@gmail.com>, <snu@amazon.de>,
        <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <zgf574564920@gmail.com>, <linux-damon@amazon.com>,
        <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC v8 02/10] tools/damon: Support init target regions specification
Date:   Mon, 31 Aug 2020 12:47:22 +0200
Message-ID: <20200831104730.28970-3-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200831104730.28970-1-sjpark@amazon.com>
References: <20200831104730.28970-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.100]
X-ClientProxiedBy: EX13D49UWB002.ant.amazon.com (10.43.163.68) To
 EX13D31EUB001.ant.amazon.com (10.43.166.210)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit updates the damon user space tool to support the initial
monitoring target regions specification.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 tools/damon/_damon.py  | 39 +++++++++++++++++++++++++++++++++++++++
 tools/damon/record.py  | 12 +++++++-----
 tools/damon/schemes.py | 12 +++++++-----
 3 files changed, 53 insertions(+), 10 deletions(-)

diff --git a/tools/damon/_damon.py b/tools/damon/_damon.py
index a4f6c03c23e4..a22ec3777c16 100644
--- a/tools/damon/_damon.py
+++ b/tools/damon/_damon.py
@@ -12,12 +12,25 @@ debugfs_attrs = None
 debugfs_record = None
 debugfs_schemes = None
 debugfs_target_ids = None
+debugfs_init_regions = None
 debugfs_monitor_on = None
 
 def set_target_id(tid):
     with open(debugfs_target_ids, 'w') as f:
         f.write('%s\n' % tid)
 
+def set_target(tid, init_regions=[]):
+    rc = set_target_id(tid)
+    if rc:
+        return rc
+
+    if not os.path.exists(debugfs_init_regions):
+        return 0
+
+    string = ' '.join(['%s %d %d' % (tid, r[0], r[1]) for r in init_regions])
+    return subprocess.call('echo "%s" > %s' % (string, debugfs_init_regions),
+            shell=True, executable='/bin/bash')
+
 def turn_damon(on_off):
     return subprocess.call("echo %s > %s" % (on_off, debugfs_monitor_on),
             shell=True, executable="/bin/bash")
@@ -97,6 +110,7 @@ def chk_update_debugfs(debugfs):
     global debugfs_record
     global debugfs_schemes
     global debugfs_target_ids
+    global debugfs_init_regions
     global debugfs_monitor_on
 
     debugfs_damon = os.path.join(debugfs, 'damon')
@@ -104,6 +118,7 @@ def chk_update_debugfs(debugfs):
     debugfs_record = os.path.join(debugfs_damon, 'record')
     debugfs_schemes = os.path.join(debugfs_damon, 'schemes')
     debugfs_target_ids = os.path.join(debugfs_damon, 'target_ids')
+    debugfs_init_regions = os.path.join(debugfs_damon, 'init_regions')
     debugfs_monitor_on = os.path.join(debugfs_damon, 'monitor_on')
 
     if not os.path.isdir(debugfs_damon):
@@ -131,6 +146,26 @@ def cmd_args_to_attrs(args):
     return Attrs(sample_interval, aggr_interval, regions_update_interval,
             min_nr_regions, max_nr_regions, rbuf_len, rfile_path, schemes)
 
+def cmd_args_to_init_regions(args):
+    regions = []
+    for arg in args.regions.split():
+        addrs = arg.split('-')
+        try:
+            if len(addrs) != 2:
+                raise Exception('two addresses not given')
+            start = int(addrs[0])
+            end = int(addrs[1])
+            if start >= end:
+                raise Exception('start >= end')
+            if regions and regions[-1][1] > start:
+                raise Exception('regions overlap')
+        except Exception as e:
+            print('Wrong \'--regions\' argument (%s)' % e)
+            exit(1)
+
+        regions.append([start, end])
+    return regions
+
 def set_attrs_argparser(parser):
     parser.add_argument('-d', '--debugfs', metavar='<debugfs>', type=str,
             default='/sys/kernel/debug', help='debugfs mounted path')
@@ -144,3 +179,7 @@ def set_attrs_argparser(parser):
             default=10, help='minimal number of regions')
     parser.add_argument('-m', '--maxr', metavar='<# regions>', type=int,
             default=1000, help='maximum number of regions')
+
+def set_init_regions_argparser(parser):
+    parser.add_argument('-r', '--regions', metavar='"<start>-<end> ..."',
+            type=str, default='', help='monitoring target address regions')
diff --git a/tools/damon/record.py b/tools/damon/record.py
index 6d1cbe593b94..11fd54001472 100644
--- a/tools/damon/record.py
+++ b/tools/damon/record.py
@@ -24,7 +24,7 @@ def pidfd_open(pid):
 
     return syscall(NR_pidfd_open, pid, 0)
 
-def do_record(target, is_target_cmd, attrs, old_attrs, pidfd):
+def do_record(target, is_target_cmd, init_regions, attrs, old_attrs, pidfd):
     if os.path.isfile(attrs.rfile_path):
         os.rename(attrs.rfile_path, attrs.rfile_path + '.old')
 
@@ -48,8 +48,8 @@ def do_record(target, is_target_cmd, attrs, old_attrs, pidfd):
         # only for reference of the pidfd usage.
         target = 'pidfd %s' % fd
 
-    if _damon.set_target_id(target):
-        print('target id setting (%s) failed' % target)
+    if _damon.set_target(target, init_regions):
+        print('target setting (%s, %s) failed' % (target, init_regions))
         cleanup_exit(old_attrs, -2)
     if _damon.turn_damon('on'):
         print('could not turn on damon' % target)
@@ -91,6 +91,7 @@ def chk_permission():
 
 def set_argparser(parser):
     _damon.set_attrs_argparser(parser)
+    _damon.set_init_regions_argparser(parser)
     parser.add_argument('target', type=str, metavar='<target>',
             help='the target command or the pid to record')
     parser.add_argument('--pidfd', action='store_true',
@@ -117,19 +118,20 @@ def main(args=None):
     args.schemes = ''
     pidfd = args.pidfd
     new_attrs = _damon.cmd_args_to_attrs(args)
+    init_regions = _damon.cmd_args_to_init_regions(args)
     target = args.target
 
     target_fields = target.split()
     if not subprocess.call('which %s &> /dev/null' % target_fields[0],
             shell=True, executable='/bin/bash'):
-        do_record(target, True, new_attrs, orig_attrs, pidfd)
+        do_record(target, True, init_regions, new_attrs, orig_attrs, pidfd)
     else:
         try:
             pid = int(target)
         except:
             print('target \'%s\' is neither a command, nor a pid' % target)
             exit(1)
-        do_record(target, False, new_attrs, orig_attrs, pidfd)
+        do_record(target, False, init_regions, new_attrs, orig_attrs, pidfd)
 
 if __name__ == '__main__':
     main()
diff --git a/tools/damon/schemes.py b/tools/damon/schemes.py
index 9095835f6133..cfec89854a08 100644
--- a/tools/damon/schemes.py
+++ b/tools/damon/schemes.py
@@ -14,7 +14,7 @@ import time
 import _convert_damos
 import _damon
 
-def run_damon(target, is_target_cmd, attrs, old_attrs):
+def run_damon(target, is_target_cmd, init_regions, attrs, old_attrs):
     if os.path.isfile(attrs.rfile_path):
         os.rename(attrs.rfile_path, attrs.rfile_path + '.old')
 
@@ -27,8 +27,8 @@ def run_damon(target, is_target_cmd, attrs, old_attrs):
     if is_target_cmd:
         p = subprocess.Popen(target, shell=True, executable='/bin/bash')
         target = p.pid
-    if _damon.set_target_pid(target):
-        print('pid setting (%s) failed' % target)
+    if _damon.set_target(target, init_regions):
+        print('target setting (%s, %s) failed' % (target, init_regions))
         cleanup_exit(old_attrs, -2)
     if _damon.turn_damon('on'):
         print('could not turn on damon' % target)
@@ -68,6 +68,7 @@ def chk_permission():
 
 def set_argparser(parser):
     _damon.set_attrs_argparser(parser)
+    _damon.set_init_regions_argparser(parser)
     parser.add_argument('target', type=str, metavar='<target>',
             help='the target command or the pid to record')
     parser.add_argument('-c', '--schemes', metavar='<file>', type=str,
@@ -92,19 +93,20 @@ def main(args=None):
     args.out = 'null'
     args.schemes = _convert_damos.convert(args.schemes, args.sample, args.aggr)
     new_attrs = _damon.cmd_args_to_attrs(args)
+    init_regions = _damon.cmd_args_to_init_regions(args)
     target = args.target
 
     target_fields = target.split()
     if not subprocess.call('which %s &> /dev/null' % target_fields[0],
             shell=True, executable='/bin/bash'):
-        run_damon(target, True, new_attrs, orig_attrs)
+        run_damon(target, True, init_regions, new_attrs, orig_attrs)
     else:
         try:
             pid = int(target)
         except:
             print('target \'%s\' is neither a command, nor a pid' % target)
             exit(1)
-        run_damon(target, False, new_attrs, orig_attrs)
+        run_damon(target, False, init_regions, new_attrs, orig_attrs)
 
 if __name__ == '__main__':
     main()
-- 
2.17.1

