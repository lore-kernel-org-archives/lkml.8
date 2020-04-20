Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F38C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 14:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D5D720B1F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 14:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587392866;
	bh=ac2OWWBXr53L9YPDwHbJzkfcGUHqONQngqqS3KBJ9c4=;
	h=Date:From:To:In-Reply-To:References:Subject:List-ID:From;
	b=pxcOUMngLtVgHYj1LDThNgCKyjsC2i4tVvturOGgetjz65SxPKTHmDueDeB2E9P88
	 sfyErCxArVMSIUTNMGx8O86/omfeaYal4YgN0k7M4G+wuxt5RqZF8n3BrxCmQn6HVm
	 DExhNhh/xJ5pya4Tih0DTMMf09JlNs6vqhloBRKk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729891AbgDTO1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 10:27:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:39742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727067AbgDTO1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 10:27:44 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7772E20857;
        Mon, 20 Apr 2020 14:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587392864;
        bh=ac2OWWBXr53L9YPDwHbJzkfcGUHqONQngqqS3KBJ9c4=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=dc9gBCaHLppl0lmTl0FUd0mpoZ+mCwdv5If1wx36/CY6OYatqWHnHzjp7AGCe0ZC6
         IdX6hFxgFvrL0hTzILU3XhyMgDGS7eV7x1CSVjmE6aHLqMotG3YLBqWvg/5N/jd3Z4
         V3OkQRSL9jR6QUKQucJHQbDaerx4bDIcMdXSLNuU=
Date:   Mon, 20 Apr 2020 15:27:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, linux-kernel@vger.kernel.org,
        Jason Yan <yanaijie@huawei.com>, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com, srinivas.kandagatla@linaro.org, perex@perex.cz
In-Reply-To: <20200420042911.19379-1-yanaijie@huawei.com>
References: <20200420042911.19379-1-yanaijie@huawei.com>
Subject: Re: [PATCH] ASoC: wcd934x: remove unneeded semicolon
Message-Id: <158739283776.7647.11335076851233885002.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Apr 2020 12:29:11 +0800, Jason Yan wrote:
> Fix the following coccicheck warning:
> 
> sound/soc/codecs/wcd934x.c:3621:2-3: Unneeded semicolon
> sound/soc/codecs/wcd934x.c:4270:2-3: Unneeded semicolon
> sound/soc/codecs/wcd934x.c:4018:2-3: Unneeded semicolon
> sound/soc/codecs/wcd934x.c:4043:2-3: Unneeded semicolon
> sound/soc/codecs/wcd934x.c:3804:2-3: Unneeded semicolon
> sound/soc/codecs/wcd934x.c:3866:2-3: Unneeded semicolon
> sound/soc/codecs/wcd934x.c:3596:2-3: Unneeded semicolon
> sound/soc/codecs/wcd934x.c:3542:2-3: Unneeded semicolon
> sound/soc/codecs/wcd934x.c:3673:2-3: Unneeded semicolon
> sound/soc/codecs/wcd934x.c:3723:2-3: Unneeded semicolon
> sound/soc/codecs/wcd934x.c:2492:2-3: Unneeded semicolon
> sound/soc/codecs/wcd934x.c:1790:3-4: Unneeded semicolon
> sound/soc/codecs/wcd934x.c:1806:3-4: Unneeded semicolon
> sound/soc/codecs/wcd934x.c:1812:2-3: Unneeded semicolon
> 
> [...]

Applied to

	https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.7

Thanks!

[1/1] ASoC: wcd934x: remove unneeded semicolon
      commit: b40efd0f254356556443355bc87c9a5e6e3d9dee

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
