Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C33FFC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 22:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 757E320CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 22:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="D1uXUcUf";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="GwvwtAGf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgAaWZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 17:25:46 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:34978 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726163AbgAaWZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 17:25:46 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00VMPJGY017917;
        Fri, 31 Jan 2020 14:25:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=NqNEdQ6WigNKK1KKvNBi5jlI6EkqIaG5kobixxuqeQY=;
 b=D1uXUcUfombMtzp0o/AMKILaJJW+UXx1KiDFWbMGA/yn+x3aGq+ejaxYPYY/9BrthT8O
 w1FRY15Pvshm7P4F+M4NnTq3e7IxhKk/0/WasolBrZXW1eCLaSd6sIG9Eb7bYoqTQbeK
 MNpbQRO0bDUkRwSBU8cwxlAUOl9hfDARHQ8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2xvb44vq0e-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 31 Jan 2020 14:25:22 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 31 Jan 2020 14:25:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VnLm4ojiapjq2AzM2esqsvpFJgrWLUqvNd7AZQW3IHvWcFyU3dMwsJ6FDZr9M2Ssk7C8NWOyIkt/sm35laLBY7+MhwfZ43Fy/vf4WnWW7uLs84pocBFTV0rFJx/lGX6pnwLlyJmPhsAcfGRZ3temcErbquOOvqLm3gwENiHhTiD+N/JCRdu66ZGD/TWPS8148wVT9roQWsXp0e57BTMQ0FTfDNcEySMB6+rRS6vONqWnpEfk5NISp969rhIPMAqi2ezE9iCk7WVYwW5PF6DPX+rPuFivrQhQylt0uFFRYVMT9yp0FnpWLlLs0fqRVaBghf+cT6baXbDVjAOgEMNGCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NqNEdQ6WigNKK1KKvNBi5jlI6EkqIaG5kobixxuqeQY=;
 b=PQVH0Nu626OOw6euknzGRiedCJuzqARgFSJ+CMw59fCmfKAtH57/iZ2wM4hCMF1fnspDRM7LOQ1sGXvjkN9RHbGt6bM3NqmCCSijo3p2xcZkMi0GTMjTDo/VXNcoUTRtzo0GxZg4t7bzmcooMwzE7ZTBs7N4LmK7YCgDs1NohML7Ugg/p3MYDi72rw3IKbbNzd+GhPkVfLaAUG0Ve2T32yc45BuaX9JeNNu3kVkRWsyZdbIvJsqRSqhqvB5FoWnbZER2gH2grRis6PZmFDcFSPM7R8EvLpBbBnRBn5HQCw0+FRyjJ2z1+Ve2UnmMiK0z/yPNrAt/kJpdxcazcP4W3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NqNEdQ6WigNKK1KKvNBi5jlI6EkqIaG5kobixxuqeQY=;
 b=GwvwtAGfcSMJBSn8g7cczFRBp3TmXpbh3hCc25UWuh3u/IsL9B5dFFDpX39QVrw/fSjFmHDS0ut2h+FYQYj/TTk9fYvIWC8tjOk/mfW7RiVts8VFZjLVsyWFjn+WcB7ef4hDCQBHhXGNq/BaIpnvD/CDARlN60yiDsIyfZ2UVqQ=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.155.147) by
 BYAPR15MB2453.namprd15.prod.outlook.com (52.135.198.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.23; Fri, 31 Jan 2020 22:24:58 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ccb6:a331:77d8:d308]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ccb6:a331:77d8:d308%7]) with mapi id 15.20.2665.027; Fri, 31 Jan 2020
 22:24:58 +0000
Received: from xps (2620:10d:c090:180::bd1a) by CO2PR04CA0198.namprd04.prod.outlook.com (2603:10b6:104:5::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.29 via Frontend Transport; Fri, 31 Jan 2020 22:24:57 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Bharata B Rao <bharata@linux.ibm.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        "Johannes Weiner" <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        "Vladimir Davydov" <vdavydov.dev@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH v2 27/28] tools/cgroup: make slabinfo.py compatible with
 new slab controller
Thread-Topic: [PATCH v2 27/28] tools/cgroup: make slabinfo.py compatible with
 new slab controller
Thread-Index: AQHV1xN2UrFWuOxJRUuTpgcWmaVcKqgFXFuA
Date:   Fri, 31 Jan 2020 22:24:58 +0000
Message-ID: <20200131222346.GA20909@xps>
References: <20200127173453.2089565-1-guro@fb.com>
 <20200127173453.2089565-28-guro@fb.com> <20200130021729.GB21973@in.ibm.com>
