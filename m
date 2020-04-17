Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A78E6C352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 12:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 859942083E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 12:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="mWXaRH/e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729770AbgDQMpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 08:45:30 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:44288 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729176AbgDQMp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 08:45:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1587127529; x=1618663529;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=VxdcW703gWBgz7FjjmMl11fS0NzvwPPH68Vk83e+i3s=;
  b=mWXaRH/eX9vv2t/jT0tgayZlg0oHUY+JDkHZR3iLPz/TIbVkX78wbcES
   yAM4lsBxid8TLNSewdyNthgQFIaXYmraA4+XR+znNnRrccecgvyxL0xdg
   Sb/xTw0mVTvCiGHMrjHHi5AnpDKXb+PFQA4RP09IMibJnZ7zZto5GQRXQ
   E=;
IronPort-SDR: Uwjivzvoj5wIrsPJMQnmh8OIZG1IMiibxXi2pVfuBwu3II9eAc8zOYplTvCSBdMmURrkrxR6xO
 uk7l3VpanCRw==
X-IronPort-AV: E=Sophos;i="5.72,395,1580774400"; 
   d="scan'208";a="25954007"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-7d76a15f.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 17 Apr 2020 12:45:16 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-7d76a15f.us-east-1.amazon.com (Postfix) with ESMTPS id 2A0FFA236A;
        Fri, 17 Apr 2020 12:45:15 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 17 Apr 2020 12:45:14 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.238) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 17 Apr 2020 12:45:03 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     Mel Gorman <mgorman@techsingularity.net>
CC:     SeongJae Park <sjpark@amazon.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Huang, Ying" <ying.huang@intel.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Rik van Riel <riel@surriel.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Tejun Heo <tj@kernel.org>, Dave Hansen <dave.hansen@intel.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Aubrey Li <aubrey.li@intel.com>
Subject: Re: Re: Re: Re: [RFC] autonuma: Support to scan page table asynchronously
Date:   Fri, 17 Apr 2020 14:44:37 +0200
Message-ID: <20200417124437.25445-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200417121629.GA3758@techsingularity.net> (raw)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.238]
X-ClientProxiedBy: EX13D06UWA004.ant.amazon.com (10.43.160.164) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Apr 2020 13:16:29 +0100 Mel Gorman <mgorman@techsingularity.net> wrote:

> On Fri, Apr 17, 2020 at 12:21:29PM +0200, SeongJae Park wrote:
> > On Fri, 17 Apr 2020 12:04:17 +0200 Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > > On Fri, Apr 17, 2020 at 09:05:08AM +0200, SeongJae Park wrote:
> > > > I think the main idea of DAMON[1] might be able to applied here.  Have you
> > > > considered it?
> > > > 
> > > > [1] https://lore.kernel.org/linux-mm/20200406130938.14066-1-sjpark@amazon.com/
> > > 
> > > I've ignored that entire thing after you said the information it
> > > provides was already available through the PMU.
> > 
> > Sorry if my answer made you confused.  What I wanted to say was that the
> > fundamental access checking mechanism that DAMON depends on is PTE Accessed bit
> > for now, but it could be modified to use PMU or other features instead. 
> 
> I would not be inclined to lean towards either approach for NUMA
> balancing. Fiddling with the accessed bit can have consequences for page
> aging and residency -- fine for debugging a problem, not to fine for
> normal usage. I would expect the PMU approach would have high overhead
> as well as taking over a PMU counter that userspace debugging may expect
> to be available.

Good point.  But, isn't it ok to use Accessed bit as long as PG_Idle and
PG_Young is adjusted properly?  Current DAMON implementation does so, as
idle_page_tracking also does.

That said, the core logics of DAMON and the underlying access check primitive
are logically seperated.  I am planning[1] to further entirely seperate those
and let users to be able to use right access check promitive for their needs.

If I'm missing something, please let me know.

[1] https://lore.kernel.org/linux-mm/20200409094232.29680-1-sjpark@amazon.com/


Thanks,
SeongJae Park

> 
> -- 
> Mel Gorman
> SUSE Labs
