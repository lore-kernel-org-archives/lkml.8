Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 149ECC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 23:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB1BD205CB
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 23:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598656539;
	bh=iyf7cavY7WRDPtQqVpmEbIXLW2KxfUTGJWKiWuKdl7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UGLIzEo1yO/khYVGXxHxxPv12+Vw00X7nGHVMuPtMIfNq6e4y+PH6tBaUJit/P8gY
	 94As5bWP9qihmh3vtbFppWaKCGDOvItr6qlSSxO3hZE2g3lw88uoL5vgT2veafwJHT
	 aPU7bKi/HEau5d1LUyPM34D+xJJpk5kX3PpqGrzA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgH1XPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 19:15:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:48770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726386AbgH1XPi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 19:15:38 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8CA0205CB;
        Fri, 28 Aug 2020 23:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598656538;
        bh=iyf7cavY7WRDPtQqVpmEbIXLW2KxfUTGJWKiWuKdl7I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nRmh7mzqw8myRiDq+jE0VGkCEBjopmS41NUfGb5VmfqunNZM58oLi7HaxIRv2t6Ug
         ATybOaVm/GR+u/74atyY3z3dbng4Cu+KKU+z/cMzIeg7uWDzBhzIBov9ZEkb4OYGC6
         sHeLzIzDe5NmYS9xukpXWgH0IiCEoxwMHj7Atfdo=
Date:   Fri, 28 Aug 2020 19:15:36 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com, robh+dt@kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.19 1/7] sdhci: tegra: Remove
 SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK for Tegra210
Message-ID: <20200828231536.GU8670@sasha-vm>
References: <1598653517-13658-1-git-send-email-skomatineni@nvidia.com>
 <1598653517-13658-2-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1598653517-13658-2-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 03:25:11PM -0700, Sowjanya Komatineni wrote:
>commit b5a84ecf025a ("mmc: tegra: Add Tegra210 support")

What does this line above represent?

>SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK is set for Tegra210 from the
>beginning of Tegra210 support in the driver.
>
>Tegra210 SDMMC hardware by default uses timeout clock (TMCLK)
>instead of SDCLK and this quirk should not be set.
>
>So, this patch remove this quirk for Tegra210.
>
>Fixes: b5a84ecf025a ("mmc: tegra: Add Tegra210 support")
>Cc: stable <stable@vger.kernel.org> # 4.19
>Tested-by: Jon Hunter <jonathanh@nvidia.com>
>Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
>Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>

-- 
Thanks,
Sasha
