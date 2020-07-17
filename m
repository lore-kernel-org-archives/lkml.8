Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80664C433F1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 15:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 511332076A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 15:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595000414;
	bh=2c6nRX3jNeNABxpORJGm06RLtRwncH2kZnG/Bd4ptDM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=wiBFVu+/MZSaXCvxukjE+QgxXgdYQCatseJLMxZcNRovwxmnVuWLjJ3z0GEucLPUf
	 yD9b3taitPS4xI2ju4br/zFllu47JNlyDKK8f2S8n7j2+R83JJZwnEyFXXeQspGr6S
	 ItqoPAUGiuU+I4pcMq3UqV4swpCi1M4aSDEBMmvg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbgGQPkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 11:40:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:59160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726256AbgGQPkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 11:40:11 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 060B720775;
        Fri, 17 Jul 2020 15:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595000411;
        bh=2c6nRX3jNeNABxpORJGm06RLtRwncH2kZnG/Bd4ptDM=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=NhDHkDLxxoZqg+kEY6+mpBp4L5RLTz72NIdcOAxmxwyXoLbMEKXcB0KvxJj9EH4zJ
         jfsqh/NAvbUC+SuRRZXF5l18HSK5CXwUPCeMNHuE+XGkUnxt1pw9fDhNJj4I92ugoE
         GJ/Uscjqk4mk3cofGaYv1xrBqeIv+IyDbCnZmEIY=
Date:   Fri, 17 Jul 2020 16:40:00 +0100
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, lgirdwood@gmail.com, plai@codeaurora.org,
        bgoswami@codeaurora.org, Tang Bin <tangbin@cmss.chinamobile.com>,
        perex@perex.cz
Cc:     linux-kernel@vger.kernel.org,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>,
        alsa-devel@alsa-project.org
In-Reply-To: <20200714112923.14944-1-tangbin@cmss.chinamobile.com>
References: <20200714112923.14944-1-tangbin@cmss.chinamobile.com>
Subject: Re: [PATCH] ASoC: qcom: qdsp6: Use the defined variable to clean code
Message-Id: <159500037997.27597.12601442767423961502.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jul 2020 19:29:23 +0800, Tang Bin wrote:
> Use the defined variable "dev" to make the code cleaner.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: qcom: qdsp6: Use the defined variable to clean code
      commit: 4c5b809377b3c66fb3c7a3e5b03c78f6ae16fd83

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
