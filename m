Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 432A7C433E5
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 20:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 131CE2086A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 20:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595535616;
	bh=m9fN9R0RLf9EORdUqrD39Ga3LCQrNVMins4vQKdmgkY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=JIaBEbW7ceKPNx7d4z/1GV3S0CbF5NtG5zQnAWtdIjkNulDKuT5+rH40nEp5VOP+f
	 qeIki8zKREegreEPmbp1hZI3KSbXDImWw3ZvJZoRtHIZkVQ6SHcrHrxzVrpIsaBSQb
	 N/bg2QYXClee+o2gZGQMzB/DihQc34Avq90+dvCA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgGWUUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 16:20:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:35422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725979AbgGWUUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 16:20:14 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEAF12065F;
        Thu, 23 Jul 2020 20:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595535614;
        bh=m9fN9R0RLf9EORdUqrD39Ga3LCQrNVMins4vQKdmgkY=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=Qj9Kudv4h9bucJglhlPdbHIU7UvfhGkLfQcS+L02jHfVyGKoUvpucoKbGN9RmmFiX
         PHcid1k8dmgQdun0E+mvOz2ViY0iel/N2rio1oIfSiBlSkM5n+pQx2f8uQMD/dkG/G
         gkwjjg1IuWmdeKf0NdnlqV+1SFc1Z59yJxbfscbY=
Date:   Thu, 23 Jul 2020 21:19:59 +0100
From:   Mark Brown <broonie@kernel.org>
To:     perex@perex.cz, nicoleotsuka@gmail.com,
        Shengjiu Wang <shengjiu.wang@nxp.com>, festevam@gmail.com,
        Xiubo.Lee@gmail.com, devicetree@vger.kernel.org, tiwai@suse.com,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com, timur@kernel.org,
        robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <1595302910-19688-1-git-send-email-shengjiu.wang@nxp.com>
References: <1595302910-19688-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH 1/2] ASoC: fsl-asoc-card: Support configuring dai fmt from DT
Message-Id: <159553557415.41908.10792905322230723477.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jul 2020 11:41:49 +0800, Shengjiu Wang wrote:
> Support same propeties as simple card for configuring fmt
> from DT.
> In order to make this change compatible with old DT, these
> properties are optional.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: fsl-asoc-card: Support configuring dai fmt from DT
      commit: 08b54b5e38e67b7e99f71b35cb8841b53e006759
[2/2] ASoC: bindings: fsl-asoc-card: Support properties for configuring dai fmt
      commit: ca168352cf94bbbc523794f2a2972adcf84d8639

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
