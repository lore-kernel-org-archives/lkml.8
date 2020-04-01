Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50206C2D0F4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 08:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19856207FF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 08:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="qPPQsTnj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731741AbgDAIWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 04:22:43 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:46444 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgDAIWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 04:22:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1585729362; x=1617265362;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=J0S4DL9mCxwT+hAkweovoiwr/8l14+JA8SrvT6gRPNQ=;
  b=qPPQsTnjyDp5Mq8ISRXvB2+WOkHjEvtKmOO2RFpR7+lnD1xhGEV/zOvL
   OdrnkS5dG2ecHe2Ncswzsmo16thS9sQ9xQimQxfDZFeR31dSIXa2Y/BWf
   7NbY/m/nkTCWbDwdJlrC9idualfKm0ug4n3qbApKAxg60QWeoRLoWtWZ7
   Y=;
IronPort-SDR: s9KoWN8K5QgmRvuUHAFPWzhNO3NQk6hDfHxY0UJlBb55RZ5TdJJbJvTa9jy0J/w/eZBM2Z1Zjy
 xo8NaQYsP+9g==
X-IronPort-AV: E=Sophos;i="5.72,330,1580774400"; 
   d="scan'208";a="25060967"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-67b371d8.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 01 Apr 2020 08:22:30 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-67b371d8.us-east-1.amazon.com (Postfix) with ESMTPS id C6450A16D3;
        Wed,  1 Apr 2020 08:22:19 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 1 Apr 2020 08:22:19 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.134) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 1 Apr 2020 08:22:05 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     SeongJae Park <sjpark@amazon.com>,
        <alexander.shishkin@linux.intel.com>, <linux-mm@kvack.org>,
        <akpm@linux-foundation.org>, SeongJae Park <sjpark@amazon.de>,
        <aarcange@redhat.com>, <acme@kernel.org>, <amit@kernel.org>,
        <brendan.d.gregg@gmail.com>, <brendanhiggins@google.com>,
        <cai@lca.pw>, <colin.king@canonical.com>, <corbet@lwn.net>,
        <dwmw@amazon.com>, <jolsa@redhat.com>, <kirill@shutemov.name>,
        <mark.rutland@arm.com>, <mgorman@suse.de>, <minchan@kernel.org>,
        <mingo@redhat.com>, <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <riel@surriel.com>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <shakeelb@google.com>, <shuah@kernel.org>,
        <sj38.park@gmail.com>, <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Re: [RFC v5 0/7] Implement Data Access Monitoring-based Memory Operation Schemes
