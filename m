Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EBDEC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 13:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AF402187F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 13:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729235AbgBNNUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 08:20:41 -0500
Received: from outbound-smtp17.blacknight.com ([46.22.139.234]:38840 "EHLO
        outbound-smtp17.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727822AbgBNNUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 08:20:41 -0500
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp17.blacknight.com (Postfix) with ESMTPS id 97B1D1C318B
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 13:20:39 +0000 (GMT)
Received: (qmail 30232 invoked from network); 14 Feb 2020 13:20:39 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 14 Feb 2020 13:20:39 -0000
Date:   Fri, 14 Feb 2020 13:20:38 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Phil Auld <pauld@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 12/12] sched/numa: Stop an exhastive search if a
 reasonable swap candidate or idle CPU is found
Message-ID: <20200214132038.GI3466@techsingularity.net>
References: <20200214081324.26859-1-mgorman@techsingularity.net>
 <20200214114746.10792-1-hdanton@sina.com>
 <20200214123229.20884-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200214123229.20884-1-hdanton@sina.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 08:32:29PM +0800, Hillf Danton wrote:
> 
> On Fri, 14 Feb 2020 12:03:07 +0000 Mel Gorman wrote:
> >
> It is not special weekend without reading your patchset.
> 

:)

> I say Thank You for the nice works you posted recently in
> the scheduler field.

Thank you for catching two extremely stupid bugs!

-- 
Mel Gorman
SUSE Labs
