Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE6DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 14:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB36F2070C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 14:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594046621;
	bh=mPDOwAUIsyMOqJhm0F0a70OGr4c9VVnVU1nOWYJWG3s=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=YmjGw+7buXxd1TjCfzWyUocsCHBPP5HNhHJ4oEJv06deeNCelkgPit9TbvaeOzbX5
	 21SSIVFGJxjGvYK7PcZxdkbsAdpUBZ35BMZ44CGvza20E3mAVIgvaUOZKR1nPCYmVc
	 LesRkPBYC8q7D+w+zpg4mjXw3q2pA878zsEiMzI8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729338AbgGFOnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 10:43:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:50920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729148AbgGFOnj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 10:43:39 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E3B8206CB;
        Mon,  6 Jul 2020 14:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594046618;
        bh=mPDOwAUIsyMOqJhm0F0a70OGr4c9VVnVU1nOWYJWG3s=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=CAvCS/P042jiNSgkQBNwZuMLm760/OMkDfbaqMGRIGppyj5wM6dhdORj135HGx119
         zPdzuRis/bpm5rHNkj07y5anPEW6fC2nlUna9zOF6YTfm5cEeLaxwYu1f+6uIYivyt
         EDZ9p3JgIdUTlFY2fcEeaFX1LkFfe6/7mEou3A+Q=
Date:   Mon, 06 Jul 2020 15:43:34 +0100
From:   Mark Brown <broonie@kernel.org>
To:     catalin.marinas@arm.com, s.hauer@pengutronix.de,
        shawnguo@kernel.org, Robin Gong <yibin.gong@nxp.com>,
        lgirdwood@gmail.com, john.lee@nxp.com, will@kernel.org,
        anson.huang@nxp.com, robh+dt@kernel.org, festevam@gmail.com,
        frieder.schrempf@kontron.de
Cc:     linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kernel@pengutronix.de
In-Reply-To: <1593793178-9737-1-git-send-email-yibin.gong@nxp.com>
References: <1593793178-9737-1-git-send-email-yibin.gong@nxp.com>
Subject: Re: [PATCH v2 0/4] Add pca9450 driver
Message-Id: <159404660937.36664.12870991491139405194.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Jul 2020 00:19:34 +0800, Robin Gong wrote:
> Add pca9450 driver for i.mx8mn-evk board. PCA9450A/B/C supported now.
> Please refer to below link for PCA9450 datasheet:
> https://www.nxp.com/docs/en/data-sheet/PCA9450DS.pdf
> 
> v2:
>   1. rebase with the latest code to use linear_ranges helper instead.
>   2. address Frieder's comments, such as dulipcated buck4 description,
>      debug info added etc.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] regulator: pca9450: add pca9450 pmic driver
      commit: 0935ff5f1f0a44f66a13e075ed49f97ad99d2fdc
[2/2] dt-bindings: regulator: add pca9450 regulator yaml
      commit: 7ae9e3a6bf3fb1b5a35a15d8a6e78fc42bed0867

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
