Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E80C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 10:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 641D1207F9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 10:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594894844;
	bh=L6O+9oJn1klewKnv0PBbNlZZnruWJcrOzt9QTNHkA/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NLp4sQ86tJtSK5tnpPWumoLs49abEinUQpX0GbNiEB8BVNWqcmDaM3c/TTDsnS8Y8
	 fQkDHPU12UKgI6nyqIKNJRA1PFiCtdE4HDzHmkCFyAJT+Flh7D7VZ+Fz0zI/GCa8Fa
	 /VCPL8q6Egix48o8RauQKK2n+X/JTQkhOT2SkKYI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbgGPKUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 06:20:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:40270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726202AbgGPKUm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 06:20:42 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8713204EA;
        Thu, 16 Jul 2020 10:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594894842;
        bh=L6O+9oJn1klewKnv0PBbNlZZnruWJcrOzt9QTNHkA/U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xkehWQ0P7hppEt6KHlYUlNGEAJM8OiWVyU/FFxdOlbHSDDRGF+SH3gG1B2UeSdM5T
         DeZueDeBk9N0QcPGSM1Gli43+RB8GbBsIzFd8GKMiWXeKYbhxuukGgUQzYqY1EjCJo
         nHXYGPB7Ds3TZpJVZ6Vp/uNo++ewbKViKu8zEbwg=
Date:   Thu, 16 Jul 2020 11:20:38 +0100
From:   Will Deacon <will@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     robin.murphy@arm.com, joro@8bytes.org, trivial@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, maz@kernel.org
Subject: Re: [PATCH 4/4] iommu/arm-smmu-v3: Remove cmpxchg() in
 arm_smmu_cmdq_issue_cmdlist()
Message-ID: <20200716102037.GB7036@willie-the-truck>
References: <1592846920-45338-1-git-send-email-john.garry@huawei.com>
 <1592846920-45338-5-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592846920-45338-5-git-send-email-john.garry@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 01:28:40AM +0800, John Garry wrote:
> It has been shown that the cmpxchg() for finding space in the cmdq can
> be a bottleneck:
> - for more CPUs contending the cmdq, the cmpxchg() will fail more often
> - since the software-maintained cons pointer is updated on the same 64b
>   memory region, the chance of cmpxchg() failure increases again
> 
> The cmpxchg() is removed as part of 2 related changes:
> 
> - Update prod and cmdq owner in a single atomic add operation. For this, we
>   count the prod and owner in separate regions in prod memory.
> 
>   As with simple binary counting, once the prod+wrap fields overflow, they
>   will zero. They should never overflow into "owner" region, and we zero
>   the non-owner, prod region for each owner. This maintains the prod
>   pointer.
> 
>   As for the "owner", we now count this value, instead of setting a flag.
>   Similar to before, once the owner has finished gathering, it will clear
>   a mask. As such, a CPU declares itself as the "owner" when it reads zero
>   for this region. This zeroing will also clear possible overflow in
>   wrap+prod region, above.
> 
>   The owner is now responsible for all cmdq locking to avoid possible
>   deadlock. The owner will lock the cmdq for all non-owers it has gathered
>   when they have space in the queue and have written their entries.
> 
> - Check for space in the cmdq after the prod pointer has been assigned.
> 
>   We don't bother checking for space in the cmdq before assigning the prod
>   pointer, as this would be racy.
> 
>   So since the prod pointer is updated unconditionally, it would be common
>   for no space to be available in the cmdq when prod is assigned - that
>   is, according the software-maintained prod and cons pointer. So now
>   it must be ensured that the entries are not yet written and not until
>   there is space.
> 
>   How the prod pointer is maintained also leads to a strange condition
>   where the prod pointer can wrap past the cons pointer. We can detect this
>   condition, and report no space here. However, a prod pointer progressed
>   twice past the cons pointer cannot be detected. But it can be ensured that
>   this that this scenario does not occur, as we limit the amount of
>   commands any CPU can issue at any given time, such that we cannot
>   progress prod pointer further.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  drivers/iommu/arm-smmu-v3.c | 101 ++++++++++++++++++++++--------------
>  1 file changed, 61 insertions(+), 40 deletions(-)

I must admit, you made me smile putting trivial@kernel.org on cc for this ;)

Will
