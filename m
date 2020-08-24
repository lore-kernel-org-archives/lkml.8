Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 859D2C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 13:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61E752065F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 13:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598276130;
	bh=L8KDTgoqa6Rk0gELQzO81+l0O3LH5zmLEgt6iWlP4DA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=Olpig/PNHteUBFeYiXmRh+C6lgQ0+3/QMo1dS14BcyrbQzkRup05jgPzV50tBEEsY
	 6mH7UqX7Loe76QKnZ0U08ry64G0Vtf+6e2+MpGXT+RkxjqP5VULCHhN/+9E7tnobbJ
	 Jm3ZbV7irq1E7Th5KyiCelH4CutfP/WXAoc2RH1E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgHXNfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 09:35:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:58760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727123AbgHXNci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 09:32:38 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 134BD2065F;
        Mon, 24 Aug 2020 13:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598275947;
        bh=L8KDTgoqa6Rk0gELQzO81+l0O3LH5zmLEgt6iWlP4DA=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=HnGV+hGbGoHAsl/D02nLKokpz+Qg0uJk07vdVxhFlzwcYZ1cou5dHKpbD/dEnTsWB
         L2/QDcaFx/1WE54P+h+qyimTr7Lv5ysRT42opWU0P8wn4cGziA6SXWxHsMwJf4yvBY
         uHg2evRpQziMR55EX46TqDcMwNvlEahjdkUAJ8tk=
Date:   Mon, 24 Aug 2020 14:31:53 +0100
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, cy_huang <u0084500@gmail.com>
Cc:     linux-kernel@vger.kernel.org, gene_chen@richtek.com,
        cy_huang@richtek.com
In-Reply-To: <1598234713-8532-1-git-send-email-u0084500@gmail.com>
References: <1598234713-8532-1-git-send-email-u0084500@gmail.com>
Subject: Re: [PATCH] regulator: rt4801: Fix W=1 build warning when CONFIG_OF=n
Message-Id: <159827590802.48129.16240965662426470036.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Aug 2020 10:05:13 +0800, cy_huang wrote:
> Fix below warning when CONFIG_OF=n:
> 
> drivers/regulator/rt4801-regulator.c:206:34: warning: unused variable 'rt4801_of_id' [-Wunused-const-variable]
>   206 | static const struct of_device_id rt4801_of_id[] = {
>       |                                  ^~~~~~~~~~~~

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: rt4801: Fix W=1 build warning when CONFIG_OF=n
      commit: c8b2c8949c45b01d75237331fc1387036b952d58

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