In-Reply-To: <20200130021729.GB21973@in.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR04CA0198.namprd04.prod.outlook.com
 (2603:10b6:104:5::28) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:150::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::bd1a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 41bd29d3-e17b-4d5e-aac7-08d7a69c67aa
x-ms-traffictypediagnostic: BYAPR15MB2453:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB2453643AEE4AC5490D88282ABE070@BYAPR15MB2453.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 029976C540
x-forefront-antispam-report: SFV:NSPM;SFS:(10001)(10019020)(376002)(39860400002)(346002)(136003)(396003)(366004)(199004)(189003)(33716001)(66446008)(6916009)(4326008)(71200400001)(6496006)(52116002)(54906003)(316002)(33656002)(1076003)(478600001)(966005)(53546011)(81166006)(8676002)(81156014)(5660300002)(9686003)(66476007)(64756008)(66556008)(66946007)(9576002)(55016002)(16526019)(2906002)(86362001)(186003)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2453;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: edpeHaObGWu4gN/oFIM1NklBOBXZaRmZ3Ht9ZuaDu6Xlow3beqxdT0VXQ0eMalXri+tDRgzFk7Rnr0S/0LJ6DSCfZD4FQoo5tG/Q+UcxNeCmmHXa/jMocCLiOWDc/E4Qw4KdMTDwisbT2vgk82TgPLxSkB827iwFTbLnX+ptJw+EpNTGztzRdvzgQNjUN1QtYD+YYPxOnzsxEygICuik0hGl04DxSGUAZCgoKJXCZpqbrTlHuqyxYrAXdKUOZUyZx3XbgZ5iq2DzeqCO74TgxgsG66+fG9TmN2OPtYQIAv9L61ebP8QH7pzSzSsBEOU4gmjmkYDjpfGmW9+2FPCI7UkZErHjgjs81/642CYhcb60RbG+8dYNlrtra//3ojEJ/cOtd3X3AuLV/K7nF88yjqasb/K8YObl6JlTA5h2bn+PGzSVk9I2uVvK5b6pnB6zGyUFTM7b+TRLdzTmdEeu0jiiYu//LT10pSe1kLzCUd/ZLd7Ij+UnX3n9k1RXafBtczDgfkhBOLu4ObizI6CURvFufxQva4mMl7axHSriPzhGpC2gPT4EYKkO8uENvrozVW1yaM/H/D9LCgI0+ZLxOvU2cJV/7dGHolt+yVePNcBJeMJZax6HM0xVncITa4e/
x-ms-exchange-antispam-messagedata: MQrpeQCGVnQjkg9U42IRzvQy/TgGDjXcCbvqsiCDVIlz5RFMD6ctDS2qrvfRNqOPFaUP0u3NSs+o8M8ADLT8RlBLX8jT4I9hebmGg8UvfeAgn/aqfrVY6HuV/iu/3KyI+QO1WZdM0cRwUvVdEmO+dos4a2bVjJJ6jdn2gg+NXGc=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9BE7C186EC11574EA114C8A7AA8DC8B6@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 41bd29d3-e17b-4d5e-aac7-08d7a69c67aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2020 22:24:58.3499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qqijPFfI1dDs4pLvXJ2V0A0NrgZiprCiDeMJnhIAW6BGNhUW/iK9SF0Yt3WrXG13
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2453
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-31_07:2020-01-31,2020-01-31 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 impostorscore=0 adultscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 spamscore=0 lowpriorityscore=0 clxscore=1015 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2001310178
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2020 at 07:47:29AM +0530, Bharata B Rao wrote:
> On Mon, Jan 27, 2020 at 09:34:52AM -0800, Roman Gushchin wrote:
> > Make slabinfo.py compatible with the new slab controller.
> =20
> Tried using slabinfo.py, but run into some errors. (I am using your
> new_slab.2 branch)
>=20
>  ./tools/cgroup/slabinfo.py /sys/fs/cgroup/memory/1
> Traceback (most recent call last):
>   File "/usr/local/bin/drgn", line 11, in <module>
>     sys.exit(main())
>   File "/usr/local/lib/python3.6/dist-packages/drgn/internal/cli.py", lin=
e 127, in main
>     runpy.run_path(args.script[0], init_globals=3Dinit_globals, run_name=
=3D"__main__")
>   File "/usr/lib/python3.6/runpy.py", line 263, in run_path
>     pkg_name=3Dpkg_name, script_name=3Dfname)
>   File "/usr/lib/python3.6/runpy.py", line 96, in _run_module_code
>     mod_name, mod_spec, pkg_name, script_name)
>   File "/usr/lib/python3.6/runpy.py", line 85, in _run_code
>     exec(code, run_globals)
>   File "./tools/cgroup/slabinfo.py", line 220, in <module>
>     main()
>   File "./tools/cgroup/slabinfo.py", line 165, in main
>     find_memcg_ids()
>   File "./tools/cgroup/slabinfo.py", line 43, in find_memcg_ids
>     MEMCGS[css.cgroup.kn.id.ino.value_()] =3D memcg
> AttributeError: '_drgn.Object' object has no attribute 'ino'
>=20
> I did make this change...
>=20
> # git diff
> diff --git a/tools/cgroup/slabinfo.py b/tools/cgroup/slabinfo.py
> index b779a4863beb..571fd95224d6 100755
> --- a/tools/cgroup/slabinfo.py
> +++ b/tools/cgroup/slabinfo.py
> @@ -40,7 +40,7 @@ def find_memcg_ids(css=3Dprog['root_mem_cgroup'].css, p=
refix=3D''):
>                                         'sibling'):
>              name =3D prefix + '/' + css.cgroup.kn.name.string_().decode(=
'utf-8')
>              memcg =3D container_of(css, 'struct mem_cgroup', 'css')
> -            MEMCGS[css.cgroup.kn.id.ino.value_()] =3D memcg
> +            MEMCGS[css.cgroup.kn.id.value_()] =3D memcg
>              find_memcg_ids(css, name)
>=20
>=20
> but now get empty output.

