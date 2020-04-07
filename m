Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE48EC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 13:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94393206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 13:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728838AbgDGNHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 09:07:30 -0400
Received: from foss.arm.com ([217.140.110.172]:56134 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726562AbgDGNHa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 09:07:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF0F031B;
        Tue,  7 Apr 2020 06:07:29 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BDF043F68F;
        Tue,  7 Apr 2020 06:07:28 -0700 (PDT)
Date:   Tue, 7 Apr 2020 14:07:26 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Qian Cai <cai@lca.pw>, Prateek Sood <prsood@codeaurora.org>,
        Li Zefan <lizefan@huawei.com>, cgroups@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: Deadlock due to "cpuset: Make cpuset hotplug synchronous"
Message-ID: <20200407130725.jhtth3bneo33zex6@e107158-lin.cambridge.arm.com>
References: <F0388D99-84D7-453B-9B6B-EEFF0E7BE4CC@lca.pw>
 <20200325191922.GM162390@mtj.duckdns.org>
 <20200326101529.xh763j5frq2r7mqv@e107158-lin>
 <20200403145523.GC162390@mtj.duckdns.org>
 <20200406105522.c66p4vzzzylety5d@e107158-lin.cambridge.arm.com>
 <20200406143405.GH162390@mtj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200406143405.GH162390@mtj.duckdns.org>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/06/20 10:34, Tejun Heo wrote:
> On Mon, Apr 06, 2020 at 11:55:23AM +0100, Qais Yousef wrote:
> > What would be the right approach to get a fix in then? We have been skipping
> > this test for a while and we'd like to enable it but this failure is a
> > blocking issue.
> 
> Update the test so that it accounts for the async nature of the operation?

With a sleep() between the hp ops and the read? Isn't this a nasty hack?

I was just trying to find out what can be done for 5.7. But based on your
response this is sadly a dead end. For no reason I can comprehend.

--
Qais Yousef
