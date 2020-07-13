Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3008BC433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 13:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0959206F4
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 13:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594648241;
	bh=zx+4Nn0WfziKJQDknstYCw7HzoUzPTgS03z9BIVq5Y0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oum0YJgZ2apylY70IjQrrCKq8lMu0SjCif+vQcog6G/Iomzr5RWaR/92PCTAJvC1M
	 n13f0QuyzeuUwJM+WnAhVkZiLhCyvjIIgfFNMSi1TRhczP93kiPHAhH3xemWnP2lTC
	 sXfWEzo6q2Cy8w1UOi0qr0IPF4CfpoM0u4lwQdXA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729878AbgGMNu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 09:50:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:55870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729581AbgGMNu1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 09:50:27 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3419206F4;
        Mon, 13 Jul 2020 13:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594648227;
        bh=zx+4Nn0WfziKJQDknstYCw7HzoUzPTgS03z9BIVq5Y0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CWJs6c41a1vUpwjTSeKRjm45pshqAXeZaQakNlzF7KpEth8qeT5EB4TX6PXc9DBKL
         vhMS9bIIuLyg2+hoHEX+xh++nofLTHpV9tS6SZOeKvp5WuXfFYgPOE2nDcHS0/pgob
         NLawUJduIQdac3phQNUD8LP+8MdaxnXT64+wh1q8=
Date:   Mon, 13 Jul 2020 14:50:20 +0100
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
Subject: Re: [PATCH v10 0/5] NVIDIA ARM SMMU Implementation
Message-ID: <20200713135020.GD2739@willie-the-truck>
References: <20200708050017.31563-1-vdumpa@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708050017.31563-1-vdumpa@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 10:00:12PM -0700, Krishna Reddy wrote:
> Changes in v10:
> Perform SMMU base ioremap before calling implementation init.
> Check for Global faults across both ARM MMU-500s during global interrupt.
> Check for context faults across all contexts of both ARM MMU-500s during context fault interrupt.
> Add new DT binding nvidia,smmu-500 for NVIDIA implementation.

Please repost based on my SMMU queue, as this doesn't currently apply.

https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=for-joerg/arm-smmu/updates

Will
