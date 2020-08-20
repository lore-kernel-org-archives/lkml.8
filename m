Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D714C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 21:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29D6921734
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 21:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597960131;
	bh=Bx31esN2mPf7lmCBEMBgqpTqFifE4a0F/RsNqDpOaDA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=Ytiu6b8BGiaXMiJyhH7PSqkfbHtgo8c+IX2qj2XWF/JR4OCBOlli9cUiqEC4GZnrr
	 Hg+Ikkl51cg45LDWYBg3VuOGK+OCuldWGloPAO4L6kaL+cbCRlgfWouaRwGfDNuxRc
	 eYxuWIBlFbJgkEl47PhRKItA+6jUXE5rMMB3lyJs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbgHTVsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 17:48:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:43756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728085AbgHTVsp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 17:48:45 -0400
Received: from localhost (cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net [82.37.168.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 269C6214F1;
        Thu, 20 Aug 2020 21:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597960125;
        bh=Bx31esN2mPf7lmCBEMBgqpTqFifE4a0F/RsNqDpOaDA=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=ijTfjR6OsaRfWZCaNUqnmjQfbXkI/pNj2mfXAmnTHt7+p1c31nIWgmezY7zBpgrq4
         jsl+vrAJnzjtLwvyj3+dpHeObs0YJ1zZZrb6Lwh/TJd1OGQ+Sap6ulXiYeOmbT2etC
         SaIdajnNskIp53GCoLvacKm8lrrbUJUCaZVI0Rbw=
Date:   Thu, 20 Aug 2020 22:48:12 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Patrick Lai <plai@codeaurora.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        alsa-devel@alsa-project.org, Colin King <colin.king@canonical.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Takashi Iwai <tiwai@suse.com>,
        Ajit Pandey <ajitp@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rohit kumar <rohitkr@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <20200819160103.164893-1-colin.king@canonical.com>
References: <20200819160103.164893-1-colin.king@canonical.com>
Subject: Re: [PATCH][next] ASoC: qcom: add missing out of memory check on drvdata->clks allocation
Message-Id: <159796008815.44152.14467897806901945440.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Aug 2020 17:01:03 +0100, Colin King wrote:
> Currently drvdata->clks is not being checked for an allocation failure,
> leading to potential null pointer dereferencing. Fix this by adding a
> check and returning -ENOMEM if an error occurred.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: qcom: add missing out of memory check on drvdata->clks allocation
      commit: a467f2f8ad5f9a21f92b3fa6ad2aac90fa7054fe

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
