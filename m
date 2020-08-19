Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB085C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B88962075E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597839358;
	bh=zgqO4dt8oDjrOVT4/c1Xvgcktui1wNIAoIAn1aAlAEY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=qqM8qHRz6y/UwqvwcXcYPs74zV7NTdPdLYWMKGjI3SS2iiHcXGVtCD8Ts3kJ9r8JW
	 9JJLKMEyNUB+BE/Ejof2DWQWjpM1QfIP+jVwAc3jsNsQntVQaSfd9LiIVF1Id1Nh83
	 7KL8MioIuM/urQAhfyfTUiz563wHJCCtYrKIBwY4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgHSMP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 08:15:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:52836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726752AbgHSMP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 08:15:57 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A05B1206FA;
        Wed, 19 Aug 2020 12:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597839356;
        bh=zgqO4dt8oDjrOVT4/c1Xvgcktui1wNIAoIAn1aAlAEY=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=efaVO3WJCaG9BaPttCL8jMRBOA31XsXEJaCMkZ4lY1wL87sOaTuVFsUBgaJ98LxWg
         afHJExSfN1wnl3Zg1JIDBUPhWbCbFu9MoBL7K2Pv1ln2RLR1C9r4Oxjw+It6gQqA8o
         Pb+JnsWixqPz2axn7rjZIIbNAWiOo0vX+dv9vWs0=
Date:   Wed, 19 Aug 2020 13:15:24 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>, robh+dt@kernel.org,
        lgirdwood@gmail.com, shengjiu.wang@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Cc:     Linux-imx@nxp.com
In-Reply-To: <1597712771-32433-1-git-send-email-Anson.Huang@nxp.com>
References: <1597712771-32433-1-git-send-email-Anson.Huang@nxp.com>
Subject: Re: [PATCH V2] dt-bindings: sound: Convert NXP spdif to json-schema
Message-Id: <159783932455.55025.17846366989004171430.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Aug 2020 09:06:11 +0800, Anson Huang wrote:
> Convert the NXP SPDIF binding to DT schema format using json-schema.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Convert NXP spdif to json-schema
      commit: c5040fec3d550e27d0a49f05564204da6c90d10b

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
