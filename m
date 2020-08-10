Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D435C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 07:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00B832065C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 07:45:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgHJHp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 03:45:27 -0400
Received: from foss.arm.com ([217.140.110.172]:53784 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbgHJHp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 03:45:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 821B01FB;
        Mon, 10 Aug 2020 00:45:26 -0700 (PDT)
Received: from bogus (unknown [10.37.12.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C1C453F7BB;
        Mon, 10 Aug 2020 00:45:24 -0700 (PDT)
Date:   Mon, 10 Aug 2020 08:45:17 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will@kernel.org>, Gavin Shan <gshan@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Sumit Gupta <sumitg@nvidia.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] fix arm64 build with lack of __cpu_logical_map exported
Message-ID: <20200810074517.GA28091@bogus>
References: <20200808124242.GA352821@kroah.com>
 <20200808150443.GA492@DESKTOP-O1885NU.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200808150443.GA492@DESKTOP-O1885NU.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin,

On Sat, Aug 08, 2020 at 04:05:00PM +0100, Catalin Marinas wrote:
> Hi Greg,
> 
> On Sat, Aug 08, 2020 at 02:42:42PM +0200, Greg Kroah-Hartman wrote:
> > diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> > index 87e81d29e6fb..b421a4756793 100644
> > --- a/arch/arm64/kernel/setup.c
> > +++ b/arch/arm64/kernel/setup.c
> > @@ -275,6 +275,7 @@ static int __init reserve_memblock_reserved_regions(void)
> >  arch_initcall(reserve_memblock_reserved_regions);
> >  
> >  u64 __cpu_logical_map[NR_CPUS] = { [0 ... NR_CPUS-1] = INVALID_HWID };
> > +EXPORT_SYMBOL_GPL(__cpu_logical_map);
> 
> This was still under discussion, Sudeep preferring an alternative in the
> driver:
> 
> http://lkml.kernel.org/r/20200727172744.GD8003@bogus
> http://lkml.kernel.org/r/20200724131059.GB6521@bogus
> 
> Sumit came with a new diff inline that fixes the driver instead of
> exporting the __cpu_logical_map.
> 
> https://lore.kernel.org/linux-arm-kernel/e3a4bc21-c334-4d48-90b5-aab8d187939e@nvidia.com/
> 
> Sumit, Sudeep, is the above diff sufficient and can it go upstream?
> 

Yes I prefer the above in above thread. I will reply on that thread. Sorry
for missing, been a week.

-- 
Regards,
Sudeep
