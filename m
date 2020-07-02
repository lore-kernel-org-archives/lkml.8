Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1253BC433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C806E2088E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593704827;
	bh=Como7h4+Ry8kLsYZ1X9gi5byJb2qZgeCFlN/M2p5GG4=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=PuxtsihXWZ5Npou73MfpN8sEBT6kvjIEaFyNSGc+b1bybbI+a/tAgt4MYR9635KRN
	 fm3prPBOCUc6FrMIIe7w2G5DZDPzgksmCHWjiUsqaBaO9bfiQt9JxmBWxedr8WbS+/
	 lOqG5o0YjrALsUcd5w6id1pWfAKEsaYvUzBRVqM0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbgGBPrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 11:47:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:59698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726117AbgGBPrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 11:47:05 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01A4A208B8;
        Thu,  2 Jul 2020 15:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593704824;
        bh=Como7h4+Ry8kLsYZ1X9gi5byJb2qZgeCFlN/M2p5GG4=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=ANxgymD0xohZ9Dsk8fIzDT0PigtHeLmkNg4BPY1aoaF6VTMH28s31Wn8gTJzyrsO3
         enBOPXKmei5Qr3Tp+o+bb5gH0D9iv8lW6bz7b2/VLiPydaEIwW1klog8IAYsEk7aNa
         w7MqxMxVioYL6spbp0f+41bRuBYWP3JnR5Funud4=
Date:   Thu, 02 Jul 2020 16:47:02 +0100
From:   Mark Brown <broonie@kernel.org>
To:     linux-mediatek@lists.infradead.org,
        Anand K Mistry <amistry@google.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>,
        drinkcat@chromium.org, hsinyi@chromium.org,
        devicetree@vger.kernel.org
In-Reply-To: <20200702031525.2662441-1-amistry@google.com>
References: <20200702031525.2662441-1-amistry@google.com>
Subject: Re: [PATCH 0/4] regulator: da9211: support changing modes
Message-Id: <159370481231.5599.4888173320266148214.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Jul 2020 13:15:21 +1000, Anand K Mistry wrote:
> This patchset adds support for being able to change regulator modes for
> the da9211 regulator. This is needed to allow the voltage scaling
> support in the MT8173 SoC to be used in the elm (Acer Chromebook R13)
> and hana (several Lenovo Chromebooks) devices.
> 
> 
> Anand K Mistry (4):
>   regulator: da9211: Move buck modes into header file
>   dt-bindings: regulator: da9211: Document allowed modes
>   regulator: da9211: Implement of_map_mode
>   arm64: dts: mediatek: Update allowed regulator modes for elm boards
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/3] regulator: da9211: Move buck modes into header file
      commit: 6c8b65950b1c75b9e41b5bf314f5d7b81df91272
[2/3] regulator: da9211: Document allowed modes
      commit: 650e5adae0197bb9ecaa48b98b8ada1cc6772fb0
[3/3] regulator: da9211: Implement of_map_mode
      commit: 6f1f1a8039e5f7a61e932d6a9a50708c56e21033

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
