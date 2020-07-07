Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 433D6C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FAA520738
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ZZSAuzPv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbgGGOrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 10:47:22 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:28213 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbgGGOrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 10:47:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1594133241; x=1625669241;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=BksteOeehUikB4CSkBmzeSkm8yWL2e44sQDAz0bv2zk=;
  b=ZZSAuzPv7ijuB4AqugwkPBlaq1MrjGWNHciO1/zc6Tgeq5tdsBzKvEld
   76/jRlXV8UmimvLwW3XFgDgT+vWJa7YkNtY8LqX21USW7reeQepor2/b2
   U+t/fKFNpdExc5baRoXqgRj6otSrI4tD96PNX43b5Uy6nA3bi808Fu6Gf
   g=;
IronPort-SDR: WD7PaGLzyjNGhUgjLSZZRswy7K3xJlIUa8C7E+ZSBE59h3yZUZcMvS9LAKmv7GCutZD67Pp70w
 h0LqxGm6iHLg==
X-IronPort-AV: E=Sophos;i="5.75,324,1589241600"; 
   d="scan'208";a="49756137"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-e7be2041.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 07 Jul 2020 14:47:20 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-e7be2041.us-west-2.amazon.com (Postfix) with ESMTPS id DBFEFA195C;
        Tue,  7 Jul 2020 14:47:17 +0000 (UTC)
Received: from EX13D31EUA004.ant.amazon.com (10.43.165.161) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 7 Jul 2020 14:47:17 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.214) by
 EX13D31EUA004.ant.amazon.com (10.43.165.161) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 7 Jul 2020 14:46:56 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <Jonathan.Cameron@Huawei.com>,
        <aarcange@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <benh@kernel.crashing.org>, <brendan.d.gregg@gmail.com>,
        <brendanhiggins@google.com>, <cai@lca.pw>,
        <colin.king@canonical.com>, <corbet@lwn.net>, <david@redhat.com>,
        <dwmw@amazon.com>, <foersleo@amazon.de>, <irogers@google.com>,
        <jolsa@redhat.com>, <kirill@shutemov.name>, <mark.rutland@arm.com>,
        <mgorman@suse.de>, <minchan@kernel.org>, <mingo@redhat.com>,
        <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <riel@surriel.com>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <rppt@kernel.org>, <sblbir@amazon.com>,
        <shakeelb@google.com>, <shuah@kernel.org>, <sj38.park@gmail.com>,
        <snu@amazon.de>, <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <linux-damon@amazon.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC v5 02/11] tools/damon: Support init target regions specification
Date:   Tue, 7 Jul 2020 16:45:31 +0200
Message-ID: <20200707144540.21216-3-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200707144540.21216-1-sjpark@amazon.com>
References: <20200707144540.21216-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.214]
X-ClientProxiedBy: EX13D35UWC001.ant.amazon.com (10.43.162.197) To
 EX13D31EUA004.ant.amazon.com (10.43.165.161)
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
index 3620ef12a5ea..ad476cc61421 100644
--- a/tools/damon/_damon.py
+++ b/tools/damon/_damon.py
@@ -12,12 +12,25 @@ debugfs_attrs = None
 debugfs_record = None
 debugfs_schemes = None
 debugfs_pids = None
+debugfs_init_regions = None
 debugfs_monitor_on = None
 
 def set_target_pid(pid):
     return subprocess.call('echo %s > %s' % (pid, debugfs_pids), shell=True,
             executable='/bin/bash')
 
+def set_target(pid, init_regions=[]):
+    rc = set_target_pid(pid)
+    if rc:
+        return rc
+
+    if not os.path.exists(debugfs_init_regions):
+        return 0
+
+    string = ' '.join(['%s %d %d' % (pid, r[0], r[1]) for r in init_regions])
+    return subprocess.call('echo "%s" > %s' % (string, debugfs_init_regions),
+            shell=True, executable='/bin/bash')
+
 def turn_damon(on_off):
     return subprocess.call("echo %s > %s" % (on_off, debugfs_monitor_on),
             shell=True, executable="/bin/bash")
@@ -97,6 +110,7 @@ def chk_update_debugfs(debugfs):
     global debugfs_record
     global debugfs_schemes
     global debugfs_pids
+    global debugfs_init_regions
     global debugfs_monitor_on
 
     debugfs_damon = os.path.join(debugfs, 'damon')
@@ -104,6 +118,7 @@ def chk_update_debugfs(debugfs):
     debugfs_record = os.path.join(debugfs_damon, 'record')
     debugfs_schemes = os.path.join(debugfs_damon, 'schemes')
     debugfs_pids = os.path.join(debugfs_damon, 'pids')
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
index 44fa3a12af35..6ce8721d782a 100644
--- a/tools/damon/record.py
+++ b/tools/damon/record.py
@@ -13,7 +13,7 @@ import time
 
 import _damon
 
-def do_record(target, is_target_cmd, attrs, old_attrs):
+def do_record(target, is_target_cmd, init_regions, attrs, old_attrs):
     if os.path.isfile(attrs.rfile_path):
         os.rename(attrs.rfile_path, attrs.rfile_path + '.old')
 
@@ -24,8 +24,8 @@ def do_record(target, is_target_cmd, attrs, old_attrs):
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
@@ -65,6 +65,7 @@ def chk_permission():
 
 def set_argparser(parser):
     _damon.set_attrs_argparser(parser)
+    _damon.set_init_regions_argparser(parser)
     parser.add_argument('target', type=str, metavar='<target>',
             help='the target command or the pid to record')
     parser.add_argument('-l', '--rbuf', metavar='<len>', type=int,
@@ -88,19 +89,20 @@ def main(args=None):
 
     args.schemes = ''
     new_attrs = _damon.cmd_args_to_attrs(args)
+    init_regions = _damon.cmd_args_to_init_regions(args)
     target = args.target
 
     target_fields = target.split()
     if not subprocess.call('which %s > /dev/null' % target_fields[0],
             shell=True, executable='/bin/bash'):
-        do_record(target, True, new_attrs, orig_attrs)
+        do_record(target, True, init_regions, new_attrs, orig_attrs)
     else:
         try:
             pid = int(target)
         except:
             print('target \'%s\' is neither a command, nor a pid' % target)
             exit(1)
-        do_record(target, False, new_attrs, orig_attrs)
+        do_record(target, False, init_regions, new_attrs, orig_attrs)
 
 if __name__ == '__main__':
     main()
diff --git a/tools/damon/schemes.py b/tools/damon/schemes.py
index 9f369db7d12e..49968fb947f1 100644
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
     if not subprocess.call('which %s > /dev/null' % target_fields[0],
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

