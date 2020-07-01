Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D111DC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 22:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E42D2082F
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 22:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593642232;
	bh=y8h8rrj+eKW/ffxtmPfoCbuMIYXnOThq0lLnPdclPgM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=gKsgMV12ZNYDS5YdyUswqUuP3ZsyDl99Bk+P0cPeObjzY/DqoSzWEzLey0QIedHSu
	 ZcGUp4WSvTxttDhMJzOJ0lKPZWual5/3O9ukk9GvohCkt8a4yjkdl7pOnnVNNCcmLg
	 NoO//dJVeN1NShMX6IkbiSKMJM0iI1V5PYLBWXo4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbgGAWXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 18:23:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:50778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726257AbgGAWXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 18:23:49 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7BC620780;
        Wed,  1 Jul 2020 22:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593642229;
        bh=y8h8rrj+eKW/ffxtmPfoCbuMIYXnOThq0lLnPdclPgM=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=WNS/v0nnbKNv8XZTKIRhAOSR7hoxnr9AT2AXP0wJW35BvCbRy86HuTnJIwEsj58JH
         scwwE7Q7LAh7ZPh2eNM9HrJX68Rx1gZN/cHmm0nAgTAcQ3OPMYKpbuIAMnF1W/D5N0
         HU9lhu96N6o8Gw/ZUQ4FXQxUVsvSrQP4Je0uiYkk=
Date:   Wed, 01 Jul 2020 23:23:47 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Luca Ceresoli <luca@lucaceresoli.net>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Keerthy <j-keerthy@ti.com>, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Axel Lin <axel.lin@ingics.com>
In-Reply-To: <20200622204329.11147-1-luca@lucaceresoli.net>
References: <20200622204329.11147-1-luca@lucaceresoli.net>
Subject: Re: [PATCH v3 0/4] mfd: lp87565: convert DT to yaml, ignore ENx pins and add LP87524-Q1
Message-Id: <159364222730.10880.1510321534507247340.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jun 2020 22:43:25 +0200, Luca Ceresoli wrote:
> the first patch in this series is a small but significant variation in how
> the lp87565 driver enables the output rails, to allow the kernel to always
> know when it is enabling an output. However it can change existing
> behaviour (depending on the hardware setup) and thus it should be carefully
> evaluated.
> 
> The following patches are a fairly straightforward addition of a new chip
> variant along DT bindings conversion to yaml.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: lp87565: enable voltage regardless of ENx pin
      commit: 81fdcef3a615f5d4ef2a2bd87a65d46f6816d687

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
