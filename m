Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20455C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 15:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE0C8207DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 15:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596470007;
	bh=MIgoWkiYyIGRvQI5hrwUdGUdvru2hp0i0DHArLtQKD0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=IQwmvYhllWarW2xKW2WPmH9IEIBIVDQSTj/ALXlg1FuGOq+qAUtxCbTTv/S29c9Sx
	 dJoLJtsEZX7iNga3GqWOUwEN6zz2SJQLmebKV9DEXKOPsGf2tKP+xSokJRbdTfbrXh
	 tKr+siEyYJni5OBphDatb8GxEgmwBT5/tPWnVhhw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbgHCPx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 11:53:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:43662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728090AbgHCPxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 11:53:24 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 051C2207DF;
        Mon,  3 Aug 2020 15:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596470002;
        bh=MIgoWkiYyIGRvQI5hrwUdGUdvru2hp0i0DHArLtQKD0=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=ArRpa4eHxQPbzgZ3CM6gul71f2xv2n+MIlHo24clzxh/vrp+Ng38h6fKAQTAnuK62
         DdKu0dGv310P+tQYTeTQoVOBOR2uVPdkSJmivjZUeaONvkGBbHOzZ4FmlUr3JqcIaF
         p02k9U4cfbFr5f0lg8NCHU1MFAeMh5KbZaH/Qziw=
Date:   Mon, 03 Aug 2020 16:53:02 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Saravanan Sekar <sravanhome@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20200728232327.71ab3729@xhacker>
References: <20200728232327.71ab3729@xhacker>
Subject: Re: [PATCH 0/4] regulator: mp886x: two features and dt json convert
Message-Id: <159646997224.2690.15283965107669623316.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jul 2020 23:23:27 +0800, Jisheng Zhang wrote:
> This is to improve the mp886x regulator driver support.
> patch1 converts dt binding to json-schema
> patch2 implments .set_ramp_delay
> patch3 and patch3 support the switch freq setting
> 
> Jisheng Zhang (4):
>   dt-bindings: regulator: Convert mp886x to json-schema
>   regulator: mp886x: implement set_ramp_delay
>   dt-bindings: regulator: mp886x: support mps,switch-frequency
>   regulator: mp886x: support setting switch freq
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/4] dt-bindings: regulator: Convert mp886x to json-schema
      (no commit info)
[2/4] regulator: mp886x: implement set_ramp_delay
      commit: 0eddcf0267f913cb6336af64cadaf5acf6b19b7b
[3/4] dt-bindings: regulator: mp886x: support mps,switch-frequency
      (no commit info)
[4/4] regulator: mp886x: support setting switch freq
      commit: ee6ad5a24575071b66bd37ffb2d8747a64fcb45f

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
