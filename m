Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 054ECC2BB84
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 18:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB02C20738
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 18:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599502019;
	bh=CSGLZgC7TEScaQRoN9rKXOxHIB1UVechuf/uXlfBqqk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=YdxZexcNsV4I3KRLZbKnYpEd+ROnAqdhjJ4+MW6R/UrQvoSPAITGSbupdCPXfo+Uf
	 RSDBE9zdUzNzcUzmN3oQ8O6Q1Z/zcV8DQQ7D0aufCrwHZwX/ia9814Cb8FcSGqD6Ay
	 CBc9OGadANZdqHbIXNwYLDFPoH68Pk661KEWDEoI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbgIGSG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 14:06:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:33110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731351AbgIGSGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 14:06:44 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BF8420738;
        Mon,  7 Sep 2020 18:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599502003;
        bh=CSGLZgC7TEScaQRoN9rKXOxHIB1UVechuf/uXlfBqqk=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=ULzVERjsYSef99QHRBtWac2dbhoKGwuPBCWSJfbmr2eXCT6igcvgPMopNGGVw5r5J
         k77HUm3lRWWBi3LnGppw+X21pzCZngyEIVBk1TL7NxycgN5dFBAPS6keLgmw2rGex6
         AF7rzAqU5zpAj45PdY/h07pZcUQl2toMlDZoowms=
Date:   Mon, 07 Sep 2020 19:06:00 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alex Dewar <alex.dewar90@gmail.com>
Cc:     Andy Gross <agross@kernel.org>, linux-spi@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
In-Reply-To: <20200904163709.110975-1-alex.dewar90@gmail.com>
References: <20200904163709.110975-1-alex.dewar90@gmail.com>
Subject: Re: [PATCH] spi: qup: Allow for compile-testing on !ARM
Message-Id: <159950195998.52926.7999875606949643050.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Sep 2020 17:37:10 +0100, Alex Dewar wrote:
> There seems no reason to restrict testing to ARM, so remove this
> constraint to improve test coverage.
> 
> Build-tested with allyesconfig on x86.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: qup: Allow for compile-testing on !ARM
      commit: 2abaad678575acd54e9939e1174becd82ecc884b

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
