Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB841C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 17:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 906B6206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 17:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594661295;
	bh=zvLNW8f4wGUz+XcJL0EtXl3kUQZfrdDQBCaDlrynNBY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=ZoxNvwv1NfvVuOdhjyWAoRZ4vPyq+fVeEu3Ghvh0H09bWwXYm20gX6ZCE9RB+4rQ5
	 DA2MEyR0DCyDQtxQRvhi2h6T70TjzHcJ7fSEfIxnKvnrdzAqkfd+ISd02y+T9zFGMp
	 3r25AXahwd1RcDQCK3FnRUhllQBox2eh0qLth04s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730366AbgGMR2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 13:28:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:53448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730192AbgGMR2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 13:28:12 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B161B206F0;
        Mon, 13 Jul 2020 17:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594661292;
        bh=zvLNW8f4wGUz+XcJL0EtXl3kUQZfrdDQBCaDlrynNBY=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=Q7K3RYUFQCIZh3rtuoPTXuNL9q73jKqOyT2ltaE+5v2OrdfROvUtxP7e2VIpxxRum
         nbmFvWvh3B7ShU/zmdNK3APFutIBOy0VBXNbyD0BD7dYIDj/N+r4TWLP7Ia63qRBZT
         1w5Vb6+VJV8fi4ZHZaCzl3BrRXdMyOhoc1w91wsg=
Date:   Mon, 13 Jul 2020 18:28:03 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     groeck@chromium.org, pihsun@chromium.org,
        enric.balletbo@collabora.com, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com, bleung@chromium.org
In-Reply-To: <20200711114409.9911-1-rikard.falkeborn@gmail.com>
References: <20200711114409.9911-1-rikard.falkeborn@gmail.com>
Subject: Re: [PATCH] regulator: cros-ec: Constify cros_ec_regulator_voltage_ops
Message-Id: <159466128351.418.2225672839034503942.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Jul 2020 13:44:09 +0200, Rikard Falkeborn wrote:
> It is never modified, so make it const to allow the compiler to put it
> in read-only memory.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: cros-ec: Constify cros_ec_regulator_voltage_ops
      commit: 308e65ad060dca2f0187731a7916c71521ce6c25

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