Btw, I've checked that the change like you've done above fixes the problem.
The script works for me both on current upstream and new_slab.2 branch.

Are you sure that in your case there is some kernel memory charged to that
cgroup? Please note, that in the current implementation kmem_caches are cre=
ated
on demand, so the accounting is effectively enabled with some delay.

Thank you!

Below is an updated version of the patch to use:
---------------------------------------------------------------------------=
-----

From 69b8e1bf451043c41e43e769b9ae15b36092ddf9 Mon Sep 17 00:00:00 2001
From: Roman Gushchin <guro@fb.com>
Date: Tue, 15 Oct 2019 17:06:04 -0700
Subject: [PATCH v2 26/28] tools/cgroup: add slabinfo.py tool

Add a drgn-based tool to display slab information for a given memcg.
Can replace cgroup v1 memory.kmem.slabinfo interface on cgroup v2,
but in a more flexiable way.

Currently supports only SLUB configuration, but SLAB can be trivially
added later.

Output example:
$ sudo ./tools/cgroup/slabinfo.py /sys/fs/cgroup/user.slice/user-111017.sli=
ce/user\@111017.service
shmem_inode_cache     92     92    704   46    8 : tunables    0    0    0 =
: slabdata      2      2      0
eventpoll_pwq         56     56     72   56    1 : tunables    0    0    0 =
: slabdata      1      1      0
eventpoll_epi         32     32    128   32    1 : tunables    0    0    0 =
: slabdata      1      1      0
kmalloc-8              0      0      8  512    1 : tunables    0    0    0 =
: slabdata      0      0      0
kmalloc-96             0      0     96   42    1 : tunables    0    0    0 =
: slabdata      0      0      0
kmalloc-2048           0      0   2048   16    8 : tunables    0    0    0 =
: slabdata      0      0      0
kmalloc-64           128    128     64   64    1 : tunables    0    0    0 =
: slabdata      2      2      0
mm_struct            160    160   1024   32    8 : tunables    0    0    0 =
: slabdata      5      5      0
signal_cache          96     96   1024   32    8 : tunables    0    0    0 =
: slabdata      3      3      0
sighand_cache         45     45   2112   15    8 : tunables    0    0    0 =
: slabdata      3      3      0
files_cache          138    138    704   46    8 : tunables    0    0    0 =
: slabdata      3      3      0
task_delay_info      153    153     80   51    1 : tunables    0    0    0 =
: slabdata      3      3      0
task_struct           27     27   3520    9    8 : tunables    0    0    0 =
: slabdata      3      3      0
radix_tree_node       56     56    584   28    4 : tunables    0    0    0 =
: slabdata      2      2      0
btrfs_inode          140    140   1136   28    8 : tunables    0    0    0 =
: slabdata      5      5      0
kmalloc-1024          64     64   1024   32    8 : tunables    0    0    0 =
: slabdata      2      2      0
kmalloc-192           84     84    192   42    2 : tunables    0    0    0 =
: slabdata      2      2      0
inode_cache           54     54    600   27    4 : tunables    0    0    0 =
: slabdata      2      2      0
kmalloc-128            0      0    128   32    1 : tunables    0    0    0 =
: slabdata      0      0      0
kmalloc-512           32     32    512   32    4 : tunables    0    0    0 =
: slabdata      1      1      0
skbuff_head_cache     32     32    256   32    2 : tunables    0    0    0 =
: slabdata      1      1      0
sock_inode_cache      46     46    704   46    8 : tunables    0    0    0 =
: slabdata      1      1      0
cred_jar             378    378    192   42    2 : tunables    0    0    0 =
: slabdata      9      9      0
proc_inode_cache      96     96    672   24    4 : tunables    0    0    0 =
: slabdata      4      4      0
dentry               336    336    192   42    2 : tunables    0    0    0 =
: slabdata      8      8      0
filp                 697    864    256   32    2 : tunables    0    0    0 =
: slabdata     27     27      0
anon_vma             644    644     88   46    1 : tunables    0    0    0 =
: slabdata     14     14      0
pid                 1408   1408     64   64    1 : tunables    0    0    0 =
: slabdata     22     22      0
vm_area_struct      1200   1200    200   40    2 : tunables    0    0    0 =
: slabdata     30     30      0

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Waiman Long <longman@redhat.com>
Cc: Tobin C. Harding <tobin@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
---
 tools/cgroup/slabinfo.py | 158 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 158 insertions(+)
 create mode 100755 tools/cgroup/slabinfo.py

