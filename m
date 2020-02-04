Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493F1C35253
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 04:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2E492084E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 04:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="dOfUo7rU";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="IfnZzLjw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbgBDEgJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 23:36:09 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:16720 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727063AbgBDEgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 23:36:08 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0144ZRWj012590;
        Mon, 3 Feb 2020 20:35:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=1XSG7voW98PlR21Thp3S4MKG+fl91C5FWPQQUYJipng=;
 b=dOfUo7rUIXalkkxhknNW+nl1rf8V9v3qYp+u1yNUA19uIK8a/UdoTcr+voLi9rLzYwWm
 GQr6iOTErpQ2ty8arSjqV+s+OPWoIV5gnrTZBNpfoUhUprv4wHpQNrcuDw+xcMXWvfXw
 kz+Yb7qCFxkwGUAwgP3EgNwFV+0xAhAmSRU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2xwsy0r3t6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 03 Feb 2020 20:35:56 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 3 Feb 2020 20:35:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f8QJo9nhEZHpPjZonNyoFtPT0wL6IAl8F9vGbBke3Idm4iYxJvODmjCHgJOYlYoeNjSmNjNP+LKhhkLz3kBvuJQipxtqMx/k2fjfe3WTyQxry265avcBimOUqVK+s4yRMsZrK4DJput5E9dC3/WWVU/X3Ywb7n7av+rCViTfnlWO2vRSVhWA96SHfpLvgOd5VvhTc7J1Et/s1EIwL0GbHkRXhWI1a1hBzUX3zGuQg02fo/u3TAgLo3zXyxzj6NLMnThNN8BNb7UnzuyG7ql1OBtl7dDWhJS/hLGrJNFCsCXPxwCQdrKl7go7zerN9t9KYb4hxEhumkk0BTrALs1UWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1XSG7voW98PlR21Thp3S4MKG+fl91C5FWPQQUYJipng=;
 b=kW346n0fM1HPEI6iL/kWLuynzSpMF+UMmfrUTtSUSHs2jerHGr0PbkiTWTpZnC/ntpeFCDiAA6b5j8/B/CDIo2K7GhOGn+t32Xsu7DOlIf9lHpZWcoJszTjQVhlw80MvEFlXifDMhdCvk9ujoAcFMjqTUNiP4z5ckPb7KOGSsXYezd9OOjbwWt+lPYGRMzgiplcWcvZAqNksdo2n6PT0O3MoAkPqmyCr5ZC4oXCkm7ksYiPLkoGzFWVyt8lIwQtSbzqhw5Cp7UI1A19SuM+/41alqmQ116S5NGh1WDmvZ/6Wu8sBs3/nUW4gddTFv9aPdBv9uQQJbAhAgIzDFYkxlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1XSG7voW98PlR21Thp3S4MKG+fl91C5FWPQQUYJipng=;
 b=IfnZzLjwDMhFTxcK5qNSBCEjGOa01EZ2CWmAmbaqF72s2ixhVzS/AoPRQ4VMDQ0FiewKA+STFFgUD9Ne+5APRMrgN1ZqI7h0IUQBrnCDFAraMwN3c0vJgqTbcKdJKoqoaCCYCsST4VGXqllQK7Ky7JUILelerk73OMKy9VeMeKQ=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.155.147) by
 BYAPR15MB3160.namprd15.prod.outlook.com (20.179.59.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Tue, 4 Feb 2020 04:35:49 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ccb6:a331:77d8:d308]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::ccb6:a331:77d8:d308%7]) with mapi id 15.20.2686.031; Tue, 4 Feb 2020
 04:35:49 +0000
Date:   Mon, 3 Feb 2020 20:35:41 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH v2 21/28] mm: memcg/slab: use a single set of kmem_caches
 for all memory cgroups
Message-ID: <20200204043541.GA12194@xps.dhcp.thefacebook.com>
References: <20200127173453.2089565-1-guro@fb.com>
 <20200127173453.2089565-22-guro@fb.com>
 <20200203195048.GA4396@cmpxchg.org>
 <20200203205834.GA6781@xps.dhcp.thefacebook.com>
 <20200203221734.GA7345@cmpxchg.org>
 <20200204011505.GA9138@xps.dhcp.thefacebook.com>
 <20200204024704.GA9027@cmpxchg.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200204024704.GA9027@cmpxchg.org>
X-ClientProxiedBy: MN2PR05CA0058.namprd05.prod.outlook.com
 (2603:10b6:208:236::27) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:150::19)
