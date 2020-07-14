Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31744C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 16:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D31722475
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 16:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594744803;
	bh=irvfRDzY/K0ARRQhB262mQahABhtwmib6ye2BEgbh1g=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=RbqBMAJQZhKeBPKPKo6REZ409jgv8ve6TM2N2r7km46hq4PK8Uj1qFjq/ff2DbC0h
	 J/UZvV85KKedauQoFp+wJLAHNwWfqhhga40a530r2GuCJSg578bHIBwdTlt1ZweRrL
	 /MlnS8JiAv3A78U9P/oxiX6eqGyg2AJDnpa4dIFE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbgGNQkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 12:40:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:56748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725931AbgGNQkB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 12:40:01 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04E4222518;
        Tue, 14 Jul 2020 16:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594744801;
        bh=irvfRDzY/K0ARRQhB262mQahABhtwmib6ye2BEgbh1g=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=Wsf1aHfn3DXD1Ju2Os7ztOjkQRzT1LIy/nMPQymcD77GM3Z4je+RMO8XHPtOsRlLE
         c0jG1gKFWJpiqHlP3FM25PEUaoPJ3EwGRnsjTRu3/WSn4HS3ouwCzSimIWEpTZtpnQ
         yE/MD6M4MswleCBVqUsjftDR8lj0OjAxyLbhGwMM=
Date:   Tue, 14 Jul 2020 17:39:52 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     - <alsa-devel@alsa-project.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20200623114005.791643-1-yamada.masahiro@socionext.com>
References: <20200623114005.791643-1-yamada.masahiro@socionext.com>
Subject: Re: [PATCH v2] dt-bindings: ASoC: Convert UniPhier EVEA codec to json-schema
Message-Id: <159474477218.998.2572332784309869444.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jun 2020 20:40:05 +0900, Masahiro Yamada wrote:
> Convert the UniPhier EVEA sound codec binding to DT schema format.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Convert UniPhier EVEA codec to json-schema
      commit: 08277cd63797d97185284bc3e86d085fb9ff2adc

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
