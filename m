Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1449C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 11:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 921C42078C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 11:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594899161;
	bh=3cOvlaZ05EcmrtKX6g8BP2m/rqNbiRqnjZrKgj08tjE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kSolygKry0X1VwIKI0WnJs/cByPmrNHn9xDI3lIShiZ+3IDhFQ+VVY6OakugxybeF
	 bLWBV4QsxBBeZYrKEZw2JiPwhcaL8H+20246cGRCZmBCWRZmwy8MEpK3b1fvC0xQqt
	 IIBEiF+vHZQ2JzmxhO6MBfGhOdi/LRKvSZBtQNKQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbgGPLck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 07:32:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:50194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727963AbgGPLcj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 07:32:39 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC3B92074B;
        Thu, 16 Jul 2020 11:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594899159;
        bh=3cOvlaZ05EcmrtKX6g8BP2m/rqNbiRqnjZrKgj08tjE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ne0dpTmDWaQ3qVkvvYEshgxF7lYWvaZkeH6xK7kTKoLW3O+pFyWi2L1A2EhHzrP39
         7O5lhBIAzAb0W62JVPPHfaaMwgIHVLghVV1DYu6+lrWZn/cMVuTJT2MQ/a3VvQ3AO9
         etxnVjWL9KQXfEWSx0NW/wq/SB+ProewtyANR1u4=
Date:   Thu, 16 Jul 2020 12:32:35 +0100
From:   Will Deacon <will@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     John Garry <john.garry@huawei.com>, joro@8bytes.org,
        trivial@kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, maz@kernel.org
Subject: Re: [PATCH 0/4] iommu/arm-smmu-v3: Improve cmdq lock efficiency
Message-ID: <20200716113234.GA7290@willie-the-truck>
References: <1592846920-45338-1-git-send-email-john.garry@huawei.com>
 <20200716101940.GA7036@willie-the-truck>
 <20200716102233.GC7036@willie-the-truck>
 <20200716102814.GD7036@willie-the-truck>
 <bd302efa-20d8-e1b3-6a80-db65ab5ad752@huawei.com>
 <aef1e4a4-d594-f477-9029-8f4295bb9f6c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aef1e4a4-d594-f477-9029-8f4295bb9f6c@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 12:22:05PM +0100, Robin Murphy wrote:
> On 2020-07-16 11:56, John Garry wrote:
> > On 16/07/2020 11:28, Will Deacon wrote:
> > > On Thu, Jul 16, 2020 at 11:22:33AM +0100, Will Deacon wrote:
> > > > On Thu, Jul 16, 2020 at 11:19:41AM +0100, Will Deacon wrote:
> > > > > On Tue, Jun 23, 2020 at 01:28:36AM +0800, John Garry wrote:
> > > > > > As mentioned in [0], the CPU may consume many cycles processing
> > > > > > arm_smmu_cmdq_issue_cmdlist(). One issue we find is the
> > > > > > cmpxchg() loop to
> > > > > > get space on the queue takes approx 25% of the cycles
> > > > > > for this function.
> > > > > > 
> > > > > > This series removes that cmpxchg().
> > > > > 
> > > > > How about something much simpler like the diff below? >>
> > > > Ah, scratch that, I don't drop the lock if we fail the cas with it held.
> > > > Let me hack it some more (I have no hardware so I can only
> > > > build-test this).
> > > 
> > > Right, second attempt...
> > 
> > I can try it, but if performance if not as good, then please check mine
> > further (patch 4/4 specifically) - performance is really good, IMHO.
> 
> Perhaps a silly question (I'm too engrossed in PMU world ATM to get properly
> back up to speed on this), but couldn't this be done without cmpxchg anyway?
> Instinctively it feels like instead of maintaining a literal software copy
> of the prod value, we could resolve the "claim my slot in the queue" part
> with atomic_fetch_add on a free-running 32-bit "pseudo-prod" index, then
> whoever updates the hardware deals with the truncation and wrap bit to
> convert it to an actual register value.

Maybe, but it's easier said than done. The hard part is figuring how that
you have space and there's no way I'm touching that logic without a way to
test this.

I'm also not keen to complicate the code because of systems that don't scale
well with contended CAS [1]. If you put down loads of cores, you need an
interconnect/coherence protocol that can handle it.

Will

[1] https://lore.kernel.org/lkml/20190607072652.GA5522@hc/T/#m0d00f107c29223045933292a8b5b90d2ca9b7e5c
