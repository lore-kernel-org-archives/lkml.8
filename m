Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92030C433E7
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62B8D206EB
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598971882;
	bh=U9kVy65nnzvTM41H46euJ38ARji/idElYj/bQEfwOe0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=n8YOXt7NT8/KmZ7PugXKfamxYaeces8u11+dpxmPUAH/4uMNLawd5O3q5R9DN3afP
	 2Jz2gcSnwQ9UjmOOMYaHnnTbJyA8E1EqBtYjw8i/hFIUgO4ovJQOxQwg361DhHqSOL
	 Ax+2UrJ0ZksnbnGBBEGQJkXjUiYC9hXCbHCltlcc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728763AbgIAOvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 10:51:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:36934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728740AbgIAOvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 10:51:04 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6853B21655;
        Tue,  1 Sep 2020 14:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598971861;
        bh=U9kVy65nnzvTM41H46euJ38ARji/idElYj/bQEfwOe0=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=yEj0FDjNHERndHIlmFK+60ckfBfP2xlsAxXCJWFPx1QbxzpEOcM+QXktMVEreCNZM
         uXVHYmMmZFY/eSjuHT51bixM7odLrLbwtUQVRusR294dBz8gPFVHklRjk9+zqSpEI8
         6bu5wRCE8yuJzzw7LfL7+9eA1MY4BNpY7f/McnQI=
Date:   Tue, 01 Sep 2020 15:50:22 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20200901111331.641072-1-vkoul@kernel.org>
References: <20200901111331.641072-1-vkoul@kernel.org>
Subject: Re: [PATCH v2] regmap: soundwire: remove unused header mod_devicetable.h
Message-Id: <159897181721.47861.11254515393563198578.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Sep 2020 16:43:31 +0530, Vinod Koul wrote:
> mod_devicetable.h does not seem to be required for this file, so
> remove it.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: soundwire: remove unused header mod_devicetable.h
      commit: 50df0eebbd49b894df7e5e3945d66cd80c322284

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
