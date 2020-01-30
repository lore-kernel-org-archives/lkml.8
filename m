Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE971C33CB2
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 02:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F11C206F0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 02:06:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgA3CGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 21:06:39 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:1882 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726632AbgA3CGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 21:06:39 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00U1xCOO011991
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 21:06:37 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xtfh1dn6x-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 21:06:37 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <bharata@linux.ibm.com>;
        Thu, 30 Jan 2020 02:06:35 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 30 Jan 2020 02:06:32 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00U25dMs47972700
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jan 2020 02:05:39 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F4F04C04E;
        Thu, 30 Jan 2020 02:06:31 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EDD544C040;
        Thu, 30 Jan 2020 02:06:28 +0000 (GMT)
Received: from in.ibm.com (unknown [9.199.51.93])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 30 Jan 2020 02:06:28 +0000 (GMT)
Date:   Thu, 30 Jan 2020 07:36:26 +0530
From:   Bharata B Rao <bharata@linux.ibm.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH v2 00/28] The new cgroup slab memory controller
Reply-To: bharata@linux.ibm.com
References: <20200127173453.2089565-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200127173453.2089565-1-guro@fb.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-TM-AS-GCONF: 00
x-cbid: 20013002-0028-0000-0000-000003D5A2F8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20013002-0029-0000-0000-00002499EFF2
Message-Id: <20200130020626.GA21973@in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-29_08:2020-01-28,2020-01-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=2 mlxlogscore=999 bulkscore=0
 malwarescore=0 spamscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2001300011
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2020 at 09:34:25AM -0800, Roman Gushchin wrote:
> The existing cgroup slab memory controller is based on the idea of
> replicating slab allocator internals for each memory cgroup.
> This approach promises a low memory overhead (one pointer per page),
> and isn't adding too much code on hot allocation and release paths.
> But is has a very serious flaw: it leads to a low slab utilization.
> 
> Using a drgn* script I've got an estimation of slab utilization on
> a number of machines running different production workloads. In most
> cases it was between 45% and 65%, and the best number I've seen was
> around 85%. Turning kmem accounting off brings it to high 90s. Also
> it brings back 30-50% of slab memory. It means that the real price
> of the existing slab memory controller is way bigger than a pointer
> per page.
> 
> The real reason why the existing design leads to a low slab utilization
> is simple: slab pages are used exclusively by one memory cgroup.
> If there are only few allocations of certain size made by a cgroup,
> or if some active objects (e.g. dentries) are left after the cgroup is
> deleted, or the cgroup contains a single-threaded application which is
> barely allocating any kernel objects, but does it every time on a new CPU:
> in all these cases the resulting slab utilization is very low.
> If kmem accounting is off, the kernel is able to use free space
> on slab pages for other allocations.
> 
> Arguably it wasn't an issue back to days when the kmem controller was
> introduced and was an opt-in feature, which had to be turned on
> individually for each memory cgroup. But now it's turned on by default
> on both cgroup v1 and v2. And modern systemd-based systems tend to
> create a large number of cgroups.
> 
> This patchset provides a new implementation of the slab memory controller,
> which aims to reach a much better slab utilization by sharing slab pages
> between multiple memory cgroups. Below is the short description of the new
> design (more details in commit messages).
> 
> Accounting is performed per-object instead of per-page. Slab-related
> vmstat counters are converted to bytes. Charging is performed on page-basis,
> with rounding up and remembering leftovers.
> 
> Memcg ownership data is stored in a per-slab-page vector: for each slab page
> a vector of corresponding size is allocated. To keep slab memory reparenting
> working, instead of saving a pointer to the memory cgroup directly an
> intermediate object is used. It's simply a pointer to a memcg (which can be
> easily changed to the parent) with a built-in reference counter. This scheme
> allows to reparent all allocated objects without walking them over and
> changing memcg pointer to the parent.
> 
> Instead of creating an individual set of kmem_caches for each memory cgroup,
> two global sets are used: the root set for non-accounted and root-cgroup
> allocations and the second set for all other allocations. This allows to
> simplify the lifetime management of individual kmem_caches: they are
> destroyed with root counterparts. It allows to remove a good amount of code
> and make things generally simpler.
> 
> The patchset* has been tested on a number of different workloads in our
> production. In all cases it saved significant amount of memory, measured
> from high hundreds of MBs to single GBs per host. On average, the size
> of slab memory has been reduced by 35-45%.

Here are some numbers from multiple runs of sysbench and kernel compilation
with this patchset on a 10 core POWER8 host:

==========================================================================
Peak usage of memory.kmem.usage_in_bytes, memory.usage_in_bytes and
meminfo:Slab for Sysbench oltp_read_write with mysqld running as part
of a mem cgroup (Sampling every 5s)
--------------------------------------------------------------------------
				5.5.0-rc7-mm1	+slab patch	%reduction
--------------------------------------------------------------------------
memory.kmem.usage_in_bytes	15859712	4456448		72
memory.usage_in_bytes		337510400	335806464	.5
Slab: (kB)			814336		607296		25

memory.kmem.usage_in_bytes	16187392	4653056		71
memory.usage_in_bytes		318832640	300154880	5
Slab: (kB)			789888		559744		29
--------------------------------------------------------------------------


Peak usage of memory.kmem.usage_in_bytes, memory.usage_in_bytes and
meminfo:Slab for kernel compilation (make -s -j64) Compilation was
done from bash that is in a memory cgroup. (Sampling every 5s)
--------------------------------------------------------------------------
				5.5.0-rc7-mm1	+slab patch	%reduction
--------------------------------------------------------------------------
memory.kmem.usage_in_bytes	338493440	231931904	31
memory.usage_in_bytes		7368015872	6275923968	15
Slab: (kB)			1139072		785408		31

memory.kmem.usage_in_bytes	341835776	236453888	30
memory.usage_in_bytes		6540427264	6072893440	7
Slab: (kB)			1074304		761280		29

memory.kmem.usage_in_bytes	340525056	233570304	31
memory.usage_in_bytes		6406209536	6177357824	3
Slab: (kB)			1244288		739712		40
--------------------------------------------------------------------------

Slab consumption right after boot
--------------------------------------------------------------------------
				5.5.0-rc7-mm1	+slab patch	%reduction
--------------------------------------------------------------------------
Slab: (kB)			821888		583424		29
==========================================================================

Summary:

With sysbench and kernel compilation,  memory.kmem.usage_in_bytes shows
around 70% and 30% reduction consistently.

Didn't see consistent reduction of memory.usage_in_bytes with sysbench and
kernel compilation.

Slab usage (from /proc/meminfo) shows consistent 30% reduction and the
same is seen right after boot too.

Regards,
Bharata.

