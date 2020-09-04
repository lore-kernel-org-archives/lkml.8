Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D942C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 10:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE90D20791
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 10:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599213857;
	bh=+M+weXZdADm0+Y06gszlZNtZQw0daMkBFofaFo4MaBY=;
	h=Date:From:To:In-Reply-To:References:Subject:List-ID:From;
	b=BOOYsu+NtWQ+6kFDmICJGNuMXTTMmqAv9FhETTtNIb433eJ5NztXqYoFKYigkYcoL
	 buynATruiGQzdxFLw7bSQYf2snNg7O0OmKVhEQ6y6zM9BVdmimLwGELLK6ZZpLbb+b
	 /OQ5xEVF1BxCH2HRHJ6yHgzIca7Q0pyrYHTcDG0c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729923AbgIDKER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 06:04:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:35114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbgIDKEN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 06:04:13 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 467BB206D4;
        Fri,  4 Sep 2020 10:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599213852;
        bh=+M+weXZdADm0+Y06gszlZNtZQw0daMkBFofaFo4MaBY=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=PMj3BkdQ+PMRRu2YPLBzbN3l/GYDAAeOTCHSUFQpY8QHUmnegq0pES6fXZzmtelAr
         NtMX+f6mBortUXSzlFMyyF3kYYdNzGXqd3ZZup1Qw6MenzN4WTAX5mPuSTqNMcRdut
         AmWfpNT9UOUorQJdWXYWbxKfJX8l5qZ7QgE+6hUc=
Date:   Fri, 04 Sep 2020 11:03:31 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Kukjin Kim <kgene@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        Sangbeom Kim <sbkim73@samsung.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20200903203250.19830-1-krzk@kernel.org>
References: <20200903203250.19830-1-krzk@kernel.org>
Subject: Re: [PATCH 1/4] ASoC: odroid: Add missing properties
Message-Id: <159921381111.42159.13882665224294101699.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Sep 2020 22:32:47 +0200, Krzysztof Kozlowski wrote:
> Usage of "unevaluatedProperties: false" is not correct as it suppresses
> warnings about all undocumented properties.  Instead, add all missing
> properties.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: odroid: Add missing properties
      commit: 6997e462b39b5041e6e4b9d547ebbcacb69052ae
[2/2] ASoC: samsung-i2s: Add missing properties
      commit: 0c5f8ca49cff1e2e18300cca4fb0c17ba794dcb0

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
