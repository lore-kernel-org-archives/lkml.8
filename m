Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC1FC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 19:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3EBD20768
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 19:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593115095;
	bh=3fT/uvZlIk0Dgh5Zbum6h1fmbJOZO1WPsNIPJ+sDTL4=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=axLzh1AiSLUAkR7zQtqmls3S5tO5rgQW/LjFNjxX01IwF65il0kvfJ/FqAycndiam
	 nIznCEtB9fUviRqaD5yyp52XQrpwJr5YZQ/7nGx5HaG02mVRpNrqE5GZfz/8TL0msl
	 WMF3EIZK0AEBGRJndMw6rz0w89zc60b9F4n963xM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406948AbgFYT6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 15:58:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:45726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406569AbgFYT6N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 15:58:13 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C15F206A5;
        Thu, 25 Jun 2020 19:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593115093;
        bh=3fT/uvZlIk0Dgh5Zbum6h1fmbJOZO1WPsNIPJ+sDTL4=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=uvKY5sQYWF+vaN2gT/PsOoedEoGuDQDW05ox37tKrR3sdKAEr/HGQnV2XkSgvH7+9
         6+gvMdy1V3d/ZjMVzCDcEAcl85y1FAV3oxP5H59lYL90Qs9t9WgzE6Ys7HlYeU7ywV
         1uMuAdTMUpegs8lA3P4r2XmxZOBOq2tiJvGXMsRs=
Date:   Thu, 25 Jun 2020 20:58:11 +0100
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, Lee Jones <lee.jones@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20200625163614.4001403-1-lee.jones@linaro.org>
References: <20200625163614.4001403-1-lee.jones@linaro.org>
Subject: Re: [PATCH 00/10] Fix a bunch of W=1 warnings in Regulator
Message-Id: <159311502137.12058.727210548768872357.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jun 2020 17:36:04 +0100, Lee Jones wrote:
> Attempting to clean-up W=1 kernel builds, which are currently
> overwhelmingly riddled with niggly little warnings.
> 
> Lee Jones (10):
>   regulator: consumer: Supply missing prototypes for 3 core functions
>   regulator: devres: Fix issues with kerneldoc headers
>   regulator: of_regulator: Add missing colon for rdev kerneldoc argument
>   regulator: dbx500-prcmu: Remove unused function
>     dbx500_regulator_testcase()
>   regulator: ab8500: Remove unused embedded struct expand_register
>   regulator: wm8350-regulator: Repair odd formatting in documentation
>   regulator: cpcap-regulator: Remove declared and set, but never used
>     variable 'ignore'
>   regulator: cpcap-regulator: Demote kerneldoc header to standard
>     comment
>   regulator: da9063-regulator: Fix .suspend 'initialized field
>     overwritten' warnings
>   regulator: max14577-regulator: Demote kerneldoc header to standard
>     comment
> 
> [...]

Applied to

   local tree regulator-next

Thanks!

[1/7] regulator: consumer: Supply missing prototypes for 3 core functions
      commit: da6690767cbd344998f36081815c85f3d467e78c
[2/7] regulator: dbx500-prcmu: Remove unused function dbx500_regulator_testcase()
      commit: d3cc3dfcc20e72d537550dbeebbe4a8faa7c2606
[3/7] regulator: ab8500: Remove unused embedded struct expand_register
      commit: aeee55b76bfd100d2612f50d2f9526d760ee2e37
[4/7] regulator: wm8350-regulator: Repair odd formatting in documentation
      commit: 2f5add1e42165c7eb7e4367e1180ae76aa13d394
[5/7] regulator: cpcap-regulator: Remove declared and set, but never used variable 'ignore'
      commit: b89a5effb3345a484584cc2b090af62e1ecb0871
[6/7] regulator: cpcap-regulator: Demote kerneldoc header to standard comment
      commit: 7b804ce0c2e0bbf77b3a1d4b457520145822c496
[7/7] regulator: max14577-regulator: Demote kerneldoc header to standard comment
      commit: 0c32f8aa0711af177248c2cba9cb105f18e0c9bb

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
