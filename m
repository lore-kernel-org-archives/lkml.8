Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 389A5C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05F6120738
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597839397;
	bh=pBCiNyZSJDtCPtcnxICUiMkHGj6Otqo1yumlFx0O7sg=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=NHAKGLichQEp9ZZYGOl0ILyWQVnCmthaW3NCDIhVT97abfQJWwYuTiUBBnGTl2keU
	 spqGcFo+2BBbq3KE4mvBW+EzYcWnZvbOVXmMGL5QUH8M6K7zpObisv+oOwK32/6rvB
	 pj5TOoha2aigZIfEiOaAf7OwUjbcAjFhQcxgUMeY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbgHSMQf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 08:16:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:53662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726600AbgHSMQX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 08:16:23 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2393C20738;
        Wed, 19 Aug 2020 12:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597839383;
        bh=pBCiNyZSJDtCPtcnxICUiMkHGj6Otqo1yumlFx0O7sg=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=MGHc4RFDSXIIbmIklx0Q7GenXfNhsBhFmTuVMNFYB4YoBwE2TyfUeblQJgv1BEl1I
         GMCLiDe2gVUqx8PAniaUxWgYxQ5xYjxw+HEr3U8sJGihtF4KzPITRusrQG3zRxKM0J
         8Enh3AA/1SNqUl+pU/SE6h3P6gsGqcGjSeEdh+7c=
Date:   Wed, 19 Aug 2020 13:15:52 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     linux-kernel@vger.kernel.org, ChiYuan Huang <cy_huang@richtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>
In-Reply-To: <20200819085959.1914471-1-axel.lin@ingics.com>
References: <20200819085959.1914471-1-axel.lin@ingics.com>
Subject: Re: [PATCH] regulator: rt4801: Select REGMAP_I2C to fix build error
Message-Id: <159783935195.14214.16521566781285277264.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Aug 2020 16:59:59 +0800, Axel Lin wrote:
> Fix build error when CONFIG_REGMAP_I2C is not set.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: rt4801: Select REGMAP_I2C to fix build error
      commit: 02532cb80543b50611656a6017bfec7477e2e200

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark
