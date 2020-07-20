Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 973BCC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 14:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67C7A22C9D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 14:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595255908;
	bh=//VcV50sd9tJfeIlah/mgh0sXpaKA3AM9BA89bGtJik=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=mLxhwJbs8wBk1pTGXZfAQQuHJwNbej96LwAEQ022buxCIGYmNcQ4T3Ry/kFAFtXO0
	 5gbwLxncHRRInfslcbDa7PSBT9E1Lew0YwyVDkO54qZkK4LcVDkj3YvvVEuVWdY5rk
	 AJmT4DW6SeOrE2cAN+ONNjStNZccChZ3qbrHJbKw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbgGTOi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 10:38:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:60800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbgGTOi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 10:38:27 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C15122482;
        Mon, 20 Jul 2020 14:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595255906;
        bh=//VcV50sd9tJfeIlah/mgh0sXpaKA3AM9BA89bGtJik=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=ZxGavlJ3VVn396J9cgbir70V/1RmjPJzHG4K+YtI7ok4nWGDlpDWk8NoBdpCieNXf
         mlamUVuaTZZBTbuGZIyi0uok1mHPUu+jtPJueydAgTv21n5/DsQIPKhUEYzhVoViBO
         3aT19mJsdM4JCtM3J38+lt8ODaORFASEOOFcS5OE=
Date:   Mon, 20 Jul 2020 15:38:14 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Stephen Warren <swarren@nvidia.com>, alsa-devel@alsa-project.org
In-Reply-To: <20200719180912.30770-1-rdunlap@infradead.org>
References: <20200719180912.30770-1-rdunlap@infradead.org>
Subject: Re: [PATCH] ASoC: tegra20_das.h: delete duplicated words
Message-Id: <159525589435.6792.4381959603221775343.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Jul 2020 11:09:12 -0700, Randy Dunlap wrote:
> Delete the doubled word "to" in two comments.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tegra20_das.h: delete duplicated words
      commit: e1b4a53df26956620fc093219a725f44405db781

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
