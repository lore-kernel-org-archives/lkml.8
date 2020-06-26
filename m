Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC97C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 15:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAC13207FC
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 15:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593184903;
	bh=QOMnYNzz4I6MkKeCTpf9TypM+LnUVTlyoDn025IUaTk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=lSxa+A1UKu6riRDe40AfhXHOtveBQGen7aemi2aBtidcay1HgXJ4i/g/GyLqqtMUH
	 V+MFED71y5bLCYyTXck3QrQhFciqrjht7TK+c65px2edHYY1RYWYB8JmztBmfcB+7W
	 GagWVeStDa1QjDWfojvT3DxjAlpDZU2oJhnejE/Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729490AbgFZPVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 11:21:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:33000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbgFZPVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 11:21:41 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EC6E20773;
        Fri, 26 Jun 2020 15:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593184900;
        bh=QOMnYNzz4I6MkKeCTpf9TypM+LnUVTlyoDn025IUaTk=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=01sC1Wy+d8CWPV7j2sbLP9FrT9pJ78gB3vmgrBudUFMFJaA+K5FUgOKLS+wr/tgPa
         yiV0WGfgOawkj833yERzDRM8NZvgYtTNMorfYXHFqEEBa+AnpyoXbeWWcD4J7vgtD8
         fk60wsmkMhEgbk+3svXsbl5kylGfdLECG+8q/mQI=
Date:   Fri, 26 Jun 2020 16:21:38 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>, lgirdwood@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20200626065738.93412-1-lee.jones@linaro.org>
References: <20200626065738.93412-1-lee.jones@linaro.org>
Subject: Re: [PATCH 0/9] Fix a bunch more W=1 warnings in Regulator
Message-Id: <159318489845.4876.11953522362387911717.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jun 2020 07:57:29 +0100, Lee Jones wrote:
> Attempting to clean-up W=1 kernel builds, which are currently
> overwhelmingly riddled with niggly little warnings.
> 
> This is the last of them.  Once applied, drivers/regulator will
> be clean of W=1 warnings.
> 
> Lee Jones (9):
>   regulator: max8998: Staticify internal function
>     max8998_get_current_limit()
>   regulator: qcom-rpmh-regulator: Repair dodgy kerneldoc header
>     formatting
>   regulator: pwm-regulator: Demote kerneldoc header to standard comment
>   regulator: stpmic1_regulator: Properly document 'struct
>     stpmic1_regulator_cfg'
>   regulator: tps65217-regulator: Remove pointless 'is unsigned int <0'
>     check
>   regulator: tps65217-regulator: Use the returned value of
>     tps65217_reg_read()
>   regulator: tps65218-regulator: Remove pointless 'is unsigned int <0'
>     check
>   regulator: wm8400-regulator: Repair dodgy kerneldoc header formatting
>   regulator: qcom_smd-regulator: Remove unused 'struct regulator_desc
>     pmi8994_boost'
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/9] regulator: max8998: Staticify internal function max8998_get_current_limit()
      commit: 36f69fa96a23a054d3aea5793ce2ef3d95907713
[2/9] regulator: qcom-rpmh-regulator: Repair dodgy kerneldoc header formatting
      commit: 7cb5f692077e3b91dcb706cbf58d495d066439ce
[3/9] regulator: pwm-regulator: Demote kerneldoc header to standard comment
      commit: 4e773e7392fb561eb4ae10deb526aa1ac8c13f61
[4/9] regulator: stpmic1_regulator: Properly document 'struct stpmic1_regulator_cfg'
      commit: ec84a7dff4474d0af6ef003719509e30aa93071d
[5/9] regulator: tps65217-regulator: Remove pointless 'is unsigned int <0' check
      commit: f10a5e499cf3e0978845cd85d8a375bcfa193907
[6/9] regulator: tps65217-regulator: Use the returned value of tps65217_reg_read()
      commit: 44455a6d3bcab53ae8330a009d513ade0f12c0c0
[7/9] regulator: tps65218-regulator: Remove pointless 'is unsigned int <0' check
      commit: 02d88863198c48675ceb2a244e5985c5650e5fe6
[8/9] regulator: wm8400-regulator: Repair dodgy kerneldoc header formatting
      commit: 0c5261663785b6505bf5d0f210f1ff0e4bd5ef2c
[9/9] regulator: qcom_smd-regulator: Remove unused 'struct regulator_desc pmi8994_boost'
      commit: bfa29acd18e53ff44135f2eae2b942419a8582cc

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
