Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97459C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 12:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 687032083B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 12:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588853903;
	bh=I5hKmcE5mcDLVhZaWDRwI64U3QpiZUFmJdDuCE+vXmE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=Pgkvy3cC6Hy/qgoWPSoBn+a+vdNq7rt5oBUrrwIsRZUDlU8D1xPv59/E1yUXrbnLe
	 pyAqmZoC75wlRQfhuyep2vesdqu9IzSy0KoEcTPndX8hb1vVrr+iE6vlnICoIDHnor
	 2IFzuxYRoHRAtnLsl8Djn7CplKFo7F2tSshSWgDo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgEGMSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 08:18:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:44946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725879AbgEGMSW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 08:18:22 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 618C320CC7;
        Thu,  7 May 2020 12:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588853901;
        bh=I5hKmcE5mcDLVhZaWDRwI64U3QpiZUFmJdDuCE+vXmE=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=fwpyh3Lq9mAdWayXxnmENOvUYSaL7jTt72sbM3RezkaGAhPeWB5n+kBGgYIECnHHg
         rhiZgbOKFBvTWslJBreJjVlcVftxMHR2R4WhmM/Nw82hu5LE/J7/Urhwcxr4qSjXac
         6D73eceh/8FZ9DbaTnhzg6b6Wmx87GdNx1gwhibg=
Date:   Thu, 07 May 2020 13:18:19 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Wei Yongjun <weiyongjun1@huawei.com>,
        Takashi Iwai <tiwai@suse.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
In-Reply-To: <20200507094335.14302-1-weiyongjun1@huawei.com>
References: <20200507094335.14302-1-weiyongjun1@huawei.com>
Subject: Re: [PATCH -next] ASoC: rt5677: Use devm_snd_soc_register_component()
Message-Id: <158885389338.38935.14311915230086603146.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 May 2020 09:43:35 +0000, Wei Yongjun wrote:
> Using devm_snd_soc_register_component() can make the code
> shorter and cleaner.
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  sound/soc/codecs/rt5677-spi.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.8

Thanks!

[1/1] ASoC: rt5677: Use devm_snd_soc_register_component()
      commit: 9558ad215509b75c72c84f4f7691f1bd80fda42a

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
