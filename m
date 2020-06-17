Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A9FC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 13:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D39E9207E8
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 13:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592400669;
	bh=1jG46vla/snnJOkxI9YckQQGUgzeCfolE1PdeXBgakI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=2NLJzmBOJdRJhIHA5nrKsWkech4zNpe7I+J9s2bQ5yl+iCL+Ie7ixlaYPeOciUxYR
	 mcMTdoqrZs56fYuGhbVTMhc4dIKR96VgZorD8LtKUwXTCEQw7L1LK1yc+5LcHknEvv
	 8z0c3vZclsCKAFtaCkz7D+t5YmgYW1zkzPk2UgGI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbgFQNbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 09:31:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:37698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbgFQNbH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 09:31:07 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5048207E8;
        Wed, 17 Jun 2020 13:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592400667;
        bh=1jG46vla/snnJOkxI9YckQQGUgzeCfolE1PdeXBgakI=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=h8Gm54MgNgn6CQ2kuUl6YCSgP6SDgCP5g8zRph5B87AtqQWVda8pEdvI6TYSgUKoG
         684pe8bRs3KGBNlK4nd0PSiZ8wJxS0rzPg41LDSOvlAu8GT5GzkDk9SGkTyAl3pjly
         FNDn5yr+X+hGnT86Dw+xTMKkh0NQvO8+H/Ck8fgg=
Date:   Wed, 17 Jun 2020 14:31:05 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
In-Reply-To: <20200616135030.1163660-1-axel.lin@ingics.com>
References: <20200616135030.1163660-1-axel.lin@ingics.com>
Subject: Re: [PATCH] regulator: mt6358: Remove BROKEN dependency
Message-Id: <159240066498.19473.1513756528360342589.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jun 2020 21:50:30 +0800, Axel Lin wrote:
> The MFD part is merged into v5.8-rc1, thus remove BROKEN dependency.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: mt6358: Remove BROKEN dependency
      commit: 1b3bcca2085865c1facfbea9baf2f5cde5dc15e4

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
