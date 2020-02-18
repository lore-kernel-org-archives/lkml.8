Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2CF8C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 12:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82CBD2176D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 12:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582030635;
	bh=xgj7HIUuh3c9j2fXgc0CIDFvIhaZn0e3I9sVaisiphY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Qr1nRs8Z9GlAmhNERtnQ/HW48nCqX6I8QbcXFa65FVGyJoclRdMjCLrVtsVLV4Ub6
	 33DTorsKqL1MVyx/d627izi5WmCHhE/QUU9J0plGJKRihkI7K36GdMk343+YLDgYiy
	 K/d1rWaL63Ojw6vb/8dKf8EHBD3RvC23mn4kltTE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgBRM5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 07:57:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:34432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbgBRM5O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 07:57:14 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF01F2067D;
        Tue, 18 Feb 2020 12:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582030633;
        bh=xgj7HIUuh3c9j2fXgc0CIDFvIhaZn0e3I9sVaisiphY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ab7WgANOKYiRaiLca2c/NpH1Jn1FxJy0jOeUR57DeFvcJRjcmRtQW/8iUtRItoK68
         pK2oWvvivsrKOGBDEn9uV/8mYLZNwKS52+0BuGg5Ln0Vai67tF42IWJKgv+FCfHa9b
         rcWajllOO7jY+xk4A+vEfgATRjOqn+Ym6/B+rHE4=
Date:   Tue, 18 Feb 2020 12:57:07 +0000
From:   Will Deacon <will@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, ak@linux.intel.com,
        linuxarm@huawei.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com,
        james.clark@arm.com, zhangshaokun@hisilicon.com,
        robin.murphy@arm.com
Subject: Re: [PATCH RFC 0/7] perf pmu-events: Support event aliasing for
 system PMUs
Message-ID: <20200218125707.GB20212@willie-the-truck>
References: <1579876505-113251-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579876505-113251-1-git-send-email-john.garry@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2020 at 10:34:58PM +0800, John Garry wrote:
> Currently event aliasing for only CPU and uncore PMUs is supported. In
> fact, only uncore PMUs aliasing for when the uncore PMUs are fixed for a
> CPU is supported, which may not always be the case for certain
> architectures.
> 
> This series adds support for PMU event aliasing for system and other
> uncore PMUs which are not fixed to a specific CPU.
> 
> For this, we introduce support for another per-arch mapfile, which maps a
> particular system identifier to a set of system PMU events for that
> system. This is much the same as what we do for CPU event aliasing.
> 
> To support this, we need to change how we match a PMU to a mapfile,
> whether it should use a CPU or system mapfile. For this we do the
> following:
> 
> - For CPU PMU, we always match for the event mapfile based on the CPUID.
>   This has not changed.
> 
> - For an uncore or system PMU, we match first based on the SYSID (if set).
>   If this fails, then we match on the CPUID.
> 
>   This works for x86, as x86 would not have any system mapfiles for uncore
>   PMUs (and match on the CPUID).
> 
> Initial reference support is also added for ARM SMMUv3 PMCG (Performance
> Monitor Event Group) PMU for HiSilicon hip08 platform with only a single
> event so far - see driver in drivers/perf/arm_smmuv3_pmu.c for that driver.

Why don't we just expose SMMU_IIDR in the SMMUv3 PMU directory, so that
you can key off that? I'm nervous about coming up with a global "SYSID"
when we don't have the ability to standardise anything in that space.

Will
