Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7937FC47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 12:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50711206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 12:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588683032;
	bh=QLn+uOYzl/cbRxyiEyBEun7Xm83d5G4JJgdYrFQ1mEM=;
	h=Date:From:To:In-Reply-To:References:Subject:List-ID:From;
	b=1x9JIbz7aaUzwTkn1Uz8GOq/eT9CUkVpcwYTGfbwzsBU04FaQU/U8WB/zN+NSd9Fe
	 TW1IWD1iewW3HhfVWdcQvJYbzhJIXg302HzaBiTqisZ7O84Yco/+qGF4qkjsnLhHnc
	 /g3wE41UfIvbv6sS5GorOE/Lg2kG80Yb6OpUerco=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729006AbgEEMub (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 08:50:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:54490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728497AbgEEMub (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 08:50:31 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88A24206D7;
        Tue,  5 May 2020 12:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588683031;
        bh=QLn+uOYzl/cbRxyiEyBEun7Xm83d5G4JJgdYrFQ1mEM=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=LlydU9w3oIJGGcpoyZ0pzki1EndLuSQlFTvtvEWjo9UsVpbxJ0ukXp3YGq9LxhQ9C
         btXFl9N+9sydEFBTK8xLhNSpEIPuzgQ+i3t+viO8J0u9gSTdvMvOVJ6Zbqwo7cQ9xH
         V+mtntBtQKy+G2c5Y4juTV2mgMojTipJmPx2O3Pw=
Date:   Tue, 05 May 2020 13:50:28 +0100
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, Jacko Dirks <jdirks.linuxdev@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20200503200033.GA3256@vasteMachine>
References: <20200503200033.GA3256@vasteMachine>
Subject: Re: [PATCH] spi: bcm2835: Fixes bare use of unsigned
Message-Id: <158868302840.38681.2575208609097582325.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 May 2020 22:00:33 +0200, Jacko Dirks wrote:
> Signed-off-by: Jacko Dirks <jdirks.linuxdev@gmail.com>
> ---
>  drivers/spi/spi-bcm2835.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
> index 11c235879bb7..e10b8f3b4bab 100644
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.8

Thanks!

[1/1] spi: bcm2835: Fixes bare use of unsigned
      commit: e37687c98ab9ee5872e672b81c44932cf5356d58

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
