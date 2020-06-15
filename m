Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B669EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 23:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A9E2208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 23:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592264448;
	bh=8Vkipt8UfbkmfZZK+DRY5P5ncOAbz5M/RzUt969ESmw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=2o0H2DO/c1gyflpJx5ShdZmqh65/vT6SN7hBVcg4lkEOO4DzTPiwDSs4BbFGQMBYI
	 iquYwUE06FcCSWIXKZu/BNrXeaFA1m8nKhxgaak7nNMMKXFceIaJX7B5tfg8KBbJwq
	 rMl4kZBjifpVclcbCWJziNQWK70ESo6zri33WcGc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbgFOXkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 19:40:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:52834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725960AbgFOXkq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 19:40:46 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B40AD207D3;
        Mon, 15 Jun 2020 23:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592264446;
        bh=8Vkipt8UfbkmfZZK+DRY5P5ncOAbz5M/RzUt969ESmw=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=15OE0GfdU5anTbWdKV3yQxD6FHb7qhfPpu0vuE/CA69VJcF+/tLGCrMBOzYZ6oQWA
         wsJqqLK098WW4nmCiacMnlxe2NI0+Ofzekk8uLtn4k61yPtHjSsGZoapaoU6xqug2x
         nZXZ6qYoncvkvolJnI0q4XJXz21uEClolssSgqaI=
Date:   Tue, 16 Jun 2020 00:40:44 +0100
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org,
        Steve Lee <steves.lee@maximintegrated.com>
Cc:     ryans.lee@maximintegrated.com, steves.lee.maxim@gmail.com,
        ryan.lee.maxim@gmail.com
In-Reply-To: <20200602084337.22116-1-steves.lee@maximintegrated.com>
References: <20200602084337.22116-1-steves.lee@maximintegrated.com>
Subject: Re: [V7 PATCH] dt-bindings: Added device tree binding for max98390
Message-Id: <159226439189.27409.1555596796262164094.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jun 2020 17:43:37 +0900, Steve Lee wrote:
> Add DT binding of max98390 amplifier driver.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] dt-bindings: Added device tree binding for max98390
      commit: 6b76bf3e0ff66eee4b714921fbabd588f90ab1fb

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
