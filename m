Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79AD0C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 502CA20885
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593704837;
	bh=zO6lsUH3BX1EoZvnnJnj2cBADGvCQxrV3R/tlze7duc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=DJnk0Y6iA0DZaIHpF5jNgw/y5Tfqa/076brOUkiDsODwa1FBJhqfHpQBsazw0O2Yl
	 SrMrAcjQ5WWeppwjuPjjOdtJyUGcqNpe3a0ZwivBafUZi9Sx8swZFwduGvyN99K1lx
	 o0gh2VxGlLEc2p1xWuHsUOjq0zcfP6kgvasngHrY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgGBPrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 11:47:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:60180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbgGBPrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 11:47:15 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D8FA2088E;
        Thu,  2 Jul 2020 15:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593704834;
        bh=zO6lsUH3BX1EoZvnnJnj2cBADGvCQxrV3R/tlze7duc=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=UNqy8vYYzquHchdVdbPwptvTxz3R5O+Psg8/e4I2DpaThOHJjQimvqKTVO8g5nAUr
         zGZ7zUHfWEl0n5mpYkj9TlzcmM2dxbYVIeW2vlngQk0J8YktREIZbAGc21Nff55vZ1
         nLaiTs8XQXlaZiB6yGbX/rkqPS+QufSIAztPo3KE=
Date:   Thu, 02 Jul 2020 16:47:12 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20200702100200.1a4c65d1@xhacker.debian>
References: <20200702100200.1a4c65d1@xhacker.debian>
Subject: Re: [PATCH] regulator: mp886x: use .probe_new
Message-Id: <159370481231.5599.5069783449499652840.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Jul 2020 10:02:00 +0800, Jisheng Zhang wrote:
> Use the new .probe_new for mp886x. It does not use the const
> struct i2c_device_id * argument, so convert it to utilise the
> simplified i2c driver registration.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: mp886x: use .probe_new
      commit: e2c6678bd836861093eecd733610f77b2d87e9f8

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
