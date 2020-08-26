Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A67C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 19:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1BFB2078A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 19:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598469483;
	bh=JmBM+nkl0t+UofWg4Gi1xS0o3nBQu5RONor3hOBJoqE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=nGt7ScXjIiulDnKjWriBYJNdjLAiBUtGRePhPfvOrh5yOvQjekXsxN2dXSzjJZODO
	 4yP2AVJdLNjJTcwzar79y6KXWmVaFTL12CAme96xU6+eG+JkkoMad82c1T9D9kToP2
	 0FNIWeU2wT9lY4VrzvFKLms0tHtaXu2CYYQUyA2c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbgHZTR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 15:17:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:40376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726940AbgHZTRV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 15:17:21 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D43552078A;
        Wed, 26 Aug 2020 19:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598469441;
        bh=JmBM+nkl0t+UofWg4Gi1xS0o3nBQu5RONor3hOBJoqE=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=PNJRCD+cKqy2Mvyvk8mEF8MpHMrU/Fy/KvJ4bIblOU22Mdh+2ISANcpiOOK+il/Fo
         mXvPO7D2WwrBryg83KPXAjKWyZpqsbNG52DuxZZ7gq5q/gHAPsHU2V/BQCrANihDeI
         l1H6Mq7+p7vPvcoUOejRI4ltWrit/YNGe8aF6aNY=
Date:   Wed, 26 Aug 2020 20:16:45 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>, kjlu@umn.edu
Cc:     Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        Patrick Lai <plai@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Takashi Iwai <tiwai@suse.com>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20200820042828.10308-1-dinghao.liu@zju.edu.cn>
References: <20200820042828.10308-1-dinghao.liu@zju.edu.cn>
Subject: Re: [PATCH] ASoC: qcom: common: Fix refcount imbalance on error
Message-Id: <159846939972.39744.13708543764168639585.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Aug 2020 12:28:27 +0800, Dinghao Liu wrote:
> for_each_child_of_node returns a node pointer np with
> refcount incremented. So when devm_kzalloc fails, a
> pairing refcount decrement is needed to keep np's
> refcount balanced.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: qcom: common: Fix refcount imbalance on error
      commit: c1e6414cdc371f9ed82cefebba7538499a3059f9

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