MIME-Version: 1.0
Received: from xps.dhcp.thefacebook.com (2620:10d:c091:480::f73a) by MN2PR05CA0058.namprd05.prod.outlook.com (2603:10b6:208:236::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.12 via Frontend Transport; Tue, 4 Feb 2020 04:35:46 +0000
X-Originating-IP: [2620:10d:c091:480::f73a]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ffe606f-4336-485c-0da9-08d7a92bb519
X-MS-TrafficTypeDiagnostic: BYAPR15MB3160:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB31608E07DE27ADE9D3FF8770BE030@BYAPR15MB3160.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 03030B9493
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(396003)(39860400002)(366004)(199004)(189003)(30864003)(186003)(16526019)(1076003)(86362001)(5660300002)(81166006)(81156014)(8676002)(8936002)(6916009)(54906003)(9686003)(316002)(66476007)(66556008)(66946007)(4326008)(33656002)(6506007)(55016002)(52116002)(2906002)(7696005)(6666004)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3160;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3actx5CpNg3w7gu2uwJhbc9aiGt7pOUpzThea6FasfPzymex/dqfWEcIrXOPUkelPHNku4n5KnKmyjhXmI2m63e1pSdH+3/Z8DaqIGKL/snl37+UKXF9RsVRHF7i2ow1jtns63rjm3UqKv1BTrdFOxbar57wD966YvijNe6XLr8aKEp/Mc+/qgGNl2vYD2WS/CPEnM4eImcKgL7QIeAh/3Y9MJLhA1zKsbIZzPus/HFMptUbHHHMNdYLqtZRben+IWMK/U6AUQ9cO0SwKuNThv1hBErvLtAxINnK2f+JPCPcFUliJAhQWrOb+dxo5K7ZulO4OTj93etYSERas/UiYl0hx+nNJDg7toMoA+kawr6Np1sLqsIKTCA2VIl8q4dNYAGH9WcaJut9RGXQKwiS7F1xaJEPiAdKEF34NHb1x3xxdI6WNOt21LWXCzlPQSQA
X-MS-Exchange-AntiSpam-MessageData: Ji3nkW3iyir46E3yXb3nat8vzlyhEKfp0VDx2YdwKPrGUlSuUpOY7tqJSXHg3mXaSGBgqA7tvzR48kw0e02QT/FGqgJRFDlA2oQ0tUcCAJqMqz2flwQzgCnA/RpFKbO9LR540KcPe28KjsniZ9TVu+gLc25ukKXPYwHMwqx3/qY=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ffe606f-4336-485c-0da9-08d7a92bb519
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2020 04:35:48.9017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WntGlgv3EUnzWXIToHcavcq4EnwVpD93XKNhp+c9qRn33r9esjdJHat6Z1qCyPoi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3160
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-04_01:2020-02-04,2020-02-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=5
 adultscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1911200001 definitions=main-2002040034
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 03, 2020 at 09:47:04PM -0500, Johannes Weiner wrote:
> On Mon, Feb 03, 2020 at 05:15:05PM -0800, Roman Gushchin wrote:
> > On Mon, Feb 03, 2020 at 05:17:34PM -0500, Johannes Weiner wrote:
> > > On Mon, Feb 03, 2020 at 12:58:34PM -0800, Roman Gushchin wrote:
> > > > On Mon, Feb 03, 2020 at 02:50:48PM -0500, Johannes Weiner wrote:
> > > > > On Mon, Jan 27, 2020 at 09:34:46AM -0800, Roman Gushchin wrote:
> > > > > > This is fairly big but mostly red patch, which makes all non-root
> > > > > > slab allocations use a single set of kmem_caches instead of
> > > > > > creating a separate set for each memory cgroup.
> > > > > > 
> > > > > > Because the number of non-root kmem_caches is now capped by the number
> > > > > > of root kmem_caches, there is no need to shrink or destroy them
> > > > > > prematurely. They can be perfectly destroyed together with their
> > > > > > root counterparts. This allows to dramatically simplify the
> > > > > > management of non-root kmem_caches and delete a ton of code.
> > > > > 
> > > > > This is definitely going in the right direction. But it doesn't quite
> > > > > explain why we still need two sets of kmem_caches?
> > > > > 
> > > > > In the old scheme, we had completely separate per-cgroup caches with
> > > > > separate slab pages. If a cgrouped process wanted to allocate a slab
> > > > > object, we'd go to the root cache and used the cgroup id to look up
> > > > > the right cgroup cache. On slab free we'd use page->slab_cache.
> > > > > 
> > > > > Now we have slab pages that have a page->objcg array. Why can't all
> > > > > allocations go through a single set of kmem caches? If an allocation
> > > > > is coming from a cgroup and the slab page the allocator wants to use
> > > > > doesn't have an objcg array yet, we can allocate it on the fly, no?
> > > > 
> > > > Well, arguably it can be done, but there are few drawbacks:
> > > > 
> > > > 1) On the release path you'll need to make some extra work even for
> > > >    root allocations: calculate the offset only to find the NULL objcg pointer.
> > > > 
> > > > 2) There will be a memory overhead for root allocations
> > > >    (which might or might not be compensated by the increase
> > > >    of the slab utilization).
> > > 
> > > Those two are only true if there is a wild mix of root and cgroup
> > > allocations inside the same slab, and that doesn't really happen in
> > > practice. Either the machine is dedicated to one workload and cgroups
> > > are only enabled due to e.g. a vendor kernel, or you have cgrouped
> > > systems (like most distro systems now) that cgroup everything.
> > 
> > It's actually a questionable statement: we do skip allocations from certain
> > contexts, and we do merge slab caches.
> > 
> > Most likely it's true for certain slab_caches and not true for others.
> > Think of kmalloc-* caches.
> 
> With merging it's actually really hard to say how sparse or dense the
> resulting objcgroup arrays would be. It could change all the time too.

