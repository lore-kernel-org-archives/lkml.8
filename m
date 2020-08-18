Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4843BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 17:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22D192067C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 17:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597770032;
	bh=4gVroXx6tPy8Wio1f0AQkYtUzfcdtPAG/dsn6VeJBKg=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=2N8CNCWcTC75AlcByacAIXg0T19m8r3f2UfgtvXTEW+TQ7OizQME6huD1WRyAXV7+
	 GtpEQKPODBwW8l4Dyob7ZRGusvmvz9kbzPE63TTMx5I4+S9Mc+Kni3aEYD9bRgFKz0
	 3kXKsiw8c7myWHabqJC5GvTjWbGSripvddEoMyuE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgHRRA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 13:00:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:39614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728527AbgHRQ4t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 12:56:49 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB32E207D3;
        Tue, 18 Aug 2020 16:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597769809;
        bh=4gVroXx6tPy8Wio1f0AQkYtUzfcdtPAG/dsn6VeJBKg=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=ukJ7LRFWCgd0jHD4TDQq/3yB8m5+gZGvrC6kEn/eggSXbW6GPGQ/soj3hNLGEsq/g
         WYBHHjX1CfApdq2tCEpitoB/QpZ7Emc5Fj6TlF8vXJMQg0SNv6NtIS6Zq0KPkX5Gka
         EGziIPLRLo3zuMe+od6vukG54cm4uCDmOY7BareE=
Date:   Tue, 18 Aug 2020 17:56:18 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>
In-Reply-To: <20200804070837.1084024-1-swboyd@chromium.org>
References: <20200804070837.1084024-1-swboyd@chromium.org>
Subject: Re: [PATCH] regulator: Avoid grabbing regulator lock during suspend/resume
Message-Id: <159776976827.56451.10944275335227283133.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Aug 2020 00:08:37 -0700, Stephen Boyd wrote:
> I see it takes about 5us per regulator to grab the lock, check that this
> regulator isn't going to do anything for suspend, and then release the
> lock. When that is combined with PMICs that have dozens of regulators we
> get into a state where we spend a few miliseconds doing a bunch of
> locking operations synchronously to figure out that there's nothing to
> do. Let's reorganize the code here a bit so that we don't grab the lock
> until we're actually going to do something so that suspend is a little
> faster.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: Avoid grabbing regulator lock during suspend/resume
      commit: 0955f5be4337c0ada82e49389249eb99199f8db2

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
