Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA321C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 16:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A606C2072D
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 16:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598028081;
	bh=EVvC6xbyzd5yeFwe4jxqhWiOm69M9hRdUd1nbJAytFI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=Z+pbSpx7xwcw3UrXsNrLgSzlsSmx0mmbQQ0q7au5Nqx3vvSFs6m4KYFV6chcBCX7L
	 k7od/osKcnhTCaYOIuSzf8ruDc0+Fu5kTUv3T1IpiUEiNUEyn+4HAJysqpfg/bWo0n
	 an6MGCl7O9+mZvblhOnyqYtxRQY0dhi+jiC0XW9A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgHUQlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 12:41:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:55466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728478AbgHUQkv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 12:40:51 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33A95207DE;
        Fri, 21 Aug 2020 16:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598028051;
        bh=EVvC6xbyzd5yeFwe4jxqhWiOm69M9hRdUd1nbJAytFI=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=jQLYaCACFEZ0lUabtI93MqTK5YAA/5K56UO9gQaqiPI4DWpXsJHxMibI3X0QfHHcZ
         3AP8eYbr8K62txt7aA0g1nfqekl+OnMJuvbZcSHkp1Aw3AbObbc9wMroBsnx03Ulf/
         Y6mDCSyaBtoqmYzCFPD1/BYvDf+zV2DdyUGxBt7A=
Date:   Fri, 21 Aug 2020 17:40:18 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
In-Reply-To: <20200821144823.13404-1-festevam@gmail.com>
References: <20200821144823.13404-1-festevam@gmail.com>
Subject: Re: [PATCH v2] regulator: dbx500: Remove unused debugfs goto label
Message-Id: <159802800846.25815.14657804031987832726.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Aug 2020 11:48:23 -0300, Fabio Estevam wrote:
> The following build warning is seen after commit 8bdaa43808b7 ("regulator:
> dbx500: no need to check return value of debugfs_create functions"):
> 
> drivers/regulator/dbx500-prcmu.c:144:1: warning: label 'exit_no_debugfs' defined but not used [-Wunused-label]
> 
> Remove the unused label and its associated error message.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: dbx500: Remove unused debugfs goto label
      commit: c0e53a448637366064d4b9ce586b68ced679cd22

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
