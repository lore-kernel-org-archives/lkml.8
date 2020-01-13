Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E75C33CA8
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 08:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 252EA20678
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 08:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbgAMIrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 03:47:22 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53412 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727331AbgAMIrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 03:47:21 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00D8bZ9Q048729
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 03:47:20 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xfvq4v69s-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 03:47:20 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <bharata@linux.ibm.com>;
        Mon, 13 Jan 2020 08:47:18 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 13 Jan 2020 08:47:15 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00D8lEra59965574
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jan 2020 08:47:14 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B79A54203F;
        Mon, 13 Jan 2020 08:47:14 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ACD9E42041;
        Mon, 13 Jan 2020 08:47:12 +0000 (GMT)
Received: from in.ibm.com (unknown [9.109.247.53])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 13 Jan 2020 08:47:12 +0000 (GMT)
Date:   Mon, 13 Jan 2020 14:17:10 +0530
From:   Bharata B Rao <bharata@linux.ibm.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     "mhocko@kernel.org" <mhocko@kernel.org>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "shakeelb@google.com" <shakeelb@google.com>,
        "vdavydov.dev@gmail.com" <vdavydov.dev@gmail.com>,
        "longman@redhat.com" <longman@redhat.com>
Subject: Re: [PATCH 00/16] The new slab memory controller
Reply-To: bharata@linux.ibm.com
References: <20190905214553.1643060-1-guro@fb.com>
 <20191209091746.GA16989@in.ibm.com>
 <20191209115649.GA17552@in.ibm.com>
 <20191209180418.GA15797@localhost.localdomain>
 <20191210062308.GC17552@in.ibm.com>
 <20191210180516.GA23940@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210180516.GA23940@localhost.localdomain>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-TM-AS-GCONF: 00
x-cbid: 20011308-0028-0000-0000-000003D09334
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20011308-0029-0000-0000-00002494B062
Message-Id: <20200113084710.GC8458@in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-13_02:2020-01-13,2020-01-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 mlxlogscore=870
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001130073
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 06:05:20PM +0000, Roman Gushchin wrote:
> > 
> > With slab patches
> > # docker stats --no-stream
> > CONTAINER ID        NAME                CPU %               MEM USAGE / LIMIT   MEM %               NET I/O             BLOCK I/O           PIDS
> > 24bc99d94d91        sleek               0.00%               1MiB / 25MiB        4.00%               1.81kB / 0B         0B / 0B             0
> > 
> > Without slab patches
> > # docker stats --no-stream
> > CONTAINER ID        NAME                CPU %               MEM USAGE / LIMIT   MEM %               NET I/O             BLOCK I/O           PIDS
> > 52382f8aaa13        sleek               0.00%               8.688MiB / 25MiB    34.75%              1.53kB / 0B         0B / 0B             0
> > 
> > So that's an improvement of MEM USAGE from 8.688MiB to 1MiB. Note that this
> > docker container isn't doing anything useful and hence the numbers
> > aren't representative of any workload.
> 
> Cool, that's great!
> 
> Small containers is where the relative win is the biggest. Of course, it will
> decrease with the size of containers, but it's expected.
> 
> If you'll get any additional numbers, please, share them. It's really
> interesting, especially if you have larger-than-4k pages.

I run a couple of workloads contained within a memory cgroup and measured
memory.kmem.usage_in_bytes and memory.usage_in_bytes with and without
this patchset on PowerPC host. I see significant reduction in
memory.kmem.usage_in_bytes and some reduction in memory.usage_in_bytes.
Before posting the numbers, would like to get the following clarified:

In the original case, the memory cgroup is charged (including kmem charging)
when a new slab page is allocated. In your patch, the subpage charging is
done in slab_pre_alloc_hook routine. However in this case, I couldn't find
where exactly kmem counters are being charged/updated. Hence wanted to
make sure that the reduction in memory.kmem.usage_in_bytes that I am
seeing is indeed real and not because kmem accounting was missed out for
slab usage?

Also, I see all non-root allocations are coming from a single set of
kmem_caches. Guess <kmemcache_name>-memcg caches don't yet show up in
/proc/slabinfo and nor their stats is accumulated into /proc/slabinfo?

Regards,
Bharata.

