Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B2DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 22:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC4CA2250E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 22:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596148096;
	bh=MPDGk6EG3O5H5cWuKSvALlqOwuaO5mBhfBAqbxq8eqQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=CNevFD+DSrLpFd4xaPNMSAf/RmJ9lASGG47LelZOqh9QBhAD357cWA8VBWmLUTN11
	 YFFNSdbbf1gvwQ+F+2ij1w3qK3/OklzD5DOsPJmcNM2jBzE4h8KWuLm5weuafy4mV8
	 t6J8Kdra1v99igJ5P6zykL4VsTDIJLkn4csLphyM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730589AbgG3W2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 18:28:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:40508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730491AbgG3W2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 18:28:14 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98EF720829;
        Thu, 30 Jul 2020 22:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596148093;
        bh=MPDGk6EG3O5H5cWuKSvALlqOwuaO5mBhfBAqbxq8eqQ=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=S9W1a9FPFTqBbmMqUpWUqbK5rQxWK+p2kPij/XiBGbFjQ8HJPQpsxNtDYoRLdT4Uv
         KmqISuSiPwRgl9DgD1Axo49Fa00x5Ly55ap6+Nb0vLkkzEEWcFvDo3ibnXkFLrKe/l
         yzjsZg25Iga9ES/yjs6Peb5luaPlnQifXGHrjvM4=
Date:   Thu, 30 Jul 2020 23:27:52 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Julia Lawall <Julia.Lawall@inria.fr>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        sound-open-firmware@alsa-project.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        kernel-janitors@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
In-Reply-To: <1595751933-4952-1-git-send-email-Julia.Lawall@inria.fr>
References: <1595751933-4952-1-git-send-email-Julia.Lawall@inria.fr>
Subject: Re: [PATCH] ASoC: SOF: imx: use resource_size
Message-Id: <159614804536.1473.644625044517486054.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Jul 2020 10:25:33 +0200, Julia Lawall wrote:
> Use resource_size rather than a verbose computation on
> the end and start fields.
> 
> The semantic patch that makes this change is as follows:
> (http://coccinelle.lip6.fr/)
> 
> <smpl>
> @@ struct resource ptr; @@
> - (ptr.end - ptr.start + 1)
> + resource_size(&ptr)
> </smpl>

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: imx: use resource_size
      commit: afd842c031408f9eaf689ff417071eed15afa05e

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
