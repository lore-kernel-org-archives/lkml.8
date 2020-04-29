Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC09DC83006
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 16:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 943D320787
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 16:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588177570;
	bh=pEbrmIswVyccn7pcll0ZqDv96VFk0WJzWxqs+hO+orA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=aTvy43TYGrGQFqfvcqRrQLryq1zdACaS3hnVkjnVly4jtN71FIy0Uvj8KNdIDn73N
	 Fw9zyTS1ns98Ms4PfbqKx39SDsQAbuCFppAiAp86lURzbiRX5SrLJUmcZ2mQeESSsX
	 6VTxtfiO7oWnWO9gUlou9j+tklJhC3dSP4lcc6rA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbgD2Q0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 12:26:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:42048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726481AbgD2Q0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 12:26:09 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABFDD2076B;
        Wed, 29 Apr 2020 16:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588177569;
        bh=pEbrmIswVyccn7pcll0ZqDv96VFk0WJzWxqs+hO+orA=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=bDixAielSDNhTG+NMPOqLNDc+jJnN/n22O7Rg23e8T+UH700Y3k2KN8uzM0qxLPkx
         EwY2WTEvHfVrWxTTEYEIKmzwa3K9ZbjjjpjUoLXxGVPqNjZqMGFPlb0kjU8+etwO+i
         HUyqHKP0FJgSeL+bOlXJktU0zY0TYIbvPfKZk8Tk=
Date:   Wed, 29 Apr 2020 17:26:06 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Takashi Iwai <tiwai@suse.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Shreyas NC <shreyas.nc@intel.com>
In-Reply-To: <20200428214754.3925368-1-arnd@arndb.de>
References: <20200428214754.3925368-1-arnd@arndb.de>
Subject: Re: [PATCH] ASoC: component: suppress uninitialized-variable warning
Message-Id: <158817756637.27768.10087269743867746681.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Apr 2020 23:47:31 +0200, Arnd Bergmann wrote:
> Old versions of gcc (tested on gcc-4.8) produce a warning for
> correct code:
> 
> sound/soc/soc-compress.c: In function 'soc_compr_open':
> sound/soc/soc-compress.c:75:28: error: 'component' is used uninitialized in this function [-Werror=uninitialized]
>   struct snd_soc_component *component, *save = NULL;
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.8

Thanks!

[1/1] ASoC: component: suppress uninitialized-variable warning
      commit: be16a0f0dc8fab8e25d9cdbeb4f8f28afc9186d2

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
