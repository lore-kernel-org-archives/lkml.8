Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A432CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73DC420773
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594131467;
	bh=AOgNC96ffB16G2PnMWfsUocfvapenbvNsXU0H973Ycs=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=pXKH8SIUidYd2E3yiwcproOQDYKSE7I2TD5qmHvEVAVHPIIsWyxcR35fHv3P0i0YB
	 VCM9BI19B1ADLiXmn6GC+SnHrm3ncavzFwyXU9uOqp9Ripb7n+if6u0B7YQobX2kk1
	 P6bHqfDypDBFN/RMQ7CWTop+kLlROBQjpc9zLtxQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbgGGORq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 10:17:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:52180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727064AbgGGORp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 10:17:45 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31E7720771;
        Tue,  7 Jul 2020 14:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594131465;
        bh=AOgNC96ffB16G2PnMWfsUocfvapenbvNsXU0H973Ycs=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=fPQD2I9ZyMUfKGMK6gRBWjFY5LbEvoGBRULTk5UWRrTrfWj4y766CljI5x8r1bSYw
         PBV6kz0O32LKfVD7K69sVr38RUgFBM9uwYbN5NUNxhuc2vZVKkORcUGs7Tfr3edk7M
         pBC5WRB2EsP+d2afMjapx5BQ+/EBwyKGMSuhAWQA=
Date:   Tue, 07 Jul 2020 15:17:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Christoph Fritz <chf.fritz@googlemail.com>
Cc:     clang-built-linux@googlegroups.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1c437154873ace65ff738a0ebca511308f1cecc1.camel@googlemail.com>
References: <202007071433.Z3bmcgjU%lkp@intel.com> <da3aece9abd23b12837e9abf908ee67f0c2c988c.camel@googlemail.com> <20200707102042.GD4870@sirena.org.uk> <1c437154873ace65ff738a0ebca511308f1cecc1.camel@googlemail.com>
Subject: Re: [PATCH] regulator: fan53880: Add support for COMPILE_TEST
Message-Id: <159413146113.34914.999828290847057133.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Jul 2020 12:57:31 +0200, Christoph Fritz wrote:
> This patch adds support for COMPILE_TEST while fixing a warning when
> no support for device tree is there.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: fan53880: Add support for COMPILE_TEST
      commit: 318b8a09f295cbf86fd504bcff3769b1fc4a936b

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
