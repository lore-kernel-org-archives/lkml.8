Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADFF8C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 15:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8819D2063A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 15:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592233541;
	bh=iQxR19VvnbxFvIXIUb0hXUuSs206NScmeWUhnXmjM9M=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=h7T0qlLQzoem6Zx/0FTjk1bDduPuGubKelepwN0Fztw6oE2VNH6GWavboVZ7m0mnz
	 iSBbnikQzq6BbpODIbXQlbMuO1WG9ujRhyNiFN/aQDalvoUqRnTTTOU4AEnhQ0V4vW
	 FeMqlhMInRP02bWudVEqodmJZm5RZuc2RhjlHABQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730893AbgFOPFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 11:05:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:50228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730877AbgFOPFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 11:05:38 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4962520739;
        Mon, 15 Jun 2020 15:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592233537;
        bh=iQxR19VvnbxFvIXIUb0hXUuSs206NScmeWUhnXmjM9M=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=IHNPQmqX1tGZkLo5Ha6lNSoK2zKTaLBn3QCA8GwvAGOwBfH+xUM1xb0Krd0TuKkJV
         PsVYgYjiPqcHDNVfD5OHLLMmEQ3qeAsWcj+DuLqLNCOH2mOfq26+g/uCK8rBxTLtKz
         aAUKTiqPJg7c82OFgzYsPdXy3pvWHEkc5tOnv5xE=
Date:   Mon, 15 Jun 2020 16:05:35 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org, John Stultz <john.stultz@linaro.org>,
        vkoul@kernel.org, lgirdwood@gmail.com, tiwai@suse.com,
        alsa-devel@alsa-project.org
In-Reply-To: <20200612123711.29130-1-srinivas.kandagatla@linaro.org>
References: <20200612123711.29130-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 1/2] ASoc: q6afe: add support to get port direction
Message-Id: <159223353044.8967.4267093488191293280.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jun 2020 13:37:10 +0100, Srinivas Kandagatla wrote:
> This patch adds support to q6afe_is_rx_port() to get direction
> of DSP BE dai port, this is useful for setting dailink
> directions correctly.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoc: q6afe: add support to get port direction
      commit: 4a95737440d426e93441d49d11abf4c6526d4666
[2/2] ASoC: qcom: common: set correct directions for dailinks
      commit: a2120089251f1fe221305e88df99af16f940e236

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
