Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA34FC18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 11:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4CDB2464B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 11:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="qwG8D0Bq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbgCJL6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 07:58:38 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:1435 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbgCJL6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 07:58:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1583841516; x=1615377516;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=GLQMl8kB6L2gbGSvOLAcWQ3LR6fwEMuXM72yqr8G2dc=;
  b=qwG8D0BqgdAs7/7Tv0t5LucUgs6bWmssAQcKjx2RlDWz3sCe5XeyZXow
   Qd1DzDj5K3DmJ8fgN6ryCvOeAOajzAxrWy0p01NQxtFwHE3NGklPib9Q2
   ecFfHcSkxHUlhr+NkPcah3hPn5nFmc0RMISRlFdMc/MvHBEfkYVs9e7h7
   U=;
IronPort-SDR: 8SwpRMdNCwA8m2jRw0p2SzfsnO3apG+FVYSSBLuSMBzsa1Eu+sVvMf6ukALAhAg4ur07YmBKHr
 39/AxGiFLT+g==
X-IronPort-AV: E=Sophos;i="5.70,536,1574121600"; 
   d="scan'208";a="31704177"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1d-9ec21598.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 10 Mar 2020 11:58:32 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-9ec21598.us-east-1.amazon.com (Postfix) with ESMTPS id 36389A19B8;
        Tue, 10 Mar 2020 11:58:21 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Tue, 10 Mar 2020 11:58:21 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.16) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 10 Mar 2020 11:58:09 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     SeongJae Park <sjpark@amazon.com>, <akpm@linux-foundation.org>,
        "SeongJae Park" <sjpark@amazon.de>, <aarcange@redhat.com>,
        <yang.shi@linux.alibaba.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <brendan.d.gregg@gmail.com>, <brendanhiggins@google.com>,
        <cai@lca.pw>, <colin.king@canonical.com>, <corbet@lwn.net>,
        <dwmw@amazon.com>, <jolsa@redhat.com>, <kirill@shutemov.name>,
        <mark.rutland@arm.com>, <mgorman@suse.de>, <minchan@kernel.org>,
        <mingo@redhat.com>, <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <shuah@kernel.org>, <sj38.park@gmail.com>,
        <vbabka@suse.cz>, <vdavydov.dev@gmail.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH v6 11/14] Documentation/admin-guide/mm: Add a document for DAMON
Date:   Tue, 10 Mar 2020 12:57:55 +0100
Message-ID: <20200310115755.25270-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200310090348.000077d5@Huawei.com> (raw)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.16]
X-ClientProxiedBy: EX13D12UWC004.ant.amazon.com (10.43.162.182) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Mar 2020 09:03:48 +0000 Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Mon, 24 Feb 2020 13:30:44 +0100
> SeongJae Park <sjpark@amazon.com> wrote:
> 
> > From: SeongJae Park <sjpark@amazon.de>
> > 
> > This commit adds a simple document for DAMON under
> > `Documentation/admin-guide/mm`.
> > 
> 
> Nice document to get people started.
> 
> Certainly worked for me doing some initial playing around.

Great to hear that :)

> 
> In general this is an interesting piece of work.   I can see there are numerous
> possible avenues to explore in making the monitoring more flexible, or potentially
> better at tracking usage whilst not breaking your fundamental 'bounded overhead'
> requirement.   Will be fun perhaps to explore some of those.
> 
> I'll do some more exploring and perhaps try some real world workloads.
> 
> Thanks,
> 
> Jonathan
> 
> 
> > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> > ---
> >  .../admin-guide/mm/data_access_monitor.rst    | 414 ++++++++++++++++++
> >  Documentation/admin-guide/mm/index.rst        |   1 +
> >  2 files changed, 415 insertions(+)
> >  create mode 100644 Documentation/admin-guide/mm/data_access_monitor.rst
> > 
> > diff --git a/Documentation/admin-guide/mm/data_access_monitor.rst b/Documentation/admin-guide/mm/data_access_monitor.rst
> > new file mode 100644
> > index 000000000000..4d836c3866e2
> > --- /dev/null
> > +++ b/Documentation/admin-guide/mm/data_access_monitor.rst
> > @@ -0,0 +1,414 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +==========================
> > +DAMON: Data Access MONitor
> > +==========================
> > +
> > +Introduction
> > +============
> > +
> > +Memory management decisions can normally be more efficient if finer data access
> > +information is available.  However, because finer information usually comes
> > +with higher overhead, most systems including Linux made a tradeoff: Forgive
> > +some wise decisions and use coarse information and/or light-weight heuristics.
> 
> I'm not sure what "Forgive some wise decisions" means...

