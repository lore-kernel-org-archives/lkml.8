Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 055EEC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 16:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7CAE207DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 16:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598026273;
	bh=KoJWYj9R3egfhrmAUtzdmQ4aHcirpe1luSVDllQR65M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VhwshQfTfriQwVTYjVTmF5ynndeN0IuCWSLRqadTMWj6KJVU09L4SK2rs/9WD8B7Q
	 qVpBcFGniDMZGknDjq2CTyB7jJRkPxIvX9QE+3zMvjTvm20zkqTlDwZBVF3y2o0+XC
	 H05iChxFeIO4lYOojafALKj0lbNr6FJIT9WvSXNo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbgHUQLL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 12:11:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:42626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbgHUQLH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 12:11:07 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEF24207BB;
        Fri, 21 Aug 2020 16:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598026266;
        bh=KoJWYj9R3egfhrmAUtzdmQ4aHcirpe1luSVDllQR65M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yrHjjTtz8bmAAarxqFRyCKp+eUzDy45aPAVgTpRquqvqFnM2Q3B/KMmajkF5M6yRP
         JyG3hI6KbQmfq//EsQ6UFchVq138yTLtw8f6zx0ArEmlIXMNHfioz5ksl7E4tQk5La
         UeC/R4IRIiGU3nWuuLWAUqlvju6DQl64nMKyW+is=
Date:   Fri, 21 Aug 2020 17:11:01 +0100
From:   Will Deacon <will@kernel.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Rob Clark <robdclark@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>, kernel-team@android.com,
        iommu@lists.linux-foundation.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        Pia Eichinger <pia.eichinger@st.oth-regensburg.de>,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: update QUALCOMM IOMMU after Arm SSMU
 drivers move
Message-ID: <20200821161101.GF21517@willie-the-truck>
References: <20200802065320.7470-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200802065320.7470-1-lukas.bulwahn@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 02, 2020 at 08:53:20AM +0200, Lukas Bulwahn wrote:
> Commit e86d1aa8b60f ("iommu/arm-smmu: Move Arm SMMU drivers into their own
> subdirectory") moved drivers/iommu/qcom_iommu.c to
> drivers/iommu/arm/arm-smmu/qcom_iommu.c amongst other moves, adjusted some
> sections in MAINTAINERS, but missed adjusting the QUALCOMM IOMMU section.
> 
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains:
> 
>   warning: no file matches    F:    drivers/iommu/qcom_iommu.c
> 
> Update the file entry in MAINTAINERS to the new location.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Will, please ack.

Typo in subject: s/SSMU/SMMU/

With that:

Acked-by: Will Deacon <will@kernel.org>

> Joerg, please pick this minor non-urgent patch for your -next branch.

Joerg -- can you queue this as a fix for 5.9-rc, please?

Thanks,

Will
