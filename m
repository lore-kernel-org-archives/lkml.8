Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1665C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 08:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 847A3206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 08:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591604333;
	bh=/IVx+9cPa/hdjtqn+bLeDhAxS+2dke/9caQWfUasXMg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=niv1ImtVDPYQknRLcD6U/tDFsoSw+eZ+uZoWNYILTSGKTdWEIyJs/ixiysCTkH5fY
	 G4fdnBRH2IR5FRCykIqqDgwKADd38Xj3IeUvGRLsoqf4F6fx7QBGWCx72KB0Dpg/bg
	 P0nivRLLHzHU58q1eoxbJsQEfPGsWWWLsSIUQIZc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729103AbgFHISw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 04:18:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:56256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729062AbgFHISw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 04:18:52 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86E3A20656;
        Mon,  8 Jun 2020 08:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591604331;
        bh=/IVx+9cPa/hdjtqn+bLeDhAxS+2dke/9caQWfUasXMg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nX2kx0ZJvQ6eZb5gFid2h2iyefJIxDMhLvhqHQ4r8PSN5juMtyzG6Rk24zGvO1Rsy
         YWYrlfUa7aCsUXURPJMHFxn4msfRGLefqDnBmBLqgQrVlSjZWwHAIHDjTXHV99AK/q
         dYwj7VLYrifpUdMj+buPBiepFMcBy74p2nfhMrh0=
Date:   Mon, 8 Jun 2020 09:18:46 +0100
From:   Will Deacon <will@kernel.org>
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [RFC PATCH] iommu/arm-smmu: Remove shutdown callback
Message-ID: <20200608081846.GA1542@willie-the-truck>
References: <20200607110918.1733-1-saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200607110918.1733-1-saiprakash.ranjan@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 07, 2020 at 04:39:18PM +0530, Sai Prakash Ranjan wrote:
> Remove SMMU shutdown callback since it seems to cause more
> problems than benefits. With this callback, we need to make
> sure that all clients/consumers of SMMU do not perform any
> DMA activity once the SMMU is shutdown and translation is
> disabled. In other words we need to add shutdown callbacks
> for all those clients to make sure they do not perform any
> DMA or else we see all kinds of weird crashes during reboot
> or shutdown. This is clearly not scalable as the number of
> clients of SMMU would vary across SoCs and we would need to
> add shutdown callbacks to almost all drivers eventually.
> This callback was added for kexec usecase where it was known
> to cause memory corruptions when SMMU was not shutdown but
> that does not directly relate to SMMU because the memory
> corruption could be because of the client of SMMU which is
> not shutdown properly before booting into new kernel. So in
> that case, we need to identify the client of SMMU causing
> the memory corruption and add appropriate shutdown callback
> to the client rather than to the SMMU.
> 
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---
>  drivers/iommu/arm-smmu-v3.c | 6 ------
>  drivers/iommu/arm-smmu.c    | 6 ------
>  2 files changed, 12 deletions(-)

This feels like a giant bodge to me and I think that any driver which
continues to perform DMA after its ->shutdown() function has been invoked
is buggy. Wouldn't that cause problems with kexec(), for example?

There's a clear shutdown dependency ordering, where the clients of the
SMMU need to shutdown before the SMMU itself, but that's not really
the SMMU driver's problem to solve.

Will
