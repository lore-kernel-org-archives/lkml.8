Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB80C433FE
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 16:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CE3B207FC
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 16:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595953922;
	bh=fMNQi5A+NN2YwKr4BGffFEl5pIiiOIfMgqPkYAoC4Ts=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=no5vXYA54a0ilzQv2hzExACRyayn1ekXCHeX076JqAxbIp1+cSf/2MPD0r6QRHaxh
	 EgrYZqTVSYsRs5XJbEqAefmTCBE6ZRUnzOs6ay4y+VNWOZscigmCd/s5EWH3npnNqh
	 YAPtFTZr8A5dF6dqvqvvs9oLseDL+tfRg723JqIM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731485AbgG1QcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 12:32:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:47684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731458AbgG1Qb6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 12:31:58 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64575207F5;
        Tue, 28 Jul 2020 16:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595953918;
        bh=fMNQi5A+NN2YwKr4BGffFEl5pIiiOIfMgqPkYAoC4Ts=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=J5LDSWxez+sdvsG5Q86BG2VchGVcuv+Ij5o934S/xyclHizLJ/DeUsKu94yFSRiyF
         zNwCTBa0xwGxWL6dTrstVII8B1s3mfB1uLSceZ3HCheQ7am8GFyOsG2DpO0hh/SH35
         YHc30CVV2cx04Nx81hneZecSPYBBAikJZ+xk4m6c=
Date:   Tue, 28 Jul 2020 17:31:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
In-Reply-To: <20200727172936.661567-1-vaibhavgupta40@gmail.com>
References: <CAHp75VfmKvAy6bSk70g3c2qJcUzzo0AUhzxR6dFja+ZppGMLRg@mail.gmail.com> <20200727172936.661567-1-vaibhavgupta40@gmail.com>
Subject: Re: [PATCH v3] spi: spi-topcliff-pch: drop call to wakeup-disable
Message-Id: <159595388005.15302.729932493645865477.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jul 2020 22:59:37 +0530, Vaibhav Gupta wrote:
> Before generic upgrade, both .suspend() and .resume() were invoking
> pci_enable_wake(pci_dev, PCI_D3hot, 0). Hence, disabling wakeup in both
> states. (Normal trend is .suspend() enables and .resume() disables the
> wakeup.)
> 
> This was ambiguous and may be buggy. Instead of replicating the legacy
> behavior, drop the wakeup-disable call.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-topcliff-pch: drop call to wakeup-disable
      commit: 15b413d93ccd0d26c29f005df82c299c8f14cbd6

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