So here is some actual data from my dev machine. The first column is the number
of pages in the root cache, the second - in the corresponding memcg.

   ext4_groupinfo_4k          1          0
     rpc_inode_cache          1          0
        fuse_request         62          0
          fuse_inode          1       2732
  btrfs_delayed_node       1192          0
btrfs_ordered_extent        129          0
    btrfs_extent_map       8686          0
 btrfs_extent_buffer       2648          0
         btrfs_inode         12       6739
              PINGv6          1         11
               RAWv6          2          5
               UDPv6          1         34
       tw_sock_TCPv6        378          3
  request_sock_TCPv6         24          0
               TCPv6         46         74
  mqueue_inode_cache          1          0
 jbd2_journal_handle          2          0
   jbd2_journal_head          2          0
 jbd2_revoke_table_s          1          0
    ext4_inode_cache          1          3
ext4_allocation_context          1          0
         ext4_io_end          1          0
  ext4_extent_status          5          0
             mbcache          1          0
      dnotify_struct          1          0
  posix_timers_cache         24          0
      xfrm_dst_cache        202          0
                 RAW          3         12
                 UDP          2         24
         tw_sock_TCP         25          0
    request_sock_TCP         24          0
                 TCP          7         24
hugetlbfs_inode_cache          2          0
               dquot          2          0
       eventpoll_pwq          1        119
           dax_cache          1          0
       request_queue          9          0
          blkdev_ioc        241          0
          biovec-max        112          0
          biovec-128          2          0
           biovec-64          6          0
  khugepaged_mm_slot        248          0
 dmaengine-unmap-256          1          0
 dmaengine-unmap-128          1          0
  dmaengine-unmap-16         39          0
    sock_inode_cache          9        219
    skbuff_ext_cache        249          0
 skbuff_fclone_cache         83          0
   skbuff_head_cache        138        141
     file_lock_cache         24          0
       net_namespace          1          5
   shmem_inode_cache         14         56
     task_delay_info         23        165
           taskstats         24          0
      proc_dir_entry         24          0
          pde_opener         16         24
    proc_inode_cache         24       1103
          bdev_cache          4         20
   kernfs_node_cache       1405          0
           mnt_cache         54          0
                filp         53        460
         inode_cache        488       2287
              dentry        367      10576
         names_cache         24          0
        ebitmap_node          2          0
     avc_xperms_data        256          0
      lsm_file_cache         92          0
         buffer_head         24          9
       uts_namespace          1          3
      vm_area_struct         48        810
           mm_struct         19         29
         files_cache         14         26
        signal_cache         28        143
       sighand_cache         45         47
         task_struct         77        430
            cred_jar         29        424
      anon_vma_chain         39        492
            anon_vma         28        467
                 pid         30        369
        Acpi-Operand         56          0
          Acpi-Parse       5587          0
          Acpi-State       4137          0
      Acpi-Namespace          8          0
         numa_policy        137          0
  ftrace_event_field         68          0
      pool_workqueue         25          0
     radix_tree_node       1694       7776
          task_group         21          0
           vmap_area        477          0
     kmalloc-rcl-512        473          0
     kmalloc-rcl-256        605          0
     kmalloc-rcl-192         43         16
     kmalloc-rcl-128          1         47
      kmalloc-rcl-96          3        229
      kmalloc-rcl-64          6        611
          kmalloc-8k         48         24
          kmalloc-4k        372         59
          kmalloc-2k        132         50
          kmalloc-1k        251         82
         kmalloc-512        360        150
         kmalloc-256        237          0
         kmalloc-192        298         24
         kmalloc-128        203         24
          kmalloc-96        112         24
          kmalloc-64        796         24
          kmalloc-32       1188         26
          kmalloc-16        555         25
           kmalloc-8         42         24
     kmem_cache_node         20          0
          kmem_cache         24          0

