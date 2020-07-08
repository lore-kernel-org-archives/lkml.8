Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C55FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EDCE2078D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594227627;
	bh=N7zc2EeHk3r0bhTq3OgKegYaJEeQCtjXoaIweWas5ac=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=EviboS3TxfcZADZX+5MZRMXyb9eyWh3r8al+wo0pYDt/DuzceGyY9Ojfa4dYwupLE
	 4rowbFQ/hOvqjVeluJwRluG2viSKGtHudt5mkhDsI///aqWD5gEf/X3s1tbJ5XvICZ
	 VBeAXBBZsZ04iogxgevzs0HctO1cSQTnCWZTMCU0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730660AbgGHRA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 13:00:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:36704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbgGHRAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 13:00:25 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4DCD206F6;
        Wed,  8 Jul 2020 17:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594227625;
        bh=N7zc2EeHk3r0bhTq3OgKegYaJEeQCtjXoaIweWas5ac=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=ANGvFU+FrmeS3EjWD++6/jhDsQ+yknawZY+4glld97t0R+O+WyHaKy4n8AMWKxVn6
         PsfgPUe7IniSEtFTp+McMdwHEM3HaLDrK82LbU1iMcYkfTb0fyn5cJUS/ZA6DdhuwC
         kOrq8rmIMVpBUZes4c6yKhIItueWSDe+9RlKhAHQ=
Date:   Wed, 08 Jul 2020 18:00:20 +0100
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc:     Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>,
        rdunlap@infradead.org, Alexander.Deucher@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <1594147044-25582-1-git-send-email-Vijendar.Mukunda@amd.com>
References: <1594147044-25582-1-git-send-email-Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH] ASoC: amd: fixed kernel warnings
Message-Id: <159422758800.28431.7689040196790188529.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Jul 2020 00:07:11 +0530, Vijendar Mukunda wrote:
> This patch will fix unused variables kernel warnings when
> CONFIG_ACPI is disabled.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: fixed kernel warnings
      commit: ee3d133972f1e5d260891c4dd58adb005014414a

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
