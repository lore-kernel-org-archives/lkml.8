Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F325C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 16:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E293207ED
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 16:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589820069;
	bh=jRbpGL6pqSTPo5yiSCfss3nZLr8Rmj8NTRgHNTYXRHU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=LuUBzezh9whG+xaTeoEUT/b5a4GwQpNHxqr6FzYsTn7f487PeAG5DWrvAqxfhvXtY
	 l0Ty22sB1Couw0RKPAYNzv89gGMTR3zrEBal+9SgEf44K0USODcnqBRFJNNI+haE7h
	 tD3YgMjT71qDGN2aSVaCb3QZuwD8bOUjBbAPCsbw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgERQlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 12:41:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:35916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726958AbgERQlI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 12:41:08 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F08B4207D8;
        Mon, 18 May 2020 16:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589820067;
        bh=jRbpGL6pqSTPo5yiSCfss3nZLr8Rmj8NTRgHNTYXRHU=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=2LIzKnkEMKZvLrbEbUuIWtqnqk64hhSkpe0BUbMyiZR9SvmbOkGkGnZCAA2hScimr
         o/wDOKDVMRlCbALLIUoVB+3SUnXEc6eAOzKlICpHnx/w0dJ9mADeSA2ESYcg2B3LUM
         Kzt66ANlAtSjIVLQCjr1YycUeDHF+P/CjzGOrMGw=
Date:   Mon, 18 May 2020 17:41:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Akshu Agrawal <akshu.agrawal@amd.com>
Cc:     Takashi Iwai <tiwai@suse.com>,
        Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Colin Ian King <colin.king@canonical.com>,
        open list <linux-kernel@vger.kernel.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>
In-Reply-To: <20200518043913.40646-1-akshu.agrawal@amd.com>
References: <20200518043913.40646-1-akshu.agrawal@amd.com>
Subject: Re: [PATCH] ASoC: amd: raven: Make the driver name consistent across files
Message-Id: <158982005877.28736.13490689793680227152.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 May 2020 10:09:05 +0530, Akshu Agrawal wrote:
> This fixes the issue of driver not getting auto loaded with
> MODULE_ALIAS.
> 
> With this patch:
> $find /sys/devices -name modalias -print0 | xargs -0 grep -i acp3x
> /sys/devices/pci0000:00/0000:00:08.1/0000:03:00.5/acp3x_i2s_playcap.2/
> modalias:platform:acp3x_i2s_playcap
> /sys/devices/pci0000:00/0000:00:08.1/0000:03:00.5/acp3x_i2s_playcap.0/
> modalias:platform:acp3x_i2s_playcap
> /sys/devices/pci0000:00/0000:00:08.1/0000:03:00.5/acp3x_rv_i2s_dma.0/
> modalias:platform:acp3x_rv_i2s_dma
> /sys/devices/pci0000:00/0000:00:08.1/0000:03:00.5/acp3x_i2s_playcap.1/
> modalias:platform:acp3x_i2s_playcap

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.8

Thanks!

[1/1] ASoC: amd: raven: Make the driver name consistent across files
      commit: f0a77d2b0e1ccad7e4086094f67d138e8c3050a2

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
