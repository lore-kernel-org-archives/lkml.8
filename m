Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF7A5C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84DBC206EB
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598971925;
	bh=74OB+DiXR08/ILMlTikZpNejETLVFkxOdl8rPfLlgWk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=Ze4CxdNHgbcCfAkHzlAK5drm+Y6JQFb17S/fcvPDR/8Oe+AjX0gfDI/zy2xcnCe5f
	 abQyApLOqwf83zIuN6Bhle2d1ARIGHxfJYiDuGykKKVUzkZnw4UH6VM/mOEMW5eYIJ
	 POBIcFYZOmWYEYihlsNVyNCXSknv/O0I3XzgppkM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbgIAOwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 10:52:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:36864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728736AbgIAOvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 10:51:02 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 463F42100A;
        Tue,  1 Sep 2020 14:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598971856;
        bh=74OB+DiXR08/ILMlTikZpNejETLVFkxOdl8rPfLlgWk=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=Brxy8AQHcvyzrPNzMSDBL2t9tGjbOIBahmiRVMykds7irJsFnoo5dr8PWy3799JoD
         AXA+Wr4GvSeiunTU+WiKe5vBDns4fGzDNmwJndzGquBFvZeoC9RRxy4xnWpn/sGJRA
         3rG74ReHGLKBrCpZcunYiD90lw1xNyTUKA3hsnrY=
Date:   Tue, 01 Sep 2020 15:50:17 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20200829103939.4007097-1-vkoul@kernel.org>
References: <20200829103939.4007097-1-vkoul@kernel.org>
Subject: Re: [PATCH] regmap: soundwire: remove unsed header mod_devicetable.h
Message-Id: <159897181721.47861.8715453024613458720.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Aug 2020 16:09:39 +0530, Vinod Koul wrote:
> mod_devicetable.h does not seem to be required for this file, so
> remove it.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: soundwire: remove unused header mod_devicetable.h
      commit: 50df0eebbd49b894df7e5e3945d66cd80c322284

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
