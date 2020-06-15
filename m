Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 805A3C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 23:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6125C207D3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 23:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592264486;
	bh=bqkgpEtV0AWOIPCPj9PiP6DShiunetgdC6n3vDohao0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=I+JaUfaivg4DDL69vkBiIF6r2RGynFf3yzy26pngcOi1PtK0U0MmFZdShbpmfV/lG
	 TTZrnn/dvPRYG0Y3lRn0nhd1c5khHuQAS5ZIGveF2GRWQ4U76qxyTJ6gvhDk7vjZNO
	 a9wzIF2xsaOIFX2dwppaFXNo0/6xdy0NGeFm/nfA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgFOXlY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 19:41:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:54376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725960AbgFOXlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 19:41:22 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9742520714;
        Mon, 15 Jun 2020 23:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592264482;
        bh=bqkgpEtV0AWOIPCPj9PiP6DShiunetgdC6n3vDohao0=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=WpSKBKw/jkVDxSpozeUjw+b5Q20jpDsbmG6j9QLYzHfE6QV6JGML3Y8Bu05o1H3fZ
         E1fGGIqiyIzrSIhKYR9ASCLoVIZV8u26vGpDbe8amA9anugOS5kJS7RfrEuVaes0CI
         Ozc/7F5Hb6zZLBaf1uIdc1CqPSe3RtQmxm6VeAYA=
Date:   Tue, 16 Jun 2020 00:41:19 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Tzung-Bi Shih <tzungbi@google.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Yicheng Li <yichengli@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>
In-Reply-To: <20200612040526.192878-1-pihsun@chromium.org>
References: <20200612040526.192878-1-pihsun@chromium.org>
Subject: Re: [PATCH v6 0/3] Add support for voltage regulator on ChromeOS EC.
Message-Id: <159226447507.27673.12544473672334795721.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jun 2020 12:05:17 +0800, Pi-Hsun Shih wrote:
> Add support for controlling voltage regulator that is connected and
> controlled by ChromeOS EC. Kernel controls these regulators through
> newly added EC host commands.
> 
> Changes from v5:
> * Move new host command to a separate patch.
> * Use devm_regulator_register.
> * Address review comments.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/3] dt-bindings: regulator: Add DT binding for cros-ec-regulator
      commit: 54bd53b9c11ed856abeedbf1ce92a19b546f56cf
[2/3] platform/chrome: cros_ec: Add command for regulator control.
      commit: dff08caf35ecef4f7647f8b1e40877a254852a2b
[3/3] regulator: Add driver for cros-ec-regulator
      commit: 8d9f8d57e023893bfa708d83e3a787e77766a378

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
