Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83EAEC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 16:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5766D2054F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 16:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588090564;
	bh=fXdPRxT6FCRtIu4fUblHOYQd0tzzczkGHPXR8eyrN3Q=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=0mvLT25/fP7CuUhes8JFRFdjdmbYHgsgJpYqM8BO90vfHtEzIo/MuoOEP0KWlXCUT
	 DMWJ4/vbk9NRVFQD0v4dMmMabAouhU0nIfLQafotakZplWPUp5+4+rELQcT2h3OA9c
	 +/GfhePcf4oW6vHTx4uzu9lY1X12p5eP358vqghg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbgD1QQD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 12:16:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:38606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728340AbgD1QQC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 12:16:02 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2D5F2075A;
        Tue, 28 Apr 2020 16:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588090562;
        bh=fXdPRxT6FCRtIu4fUblHOYQd0tzzczkGHPXR8eyrN3Q=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=dDPbClvhcuLmVajdHfTYdoMDeLKFkB6aXNRCVBdyxVSNr9TVcUKFdXSc0cN6r4r92
         lzQbuBZXEauwgDhjcpZ2FPAL/2gjXm6/hb2AhydnLPQVhVdRtAyeft2N8f14e8d4E9
         5pCH3GErSYfn1/DAczTDhySP6WAFlO6ltgmw948g=
Date:   Tue, 28 Apr 2020 17:15:59 +0100
From:   Mark Brown <broonie@kernel.org>
To:     mazziesaccount@gmail.com,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
In-Reply-To: <20200428092930.GA9721@localhost.localdomain>
References: <20200428092930.GA9721@localhost.localdomain>
Subject: Re: [PATCH] regulator: bd718x7: remove voltage change restriction from BD71847
Message-Id: <158809055962.24684.286587561551828697.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Apr 2020 12:29:30 +0300, Matti Vaittinen wrote:
> The BD71837 had a HW "feature" where changing the regulator output
> voltages of other regulators but bucks 1-4 might cause spikes if
> regulators were enabled. Thus SW prohibit voltage changes for other
> regulators except for bucks 1-4 when regulator is enabled.
> 
> The HW colleagues did inadvertly fix this issue for BD71847 and
> BD71850. Remove voltage change restrictions from other PMICs but
> BD71837.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.8

Thanks!

[1/1] regulator: bd718x7: remove voltage change restriction from BD71847
      commit: f0ca7b249c7305c9b9781f7dbcb8d294e0086808

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
