Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD55C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 14:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39FCB207F5
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 14:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591279659;
	bh=tIx6WDY628i3sbqZbB1BH8QLISVpJLqNaOfUTgByqC0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=bg1VIt7GgtLUvnHJRBSBajISV4hLnn4ILjI++aN0kg4y/cDxADRANnhwAg28NQIys
	 sq4F4J6wcEAtOfocSxwSj57OWsfES22tqjZeOx+4j06A/wbSO0h5OqY7n9D1AvpcwD
	 GfENmC5KmKq4CiojoXrDlo2O9E2qTLN68plgGg58=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbgFDOHi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 10:07:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:51376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728747AbgFDOHi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 10:07:38 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32AC8207D8;
        Thu,  4 Jun 2020 14:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591279657;
        bh=tIx6WDY628i3sbqZbB1BH8QLISVpJLqNaOfUTgByqC0=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=kKoy+jEqxsQ9VGNmgiEAe9cOAs4WNNbqCMFh5MWpLGukZOKOqjAgeYQKHSOea9NPG
         ApIGZIgBr9WDnToGyzHEY0uN7GZzrkq+4TK3n5/Qi6B+DrZOep1nh1ljIRUEx79RAW
         CW08w7xq6scgAYW8WEL15oMFcVe2IxSLf7/HgbWQ=
Date:   Thu, 04 Jun 2020 15:07:35 +0100
From:   Mark Brown <broonie@kernel.org>
To:     perex@perex.cz, alsa-devel@alsa-project.org,
        ckeepax@opensource.cirrus.com,
        Steve Lee <steves.lee@maximintegrated.com>, nuno.sa@analog.com,
        rf@opensource.wolfsonmicro.com, geert@linux-m68k.org,
        shumingf@realtek.com, linux-kernel@vger.kernel.org, tiwai@suse.com,
        krzk@kernel.org, jack.yu@realtek.com, dmurphy@ti.com,
        lgirdwood@gmail.com, srinivas.kandagatla@linaro.org
Cc:     ryan.lee.maxim@gmail.com, steves.lee.maxim@gmail.com,
        ryans.lee@maximintegrated.com
In-Reply-To: <20200604054731.21140-1-steves.lee@maximintegrated.com>
References: <20200604054731.21140-1-steves.lee@maximintegrated.com>
Subject: Re: [v2 PATCH] ASoC: max98390: Fix potential crash during param fw loading
Message-Id: <159127965569.55652.8183322346754988005.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jun 2020 14:47:31 +0900, Steve Lee wrote:
>  malformed firmware file can cause out-of-bound access and crash
>  during dsm_param bin loading.
>   - add MIN/MAX param size to avoid out-of-bound access.
>   - read start addr and size of param and check bound.
>   - add condition that fw->size > param_size + _PAYLOAD_OFFSET
>     to confirm enough data.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: max98390: Fix potential crash during param fw loading
      commit: 97ed3e509ee6d098730d137759c627a8d674cf55

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
