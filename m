Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49679C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C4DC20773
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594131447;
	bh=nqNaTEsJJ1BX5Ar+tPUZJmqbadwF/kx214S3Z0T5Vjk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=ioEipgCnFmucPJRNO6yrepKZhFz9QTIoWQYOTXpMRd+DgCDDJ+gpoKY6Qb3mWUTOb
	 uVDF80iSkpaZJDAPjWbObrZ/lDSWsaNiCypHjABr+JGtiSoDqieMG5M8xqsMGHCEvU
	 7rbKAnAG7CGhKRwhl++ce47tHQuJlAF073BgmPlA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728246AbgGGORZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 10:17:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:51774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728225AbgGGORY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 10:17:24 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FBFA20771;
        Tue,  7 Jul 2020 14:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594131444;
        bh=nqNaTEsJJ1BX5Ar+tPUZJmqbadwF/kx214S3Z0T5Vjk=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=hhky3TmYhv5JgVIPZTtSGNTNyit59gQIgJ7yZrPoLAZWcOTEvhyMxTkX/x2jlA+me
         FRrTV8Y1+s3opu5QE9dLXJbHzhNfgp50H2uXy3ilQLhk2Ny0qXxEQ0kFkAjb4lWuOu
         M2yrWLlhJebgVEaY/txw4w+NXtGL6LBAWwIN9yuk=
Date:   Tue, 07 Jul 2020 15:17:20 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        alsa-devel@alsa-project.org
Cc:     Alexander.Deucher@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        hui.wang@canonical.com, Takashi Iwai <tiwai@suse.com>
In-Reply-To: <1594118813-18689-1-git-send-email-Vijendar.Mukunda@amd.com>
References: <1594118813-18689-1-git-send-email-Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH] ASoC: amd: add ACPI dependency check
Message-Id: <159413142467.34737.8485886141400585716.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jul 2020 16:16:41 +0530, Vijendar Mukunda wrote:
> Add ACPI dependency for evaluating DMIC hardware
> runtime.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: add ACPI dependency check
      commit: 68d1abe186d1c865923d3b97414906f4697daf58

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
