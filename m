Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06EECC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE1D5206A1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593467202;
	bh=PRzEUjCwFdEbb2h7LthoNz2Fd8Gh9/Q8utmKomXm5U8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=W8WgI5E1VCNrWCul4DYh15THXYDlrcdxWLxn0HTHyGz9zQEhprUsXldN75AjyotLA
	 /OhvsYmfqZlE4hf7bNuNPiAbd3JMELko5Sj4NbQA1jkja116lHvG2SDbIyHliRP7Z5
	 Cp2ibGFZgLu2F4mbR+M6hjUN1R2KlzDMBm248dQM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403962AbgF2Vql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:46:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:56764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726765AbgF2Sft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:35:49 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9520255CB;
        Mon, 29 Jun 2020 18:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593454524;
        bh=PRzEUjCwFdEbb2h7LthoNz2Fd8Gh9/Q8utmKomXm5U8=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=Cjie/f2sybCATA4dkTGFcdf59jIZLIWBY4SBWEoNDYh68xvujTFZ817yIvQtB6lI+
         +9A/rMEaV7xPEijchgYYTDVRYRuTK28yEMdGLgZwWY15w/4gCz9kTkEzy03QVGT4ZI
         JDzvQ3bLdUv9oA55zVyE9o5Mvdwp5zqxSnqSsIaI=
Date:   Mon, 29 Jun 2020 19:15:22 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com
Cc:     robh@kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20200626154143.20351-1-dmurphy@ti.com>
References: <20200626154143.20351-1-dmurphy@ti.com>
Subject: Re: [PATCH 1/4] ASoC: tas2562: Add right and left channel slot programming
Message-Id: <159345450675.54191.5281354512647747070.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jun 2020 10:41:40 -0500, Dan Murphy wrote:
> Add programming for the tdm slots for the right and left. This also
> requires configuring the RX/TX offsets for the DAI format type.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: tas2562: Add right and left channel slot programming
      commit: d7bd40ae55ce339a3c9be7fc2087c671d3d80894
[2/3] ASoC: tas2562: Add voltage sense slot property
      commit: f10b6c99c08433861d1ed62267fa57ced7dbdf50
[3/3] ASoC: tas2562: Add voltage sense slot configuration
      commit: 09ed395b05feb7d0f77ab52c48d2f77c1b44d2ab

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