> 
> > Also, because obj_cgroup vectors will not be freed without underlying pages,
> > most likely the percentage of pages with obj_cgroups will grow with uptime.
> > In other words, memcg allocations will fragment root slab pages.
> 
> I understand the first part of this paragraph, but not the second. The
> objcgroup vectors will be freed when the slab pages get freed. But the
> partially filled slab pages can be reused by any types of allocations,
> surely? How would this cause the pages to fragment?

I mean the following: once you allocate a single accounted object
from the page, obj_cgroup vector is allocated and will be released only
with the slab page. We really really don't want to count how many accounted
objects are on the page and release obj_cgroup vector on reaching 0.
So even if all following allocations are root allocations, the overhead
will not go away with the uptime.

In other words, even a small percentage of accounted objects will
turn the whole cache into "accountable".

> 
> > > > 3) I'm working on percpu memory accounting that resembles the same scheme,
> > > >    except that obj_cgroups vector is created for the whole percpu block.
> > > >    There will be root- and memcg-blocks, and it will be expensive to merge them.
> > > >    I kinda like using the same scheme here and there.
> > > 
> > > It's hard to conclude anything based on this information alone. If
> > > it's truly expensive to merge them, then it warrants the additional
> > > complexity. But I don't understand the desire to share a design for
> > > two systems with sufficiently different constraints.
> > > 
> > > > Upsides?
> > > > 
> > > > 1) slab utilization might increase a little bit (but I doubt it will have
> > > >    a huge effect, because both merging sets should be relatively big and well
> > > >    utilized)
> > > 
> > > Right.
> > > 
> > > > 2) eliminate memcg kmem_cache dynamic creation/destruction. it's nice,
> > > >    but there isn't so much code left anyway.
> > > 
> > > There is a lot of complexity associated with the cache cloning that
> > > isn't the lines of code, but the lifetime and synchronization rules.
> > 
> > Quite opposite: the patchset removes all the complexity (or 90% of it),
> > because it makes the kmem_cache lifetime independent from any cgroup stuff.
> > 
> > Kmem_caches are created on demand on the first request (most likely during
> > the system start-up), and destroyed together with their root counterparts
> > (most likely never or on rmmod). First request means globally first request,
> > not a first request from a given memcg.
> > 
> > Memcg kmem_cache lifecycle has nothing to do with memory/obj_cgroups, and
> > after creation just matches the lifetime of the root kmem caches.
> > 
> > The only reason to keep the async creation is that some kmem_caches
> > are created very early in the boot process, long before any cgroup
> > stuff is initialized.
> 
> Yes, it's independent of the obj_cgroup and memcg, and yes it's
> simpler after your patches. But I'm not talking about the delta, I'm
> trying to understand the end result.
> 
> And the truth is there is a decent chunk of code and tentacles spread
> throughout the slab/cgroup code to clone, destroy, and handle the
> split caches, as well as the branches/indirections on every cgrouped
> slab allocation.

Did you see the final code? It's fairly simple and there is really not
much of complexity left. If you don't think so, let's go into details,
because otherwise it's hard to say anything.

With a such change which basically removes the current implementation
and replaces it with a new one, it's hard to keep the balance between
making commits self-contained and small, but also showing the whole picture.
I'm fully open to questions and generally want to make it simpler.

I've tried to separate some parts and get them merged before the main
thing, but they haven't been merged yet, so I have to include them
to keep the thing building.

Will a more-detailed design in the cover help?
Will writing a design doc to put into Documentation/ help?
Is it better to rearrange patches in a way to eliminate the current
implementation first and build from scratch?

> 
> Yet there is no good explanation for why things are done this way
> anywhere in the changelog, the cover letter, or the code. And it's
> hard to get a satisfying answer even to direct questions about it.

