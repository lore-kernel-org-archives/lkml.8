Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6897CC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 13:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49E662075F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 13:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594647899;
	bh=ct2PJVK3v9aqQdAaYhtWeltGvO9MFnxLdsz9ZGp1m8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0ClrLBvjfYTs9UbHBBfUcL/tuHCz1ux+kipxEti/NPKOs8q8jUgJYpiggXDqNmn5y
	 gsOI6zBqhmWIuqgdRPHOFExPFbsLzQu9MI0ifRh2O99GvWc5FQ7A1D6U+LuQhLUIfB
	 ZBwxq9r2bSZOxRTg5MIaixcsYONxenYV+v5BXSXo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729864AbgGMNo5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 09:44:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:51704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728950AbgGMNo5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 09:44:57 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 099732072D;
        Mon, 13 Jul 2020 13:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594647897;
        bh=ct2PJVK3v9aqQdAaYhtWeltGvO9MFnxLdsz9ZGp1m8c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=03i+wBFkvHUzATa6golRiPGIrx0zXbZhvoXvywEQM//aVB3Tm7aAGC04FwFuBdj9T
         lSsDOaF8U+0pTuB3FczsXbFim/rN6/dcBEdhIwuZL0Sd9NmdpAXepHsY8EmmaB0WQn
         +bf9cYr32pA2Ay3X0/BpQ2dKvur7ALhfOZ30QMRo=
Date:   Mon, 13 Jul 2020 14:44:51 +0100
From:   Will Deacon <will@kernel.org>
To:     Krishna Reddy <vdumpa@nvidia.com>
Cc:     joro@8bytes.org, robin.murphy@arm.com, robh+dt@kernel.org,
        treding@nvidia.com, jonathanh@nvidia.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, yhsu@nvidia.com, snikam@nvidia.com,
        praithatha@nvidia.com, talho@nvidia.com, bbiswas@nvidia.com,
        mperttunen@nvidia.com, nicolinc@nvidia.com, bhuntsman@nvidia.com,
        nicoleotsuka@gmail.com
Subject: Re: [PATCH v10 5/5] iommu/arm-smmu: Add global/context fault
 implementation hooks
Message-ID: <20200713134450.GC2739@willie-the-truck>
References: <20200708050017.31563-1-vdumpa@nvidia.com>
 <20200708050017.31563-6-vdumpa@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708050017.31563-6-vdumpa@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 10:00:17PM -0700, Krishna Reddy wrote:
> Add global/context fault hooks to allow vendor specific implementations
> override default fault interrupt handlers.
> 
> Update NVIDIA implementation to override the default global/context fault
> interrupt handlers and handle interrupts across the two ARM MMU-500s that
> are programmed identically.
> 
> Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>
> ---
>  drivers/iommu/arm-smmu-nvidia.c | 99 +++++++++++++++++++++++++++++++++
>  drivers/iommu/arm-smmu.c        | 17 +++++-
>  drivers/iommu/arm-smmu.h        |  3 +
>  3 files changed, 117 insertions(+), 2 deletions(-)

Given that faults shouldn't occur during normal operation, is this patch
actually necessary?

Will
