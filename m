Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191E5C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 13:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCCA5206D4
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 13:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599742928;
	bh=c+f/k+6GyQvNsPgFbCCeEDvT5NuCYq5YkYLiuMEqnl0=;
	h=Date:From:To:In-Reply-To:References:Subject:List-ID:From;
	b=P0lsDFva/OWZvlPyFk3f6tlb41U0DjWmsFvXMHx0Me2gCj94Oj61M7byQHih5vFN7
	 vj9X1pBwZjR5ERwnEP/Uo30kZjpWRDzi0xQT3oSt4dV7C8zBhqLCCbWuTyzA+B2HgU
	 YyuC21npAoLLWSHXgdwbRI2S95txUqXZwgM+OeVw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730273AbgIJNBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 09:01:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:35980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730734AbgIJMwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 08:52:49 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEEB220BED;
        Thu, 10 Sep 2020 12:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599742338;
        bh=c+f/k+6GyQvNsPgFbCCeEDvT5NuCYq5YkYLiuMEqnl0=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=u2vf6VJMoiVc4IaTLGmNSUN1npSYI2KRTyLzavM8NrJyrIh+B9XmLeDU/us9/J0br
         i5vmaQwhee+l8UMteeLnhYSKfm2OfzSaHXAJx4ZqS3UDMPpsKX9aJDhqDvgpaH4zEg
         MpXOkM7X0k4bAQynkV+vZxPri2mYykDsSXw/7hr4=
Date:   Thu, 10 Sep 2020 13:51:33 +0100
From:   Mark Brown <broonie@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>
In-Reply-To: <20200827150640.267f6edc@xhacker.debian>
References: <20200827150640.267f6edc@xhacker.debian>
Subject: Re: [PATCH] dt-bindings: regulator: Convert mp886x to json-schema
Message-Id: <159974229313.39285.6202853983766593999.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Aug 2020 15:06:40 +0800, Jisheng Zhang wrote:
> Convert the mp886x binding to DT schema format using json-schema.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] dt-bindings: regulator: Convert mp886x to json-schema
      commit: fd24adf887e490fd10a9a6bb9d76854e87c235f8

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
