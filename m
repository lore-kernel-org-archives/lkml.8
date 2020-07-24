Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49260C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 14:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A9C9206D8
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 14:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595601460;
	bh=vvXRFf9DR9prMCJTMjWUgfZ40QqlI5frl3EKxELfXEw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=WF7fw6L2LR7kZ2EDVFukn+Gv+W3LxCjwL+OiaBRIVMvJsG5TzQfiYmNf4Z9BK3D7V
	 qCd+WHSE3gCBS9TIA2vHnBAH7/PmPhsJ/QLKjdEyvHa3+C/GTlnIfzvRUqz3r3od2r
	 Ehjd5+ZahBFzS9oy/e4QshpM7YwLjACv460L06p0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbgGXOhi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 10:37:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:54414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726366AbgGXOhi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 10:37:38 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15C7F2065C;
        Fri, 24 Jul 2020 14:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595601457;
        bh=vvXRFf9DR9prMCJTMjWUgfZ40QqlI5frl3EKxELfXEw=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=ccmTg/hZvx3U8RIzCUDQcVoSBByBY/eBTr19sIwu3Ve24JomDxPRzOMMNyRAxtdXv
         7yDzKKt87pZIQMa2tq1gxB2Utmp0l/pPxgm3m6WQMebl+DkhWBKUHPcedTFYNb2DY4
         b2+U1imNTH4E1J2Bfg5MLMoRUkqdkIBf5UNjnDY0=
Date:   Fri, 24 Jul 2020 15:37:22 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Vladimir Zapolskiy <vz@mleia.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Wen Yang <wenyang@linux.alibaba.com>
In-Reply-To: <20200724005013.23278-1-vz@mleia.com>
References: <20200724005013.23278-1-vz@mleia.com>
Subject: Re: [PATCH] regulator: fix memory leak on error path of regulator_register()
Message-Id: <159560144247.13250.1416101687025192776.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jul 2020 03:50:13 +0300, Vladimir Zapolskiy wrote:
> The change corrects registration and deregistration on error path
> of a regulator, the problem was manifested by a reported memory
> leak on deferred probe:
> 
>     as3722-regulator as3722-regulator: regulator 13 register failed -517
> 
>     # cat /sys/kernel/debug/kmemleak
>     unreferenced object 0xecc43740 (size 64):
>       comm "swapper/0", pid 1, jiffies 4294937640 (age 712.880s)
>       hex dump (first 32 bytes):
>         72 65 67 75 6c 61 74 6f 72 2e 32 34 00 5a 5a 5a  regulator.24.ZZZ
>         5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a  ZZZZZZZZZZZZZZZZ
>       backtrace:
>         [<0c4c3d1c>] __kmalloc_track_caller+0x15c/0x2c0
>         [<40c0ad48>] kvasprintf+0x64/0xd4
>         [<109abd29>] kvasprintf_const+0x70/0x84
>         [<c4215946>] kobject_set_name_vargs+0x34/0xa8
>         [<62282ea2>] dev_set_name+0x40/0x64
>         [<a39b6757>] regulator_register+0x3a4/0x1344
>         [<16a9543f>] devm_regulator_register+0x4c/0x84
>         [<51a4c6a1>] as3722_regulator_probe+0x294/0x754
>         ...
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: fix memory leak on error path of regulator_register()
      commit: 9177514ce34902b3adb2abd490b6ad05d1cfcb43

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
