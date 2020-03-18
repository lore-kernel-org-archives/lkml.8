Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F53C4332B
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 20:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2B4C20777
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 20:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584564638;
	bh=RpVUbrA6GLX6oxjlNmWztIMdXN6zWtDhebJqAHQf1+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=skIXrwFS+qxYkDwUs8M6q3Crkqu//sp8n678qNzJSgMJlJuNEoSCZUOkC1271hhpj
	 uJi2t5DU4Xbx/pGPNUfnJgjWbRfjokO0xPVAumF9b6SbcVxqK3ZEEOvwKg2LMr/Oie
	 qBVZOj5FGMtkNCDfLmo26wDY77Dy7KC5Pj8nfif8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbgCRUuh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 16:50:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:50358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726747AbgCRUuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 16:50:37 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28DB320724;
        Wed, 18 Mar 2020 20:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584564637;
        bh=RpVUbrA6GLX6oxjlNmWztIMdXN6zWtDhebJqAHQf1+c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uoOE98RpOGBl59PNZvCx/Au9i4LC64YKNe98455ND4I6HWKEz9G1qqIvggonNnedD
         dLXXgSx4gMv0y4BeMSxxI8oJC1jrSz9UVH772yTbtO77WTZ8GQc0V8J6YsKI6Ej165
         xOes8VhTaE8+5snNexRj2elwnj8NYen9ITpA1eu4=
Date:   Wed, 18 Mar 2020 20:50:30 +0000
From:   Will Deacon <will@kernel.org>
To:     Krishna Reddy <vdumpa@nvidia.com>
Cc:     joro@8bytes.org, robin.murphy@arm.com,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, treding@nvidia.com, yhsu@nvidia.com,
        snikam@nvidia.com, praithatha@nvidia.com, talho@nvidia.com,
        avanbrunt@nvidia.com, bbiswas@nvidia.com, olof@lixom.net,
        jtukkinen@nvidia.com, mperttunen@nvidia.com, nicolinc@nvidia.com
Subject: Re: [PATCH v4 0/6] Nvidia Arm SMMUv2 Implementation
Message-ID: <20200318205030.GA8094@willie-the-truck>
References: <1572480437-28449-1-git-send-email-vdumpa@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572480437-28449-1-git-send-email-vdumpa@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krishna,

On Wed, Oct 30, 2019 at 05:07:11PM -0700, Krishna Reddy wrote:
> Changes in v4:
> Rebased on top of https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/ for-joerg/arm-smmu/updates.
> Updated arm-smmu-nvidia.c to use the tlb_sync implementation hook.
> Dropped patch that updates arm_smmu_flush_ops for override as it is no longer necessary.
> 
> v3 - https://lkml.org/lkml/2019/10/18/1601
> v2 - https://lkml.org/lkml/2019/9/2/980
> v1 - https://lkml.org/lkml/2019/8/29/1588

Do you plan to repost this at some point?

Will
