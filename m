Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA1FC352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 10:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B027E21D95
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 10:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="a43uLLps"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729204AbgDQKWb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 06:22:31 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:21543 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728627AbgDQKW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 06:22:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1587118948; x=1618654948;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=aTIAcIO1w9LM8vub4lfbLCo4YRtnh5tcxb1BzUTDdWA=;
  b=a43uLLpsp0+LAEhQj8nOnm11polWtIvrr+Mj9k2CusYcc+Yc1RSRqjzr
   3ztiIB4+63tVRpMg+Ooa8k2LdY9v5CZ80AaAPF5ZYi2m8RI5y5xVdkXQ5
   mDkhZQM5vHNzsMHIA370QmjePFV3/GqHi8u5EPBJp7yJbunEDAQMMXZ8E
   k=;
IronPort-SDR: sRUR1BUkilGuYpEQveKHjmldW3NGM6g3Plm1lo8Ns/aiG5KUs82OpuBznAV6Mr/Z4aM3pS+sZ1
 yJJ/GLXrNzWQ==
X-IronPort-AV: E=Sophos;i="5.72,394,1580774400"; 
   d="scan'208";a="39069940"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-1c1b5cdd.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 17 Apr 2020 10:22:26 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-1c1b5cdd.us-west-2.amazon.com (Postfix) with ESMTPS id 6C6C6A07B2;
        Fri, 17 Apr 2020 10:22:25 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 17 Apr 2020 10:22:25 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.238) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 17 Apr 2020 10:22:17 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     SeongJae Park <sjpark@amazon.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Rik van Riel <riel@surriel.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Tejun Heo <tj@kernel.org>, Dave Hansen <dave.hansen@intel.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Aubrey Li <aubrey.li@intel.com>
Subject: Re: Re: Re: [RFC] autonuma: Support to scan page table asynchronously
Date:   Fri, 17 Apr 2020 12:21:29 +0200
Message-ID: <20200417102129.23399-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200417100417.GT20730@hirez.programming.kicks-ass.net> (raw)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.238]
X-ClientProxiedBy: EX13D24UWB001.ant.amazon.com (10.43.161.93) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Apr 2020 12:04:17 +0200 Peter Zijlstra <peterz@infradead.org> wrote:

> On Fri, Apr 17, 2020 at 09:05:08AM +0200, SeongJae Park wrote:
> > I think the main idea of DAMON[1] might be able to applied here.  Have you
> > considered it?
> > 
> > [1] https://lore.kernel.org/linux-mm/20200406130938.14066-1-sjpark@amazon.com/
> 
> I've ignored that entire thing after you said the information it
> provides was already available through the PMU.

Sorry if my answer made you confused.  What I wanted to say was that the
fundamental access checking mechanism that DAMON depends on is PTE Accessed bit
for now, but it could be modified to use PMU or other features instead.  In
other words, PMU on some architectures could provide the fundamental, low level
information for DAMON, as PTE Accessed bit does.  What DAMON does are efficient
control of the fundamental access checking features and making of elaborated
final informations, which PMU itself doesn't provide.


Thanks,
SeongJae Park
