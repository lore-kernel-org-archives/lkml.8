Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF5CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6EBE20663
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594801824;
	bh=WDUrHfDBynWOQYaHlD7ZA0aOIiAjAZBjHlYA/2JEtXQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ldl12fWUVf+q5LSJMyRR3D8p0N2l570+e5mqVk/nuvh4l93LmgNhVXCEDk8l4Rvpp
	 Xoq5mVhfLryKgMb1Dc+p45fAQYTqmAMeZz1OUkZ+NiKjLllHDMwTQXaEAX8ys7DoFt
	 lJG6oPkzEds+DxGzMn0zNsqD0+R+koMJEKk0n5Z0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgGOIaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 04:30:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:38920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726971AbgGOIaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 04:30:22 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B4CA20657;
        Wed, 15 Jul 2020 08:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594801822;
        bh=WDUrHfDBynWOQYaHlD7ZA0aOIiAjAZBjHlYA/2JEtXQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dQznYcTpJ6uIZYxjbsa3EFFZ+Rtfly2yeUwEHNIl5vOve/r75JqBH79CwCSeKrZ8k
         Mx1rABjYB/QXQiA0x4BEKClOLKbgoWoDy5Sq9EMfRDmTev4i2PG2w0ic/S1R0T9u6p
         6s8TQaHNTnWL94kCou57dIBEKdeTk6DWSVHo2lhI=
Date:   Wed, 15 Jul 2020 09:30:17 +0100
From:   Will Deacon <will@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     zhangshaokun@hisilicon.com, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        qiangqing.zhang@nxp.com, jolsa@redhat.com, linuxarm@huawei.com
Subject: Re: [PATCH] drivers/perf: hisi: Add identifier sysfs file
Message-ID: <20200715083016.GB5683@willie-the-truck>
References: <1592399111-134786-1-git-send-email-john.garry@huawei.com>
 <20200714083216.GD4516@willie-the-truck>
 <67db3c30-5aaf-ac17-0256-950494f5ba88@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67db3c30-5aaf-ac17-0256-950494f5ba88@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On Wed, Jul 15, 2020 at 09:23:19AM +0100, John Garry wrote:
> > On Wed, Jun 17, 2020 at 09:05:11PM +0800, John Garry wrote:
> > > To allow userspace to identify the specific implementation of the device,
> > > add an "identifier" sysfs file.
> > > 
> > > Encoding is as follows:
> > > hi1620: 0x0	(aka hip08)
> > > hi1630: 0x30
> > > 
> > > Signed-off-by: John Garry <john.garry@huawei.com>
> > 
> > I'm struggling a bit to track this. If you still think it's worth pursuing,
> > please could you post a series with a cover-letter describing what this is
> > for, a link to the userspace changes and then patches for all the PMU
> > drivers that need updating?
> 
> There is no hi1630 userspace support yet.
> 
> So what I can do is post updated userspace support (including hi1630), and
> then post kernel parts together for all drivers we could initially support.
> 
> @Joakim, I'll pick your imx driver changes here, if you don't mind.
> 
> There was an RFC from you for the SMMUv3 PMU as
> > well, and also some other "arm64" changes.
> > 
> 
> I hope to drop that RFC if an updated SMMUv3 spec helps us out.

Thanks, John. That should be a tonne easier to review.

Will
