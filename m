Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E3DBC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DCFA20773
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594131461;
	bh=TK5Cmeh9M/MUfKwtkEO+yW3fxeLeyY7PEeljzDxg6Ss=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=LR66D/JxPSSPVYdFn8T6dbARhPZ0KZVd4EmGUV2HU2NI4m8A4DaavIOo51eP0Pzm+
	 kum0WzJG2XDXJSnCgReAihAt1fN63TpzIpLsRhJ1XQRT6qj5eb+9uUWL4tHodZyjhQ
	 doy9ddW52vUOKaU01jjwSimFrbWafl9TO3n5Ay4Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbgGGORk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 10:17:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:52060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727090AbgGGORj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 10:17:39 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C28220771;
        Tue,  7 Jul 2020 14:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594131459;
        bh=TK5Cmeh9M/MUfKwtkEO+yW3fxeLeyY7PEeljzDxg6Ss=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=S9GITpcSEv1WJqH3IKUE+Ppu4DyA6YBHZG1krJj2NErR/mlM0kb8OXdjllSTmX+WB
         30TKI4qU9XgipwupbpksKfiQpKe8Y9RgZvh0ooOYlIRiuAtBlBwO2ccRvty9Ew0zbS
         jFz8/dT3SqtISBb0Wxp4w2LJLW7ANSCuFjGXP1sg=
Date:   Tue, 07 Jul 2020 15:17:35 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     timur@tabi.org, shengjiu.wang@nxp.com,
        linux-kernel@vger.kernel.org, festevam@gmail.com,
        Xiubo.Lee@gmail.com, shengjiu.wang@gmail.com,
        linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org
In-Reply-To: <20200707045829.10002-1-nicoleotsuka@gmail.com>
References: <20200707045829.10002-1-nicoleotsuka@gmail.com>
Subject: Re: [PATCH v2] MAINTAINERS: Add Shengjiu to reviewer list of sound/soc/fsl
Message-Id: <159413142466.34737.3295058697996171604.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Jul 2020 21:58:29 -0700, Nicolin Chen wrote:
> Add Shengjiu who's actively working on the latest fsl/nxp audio drivers.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] MAINTAINERS: Add Shengjiu to reviewer list of sound/soc/fsl
      commit: 503ed52225ed3d369c8e0dedf13556a7bc1e5c2b

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
