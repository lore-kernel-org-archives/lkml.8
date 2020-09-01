Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 939B7C433E7
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 563A8206EB
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598971911;
	bh=anuuC+nyOp49gnlHHAG1/TrEkpLdDC9qf98Nwn4rs3s=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=M60c96agqxxcCceUB2q4OrW3Mn24r/QljzeHHflXJFzKcc2eSHuE1OFCjMx+rjbN7
	 kZUJO/3Hs+WAQpZaLrBTyioJb3hG206I34bT7OliWt9O5Cvjh37ljAhanPZHONX8Hf
	 jnFp+R6SEewUwJzSglvfF012Mu3KIz7YRZO3a6E0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbgIAOvo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 10:51:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:37120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728745AbgIAOvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 10:51:13 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B3362078B;
        Tue,  1 Sep 2020 14:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598971872;
        bh=anuuC+nyOp49gnlHHAG1/TrEkpLdDC9qf98Nwn4rs3s=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=YfbDWAJVGN1SmpC3e39BG5KOauWOSh9drKQX26b7xgcJ5ha74rdQMvaUYIXmMdc02
         fvUSYQqi4grDxZyW6Gv0x6rhU2Ki3Bh+h48QnunrmrzdJsJwZz/m5RQFHa464ocCzA
         vbT3AnopW/phaGT3fICSivalHthTEUKZMFvnmxj8=
Date:   Tue, 01 Sep 2020 15:50:33 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20200831204335.19489-1-digetx@gmail.com>
References: <20200831204335.19489-1-digetx@gmail.com>
Subject: Re: [PATCH v1] regulator: core: Fix slab-out-of-bounds in regulator_unlock_recursive()
Message-Id: <159897183313.47900.9927134230098775732.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Aug 2020 23:43:35 +0300, Dmitry Osipenko wrote:
> The recent commit 7d8196641ee1 ("regulator: Remove pointer table
> overallocation") changed the size of coupled_rdevs and now KASAN is able
> to detect slab-out-of-bounds problem in regulator_unlock_recursive(),
> which is a legit problem caused by a typo in the code. The recursive
> unlock function uses n_coupled value of a parent regulator for unlocking
> supply regulator, while supply's n_coupled should be used. In practice
> problem may only affect platforms that use coupled regulators.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: core: Fix slab-out-of-bounds in regulator_unlock_recursive()
      commit: 0a7416f94707c60b9f66b01c0a505b7e41375f3a

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