Date:   Wed, 1 Apr 2020 10:21:50 +0200
Message-ID: <20200401082150.21124-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200331173908.0000696f@Huawei.com> (raw)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.134]
X-ClientProxiedBy: EX13D37UWC004.ant.amazon.com (10.43.162.212) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Mar 2020 17:39:08 +0100 Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Tue, 31 Mar 2020 18:18:19 +0200
> SeongJae Park <sjpark@amazon.com> wrote:
> 
> > On Tue, 31 Mar 2020 16:51:55 +0100 Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> > 
> > > On Mon, 30 Mar 2020 13:50:35 +0200
> > > SeongJae Park <sjpark@amazon.com> wrote:
> > >   
> > > > From: SeongJae Park <sjpark@amazon.de>
> > > > 
> > > > DAMON[1] can be used as a primitive for data access awared memory management
> > > > optimizations.  That said, users who want such optimizations should run DAMON,
> > > > read the monitoring results, analyze it, plan a new memory management scheme,
> > > > and apply the new scheme by themselves.  Such efforts will be inevitable for
> > > > some complicated optimizations.
> > > > 
> > > > However, in many other cases, the users could simply want the system to apply a
> > > > memory management action to a memory region of a specific size having a
> > > > specific access frequency for a specific time.  For example, "page out a memory
> > > > region larger than 100 MiB keeping only rare accesses more than 2 minutes", or
> > > > "Do not use THP for a memory region larger than 2 MiB rarely accessed for more
> > > > than 1 seconds".
> > > > 
> > > > This RFC patchset makes DAMON to handle such data access monitoring-based
> > > > operation schemes.  With this change, users can do the data access awared
> > > > optimizations by simply specifying their schemes to DAMON.  
[...]
> > > > 
> > > > Efficient THP
> > > > ~~~~~~~~~~~~~
> > > > 
> > > > THP 'always' enabled policy achieves 5.57% speedup but incurs 7.29% memory
> > > > overhead.  It achieves 41.62% speedup in best case, but 79.98% memory overhead
> > > > in worst case.  Interestingly, both the best and worst case are with
> > > > 'splash2x/ocean_ncp').  
> > > 
> > > The results above don't seems to support this any more? 
> > >   
> > > > runtime                 orig     rec      (overhead) thp      (overhead) ethp     (overhead) prcl     (overhead)
> > > > splash2x/ocean_ncp      86.927   87.065   (0.16)     50.747   (-41.62)   86.855   (-0.08)    199.553  (129.57)   
> > 
> > Hmm... But, I don't get what point you meaning...  In the data, column of 'thp'
> > means the THP 'always' enabled policy.  And, the following column shows the
> > overhead of it compared to that of 'orig', in percent.  Thus, the data says THP
> > 'always' enabled policy enabled kernel consumes 50.747 seconds to finish
> > splash2x/ocean_ncp, while THP disabled original kernel consumes 86.927 seconds.
> 
> ah. I got myself confused. 
> 
> However, I was expecting to see a significant performance advantage
> to ethp for this particular case as we did in the previous version.
> 
> In the previous version (you posted in reply to v6 of Damon), for ethp we had a significant gain with:
> 
> runtime                 orig     rec      (overhead) thp      (overhead) ethp     (overhead) prcl     (overhead)
> splash2x/ocean_ncp      81.360   81.434   (0.09)     51.157   (-37.12)   66.711   (-18.00)   91.611   (12.60) 
> 
> So, in ethp we got roughly half the performance back (at the cost of some of the memory)
> 
> That was a result I have been trying to replicate, hence was at the front of my mind!
> 
> Any idea why that changed so much? 

Ah, I forgot to explain about this change.  Thank you for let me know.

Overall, ETHP in DAMON-based Operations Schemes RFC v5 shows worse peak
performance gains.

For example, splash2x/fft shows best case speedup with ETHP for both this
version and previous version.  The speedup changed from 19% to 12%.  In case of
splash2x/ocean_ncp, it changed from 18% to only 0.08%.

That said, total performance speedup is improved.  It was 1.83% before, and
2.21% now.  Also, there are several workloads showing better speedup.  In case
of parsec3/canneal, the speedup changed from 3.86% to 6.34%.

Also note that ETHP's memory savings for the workloads showing less speedup are
much improved.  For example, the memory overhead of ETHP for splash2x/ocean_ncp
was 24.4% before, but only 3.5% now.

This is due to the fact that I didn't update the schemes for the updated DAMON.
Basically, the effect of the schemes are access pattern dependent.  In this
case, because DAMON has changed so that it might report access pattern that
different from that of previous version, the schemes should also be modified to
make best performance.  However, I didn't update the schemes because those are
for only proof of the concepts, not for productions.

The change of report was not so huge, fortunately.  I also confirmed this with
my human eyes by comparing the visualized access patterns of the two version.
The overall trend (better performance, less memory overhead) also changed only
subtle.  However, some individual workloads got some remarkable changes.


Thanks,
SeongJae Park

> 
> Thanks,
> 
> Jonathan
> 
> 
> > Thus, the overhead is ``(50.747 - 86.927) / 86.927 = -0.4162``.  In other
> > words, 41.62% speedup.
> > 
> > Also, 5.57% speedup and 7.29% memory overhead is for _total_.  This data shows
> > it.
> > 
> > > > runtime                 orig     rec      (overhead) thp      (overhead) ethp     (overhead) prcl     (overhead)
> > > > total                   3020.570 3028.080 (0.25)     2852.190 (-5.57)    2953.960 (-2.21)    3276.550 (8.47)      
> > 
> > Maybe I made you confused by ambiguously saying this.  Sorry if so.  Or, if I'm
> > still misunderstanding your point, please let me know.
> 
> 
> > 
> > 
> > Thanks,
> > SeongJae Park
> >  
> > [...]
> 
