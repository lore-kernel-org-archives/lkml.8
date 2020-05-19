Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4ED8C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 13:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87D3F20709
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 13:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589895626;
	bh=UfcaPYqw8PThCwc+j4naOeo8VysrjLH+PfFn12ein3s=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=SvedPu9tB4/NmSPTS8dPOv9ZxqX7hZ3eIxYe7W+tOtbkYgoRIqQF074t5GiH2M6t9
	 m44tkRK+IO/xwEYHrszBxqS9KMKBj04RFyZxfaP70WdKKR4iV3Esq7ypXpEDNUYQLQ
	 2H8rvm+r6jtcmKLVAOKZqjEbMEtUfquqMn5IgFmQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbgESNk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 09:40:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:36118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728778AbgESNkY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 09:40:24 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E334820709;
        Tue, 19 May 2020 13:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589895624;
        bh=UfcaPYqw8PThCwc+j4naOeo8VysrjLH+PfFn12ein3s=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=k2c1nb2YBO4QwKn02LwUS+E4p28309jNTVbs3LK7RDOSE/ihs2ZM06xun2kqPS/Zy
         TGyohaKUSPiejZP1HE4MKpHHxIiFRYpLbsokzBTpmN1sSRpXsC3oqV49H5rQrBtKCm
         YBzBBplfdbG5H5JnFkLtBoMRmfl4VDWSt8HGmMZ0=
Date:   Tue, 19 May 2020 14:40:21 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Kangmin Park <l4stpr0gr4m@gmail.com>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
In-Reply-To: <1589873541-5587-1-git-send-email-l4stpr0gr4m@gmail.com>
References: <1589873541-5587-1-git-send-email-l4stpr0gr4m@gmail.com>
Subject: Re: [PATCH] dt-bindings: spi: ti_qspi.txt: fix unit address
Message-Id: <158989562178.37683.12043567776552600589.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 May 2020 16:32:21 +0900, Kangmin Park wrote:
> Fix unit address to match the first address specified in the reg
> property of the node in example.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.8

Thanks!

[1/1] spi: ti_qspi: fix unit address
      commit: 73da2352075adb24868229f9463736a5dd331b95

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
