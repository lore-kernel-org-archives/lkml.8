Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8FC7C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 22:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C21D207E8
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 22:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593642216;
	bh=DYqARSnCtlPBrpflkw8bT5Zj9BAykb0yE49xPHHJyps=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=RcRYYCxodW8z8NT6LW6cQkZT2Q65IhxhdBF5Q+7t/uc6fnemsfKkkuuuz82xItl/H
	 mfC2AnT+1sVepdfmL8/oatxVU0mREde+fk5Ez4WQGTHFW1+yJFJkrVI514bjL8QlCa
	 LdaPbGrv3ZV2Vcl4zHJQD7Ts8K01YF1K5m/1Irfc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbgGAWXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 18:23:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:50554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727927AbgGAWXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 18:23:33 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B00620780;
        Wed,  1 Jul 2020 22:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593642213;
        bh=DYqARSnCtlPBrpflkw8bT5Zj9BAykb0yE49xPHHJyps=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=pkC2YTheBpYbouxzkNxejigarsGzb9cr08BPrDq3OSgiDqEjwa9aBb5unIaNecMat
         FIlWo4FuGFQoe1dO23XmzHTgcb/i6nrDTxaKMHRWLR9IS4aWGkSkFKTsQLgY1LKEth
         VdrCaEwnpDEyxv97VR2gLbzfJqTABqPWB/0YYUyQ=
Date:   Wed, 01 Jul 2020 23:23:30 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>
Cc:     Akshu Agrawal <akshu.agrawal@amd.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Alexander.Deucher@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
In-Reply-To: <20200630092242.7799-1-Vishnuvardhanrao.Ravulapati@amd.com>
References: <20200630092242.7799-1-Vishnuvardhanrao.Ravulapati@amd.com>
Subject: Re: [PATCH] ASoC: amd: Rectifying Unbalanced pm_runtime_enable! issue
Message-Id: <159364215573.10630.7871796105365171501.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jun 2020 14:52:38 +0530, Ravulapati Vishnu vardhan rao wrote:
> When snd_pci_acp3x driver loads we see:
> 
> WARNING kernel:snd_pci_acp3x 0000:04:00.5: Unbalanced pm_runtime_enable!
> at boot time.
> same can be observed in /var/log/messages/.
> 
> Modifying pm runtime sequence for fixing unbalanced pm issue.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: Rectifying Unbalanced pm_runtime_enable! issue
      commit: ad922ca199b38974dbe392e2faeba3aadf461ac2

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
