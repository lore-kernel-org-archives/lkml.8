Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F3AC55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 20:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51580214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 20:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="XoB0vG6n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgDVUro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 16:47:44 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:49406 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726589AbgDVUra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 16:47:30 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03MKi5EV011539
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 13:47:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=36iL6fcUyzzyk2uQxjMSUmOSX6/ONuAh4DixC9KKRUY=;
 b=XoB0vG6nnJZPep0lAuBlXxhRrkYyKUAV5hW41YjDa5aPsk1AQ8Le905H+ndRq1ykw9c3
 l7ubrzSQX1iNmjLnHtWAGE425jvPAptbQIfR5ThLnl9GY+5SLjGT1ha0w/3Wk7diYUek
 c2YY9gjHBk1EB0OV3H9kDNh8rFOfqHuHFfc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 30jtc5h1xt-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 13:47:28 -0700
Received: from intmgw003.06.prn3.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Wed, 22 Apr 2020 13:47:27 -0700
Received: by devvm4439.prn2.facebook.com (Postfix, from userid 111017)
        id 0EC542293581D; Wed, 22 Apr 2020 13:47:17 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm4439.prn2.facebook.com
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>, Waiman Long <longman@redhat.com>,
        "Tobin C . Harding" <tobin@kernel.org>, Tejun Heo <tj@kernel.org>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v3 19/19] tools/cgroup: add memcg_slabinfo.py tool
Date:   Wed, 22 Apr 2020 13:47:08 -0700
Message-ID: <20200422204708.2176080-20-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200422204708.2176080-1-guro@fb.com>
References: <20200422204708.2176080-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-22_07:2020-04-22,2020-04-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 clxscore=1015 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004220158
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a drgn-based tool to display slab information for a given memcg.
Can replace cgroup v1 memory.kmem.slabinfo interface on cgroup v2,
but in a more flexiable way.

Currently supports only SLUB configuration, but SLAB can be trivially
added later.

Output example:
$ sudo ./tools/cgroup/memcg_slabinfo.py /sys/fs/cgroup/user.slice/user-11=
1017.slice/user\@111017.service
shmem_inode_cache     92     92    704   46    8 : tunables    0    0    =
0 : slabdata      2      2      0
eventpoll_pwq         56     56     72   56    1 : tunables    0    0    =
0 : slabdata      1      1      0
eventpoll_epi         32     32    128   32    1 : tunables    0    0    =
0 : slabdata      1      1      0
kmalloc-8              0      0      8  512    1 : tunables    0    0    =
0 : slabdata      0      0      0
kmalloc-96             0      0     96   42    1 : tunables    0    0    =
0 : slabdata      0      0      0
kmalloc-2048           0      0   2048   16    8 : tunables    0    0    =
0 : slabdata      0      0      0
kmalloc-64           128    128     64   64    1 : tunables    0    0    =
0 : slabdata      2      2      0
mm_struct            160    160   1024   32    8 : tunables    0    0    =
0 : slabdata      5      5      0
signal_cache          96     96   1024   32    8 : tunables    0    0    =
0 : slabdata      3      3      0
sighand_cache         45     45   2112   15    8 : tunables    0    0    =
0 : slabdata      3      3      0
files_cache          138    138    704   46    8 : tunables    0    0    =
0 : slabdata      3      3      0
task_delay_info      153    153     80   51    1 : tunables    0    0    =
0 : slabdata      3      3      0
task_struct           27     27   3520    9    8 : tunables    0    0    =
0 : slabdata      3      3      0
radix_tree_node       56     56    584   28    4 : tunables    0    0    =
0 : slabdata      2      2      0
btrfs_inode          140    140   1136   28    8 : tunables    0    0    =
0 : slabdata      5      5      0
kmalloc-1024          64     64   1024   32    8 : tunables    0    0    =
0 : slabdata      2      2      0
kmalloc-192           84     84    192   42    2 : tunables    0    0    =
0 : slabdata      2      2      0
inode_cache           54     54    600   27    4 : tunables    0    0    =
0 : slabdata      2      2      0
kmalloc-128            0      0    128   32    1 : tunables    0    0    =
0 : slabdata      0      0      0
kmalloc-512           32     32    512   32    4 : tunables    0    0    =
0 : slabdata      1      1      0
skbuff_head_cache     32     32    256   32    2 : tunables    0    0    =
0 : slabdata      1      1      0
sock_inode_cache      46     46    704   46    8 : tunables    0    0    =
0 : slabdata      1      1      0
cred_jar             378    378    192   42    2 : tunables    0    0    =
0 : slabdata      9      9      0
proc_inode_cache      96     96    672   24    4 : tunables    0    0    =
0 : slabdata      4      4      0
dentry               336    336    192   42    2 : tunables    0    0    =
0 : slabdata      8      8      0
filp                 697    864    256   32    2 : tunables    0    0    =
0 : slabdata     27     27      0
anon_vma             644    644     88   46    1 : tunables    0    0    =
0 : slabdata     14     14      0
pid                 1408   1408     64   64    1 : tunables    0    0    =
0 : slabdata     22     22      0
vm_area_struct      1200   1200    200   40    2 : tunables    0    0    =
0 : slabdata     30     30      0

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Waiman Long <longman@redhat.com>
Cc: Tobin C. Harding <tobin@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
---
 tools/cgroup/memcg_slabinfo.py | 226 +++++++++++++++++++++++++++++++++
 1 file changed, 226 insertions(+)
 create mode 100755 tools/cgroup/memcg_slabinfo.py

