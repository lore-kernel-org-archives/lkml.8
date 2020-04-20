Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74282C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 14:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5163A21473
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 14:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587392860;
	bh=dcc8TEqP56glDATskmdRD92f9tPx8qJ1MkwXi6NrCrs=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=uA2rYAXLJNdawXoJywu3Cj9/uP+1S7pzAWs8/K67zZ9kwupRyAA64FvfxQmlTWv04
	 e1WQcQfBIQQImwiBzhi5iXeh8KFZJZhGV25DItR4csGsTiMLAljqh6WNkbPpMuOkwr
	 pSPeaCL18QXshMHMaxJhTBeimaDyR/Ncux5c8lB8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729882AbgDTO1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 10:27:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:39634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727067AbgDTO1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 10:27:38 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 869BF20857;
        Mon, 20 Apr 2020 14:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587392858;
        bh=dcc8TEqP56glDATskmdRD92f9tPx8qJ1MkwXi6NrCrs=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=OD/T4g2CfIXPiogmjau5DsHG3oZy32csl9YVP2aayvGI917uMuHOBbAwTkpaogeO9
         KitpUbWRJNFfhkUh8HX2hlHY46aa/WTwccDb3iNxetnk43GzM1h+mjqjKN5gayXnq9
         sZWRZaU84sEhapUmifPyayJ1Q7dutahhq1ERRtK4=
Date:   Mon, 20 Apr 2020 15:27:35 +0100
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, Wei Li <liwei391@huawei.com>,
        rdunlap@infradead.org, lgirdwood@gmail.com, geert@linux-m68k.org,
        perex@perex.cz
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20200420202410.47327-1-liwei391@huawei.com>
References: <20200420202410.47327-1-liwei391@huawei.com>
Subject: Re: [PATCH 0/2] ASoC: Fix dependency issues of SND_SOC
Message-Id: <158739283776.7647.4620361063260583314.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Apr 2020 04:24:08 +0800, Wei Li wrote:
> Fix dependency issues of SND_SOC introduced by commit ea00d95200d02 
> ("ASoC: Use imply for SND_SOC_ALL_CODECS").
> 
> Wei Li (2):
>   ASoC: wm89xx: Fix build errors caused by I2C dependency
>   ASoC: Fix wrong dependency of da7210 and wm8983
> 
> [...]

Applied to

	https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.7

Thanks!

[1/2] ASoC: wm89xx: Add missing dependency
      commit: 9bff3d3024e51122c0c09634056debcd6c7359ec
[2/2] ASoC: Fix wrong dependency of da7210 and wm8983
      (not applied)

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
