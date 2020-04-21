Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE917C54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 18:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C24902072D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 18:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587493353;
	bh=FwcHGUYdMnDibj/tRCqmioRk8NJPli42GayBPx027Pw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=PWya0Zlh7BkEhEKe5JUYxwJ5+zwnRI+mNeZU7IVC+7JfpVfF9fdzrh+63v3F0Ggjn
	 VZC9n3oQuZpWYNR4VcD1L/18AO9tb8rmd8C0dQmOktILW6AopyjkWzzIUcEn19Gio0
	 dkPwEbf9MuU6WMDuAVutcAJU3t2YeVcb7fz4gDvU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729429AbgDUSWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 14:22:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:35314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbgDUSWc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 14:22:32 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56F05206D9;
        Tue, 21 Apr 2020 18:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587493351;
        bh=FwcHGUYdMnDibj/tRCqmioRk8NJPli42GayBPx027Pw=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=eK2EvRMqCoy5KAlgM/CatYGa7aZv9+O9BbdwG0SYk1b29oAlt7ThQMoKL3REtyXkO
         rpz4apg98lYR4E9JXQTCCofMqT6leAp9UCThGk2rPKjkEJOa2eZovD9dUgaFdZUniE
         2orodMJywuJiOar76mwN+At/k9AiGOztnVPpN56Q=
Date:   Tue, 21 Apr 2020 19:22:29 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Xiubo.Lee@gmail.com, devicetree@vger.kernel.org,
        nicoleotsuka@gmail.com, perex@perex.cz, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, Shengjiu Wang <shengjiu.wang@nxp.com>,
        timur@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        festevam@gmail.com, tiwai@suse.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <cover.1587038908.git.shengjiu.wang@nxp.com>
References: <cover.1587038908.git.shengjiu.wang@nxp.com>
Subject: Re: [PATCH v9 0/7] ASoC: Add new module driver for new ASRC
Message-Id: <158749333764.13706.16975370508037163881.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Apr 2020 20:25:30 +0800, Shengjiu Wang wrote:
> Add new module driver for new ASRC in i.MX8MN, several commits
> are added for new property fsl,asrc-format
> 
> Shengjiu Wang (7):
>   ASoC: fsl_asrc: rename asrc_priv to asrc
>   ASoC: dt-bindings: fsl_asrc: Add new property fsl,asrc-format
>   ASoC: fsl-asoc-card: Support new property fsl,asrc-format
>   ASoC: fsl_asrc: Support new property fsl,asrc-format
>   ASoC: fsl_asrc: Move common definition to fsl_asrc_common
>   ASoC: dt-bindings: fsl_easrc: Add document for EASRC
>   ASoC: fsl_easrc: Add EASRC ASoC CPU DAI drivers
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.8

Thanks!

[1/7] ASoC: fsl_asrc: rename asrc_priv to asrc
      commit: 7470704d8b425c4c7045884690f92cf015563aac
[2/7] ASoC: dt-bindings: fsl_asrc: Add new property fsl, asrc-format
      commit: b84b4c9a688d803b0e7cf91fec9a5d8b3ba47768
[3/7] ASoC: fsl-asoc-card: Support new property fsl, asrc-format
      commit: 859e364302c510cfdd9abda13a3c4c1d1bc68c57
[4/7] ASoC: fsl_asrc: Support new property fsl,asrc-format
      commit: 4520af41fd21863d026d53c7e1eb987509cb3c24
[5/7] ASoC: fsl_asrc: Move common definition to fsl_asrc_common
      commit: be7bd03f0201b5a513ced98c08444a140eab92ea
[6/7] ASoC: dt-bindings: fsl_easrc: Add document for EASRC
      commit: a960de4da241d409a73e318ab19e6b5fdcd95a83
[7/7] ASoC: fsl_easrc: Add EASRC ASoC CPU DAI drivers
      commit: 955ac624058f91172b3b8820280556e699e1e0ff

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
