Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31465C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F07332054F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598539787;
	bh=BqFUTSxUc/Ju1HCKmJR/+W5ucBL8lkWX4COp4tweWik=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=YMOmP6TRLeuRrJC1C0W+WBm6IcFbSFhiG/GzsuxtGcD+hqZMxZeL6+uUSw2iPbNoH
	 cw79UeUB5+vglf8dSxPcVfsG3qOYOUrcLcHa3D952eASDgV7UeeY/CdfjqvO2QHl5n
	 GRX94RNBX9Wz9Ls47N/CZL2PuPOD11A853aE/7z4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbgH0Otp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 10:49:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:39538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728115AbgH0N6Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 09:58:16 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3042122CAE;
        Thu, 27 Aug 2020 13:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598536646;
        bh=BqFUTSxUc/Ju1HCKmJR/+W5ucBL8lkWX4COp4tweWik=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=hwAqjMewviDxBQItQUfEfRSQgnQutlirg6Npg3CE67+3sJ7AtbLMMTew6JfkR7gYV
         1JfGwWRwkp7eapIZJBT55NrKFD0f5ZapTZOKuulAr7LRZD6LrOgpkhYpISvAQ0d7Zg
         Fko3qtacqdyZ0IzAiWcLHTjWYwVu0Kx0og3apI0E=
Date:   Thu, 27 Aug 2020 14:56:50 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Akshu Agrawal <akshu.agrawal@amd.com>
Cc:     Takashi Iwai <tiwai@suse.com>,
        Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>, YueHaibing <yuehaibing@huawei.com>,
        open list <linux-kernel@vger.kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>
In-Reply-To: <20200826185454.5545-1-akshu.agrawal@amd.com>
References: <20200826185454.5545-1-akshu.agrawal@amd.com>
Subject: Re: [v2] ASoC: AMD: Clean kernel log from deferred probe error messages
Message-Id: <159853660471.29762.8889359073042281465.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Aug 2020 00:24:20 +0530, Akshu Agrawal wrote:
> While the driver waits for DAIs to be probed and retries probing,
> have the error messages at debug level instead of error.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: AMD: Clean kernel log from deferred probe error messages
      commit: f7660445c8e7fda91e8b944128554249d886b1d4

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
