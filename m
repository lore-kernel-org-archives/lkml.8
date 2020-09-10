Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D397C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 12:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 074DB206D4
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 12:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599742729;
	bh=UD5TaEy8wxsIp8mgrsHiGFMm82kAp/qRHT62V05wZ/c=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=d5A3eLiXUBWc3z+4viVDRGxzcWaVaKv2GMsaQj/9KysMllTiGj62YPcVCsG+swj7g
	 Tt8QYmwQ98az7/UN6OcxUR3MijrV8oC7qrUK4AImZQjTjmBCjbL0tQrfrgpuXPAoIV
	 ka2l0uM2nudw92V4MVpoO9NpCxSfQtr0/CqVYJp0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730896AbgIJM6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 08:58:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:35868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730694AbgIJMwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 08:52:07 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DB0B208FE;
        Thu, 10 Sep 2020 12:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599742327;
        bh=UD5TaEy8wxsIp8mgrsHiGFMm82kAp/qRHT62V05wZ/c=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=pigTNppn4yTAbkkFsKlwZKc5rp/cZDxXMIjQKcrl38XBMQDNgsoeyJbc+xT2FrbuE
         5hwVtobENa27f1/CUF47R+egESEI/eWR8qsrXlzO8BJIfLORRvXcBxqvHpmEZbL/yi
         cFr835WK9hubS7YEGVv8FrkwYDn/yzJ6a4jERk6g=
Date:   Thu, 10 Sep 2020 13:51:22 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     alsa-devel@alsa-project.org, plai@codeaurora.org,
        lgirdwood@gmail.com, robh+dt@kernel.org, tiwai@suse.com,
        bgoswami@codeaurora.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20200910101732.23484-1-srinivas.kandagatla@linaro.org>
References: <20200910101732.23484-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 0/8] ASoC: q6dsp: Add support to Codec Ports.
Message-Id: <159974228224.39114.1744393464890136484.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Sep 2020 11:17:24 +0100, Srinivas Kandagatla wrote:
> LPASS IP on SoCs like SM8250 has Digital Codec part integrated into it.
> This ports are exposed in Q6DSP as Codec ports. This patchset adds
> support to those q6afe ports along with q6routing and q6afe-dai.
> 
> This patchset has been tested along with other patches on
> Qualcomm Robotics RB5 Platform with Soundwire and WSA8815 Codec.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/8] ASoC: q6dsp: q6afe: add support to Codec DMA ports
      commit: 150b2e86c54ad09c26e60f32925aeaf1fca1a5d3
[2/8] ASoC: q6dsp: q6routing: add support to Codec DMA ports
      commit: 825492cb518bcf654e9205b3c723585191314d1a
[3/8] ASoC: q6dsp: q6afe: prepare afe_apr_send_pkt to take response opcode
      commit: 342a4f8ca12b1cac812151b05f8a837eebc6885c
[4/8] ASoC: q6dsp: q6afe: add global q6afe waitqueue
      commit: 181202d021f51d4c0442e71adc34e9629a35a6d8
[5/8] ASoC: q6dsp: q6afe: add lpass hw voting support
      commit: 55e07531d922540c656c7fc2e21d76e1b751f279
[6/8] ASoC: q6dsp: q6afe: update q6afe_set_param to support global clocks
      commit: 84ab3b9f19f6ff0bb5df6c6deea75ab4c1d2aff8
[7/8] ASoC: q6dsp: q6afe: add codec lpass clocks
      commit: 0c3e35fc1ebe22a5254ba3bff2599a2c49b00abe
[8/8] ASoC: q6dsp: q6afe-dai: add support to Codec DMA ports
      commit: 1fdbcfa9fdee6f9cc00129f0f5ed0ff29cfef646

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