I do not agree. I try to answer all questions. But I also expect
that my arguments will be listened.
(I didn't answer questions re lifetime of obj_cgroup, but only
because I need some more time to think. If it wasn't clear, I'm sorry.).

> 
> Forget about how anything was before your patches and put yourself
> into the shoes of somebody who comes at the new code without any
> previous knowledge. "It was even worse before" just isn't a satisfying
> answer.

Absolutely agree.

But at the same time "now it's better than before" sounds like a good
validation for a change. The code is never perfect.

But, please, let's don't go into long discussions here and save some time.

> 
> > > And these two things are the primary aspects that make my head hurt
> > > trying to review this patch series.
> > > 
> > > > So IMO it's an interesting direction to explore, but not something
> > > > that necessarily has to be done in the context of this patchset.
> > > 
> > > I disagree. Instead of replacing the old coherent model and its
> > > complexities with a new coherent one, you are mixing the two. And I
> > > can barely understand the end result.
> > > 
> > > Dynamically cloning entire slab caches for the sole purpose of telling
> > > whether the pages have an obj_cgroup array or not is *completely
> > > insane*. If the controller had followed the obj_cgroup design from the
> > > start, nobody would have ever thought about doing it like this.
> > 
> > It's just not true. The whole point of having root- and memcg sets is
> > to be able to not look for a NULL pointer in the obj_cgroup vector on
> > releasing of the root object. In other words, it allows to keep zero
> > overhead for root allocations. IMHO it's an important thing, and calling
> > it *completely insane* isn't the best way to communicate.
> 
> But you're trading it for the indirection of going through a separate
> kmem_cache for every single cgroup-accounted allocation. Why is this a
> preferable trade-off to make?

Because it allows to keep zero memory and cpu overhead for root allocations.
I've no data showing that this overhead is small and acceptable in all cases.
I think keeping zero overhead for root allocations is more important
than having a single set of kmem caches.

> 
> I'm asking basic questions about your design choices. It's not okay to
> dismiss this with "it's an interesting direction to explore outside
> the context this patchset".

I'm not dismissing any questions.
There is a difference between a question and a must-to-follow suggestion,
which has known and ignored trade-offs.

> 
> > > From a maintainability POV, we cannot afford merging it in this form.
> > 
> > It sounds strange: the patchset eliminates 90% of the complexity,
> > but it's unmergeable because there are 10% left.
> 
> No, it's unmergeable if you're unwilling to explain and document your
> design choices when somebody who is taking the time and effort to look
> at your patches doesn't understand why things are the way they are.

I'm not unwilling to explain. Otherwise I just wouldn't post it upstream,
right? And I assume you're spending your time reviewing it not with the goal
to keep the current code intact.

Please, let's keep separate things which are hard to understand and
require an explanation and things which you think are better done differently.

Both are valid and appreciated comments, but mixing them isn't productive.

> 
> We are talking about 1500 lines of complicated core kernel code. They
> *have* to make sense to people other than you if we want to have this
> upstream.

Right.

> 
> > I agree that it's an arguable question if we can tolerate some
> > additional overhead on root allocations to eliminate these additional
> > 10%, but I really don't think it's so obvious that even discussing
> > it is insane.
> 
> Well that's exactly my point.

Ok, what's the acceptable performance penalty?
Is adding 20% on free path is acceptable, for example?
Or adding 3% of slab memory?

> 
> > Btw, there is another good idea to explore (also suggested by Christopher
> > Lameter): we can put memcg/objcg pointer into the slab page, avoiding
> > an extra allocation.
> 
> I agree with this idea, but I do think that's a bit more obviously in
> optimization territory. The objcg is much larger than a pointer to it,
> and it wouldn't significantly change the alloc/free sequence, right?

So the idea is that putting the obj_cgroup pointer nearby will eliminate
some cache misses. But then it's preferable to have two sets, because otherwise
there is a memory overhead from allocating an extra space for the objcg pointer.


Stepping a bit back: the new scheme (new slab controller) adds some cpu operations
on the allocation and release paths. It's unavoidable: more precise
accounting requires more CPU. But IMO it's worth it because it leads
to significant memory savings and reduced memory fragmentation.
Also it reduces the code complexity (which is a bonus but not the primary goal).

I haven't seen so far any workloads where the difference was noticeable,
but it doesn't mean they do not exist. That's why I'm very concerned about
any suggestions which might even in theory increase the cpu overhead.
Keeping it at zero level for root allocations allows do exclude
something from the accounting if the performance penalty is not tolerable.

Thanks!
