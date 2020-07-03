Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F51DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EF822145D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593795849;
	bh=oZBcivQgPufrQ0CRdFADQmR1QahIJ/BXtZ0XT8q6m6Q=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=jAp9WiVndh18Z0R75SDrwJTvu38Le4VhF6SQyabTLikKrX2mnyGWvuvRQ/RN4Z5pF
	 tDdTryRjdcB1eGRRvpQ7+2hhv1Ezga+9DeEJXETLBlnzbhtEkACey6IcAOF7x9wY91
	 hRcZVVI+FQS+bx/NYly6alKnz3224ZxttvZHhYpo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbgGCREH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 13:04:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:33746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726632AbgGCREG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 13:04:06 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E10052100A;
        Fri,  3 Jul 2020 17:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593795846;
        bh=oZBcivQgPufrQ0CRdFADQmR1QahIJ/BXtZ0XT8q6m6Q=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=lZe1eYyULbDltiEUt/z1MLLTN/fzOzbKWl+sKZc09u+xXMRKnm/cZbfN9fBXNPIjL
         0d1+D4wy3sZSYoG2klLYRlWhGkjOMwMuDYFaShDsAaSZzhF4+Cs4FawGbwjubHnT1i
         zBIFvMD2Io66Ckdgj2SUnIifSZNP3gK28pp6n7Q8=
Date:   Fri, 03 Jul 2020 18:04:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        alsa-devel@alsa-project.org
Cc:     Alexander.Deucher@amd.com,
        open list <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>, hui.wang@canonical.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <1593710826-1106-1-git-send-email-Vijendar.Mukunda@amd.com>
References: <1593710826-1106-1-git-send-email-Vijendar.Mukunda@amd.com>
Subject: Re: [RESEND PATCH V3] ASoC: amd: add logic to check dmic hardware runtime
Message-Id: <159379581381.55795.8623430713343303232.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Jul 2020 22:56:52 +0530, Vijendar Mukunda wrote:
> Add logic to check DMIC hardware exists or not on
> the platform at runtime.
> 
> Add module param for overriding DMIC hardware check
> at runtime.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: add logic to check dmic hardware runtime
      commit: 9e0d21e1210ffe27682a5ef71209af57f975b0d3

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