diff --git a/tools/cgroup/slabinfo.py b/tools/cgroup/slabinfo.py
new file mode 100755
index 000000000000..0dc3a1fc260c
--- /dev/null
+++ b/tools/cgroup/slabinfo.py
@@ -0,0 +1,158 @@
+#!/usr/bin/env drgn
+#
+# Copyright (C) 2019 Roman Gushchin <guro@fb.com>
+# Copyright (C) 2019 Facebook
+
+from os import stat
+import argparse
+import sys
+
+from drgn.helpers.linux import list_for_each_entry, list_empty
+from drgn import container_of
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
+            name =3D prefix + '/' + css.cgroup.kn.name.string_().decode('u=
tf-8')
+            memcg =3D container_of(css, 'struct mem_cgroup', 'css')
+            MEMCGS[css.cgroup.kn.id.value_()] =3D memcg
+            find_memcg_ids(css, name)
+
+
+def is_root_cache(s):
+    return False if s.memcg_params.root_cache else True
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
+    for page in list_for_each_entry('struct page', n.partial.address_of_()=
,
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
+def cache_show(s, cfg):
+    if cfg['allocator'] =3D=3D 'SLUB':
+        sinfo =3D slub_get_slabinfo(s, cfg)
+    else:
+        err('SLAB isn\'t supported yet')
+
+    print('%-17s %6lu %6lu %6u %4u %4d'
+          ' : tunables %4u %4u %4u'
+          ' : slabdata %6lu %6lu %6lu' % (
+              cache_name(s), sinfo['active_objs'], sinfo['num_objs'],
+              s.size, sinfo['objects_per_slab'], 1 << sinfo['cache_order']=
,
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
+    elif prog.type('struct kmem_cache').members[1][1] =3D=3D 'batchcount':
+        cfg['allocator'] =3D 'SLAB'
+    else:
+        err('Can\'t determine the slab allocator')
+
+    return cfg
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
+    print('# name            <active_objs> <num_objs> <objsize> <objpersla=
b> <pagesperslab>'
+          ' : tunables <limit> <batchcount> <sharedfactor>'
+          ' : slabdata <active_slabs> <num_slabs> <sharedavail>')
+
+    for s in list_for_each_entry('struct kmem_cache',
+                                 memcg.kmem_caches.address_of_(),
+                                 'memcg_params.kmem_caches_node'):
+        cache_show(s, cfg)
+
+
+main()
--=20
2.24.1

