Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C632C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 22:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5246C20672
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 22:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594332045;
	bh=pu/BRRDFvnY7VdAK7VRlURGhF5E/6f6U+WeO9dB7VZY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=NhmiQmU1oNxM0Tr6vmeslPG74BRvAlp7vtklePK6R/zOShrYNOvhNMPc20IvqYwCz
	 O9OC4nxvLZJQ8H2UiT8tINtq5d4G63G3/1VF/1Ef7j/YQOjgpLtvVg2NBzrH5z0RTg
	 /wf6KtjvVB002R9YMg+HntjJJHIT4CLXSKYskVHs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgGIWAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 18:00:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:44258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726213AbgGIWAn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 18:00:43 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F054A20708;
        Thu,  9 Jul 2020 22:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594332043;
        bh=pu/BRRDFvnY7VdAK7VRlURGhF5E/6f6U+WeO9dB7VZY=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=LivJJHit/DJNozyXJaxeZPXEoTOddQwxQjL7a7cLP96rxFVSViDXbh5TFlaxVTqb7
         WwByjqLeywyIUcC/WcrIvg/OS+UzblmiIDE24n535sOpww9vYTAyyO3vnEiv2VwnI/
         GdZ/3RSCrlLRRtmDy2Ry8fsWR79ioBdbLTfuENQM=
Date:   Thu, 09 Jul 2020 23:00:37 +0100
From:   Mark Brown <broonie@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     tiwai@suse.com, ludovic.desroches@microchip.com,
        alexandre.belloni@bootlin.com, lgirdwood@gmail.com,
        nicolas.ferre@microchip.com
In-Reply-To: <20200708163359.2698696-1-codrin.ciubotariu@microchip.com>
References: <20200708163359.2698696-1-codrin.ciubotariu@microchip.com>
Subject: Re: [PATCH] ASoC: atmel-pdmic: remove codec component
Message-Id: <159433200032.57213.13831700646787153662.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Jul 2020 19:33:59 +0300, Codrin Ciubotariu wrote:
> The CPU and the codec both are represented now as components, so for
> PDMIC we are registering two componenets with the same name. Since
> there is no actual codec, we will merge the codec component into the
> CPU one and use a dummy codec instead, for the DAI link.
> As a bonus, debugfs will no longer report an error when will try to
> create entries for both componenets with the same name.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: atmel-pdmic: remove codec component
      commit: f3c668074a04020c06e434c51b030bad1702aa12

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
