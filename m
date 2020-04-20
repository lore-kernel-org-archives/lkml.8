Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0595EC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 14:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7DD2214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 14:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587392871;
	bh=bPab1cXXjTKCGuVPa8Wpl3AqXztqKcJ3d16mm/JZp5o=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=tnIWISXdJNM0R5uBkxOpyv7vMjxSm61MDdkbuzQtXDt/hXbYmW26eagiHvtihHRgO
	 SIVBdMYoVirmObMNZJRgB2eJXe5fcYu5cbPN4ypbhb9uivvqZY+TYUsn35lXkN/kNR
	 Ay55SZpN5khTF/gP58Vo5LBOcZAYB4I4aDTq3as4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729899AbgDTO1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 10:27:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:39832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726805AbgDTO1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 10:27:50 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65B4120B1F;
        Mon, 20 Apr 2020 14:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587392870;
        bh=bPab1cXXjTKCGuVPa8Wpl3AqXztqKcJ3d16mm/JZp5o=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=kyEso5E+3LJnfxMS4uFChrckuUkcqy5XEwf6azX4hEDUzA0EXVht9utTshsBId9hn
         xdkC3feXceOdrz4N3WDbt3dvFL0GcBSMsofdSX/4/kkPdgek9rDQ84kmgDWDZAyC/v
         j4tOxeX76NyXMALvzpEONuAPOlr24/Jr0jkg3VL8=
Date:   Mon, 20 Apr 2020 15:27:47 +0100
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>, tiwai@suse.com,
        lgirdwood@gmail.com, geert@linux-m68k.org, perex@perex.cz
Cc:     ckeepax@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20200420125343.20920-1-yuehaibing@huawei.com>
References: <20200418090853.30340-1-yuehaibing@huawei.com> <20200420125343.20920-1-yuehaibing@huawei.com>
Subject: Re: [PATCH] ASoC: wm89xx: Add missing dependency
Message-Id: <158739283776.7647.10304654124585055590.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Apr 2020 20:53:43 +0800, YueHaibing wrote:
> sound/soc/codecs/wm8900.o: In function `wm8900_i2c_probe':
> wm8900.c:(.text+0xa36): undefined reference to `__devm_regmap_init_i2c'
> sound/soc/codecs/wm8900.o: In function `wm8900_modinit':
> wm8900.c:(.init.text+0xb): undefined reference to `i2c_register_driver'
> sound/soc/codecs/wm8900.o: In function `wm8900_exit':
> wm8900.c:(.exit.text+0x8): undefined reference to `i2c_del_driver'
> sound/soc/codecs/wm8988.o: In function `wm8988_i2c_probe':
> wm8988.c:(.text+0x857): undefined reference to `__devm_regmap_init_i2c'
> sound/soc/codecs/wm8988.o: In function `wm8988_modinit':
> wm8988.c:(.init.text+0xb): undefined reference to `i2c_register_driver'
> sound/soc/codecs/wm8988.o: In function `wm8988_exit':
> wm8988.c:(.exit.text+0x8): undefined reference to `i2c_del_driver'
> sound/soc/codecs/wm8995.o: In function `wm8995_i2c_probe':
> wm8995.c:(.text+0x1c4f): undefined reference to `__devm_regmap_init_i2c'
> sound/soc/codecs/wm8995.o: In function `wm8995_modinit':
> wm8995.c:(.init.text+0xb): undefined reference to `i2c_register_driver'
> sound/soc/codecs/wm8995.o: In function `wm8995_exit':
> wm8995.c:(.exit.text+0x8): undefined reference to `i2c_del_driver'
> 
> [...]

Applied to

	https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.7

Thanks!

[1/1] ASoC: wm89xx: Add missing dependency
      commit: 9bff3d3024e51122c0c09634056debcd6c7359ec

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
