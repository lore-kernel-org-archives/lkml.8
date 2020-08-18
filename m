Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950C9C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 16:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74E38207D3
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 16:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597769866;
	bh=d9cPWtyENfNl2HRXMgEXWQnjJbqhSVmywdREqBxnrCY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=hITogjzjjmS5ZRK46YcI9/hvaSNm8ZUWiufpKJ2BxwxVmx4gG5TCKi90pl6KtfAMo
	 iKwpfR2CvHUiaEKdsRJxANkUjBag1ZWMYVu7SNP5YhU2ClsPI2yti+dQjMYUCm4PhU
	 EVIRMmybrFTB4cD/hF/WyAyqyAA94c0XtVDXL02U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbgHRQ5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 12:57:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:39236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728464AbgHRQ4j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 12:56:39 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A0F1207DE;
        Tue, 18 Aug 2020 16:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597769799;
        bh=d9cPWtyENfNl2HRXMgEXWQnjJbqhSVmywdREqBxnrCY=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=yACKnyoFBp/jxXuRDWlpSzvp2g1iat9EXWJrvfq2dZ+yQg8CnSl9gDFhRAUIeA6i0
         EWulvufwZkN8Ge0orn4jZUcjPoLezXn4aclHI6Rg1JqA7kwW6G6CBFzIAHDj3XN6cm
         I9riw1LPjz9poKJXILlWkhL0s6sIq4k0OOqZ8wyE=
Date:   Tue, 18 Aug 2020 17:56:08 +0100
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, robh+dt@kernel.org,
        cy_huang <u0084500@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        cy_huang@richtek.com, gene_chen@richtek.com
In-Reply-To: <1597461262-25878-1-git-send-email-u0084500@gmail.com>
References: <1597461262-25878-1-git-send-email-u0084500@gmail.com>
Subject: Re: [PATCH 1/3] regulator: rt4801: Add support for RT4801 Display Bias regulator driver
Message-Id: <159776976828.56451.5593321071237177212.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Aug 2020 11:14:20 +0800, cy_huang wrote:
> Adds support for the RT4801 DSV. It has two regulators (DSVP/DSVN) with
> an I2C interface. DSVP/DSVN can provide the display panel module for the
> positive/negative voltage range from (+/-)4V to (+/-)6V.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/3] regulator: rt4801: Add support for RT4801 Display Bias regulator driver
      commit: 5bbbfc7f7f0a44b7a85ab3872dd2ccce7019f7b1
[2/3] regulator: rt4801: Add DT binding documentation
      commit: fd6b928db8a05fcd8629320c52eae214a8615aae
[3/3] regulator: rt4801: Fix the dt-binding document for dtc check.
      commit: 6f4ac2844b61d43c0c48b7c67a974d9f6e4ddd9c

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
