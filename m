Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F88C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 22:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D09C220720
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 22:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594332067;
	bh=qGD80egtZFoMZA4mqqCxfqJGdccsub1sxXgdZJ/oxAI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=18yqiQ5HnKpAWfczwsOep5iqT0YGWm+CJdINLwpqTQb3vMB9o3oAvCxnFxEXw1R1g
	 0M+cXb3eigmE6qdAZndkmvVnwXShVYoxGlnFPYC07NaHSUMZh/Ft8hOFcElV0OJfe5
	 XjaIUmYPXLLGsq9Bd4oFSHZZp7FKQblo0kWflX4g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgGIWBG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 18:01:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:44608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726213AbgGIWBF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 18:01:05 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7477D20672;
        Thu,  9 Jul 2020 22:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594332065;
        bh=qGD80egtZFoMZA4mqqCxfqJGdccsub1sxXgdZJ/oxAI=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=pb4bGji5iciLzjQCBs8dZ+8RF2x9sDoV4tQUe8e6j468R+x6CvcHXeJM8o5LEhTw/
         B4sSp+udV7Q9lcQmU+jf4CJ2/EGa3HzdKB9MQxKGRyNPqcuJF8rBp1lBSIUGWujfQX
         75BRpln9Nm4tLA9vmpueSxpLHi026SBzHmZN7Tqc=
Date:   Thu, 09 Jul 2020 23:00:59 +0100
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org
Cc:     Zhang Qiang <qiang.zhang@windriver.com>,
        linux-samsung-soc@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Petr Mladek <pmladek@suse.com>
In-Reply-To: <20200709065007.26896-1-m.szyprowski@samsung.com>
References: <CGME20200709065016eucas1p22ef816e6a2a6e47c008cabc5e06d6716@eucas1p2.samsung.com> <20200709065007.26896-1-m.szyprowski@samsung.com>
Subject: Re: [PATCH v3] spi: use kthread_create_worker() helper
Message-Id: <159433204447.479.9183431834773506860.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Jul 2020 08:50:07 +0200, Marek Szyprowski wrote:
> Use kthread_create_worker() helper to simplify the code. It uses
> the kthread worker API the right way. It will eventually allow
> to remove the FIXME in kthread_worker_fn() and add more consistency
> checks in the future.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: use kthread_create_worker() helper
      commit: 60a883d119ab9ef63f830c85bbd2f0e2e2314f4f

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