diff --git a/tools/cgroup/memcg_slabinfo.py b/tools/cgroup/memcg_slabinfo=
.py
new file mode 100755
index 000000000000..c4225ed63565
--- /dev/null
+++ b/tools/cgroup/memcg_slabinfo.py
@@ -0,0 +1,226 @@
+#!/usr/bin/env drgn
+#
+# Copyright (C) 2020 Roman Gushchin <guro@fb.com>
+# Copyright (C) 2020 Facebook
+
+from os import stat
+import argparse
+import sys
+
+from drgn.helpers.linux import list_for_each_entry, list_empty
+from drgn.helpers.linux import for_each_page
+from drgn.helpers.linux.cpumask import for_each_online_cpu
+from drgn.helpers.linux.percpu import per_cpu_ptr
+from drgn import container_of, FaultError, Object
+
+
+DESC =3D """
+This is a drgn script to provide slab statistics for memory cgroups.
+It supports cgroup v2 and v1 and can emulate memory.kmem.slabinfo
+interface of cgroup v1.
+For drgn, visit https://github.com/osandov/drgn.
+"""
+
+
+MEMCGS =3D {}
+
+OO_SHIFT =3D 16
+OO_MASK =3D ((1 << OO_SHIFT) - 1)
+
+
+def err(s):
+    print('slabinfo.py: error: %s' % s, file=3Dsys.stderr, flush=3DTrue)
+    sys.exit(1)
+
+
+def find_memcg_ids(css=3Dprog['root_mem_cgroup'].css, prefix=3D''):
+    if not list_empty(css.children.address_of_()):
+        for css in list_for_each_entry('struct cgroup_subsys_state',
+                                       css.children.address_of_(),
+                                       'sibling'):
+            name =3D prefix + '/' + css.cgroup.kn.name.string_().decode(=
'utf-8')
+            memcg =3D container_of(css, 'struct mem_cgroup', 'css')
+            MEMCGS[css.cgroup.kn.id.value_()] =3D memcg
+            find_memcg_ids(css, name)
+
+
+def is_root_cache(s):
+    try:
+        return False if s.memcg_params.root_cache else True
+    except AttributeError:
+        return True
+
+
+def cache_name(s):
+    if is_root_cache(s):
+        return s.name.string_().decode('utf-8')
+    else:
+        return s.memcg_params.root_cache.name.string_().decode('utf-8')
+
+
+# SLUB
+
+def oo_order(s):
+    return s.oo.x >> OO_SHIFT
+
+
+def oo_objects(s):
+    return s.oo.x & OO_MASK
+
+
+def count_partial(n, fn):
+    nr_pages =3D 0
+    for page in list_for_each_entry('struct page', n.partial.address_of_=
(),
+                                    'lru'):
+         nr_pages +=3D fn(page)
+    return nr_pages
+
+
+def count_free(page):
+    return page.objects - page.inuse
+
+
+def slub_get_slabinfo(s, cfg):
+    nr_slabs =3D 0
+    nr_objs =3D 0
+    nr_free =3D 0
+
+    for node in range(cfg['nr_nodes']):
+        n =3D s.node[node]
+        nr_slabs +=3D n.nr_slabs.counter.value_()
+        nr_objs +=3D n.total_objects.counter.value_()
+        nr_free +=3D count_partial(n, count_free)
+
+    return {'active_objs': nr_objs - nr_free,
+            'num_objs': nr_objs,
+            'active_slabs': nr_slabs,
+            'num_slabs': nr_slabs,
+            'objects_per_slab': oo_objects(s),
+            'cache_order': oo_order(s),
+            'limit': 0,
+            'batchcount': 0,
+            'shared': 0,
+            'shared_avail': 0}
+
+
+def cache_show(s, cfg, objs):
+    if cfg['allocator'] =3D=3D 'SLUB':
+        sinfo =3D slub_get_slabinfo(s, cfg)
+    else:
+        err('SLAB isn\'t supported yet')
+
+    if cfg['shared_slab_pages']:
+        sinfo['active_objs'] =3D objs
+        sinfo['num_objs'] =3D objs
+
+    print('%-17s %6lu %6lu %6u %4u %4d'
+          ' : tunables %4u %4u %4u'
+          ' : slabdata %6lu %6lu %6lu' % (
+              cache_name(s), sinfo['active_objs'], sinfo['num_objs'],
+              s.size, sinfo['objects_per_slab'], 1 << sinfo['cache_order=
'],
+              sinfo['limit'], sinfo['batchcount'], sinfo['shared'],
+              sinfo['active_slabs'], sinfo['num_slabs'],
+              sinfo['shared_avail']))
+
+
+def detect_kernel_config():
+    cfg =3D {}
+
+    cfg['nr_nodes'] =3D prog['nr_online_nodes'].value_()
+
+    if prog.type('struct kmem_cache').members[1][1] =3D=3D 'flags':
+        cfg['allocator'] =3D 'SLUB'
+    elif prog.type('struct kmem_cache').members[1][1] =3D=3D 'batchcount=
':
+        cfg['allocator'] =3D 'SLAB'
+    else:
+        err('Can\'t determine the slab allocator')
+
+    cfg['shared_slab_pages'] =3D False
+    try:
+        if prog.type('struct obj_cgroup'):
+            cfg['shared_slab_pages'] =3D True
+    except:
+        pass
+
+    return cfg
+
+
+def for_each_slab_page(prog):
+    PGSlab =3D 1 << prog.constant('PG_slab')
+    PGHead =3D 1 << prog.constant('PG_head')
+
+    for page in for_each_page(prog):
+        try:
+            if page.flags.value_() & PGSlab:
+                yield page
+        except FaultError:
+            pass
+
+
+def main():
+    parser =3D argparse.ArgumentParser(description=3DDESC,
+                                     formatter_class=3D
+                                     argparse.RawTextHelpFormatter)
+    parser.add_argument('cgroup', metavar=3D'CGROUP',
+                        help=3D'Target memory cgroup')
+    args =3D parser.parse_args()
+
+    try:
+        cgroup_id =3D stat(args.cgroup).st_ino
+        find_memcg_ids()
+        memcg =3D MEMCGS[cgroup_id]
+    except KeyError:
+        err('Can\'t find the memory cgroup')
+
+    cfg =3D detect_kernel_config()
+
+    print('# name            <active_objs> <num_objs> <objsize> <objpers=
lab> <pagesperslab>'
+          ' : tunables <limit> <batchcount> <sharedfactor>'
+          ' : slabdata <active_slabs> <num_slabs> <sharedavail>')
+
+    if cfg['shared_slab_pages']:
+        obj_cgroups =3D set()
+        stats =3D {}
+        caches =3D {}
+
+        # find memcg pointers belonging to the specified cgroup
+        obj_cgroups.add(memcg.objcg.value_())
+        for ptr in list_for_each_entry('struct obj_cgroup',
+                                       memcg.objcg_list.address_of_(),
+                                       'list'):
+            obj_cgroups.add(ptr.value_())
+
+        # look over all slab pages, belonging to non-root memcgs
+        # and look for objects belonging to the given memory cgroup
+        for page in for_each_slab_page(prog):
+            objcg_vec_raw =3D page.obj_cgroups.value_()
+            if objcg_vec_raw =3D=3D 0:
+                continue
+            cache =3D page.slab_cache
+            if not cache:
+                continue
+            addr =3D cache.value_()
+            caches[addr] =3D cache
+            # clear the lowest bit to get the true obj_cgroups
+            objcg_vec =3D Object(prog, page.obj_cgroups.type_,
+                               value=3Dobjcg_vec_raw & ~1)
+
+            if addr not in stats:
+                stats[addr] =3D 0
+
+            for i in range(oo_objects(cache)):
+                if objcg_vec[i].value_() in obj_cgroups:
+                    stats[addr] +=3D 1
+
+        for addr in caches:
+            if stats[addr] > 0:
+                cache_show(caches[addr], cfg, stats[addr])
+
+    else:
+        for s in list_for_each_entry('struct kmem_cache',
+                                     memcg.kmem_caches.address_of_(),
+                                     'memcg_params.kmem_caches_node'):
+            cache_show(s, cfg, None)
+
+
+main()
--=20
2.25.3

