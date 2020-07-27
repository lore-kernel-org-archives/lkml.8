Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DADF2C433FC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 13:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A37962074F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 13:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595858230;
	bh=kU5PVciGwJeECNv1giAjq0Weunv/9iuJSQi6OmpPGe8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=jVgnV07dpdV1baYUTrqQzwjoxzRmgKc6ipuPjv8ivq7aEIYrTB96HU8dlSRYq0aM2
	 18geGhEkaXgTOdrRApD+JwI58HhhIpS7P0XYrV65dqaujadeuZjSZFLzJfb7PRGiFo
	 cKpYwLqlr5smF1C0oeDCOyP3m2y87cTZzW2vhFQM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbgG0N5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 09:57:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:46892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728873AbgG0N5F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 09:57:05 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 468DF2074F;
        Mon, 27 Jul 2020 13:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595858224;
        bh=kU5PVciGwJeECNv1giAjq0Weunv/9iuJSQi6OmpPGe8=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=a8WL01Wz6KzC1keNhS4+xS2Kje6D+nIgppB2IHx77K/nBCPkmvqelBh6zpepLsBjb
         wzsAhGl1JQy4MJxFWhips+pRGnsO+y5GSHvCzWxxtByXBpGSAB7YGNwoYHItBF17L4
         dzyLhI4sHmi1BcZLQXKbAd4tWfquSk2rMrNkdcIo=
Date:   Mon, 27 Jul 2020 14:56:47 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Pi-Hsun Shih <pihsun@chromium.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Yicheng Li <yichengli@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
In-Reply-To: <20200724080358.619245-1-pihsun@chromium.org>
References: <20200724080358.619245-1-pihsun@chromium.org>
Subject: Re: [PATCH] platform/chrome: cros_ec: Fix host command for regulator control.
Message-Id: <159585820266.22516.18324449635576565431.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jul 2020 16:03:55 +0800, Pi-Hsun Shih wrote:
> Since the host command number 0x012B conflicts with other EC host
> command, add one to all regulator control related host command.
> 
> Also fix a wrong alignment on struct and sync the comment with the one
> in ChromeOS EC codebase.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] platform/chrome: cros_ec: Fix host command for regulator control.
      commit: a233547660a3915973d41e2a9a0923d0cf317a62

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
