Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E178DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA0FA20C56
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593795864;
	bh=/bHCXUtCQnJvcopt0WJM7dRf94ru/1B7osnqoMSQf5M=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=d5FNxXTjXBxvQoJRpEFPiIrYTwCg15usQ6s53sP/wnLYDdwlDPgN7nbVdl24KRBLQ
	 trEw9EZmid4NzR/NR1rYRVV9EHaYdGg+uo0Dledvi+Th4yAntBxnshOs7f4Uzg/a+Q
	 3VSexacX7/DPrWg/PB18qfdw1INmZfovUOvF/Boc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbgGCREX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 13:04:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:33988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726560AbgGCREW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 13:04:22 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC8FC208C7;
        Fri,  3 Jul 2020 17:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593795862;
        bh=/bHCXUtCQnJvcopt0WJM7dRf94ru/1B7osnqoMSQf5M=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=Oh/Tqa+7ZTrM036HV+frLGeev1dOeWV6LGGqzfIDlMwvP3iQ/OefBKVKIQjI5OEOE
         POjsYDgQhmodPMX+TyNLZiTct3BfMDzgxChnPbWHNUs+alC4pxxnHZa9PpJUAjpj40
         x6p2pl6gCbKR2ORU3nvjaRltQVdwfTU4XfX1xnBM=
Date:   Fri, 03 Jul 2020 18:04:20 +0100
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>
In-Reply-To: <20200703103315.267996-1-mkl@pengutronix.de>
References: <20200703103315.267996-1-mkl@pengutronix.de>
Subject: Re: [PATCH] regmap: dev_get_regmap_match(): fix string comparison
Message-Id: <159379586016.55960.11665038090774501749.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Jul 2020 12:33:15 +0200, Marc Kleine-Budde wrote:
> This function is used by dev_get_regmap() to retrieve a regmap for the
> specified device. If the device has more than one regmap, the name parameter
> can be used to specify one.
> 
> The code here uses a pointer comparison to check for equal strings. This
> however will probably always fail, as the regmap->name is allocated via
> kstrdup_const() from the regmap's config->name.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: dev_get_regmap_match(): fix string comparison
      commit: e84861fec32dee8a2e62bbaa52cded6b05a2a456

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