I wanted to mean that the mechanism makes no optimal decisions.  Will wordsmith
again.

> 
> > +
> > +A number of experimental data access pattern awared memory management
> > +optimizations say the sacrifices are
> > +huge (2.55x slowdown).  
> 
> Good to have a reference.

:)

> 
> > However, none of those has successfully adopted to
> 
> adopted into the 

Thanks for correcting.

> 
[...]
> > +Applying Dynamic Memory Mappings
> > +--------------------------------
> > +
> > +Only a number of small parts in the super-huge virtual address space of the
> > +processes is mapped to physical memory and accessed.  Thus, tracking the
> > +unmapped address regions is just wasteful.  However, tracking every memory
> > +mapping change might incur an overhead.  For the reason, DAMON applies the
> > +dynamic memory mapping changes to the tracking regions only for each of an
> > +user-specified time interval (``regions update interval``).
> 
> One key part of the approach is the 3 region bit.  Perhaps talk about that here
> somewhere?

I was afraid if it is too implementation detail, as this document is for admin
users.  Will add it in next spin, though.

> 
> > +
> > +
> > +``debugfs`` Interface
> > +=====================
> > +
> > +DAMON exports four files, ``attrs``, ``pids``, ``record``, and ``monitor_on``
> > +under its debugfs directory, ``<debugfs>/damon/``.
> > +
> > +Attributes
> > +----------
> > +
> > +Users can read and write the ``sampling interval``, ``aggregation interval``,
> > +``regions update interval``, and min/max number of monitoring target regions by
> > +reading from and writing to the ``attrs`` file.  For example, below commands
> > +set those values to 5 ms, 100 ms, 1,000 ms, 10, 1000 and check it again::
> > +
> > +    # cd <debugfs>/damon
> > +    # echo 5000 100000 1000000 10 1000 > attrs
> 
> I'm personally a great fan of human readable interfaces.  Could we just
> split this into one file per interval?  That way the file naming would
> make it self describing.

I was worried if it makes too many files.  Do you think it's ok?

> 
> > +    # cat attrs
> > +    5000 100000 1000000 10 1000
> > +
> > +Target PIDs
> > +-----------
> > +
> > +Users can read and write the pids of current monitoring target processes by
> > +reading from and writing to the ``pids`` file.  For example, below commands set
> > +processes having pids 42 and 4242 as the processes to be monitored and check it
> > +again::
> > +
> > +    # cd <debugfs>/damon
> > +    # echo 42 4242 > pids
> > +    # cat pids
> > +    42 4242
> > +
> > +Note that setting the pids doesn't starts the monitoring.
> > +
> > +Record
> > +------
> > +
> > +DAMON support direct monitoring result record feature.  The recorded results
> > +are first written to a buffer and flushed to a file in batch.  Users can set
> > +the size of the buffer and the path to the result file by reading from and
> > +writing to the ``record`` file.  For example, below commands set the buffer to
> > +be 4 KiB and the result to be saved in ``/damon.data``.
> > +
> > +    # cd <debugfs>/damon
> > +    # echo "4096 /damon.data" > pids
> 
> write it to record, not pids.

Ah, good eye!

> 
> > +    # cat record
> > +    4096 /damon.data
> > +
> > +Turning On/Off
> > +--------------
> > +
> > +You can check current status, start and stop the monitoring by reading from and
> > +writing to the ``monitor_on`` file.  Writing ``on`` to the file starts DAMON to
> > +monitor the target processes with the attributes.  Writing ``off`` to the file
> > +stops DAMON.  DAMON also stops if every target processes is be terminated.
> > +Below example commands turn on, off, and check status of DAMON::
> > +
> > +    # cd <debugfs>/damon
> > +    # echo on > monitor_on
> > +    # echo off > monitor_on
> > +    # cat monitor_on
> > +    off
> > +
> > +Please note that you cannot write to the ``attrs`` and ``pids`` files while the
> > +monitoring is turned on.  If you write to the files while DAMON is running,
> > +``-EINVAL`` will be returned.
> 
> Perhaps -EBUSY would be more informative?  Implies values might be fine, but
> the issue is 'not now'.

Agreed, will change so!


Thanks,
SeongJae Park

[...]
